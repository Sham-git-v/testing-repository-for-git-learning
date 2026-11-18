import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { LightningElement,wire } from 'lwc';
import LEAD_OBJECT from '@salesforce/schema/Contact';
import LEAD_FIRSTNAME from '@salesforce/schema/Contact.FirstName'
import LEAD_LASTNAME from '@salesforce/schema/Contact.LastName'
import LEAD_EMAIL from '@salesforce/schema/Contact.Email';
import LEAD_LEADSOURCE from '@salesforce/schema/Contact.LeadSource';
import {NavigationMixin} from 'lightning/navigation';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class CreateRecordAdaptorOnLead extends NavigationMixin(LightningElement) {
    leadFirstName;
    leadLastName;
    leadEmail;
    leadSources;


  
    @wire(getObjectInfo,{
        objectApiName:LEAD_OBJECT })
        getObjectFunction;

    @wire(getPicklistValues,{
        recordTypeId:"$getObjectFunction.data.defaultRecordTypeId",
        fieldApiName:LEAD_LEADSOURCE
    }) leadOptionList;

    handlOnchange(event){
        let fieldName = event.target.name;
        let value = event.target.value;
 
        if(fieldName === 'fname'){
            this.leadFirstName = value;
        }
        else if(fieldName === 'lname'){
            this.leadLastName = value;
        }
        else if(fieldName === 'eml'){
            this.leadEmail = value;
        }
        else if(fieldName === 'lsource'){
            this.leadSources = value;
        }
    }

    saveLead(){
        let isValid=this.validations();
        if(!isValid){
            this.showToast('Error','Please Enter Correct Details','error');
        }else{
            this.creatAsyncRecord();
        }
    }


    async creatAsyncRecord(){
        let inputFields={};
        inputFields[LEAD_FIRSTNAME.fieldApiName]=this.leadFirstName
        inputFields[LEAD_LASTNAME.fieldApiName]=this.leadLastName
        inputFields[LEAD_EMAIL.fieldApiName]=this.leadEmail
        inputFields[LEAD_LEADSOURCE.fieldApiName]=this.leadSources

        const recordInput={
            apiName:LEAD_OBJECT.objectApiName,
            fields:inputFields
        };

    try{
        
        
        let record= await createRecord(recordInput);
        this.showToast('Success','Lead Created Successfully','success');
        let pageReference={
            type:'standard__recordPage',
            attributes:{
                recordId:record.id,
                objectApiName:LEAD_OBJECT.objectApiName,
                actionName:'view'
            }
        }
        this[NavigationMixin.Navigate](pageReference)


    }catch(error){
      
        console.log('heloo',JSON.stringify(error));
          this.showToast('Error','Record Creation Failed','error');
        
    }
    }

    validations(){
        let isValid=true;
        let element=this.template.querySelector('lightning-input')
        if(!element.checkValidity()){
            element.reportValidity()
            isValid=false;

        }
        return isValid;
    }

        showToast(inpTitle,inpMessage,inpVariant) {
        const event = new ShowToastEvent({
            title: inpTitle,
            message:inpMessage,
            variant:inpVariant
        });
        this.dispatchEvent(event);
    }
}