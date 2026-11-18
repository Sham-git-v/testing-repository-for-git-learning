import { LightningElement, wire } from 'lwc';
import getTopCaseList from '@salesforce/apex/caseHandler.getTopCaseList';
import updateRecords from '@salesforce/apex/caseHandler.updateRecords';
import { refreshApex } from '@salesforce/apex';
export default class UpdateMultipelRecords extends LightningElement {
    handle;
    showModal = false;
    async handleClick(event){
        this.handle=event.detail;
        this.showModal= false;
        await refreshApex(this.cases);
    }
    columns = [
        { label: 'case Number', fieldName: 'CaseNumber' },
        { label: 'Case Status', fieldName: 'Status' },
        { label: 'Subject', fieldName: 'Subject' }
        

    ];

    @wire(getTopCaseList) cases;

    createRecord(){
        this.showModal = true;
    }
    updateRecords() {
        let element = this.template.querySelector('lightning-datatable').getSelectedRows();
        console.log('element ', element);
        this.updateCaseStatusToClosed(element);
    }

    async updateCaseStatusToClosed(element) {
        try {
            await updateRecords({
                caseList: element
            })
            await refreshApex(this.cases);
            //toast message - assignment
        } catch (error) {
            console.log('Error', error);
        }
    }
}