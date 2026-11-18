import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
export default class NavigationButtonOnCase extends NavigationMixin (LightningElement) {
    navigationHandlere(){
    let pageReference = {
                            type: 'standard__namedPage',
                         attributes: {pageName: 'home'}
                        }
        this[NavigationMixin.Navigate](pageReference);
    }
 
    
    createNewCaseHandler(){
        let defaultValues = {
            Priority : "High",
            Status : "Working"
        }
 
        let encodedValues = encodeDefaultFieldValues(defaultValues)
 
        let pageReference = {
    type: 'standard__objectPage',
    attributes: {
        objectApiName: 'Case',
        actionName: 'new'
    },state: {
        defaultFieldValues : encodedValues,
        nooverride: '1'
    }
    }
 
        this[NavigationMixin.Navigate](pageReference);
    }
    

}