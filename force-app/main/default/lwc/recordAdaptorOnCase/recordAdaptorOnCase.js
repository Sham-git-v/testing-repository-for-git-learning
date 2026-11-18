import { LightningElement,api,wire } from 'lwc';
import { getFieldValue, getRecord, getRecords } from 'lightning/uiRecordApi';
import case_caseNumger from '@salesforce/schema/Case.CaseNumber'
import case_origin from '@salesforce/schema/Case.Origin'
import case_status from '@salesforce/schema/Case.Status'
import case_subject from '@salesforce/schema/Case.Subject'
import case_description from '@salesforce/schema/Case.Description'

export default class RecordAdaptorOnCase extends LightningElement {
    @api recordId;

    caseNumbers;
    CaseOrigins;
    caseStatuss;
    caseSubjects;
    caseDescriptions;
    CaseRecords;
    CaseErrors;
    @wire(getRecord, {recordId: '$recordId', fields:[case_caseNumger,case_origin,case_status,case_subject,case_description]})
    getRecordFunction({data,error}){
        if(data){

            console.log('getRecordFunction',data);
            this.caseNumbers=getFieldValue(data,case_caseNumger);
            this.CaseOrigins=getFieldValue(data,case_origin);
            this.caseStatuss=getFieldValue(data,case_status);
            this.caseSubjects=getFieldValue(data,case_subject);
            this.caseDescriptions=getFieldValue(data,case_description);
           
        }else if(error){
            console.log('getRecordFunction',error);
        }
    }

    @wire(getRecords,
        {records:[
            {recordIds:'500WU00000EHFpuYAH', fields:[case_caseNumger,case_origin,case_status,case_subject,case_description]},
            {recordIds:'500WU00000EHFpwYAH',fields:[case_caseNumger,case_origin,case_status,case_subject,case_description]}]
        })
        getRecordsFunction({data,error}){
            if(data){
                console.log('the records of data', data);
                this.CaseRecords=data;
            }else if(error){
                console.log('the record errors',error);
                this.CaseErrors=error;
            }
        }
}