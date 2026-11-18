import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { LightningElement,wire } from 'lwc';
import LEAD_OBJECT from '@salesforce/schema/Lead';
import LEAD_LEADSOURCE from '@salesforce/schema/Lead.LeadSource';
export default class GetPickListValuesAdaptorOnLead extends LightningElement {
    defaultRecordTypeIdOfLead;
    @wire(getObjectInfo,{
        objectApiName:LEAD_OBJECT })
        getObjectFunction({data,error}){
            if(data){
                console.log('data', data);
                
                this.defaultRecordTypeIdOfLead=data.defaultRecordTypeId;
                console.log('data', data);
            }else if(error){
                console.log('error',error);
                
            }
            
        }
    @wire(getPicklistValues,{
        recordTypeId:"$defaultRecordTypeIdOfLead",
        fieldApiName:LEAD_LEADSOURCE
    }) leadOptionList
}