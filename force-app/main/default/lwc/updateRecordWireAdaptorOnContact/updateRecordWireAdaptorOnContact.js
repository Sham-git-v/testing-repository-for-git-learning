import { LightningElement,wire,api } from 'lwc';
import { getRecord,getFieldValue,updateRecord } from 'lightning/uiRecordApi';
import CONTACT_LASTNAME from '@salesforce/schema/Contact.LastName'
import CONTACT_ID from '@salesforce/schema/Contact.Id'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class UpdateRecordWireAdaptorOnContact extends LightningElement {
    contactLastName='';
    @api recordId;

    @wire(getRecord,{recordId:'$recordId', fields:[CONTACT_LASTNAME]})
    getRecordFunction({data,error}){
        if(data){
            this.contactLastName = getFieldValue(data,CONTACT_LASTNAME);
        }else if(error){
            console.log(error);
            
        }
    }


    handleOnChange(event){
        this.contactLastName = event.target.value;
    }
    
    handleUpdateRecord(){
        let isValid=this.validations();
        if(!isValid){
            this.showMessage('Error','Please enter value in required field','error');
        }else{
            //update
            this.updateRecordAsync();
        }
    }

    async updateRecordAsync(){
        let inpuFields={};
        inpuFields[CONTACT_LASTNAME.fieldApiName]=this.contactLastName;
        inpuFields[CONTACT_ID.fieldApiName]=this.recordId;
        let recordInput={fields:inpuFields};
        
        try{
            await updateRecord(recordInput);
            this.showMessage('Success','Record updated successfully','success');
        }catch(error){
            this.showMessage('error','update record is failed','error');

        }
    }

    showMessage(InpTitle,inpMessage,inpVariant){
        
        const event=new ShowToastEvent({
            title:InpTitle,
            message:inpMessage,
            variant:inpVariant
        })
        this.dispatchEvent(event);
    
    }


    validations(){
        let isValid=true;
        let elements=this.template.querySelector('lightning-input')
        if(!elements.checkValidity()){
            elements.reportValidity();
            isValid=false;

        }
        return isValid;
    }
}