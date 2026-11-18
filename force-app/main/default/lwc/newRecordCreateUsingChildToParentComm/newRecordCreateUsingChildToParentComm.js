import CASE_OBJECT from '@salesforce/schema/Case'
import CASE_SUBJECT from '@salesforce/schema/Case.Subject'
import CASE_STATUS from '@salesforce/schema/Case.Status'
import CASE_ORIGIN from '@salesforce/schema/Case.Origin'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { LightningElement, wire } from 'lwc';

export default class NewRecordCreateUsingChildToParentComm extends LightningElement {
    caseSubject;
    caseStatus;
    caseOrigin;



    @wire(getObjectInfo, { ObjectApiName: CASE_OBJECT }) getObjectInfoPropery;

    @wire(getPicklistValues, {
        recordTypeId: '$getObjectInfoPropery.data.defaultRecordTypeId',
        fieldApiName: CASE_STATUS
    }) caseStatusList({ data, error }) {
        if (data) {
            console.log('data', data.values);

        } else if (error) {
            console.log('error', JSON.stringify(error));

        }

    }

    @wire(getPicklistValues, {
        recordTypeId: '$getObjectInfoPropery.data.defaultRecordTypeId',
        fieldApiName: CASE_ORIGIN
    }) caseOriginList;


    changeHandler(event) {
        let field = event.target.name;
        let value = event.target.value;
        if (field === 'sbj') {
            this.caseSubject = value;
        } else if (field === 'sts') {
            this.caseStatus = value;
        } else if (field === 'org') {
            this.caseOrigin = value;
        }
    }


    createHandler() {
        let isValid = this.validations();
        if (!isValid) {
            this.showMessage('Error', 'Please enter valid data', 'error');
        } else {
            //create
            this.createRecordOnCase();

        }
    }


    async createRecordOnCase() {


        try {
            let inputFields = {};
            inputFields[CASE_SUBJECT.fieldApiName] = this.caseNumbers;
            inputFields[CASE_STATUS.fieldApiName] = this.caseStatus;
            inputFields[CASE_ORIGIN.fieldApiName] = this.caseOrigin;
            let recordInput = {
                apiName: CASE_OBJECT.objectApiName,
                fields: inputFields
            }
            await createRecord(recordInput);
            this.showMessage('Success', 'Case Created Successfully', 'success');

            const createEvent = new CustomEvent('recordcreated', {
                detail: 'Case Created'
            });
            this.dispatchEvent(createEvent);
        } catch (error) {
            this.showMessage('Error', 'failed to create', 'error');
            // console.log('error', error, JSON.stringify(error));

        }
    }


    validations() {
        let isValid = true;
        let element = this.template.querySelector('lightning-input')
        if (!element.checkValidity()) {
            element.reportValidity()
            isValid = false;

        }
        return isValid;
    }

    showMessage(InpTitle, inpMessage, inpVariant) {

        const event = new ShowToastEvent({
            title: InpTitle,
            message: inpMessage,
            variant: inpVariant
        })
        this.dispatchEvent(event);

    }
}