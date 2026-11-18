import { LightningElement,wire } from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_RATING from '@salesforce/schema/Account.Rating';
import getAccRecByRating from '@salesforce/apex/AccountHandler.getAccRecByRating';
export default class DisplayAccRecBasedOnRating extends LightningElement {
    
    accounts;
    errors;
    inpRating;
    columns = [
    { label: 'Account Name', fieldName: 'Name' },
    { label: 'Rating', fieldName: 'Rating'},
    { label: 'Phone', fieldName: 'Phone'},
    { label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'currency' },
    { label: 'Industry', fieldName: 'Industry'}
];
    
    defaultRecordTypeIdOfAccount;
    @wire(getObjectInfo,
        {objectApiName:ACCOUNT_OBJECT})
        getObjectFunction({data,error}){
            if(data){
                this.defaultRecordTypeIdOfAccount=data.defaultRecordTypeId;
                
                console.log('defaultRecordTypeIdOfAccounta', this.defaultRecordTypeIdOfAccount);
                console.log('Account Data', data);
                
            }else if(error){
                console.log('Account error', error);
                
            }
        }
    
    @wire(getPicklistValues,{
        recordTypeId:'$defaultRecordTypeIdOfAccount',
        fieldApiName:ACCOUNT_RATING
    })accountRatingOptions;

    handleOnChange(event){
        this.inpRating=event.target.value;
        
        
    }

    @wire(getAccRecByRating, {InpRating: '$inpRating'})
    accountRatingFunction({data,error}){
        if(data){
            this.accounts=data;
            this.errors=undefined;
        }else if(error){
            this.errors=error;
            this.accounts=undefined;
        }
    }
}