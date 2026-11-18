import { LightningElement,api} from 'lwc';
import CONTACT_FIRSTNAME from '@salesforce/schema/Contact.FirstName';
import CONTACT_LASTNAME from '@salesforce/schema/Contact.LastName';
import CONTACT_EMAIL from '@salesforce/schema/Contact.Email';

export default class LightningRecordViewForm extends LightningElement {
    @api recordId;
    @api objectApiName;
    conFirstName=CONTACT_FIRSTNAME;
    conLastName=CONTACT_LASTNAME;
    conEmail=CONTACT_EMAIL;

}