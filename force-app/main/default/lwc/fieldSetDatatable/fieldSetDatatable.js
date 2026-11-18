import { LightningElement, api, wire } from 'lwc';
import getDataFromFieldSet from '@salesforce/apex/FieldSetDatatableController.getDataFromFieldSet';

export default class FieldSetDatatable extends LightningElement {
    // Public properties to be configured in the Lightning App Builder
    @api objectApiName;
    @api fieldSetName;
    @api cardTitle;

    // Private component properties
    columns;
    processedData;
    error;
    friendlyErrorMessage;
    dataLoadedOrError = false; // Controls the spinner visibility

    @wire(getDataFromFieldSet, {
        objectApiName: '$objectApiName', // '$' makes the wire reactive to property changes
        fieldSetName: '$fieldSetName'
    })
    wiredData({ error, data }) {
        if (data) {
            this.columns = data.columns;
            // The magic happens here: we process the data to handle related fields
            this.processedData = this.flattenData(data.data);
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.friendlyErrorMessage = 'An error occurred. Please check the component configuration and field permissions. Details: ' + error.body.message;
            this.columns = undefined;
            this.processedData = undefined;
        }
        this.dataLoadedOrError = true; // Hide spinner once data arrives or an error occurs
    }

    /**
     * This crucial helper function "flattens" the nested data from Apex
     * so the lightning-datatable can display related object fields.
     *
     * @param {Object[]} data - The array of SObjects returned from Apex.
     * @returns {Object[]} A new array with flattened data.
     *
     * @example
     * // Transforms this:
     * { Name: 'John Doe', Account: { Name: 'Acme Inc.' } }
     * // Into this:
     * { Name: 'John Doe', 'Account.Name': 'Acme Inc.' }
     */
    flattenData(data) {
        if (!data) {
            return [];
        }
        
        let flattenedData = [];
        data.forEach(record => {
            let flatRecord = { ...record }; // Create a shallow copy

            for (const key in flatRecord) {
                // Check if the property is a related object (and not null)
                if (typeof flatRecord[key] === 'object' && flatRecord[key] !== null) {
                    const relatedObject = flatRecord[key];
                    // Iterate over the keys of the nested related object
                    for (const nestedKey in relatedObject) {
                        // Create a new key with dot notation, e.g., 'Account.Name'
                        const flattenedKey = `${key}.${nestedKey}`;
                        flatRecord[flattenedKey] = relatedObject[nestedKey];
                    }
                }
            }
            flattenedData.push(flatRecord);
        });
        return flattenedData;
    }
}