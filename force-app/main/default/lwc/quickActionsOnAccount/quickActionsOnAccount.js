import { LightningElement, api } from 'lwc';
import CONTACT_LASTNAME from '@salesforce/schema/Contact.LastName'
import CONTACT_PHONE from '@salesforce/schema/Contact.Phone'
import CONTACT_EMAIL from '@salesforce/schema/Contact.Email'
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class QuickActionsOnAccount extends LightningElement {

    contactLastName = CONTACT_LASTNAME;
    contactPhone = CONTACT_PHONE;
    contactEmail = CONTACT_EMAIL
    @api recordId;
    successHandler() {
        // Close the modal window and display a success toast
        this.dispatchEvent(new CloseActionScreenEvent());
        this.dispatchEvent(
            new ShowToastEvent({
                title: "Success",
                message: "Record Created!",
                variant: "success",
            }),
        );
    }

    errorHandler(event) {
        console.log('Error', JSON.stringify(event.detail), JSON.stringify(event))
    }
    cancelHandler() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }
}