import { LightningElement,api} from 'lwc';
import CASE_SUBJECT from '@salesforce/schema/Case.Subject';
import CASE_STATUS from '@salesforce/schema/Case.Status';
import CASE_PRIORITY from '@salesforce/schema/Case.Priority';
import CASE_DESCRIPTION from '@salesforce/schema/Case.Description';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import {NavigationMixin} from 'lightning/navigation';

export default class CaseFormComponent extends NavigationMixin(LightningElement) {
    caseSubject=CASE_SUBJECT;
    caseStatus=CASE_STATUS;
    casePriority=CASE_PRIORITY;
    caseDescription=CASE_DESCRIPTION;
    @api objectApiName;
    @api recordId;
    clickedNewbutton=false;
    clickedEditButton=false;

    handleCreatCase(){
        this.clickedNewbutton=true;
        this.clickedEditButton=false;

    }

    handleEditCase(){
        this.clickedNewbutton=false;
        this.clickedEditButton=true;
    }

    handleOnCreateSuccess(event){
        console.log('succuessfullu created.');
        
        const showMessage=new ShowToastEvent({
            title:'Success message',
            message:'Case created Successfully',
            variant:'success',

        });
        this.dispatchEvent(showMessage);

        this[NavigationMixin.Navigate]({
            type:'standard__recordPage',
            attributes:{
                recordId:event.detail.id,
                objectApiName:this.objectApiName,
                actionName:'view',
            },
        });

    }


    handleOnCreateSubmit(event){
        event.preventDefault();
        const inpFields=event.detail.fields;
        if(!inpFields.Subject || !inpFields.Status){
            const showError=new ShowToastEvent({
            title:'Error message',
            message:'Subject or status fields are mandatory.',
            variant:'error',

        });
        this.dispatchEvent(showError);
        }else{
            let elements=this.template.querySelector('.createRequired');
            elements.submit(inpFields);
        }

        
    }

    handleOnCreateError(){
        const showCreateError=new ShowToastEvent({
            title:'submission fail',
            message:'Form submission is denied, please enter the correct inputs',
            variant:'error',

        });
        this.dispatchEvent(showCreateError);
    }
}