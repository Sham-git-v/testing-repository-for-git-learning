import { LightningElement } from 'lwc';

export default class InputValidationComp extends LightningElement {
    handleSubmit(){
        //validations
        let isValid = this.validations()
        //if validations are succcessfull
        if(isValid){
            alert('Form Submitted Successfully');
        }else{
            alert('Errors !!')
        }
    }
 
    validations(){
        let isValid = true;
        let elements = this.template.querySelectorAll('lightning-input');
        elements.forEach(currItem =>{
            if(!currItem.checkValidity()){
                currItem.reportValidity();
                isValid = false;
            }
        })
        let emailElement= this.template.querySelector('.requiredEmail');
        let phoneElement=this.template.querySelector('.requiredPhone');
        if(!emailElement.value){
            isValid = false;
            emailElement.setCustomValidity('enter either email or phone');
            emailElement.reportValidity();

        }else if(!phoneElement.value){
            isValid = false;
            phoneElement.setCustomValidity('enter valid phone number');
            phoneElement.reportValidity();
        }



        return isValid;
    }
}