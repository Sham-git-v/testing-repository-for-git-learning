import { LightningElement, track } from 'lwc';
import getCaseByStatus from '@salesforce/apex/CaseTriggerHandler.getCaseByStatus';
export default class CaseStatusSearchUsingImperative extends LightningElement {

    @track caseStatus = '';
    @track cases = [];
    @track error = null;
    isLoading = false;

    columns = [
        { label: 'Account Name', fieldName: 'AccountId' },
        { label: 'Case Origin', fieldName: 'Origin' },
        { label: 'Status', fieldName: 'Status' }

    ];

    changeHandler(event) {
        this.caseStatus = event.target.value;
    }

    async fetchCases() {
        if (!this.caseStatus) {
            this.cases = [];
            this.error = 'Please enter a case status!';
            return;
        }

        this.isLoading = true;

        try {
            const result = await getCaseByStatus({ inpStatus: this.caseStatus });
            this.cases = result;
            this.error = null;
        } catch (error) {
            this.error = 'Failed to load cases';
            console.error(error);
        } finally {
            this.isLoading = false;
        }
    }
}