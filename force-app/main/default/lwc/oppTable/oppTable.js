import { LightningElement,wire } from 'lwc';
import getOpps1 from '@salesforce/apex/OppRecordsTable.getOpps';
export default class OppTable extends LightningElement {
    @wire(getOpps1) Opportunities;
    columns=[
        { label: 'Account Name', fieldName: 'Name' },
        { label: 'Amount', fieldName: 'Amount'},
        { label: 'Stage Name', fieldName: 'StageName'}
    ]
}
// Select Id, Name, StageName, Amount from Opportunity where Amount !=null order by Amount