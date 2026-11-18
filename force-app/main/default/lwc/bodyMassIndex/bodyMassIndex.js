import { LightningElement } from 'lwc';

export default class BodyMassIndex extends LightningElement {
    inputheight=0;
    inputweight=0;
    CalculatedBmi='';
    BmiCategory='';

    handleOnChange(event){
        let element=event.target.name;
        let value=event.target.value;
        if(element==='enhet'){
            this.inputheight=parseFloat(value);
        
        }else if(element==='enwet'){
            this.inputweight=parseFloat(value);
        }
    }

    handlOnClick(event){
        let bmi=(this.inputweight)/this.inputheight**2;
        console.log('bmi', bmi);
        
        let result='';
        if(bmi<18.5){
            result='Underweight';
        }else if(bmi >=18.5 && bmi <24.9){
            result='Normal weight';
        }else if(bmi >=25 && bmi <29.9){
            result='Overweight';
        }else if(bmi>=30){
            result='Obese';
        }

        this.CalculatedBmi=bmi;
        this.BmiCategory=result;
    }

}

// Underweight: BMI < 18.5
// Normal weight: 18.5 ≤ BMI < 24.9
// Overweight: 25 ≤ BMI < 29.9
// Obese: BMI ≥ 30