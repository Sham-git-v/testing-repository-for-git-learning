import { LightningElement, wire } from 'lwc';
import { subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext, } from 'lightning/messageService';
import sampleMessage from '@salesforce/messageChannel/sampleMessage__c';
export default class ContactDetailsUsingIndividualCommu extends LightningElement {

    selecetedId = '';
    subscription = null
    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.subscription = subscribe(this.messageContext, sampleMessage, (message) => this.handleMessage(message),
            { scope: APPLICATION_SCOPE })
    }

    handleMessage(message) {
        console.log(message.lmsData);
        this.selecetedId = message.lmsData;
        console.log('this.selecetedId ', this.selecetedId)
    }

    disconnectedCallback() {
        unsubscribe(this.subscription);
        this.subscription = null
    }
}