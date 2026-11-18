import { LightningElement } from 'lwc';

export default class CalculateEMI extends LightningElement {
    principalAmount=0;
    interestRate=0;
    selectedMonth=0;
    emiResult;
    totalPayAmount;
    changehandler(event){
        let{name,value}=event.target;
       if(name==='pri')this.principalAmount=value;
        if(name==='int')this.interestRate=value;
         if(name==='ten')this.selectedMonth=value;

    }
    calculateEMI(event){
        // console.log('emi calculator');
       const monthlyInterestRate = this.interestRate / 12 / 100;
        
     
        const P = this.principalAmount;
        const R = monthlyInterestRate;
        const N = this.selectedMonth;

        if (R > 0) {
            
            this.emiResult = (P * R * Math.pow(1 + R, N)) / (Math.pow(1 + R, N) - 1);
        } else {
         
            this.emiResult = P / N;
        } 

        const ttAmount=this.emiResult*N;
        
        this.totalPayAmount=ttAmount;
        
    }
}