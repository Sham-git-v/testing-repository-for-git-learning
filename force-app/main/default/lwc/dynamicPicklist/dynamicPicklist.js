import { LightningElement, wire, track } from 'lwc';
import getDynamicValues from '@salesforce/apex/PicklistController.getDynamicValues';

export default class DynamicPicklist extends LightningElement {
    @track options = [];
    @track value;

    @wire(getDynamicValues)
    wiredOptions({ data, error }) {
        if (data) {
            this.options = data; // Already in {label, value} format
        } else if (error) {
            console.error(error);
        }
    }

    handleChange(event) {
        this.value = event.detail.value;
    }
}