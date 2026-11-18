import { LightningElement, wire } from 'lwc';
import getContactList from '@salesforce/apex/ContactHandler.getContactList'
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { publish, MessageContext } from 'lightning/messageService';
import sampleMessage from '@salesforce/messageChannel/sampleMessage__c';
export default class DeleteRecordWireAdaptorOnContact extends LightningElement {
    @wire(MessageContext)
    messageContext;

    @wire(getContactList) contactList;
    columns = [
        { label: 'Contact first Name', fieldName: 'FirstName' },
        { label: 'last Name', fieldName: 'LastName' },
        { label: 'phone', fieldName: 'Phone' }
    ]

    deleteHandler() {
        let element = this.template.querySelector('lightning-datatable').getSelectedRows();
        if (element.length > 0) {
            let record = element[0];
            let recordId = record.Id
            console.log('Delete Record Id ', recordId);
            //delete operation
            this.deleteSelectedRecord(recordId)
        }
    }

    handleRowSelection(event) {
        console.log('Method Fired');
        const selectedRows = event.detail.selectedRows;
        console.log('selectedRows ', selectedRows)
        console.log('Selected Row Id', selectedRows[0].Id)
        let selectedRecordId = selectedRows[0].Id

        let payload = {
            lmsData: selectedRecordId
        }
        publish(this.messageContext, sampleMessage, payload)
    }

    async deleteSelectedRecord(recordId) {
        try {
            await deleteRecord(recordId);
            await refreshApex(this.contactList);
            this.showToast('Success', 'Record Deleted Successfully', 'success')
        } catch (error) {
            this.showToast('Error', 'Record Deletion Failed', 'error')
            console.log('error ', error, JSON.stringify(error));
        }
    }

    showToast(inpTitle, inpMessage, inpVariant) {
        const event = new ShowToastEvent({
            title: inpTitle,
            message: inpMessage,
            variant: inpVariant
        });
        this.dispatchEvent(event);
    }
}