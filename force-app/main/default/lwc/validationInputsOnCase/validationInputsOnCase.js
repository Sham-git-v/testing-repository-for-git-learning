import { LightningElement,wire } from 'lwc';
import { getObjectInfo,getPicklistValues } from 'lightning/uiObjectInfoApi';
import CASE_PRIORITY from '@salesforce/schema/Case.Priority'
import CASE_OBJECT from '@salesforce/schema/Case'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ValidationInputsOnCase extends LightningElement {
    getDefaultRecordIdOfCase;
    @wire(getObjectInfo,{objectApiName:CASE_OBJECT})
    getObjectInfoFunction({data,error}){
        if(data){
            console.log('picklist data',data);
            this.getDefaultRecordIdOfCase=data.defaultRecordTypeId;
        }
        else if(error){
            console.log('error',error);
    }
    }
    @wire(getPicklistValues,{
            recordTypeId:'$getDefaultRecordIdOfCase',
            fieldApiName:CASE_PRIORITY
        })caseOptionList





    handleOnSubmit(event){
        console.log(event);
        
    }

}