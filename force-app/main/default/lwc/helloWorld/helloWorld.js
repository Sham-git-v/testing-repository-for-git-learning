import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {
    learningLWC = 'Today I m learning LWC';
    changeEmailHandler(event){
       this.learningLWC=event.target.value;
    }
}


//create one component : welcomeLearning
//define one property : learningLWC = 'Today I m learning LWC'
//On html -- add one card title : populate : learningLWC
//on html -- add one input field with label : email
// if user type email -- onChangeEvent -- changeEmailHandler
//in js -- define the method : changeEmailHandler
//in js -- define the property : changeEmailMessage
//in js -- populate the property - changeEmailMessage
//in html -- display that property - changeEmailMessage

//Component available on App Page