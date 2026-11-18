import { LightningElement, track, wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';
import CASE_OBJECT from '@salesforce/schema/Case';
export default class CaseStatusSearchLDS extends LightningElement {

    @track caseName = '';
    @track cases = [];

    columns = [
        { label: 'Account Name', fieldName: 'AccountId' },
        { label: 'Case Origin', fieldName: 'Origin' },
        { label: 'Case Reason', fieldName: 'Reason' },
        { label: 'Priority', fieldName: 'Priority' },
        { label: 'Industry', fieldName: 'Status' },
        { label: 'Type', fieldName: 'Type' }
    ];

    @wire(getListUi, { objectApiName: CASE_OBJECT, filterBy: [{ fieldName: 'Status', operator: '=', value: '$caseName' }] })
    wiredCases({ data, error }) {
        if (data) {
            this.cases = data.records;
            System.debug(data);
        } else if (error) {
            this.cases = [];
            console.error(error);
        }
    }

    changeHandler(event) {
        this.caseName = event.target.value;
    }
}