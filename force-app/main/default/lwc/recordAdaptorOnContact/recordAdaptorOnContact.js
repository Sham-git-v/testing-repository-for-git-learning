import { LightningElement,api,wire } from 'lwc';
import { getFieldDisplayValue, getFieldValue, getRecord } from 'lightning/uiRecordApi';
import contact_FirstName from '@salesforce/schema/Contact.FirstName'
import contact_LastName from '@salesforce/schema/Contact.LastName'
import contact_Email from '@salesforce/schema/Contact.Email'
import contact_phone from '@salesforce/schema/Contact.Phone'
export default class RecordAdaptorOnContact extends LightningElement {

        @api recordId; //to access the record Id -- Values will come only Record Page
    contactFirstName;
    contactLastName;
    contactEmail;
    contactPhone;
 
    @wire(getRecord, { recordId: '$recordId', fields: [contact_FirstName,contact_LastName,contact_Email,contact_phone] })
    getRecordFunction({data,error}){
        if(data){
            console.log('Get Record Data',data.fields.Name.value)
            // console.log('data',data);
            
            this.contactFirstName = getFieldValue (data,contact_FirstName);
            this.contactLastName = getFieldValue (data,contact_LastName);
            this.contactEmail = getFieldValue (data,contact_Email);
            this.contactPhone = getFieldDisplayValue (data,contact_phone);
        }else if(error){
            console.log('Get Record Data',error);
 
        }
    }

}