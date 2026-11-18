import { LightningElement} from 'lwc';

export default class InputParentComp extends LightningElement {
   
   input='';
   
    handleOnChange(event){
        this.input=event.target.value;
    }


    handleOnClick(event){
        this.input=this.input.toUpperCase();
        
    }
    
}