import { LightningElement } from 'lwc';

export default class GetFullName extends LightningElement {


    firstName;
    lastName;
    result;
    handleOnFullNmae(event){
        let fullName=event.target.name;
        if(fullName==='fn'){
            this.firstName=event.target.value;
        }else{
            this.lastName=event.target.value;
        }
    }
    handleOnClick(event){
       this.result=this.firstName+' '+this.lastName;
    }
}