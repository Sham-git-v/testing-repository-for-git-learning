import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { LightningElement,wire } from 'lwc';
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity'
import OPPORTUNITY_STAGENAME from '@salesforce/schema/Opportunity.StageName'
export default class ObjectAdaptorsOnOpp extends LightningElement {


    defaultRecordTypeOfOpportunity;
    @wire(getObjectInfo,{
        objectApiName : OPPORTUNITY_OBJECT
    }) getObjectFunction({data,error}){
        if(data){
           
            this.defaultRecordTypeOfOpportunity = data.defaultRecordTypeId;
            console.log('Record Type Id -Info',this.defaultRecordTypeOfOpportunity)
        }
        else if(error){
            console.log('Error - Get Object Info',error)
        }
    }
 
    @wire(getPicklistValues,{
        recordTypeId: "$defaultRecordTypeOfOpportunity",
        fieldApiName: OPPORTUNITY_STAGENAME
    }) stageNameOptions

}


// <!-- Create LWC to get the opportunity picklist field - StageName -->