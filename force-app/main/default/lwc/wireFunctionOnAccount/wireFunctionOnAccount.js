import { LightningElement,wire } from 'lwc';
import getAccountByIndustry from '@salesforce/apex/AccountHandler.getAccountByIndustry';
export default class WireFunctionOnAccount extends LightningElement {
    Accounts;
    Errors;
    InpIndustry;
    columns = [
    { label: 'Account Name', fieldName: 'Name' },
    { label: 'Rating', fieldName: 'Rating'},
    { label: 'Phone', fieldName: 'Phone'},
    { label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'currency' },
    { label: 'Industry', fieldName: 'Industry'}
];  

    changeHandler(event){
        this.InpIndustry=event.target.value;
    }

    @wire(getAccountByIndustry, {inpIndustry: '$InpIndustry'})
     accountFunction({data,error}){
        if(data){
            // let newdata=data.map(element => {
            //    let copied={...element};
            //    if(copied.Rating===null || copied.Rating===undefined)
            //    {
            //     copied.Rating='NA';
            //    }
            // });
           let sss= data.map(cv=>{
                let cvCopy={...cv};
                if(!cvCopy.hasOwnProperty('Rating')){
                    cvCopy.Rating='NA';
                }
                return cvCopy;
            });
                // console.log(ok,'copied data');
                this.Accounts=sss;
                this.Errors=Null;

            
            
        }else if(error){
            this.Errors=error;
            this.Accounts=Null;
        }
    }
}