import { LightningElement,api } from 'lwc';
import contact_firstName from '@salesforce/schema/Contact.FirstName'
import contact_lastName from '@salesforce/schema/Contact.LastName'
import contact_email from '@salesforce/schema/Contact.Email'
import contact_phone from '@salesforce/schema/Contact.Phone'
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
import { NavigationMixin } from 'lightning/navigation';
export default class LightningRecordFormOnContact extends NavigationMixin (LightningElement) {

    @api recordId;
    @api objectApiName;
    @api fields=[contact_firstName,contact_lastName,contact_email,contact_phone];
    handleSuccess(){
         this.showToast('Success','Record Updated Successfully','success');
    }
    handleerror(){
        this.showToast('Error','Error Occured While Updating Record','error');
    }

    showToast(inptitle,inpMessage,inpVariant) {
        const event = new ShowToastEvent({
            title: inptitle,
            message:inpMessage,
            variant:inpVariant
        });
        this.dispatchEvent(event);
    }

    handleSuccess(event){
        let pageReference = {
        type: 'standard__recordPage',
        attributes: {
            recordId: event.detail.id,
            objectApiName: this.objectApiName,
            actionName: 'view'
        }
      }
        this[NavigationMixin.Navigate](pageReference);
    }
    handleerror(){

    }

    
}