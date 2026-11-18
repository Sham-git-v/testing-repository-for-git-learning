import { LightningElement, wire } from 'lwc';
import getCaseByStatus from '@salesforce/apex/CaseTriggerHandler.getCaseByStatus';
export default class CaseStatusSearch extends LightningElement {
    caseStatus;
    columns = [
        { label: 'Account Name', fieldName: 'AccountId' },
        { label: 'Case Origin', fieldName: 'Origin' },
        { label: 'Case Reason', fieldName: 'Reason' },
        { label: 'Priority', fieldName: 'Priority', type: 'currency' },
        { label: 'Industry', fieldName: 'Status' },
        { label: 'Type', fieldName: 'Type' }
    ];
    changeHandler(event) {
        this.caseStatus = event.target.value
    }

    @wire(getCaseByStatus, {
        inpStatus: "$caseStatus"
    }) cases;
}