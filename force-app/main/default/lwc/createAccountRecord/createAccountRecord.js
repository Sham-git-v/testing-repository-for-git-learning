import { LightningElement } from 'lwc';
import createAccount from '@salesforce/apex/AccountCreation.createAcc';

export default class CreateAccountRecord extends LightningElement {
  Name;
  Phone;
  Fax;

    changeNameHandler(event){
      let{name,value}=event.target;
      if(name==='nme')this.Name=value;
      if(name==='phn')this.Phone=value;
      if(name==='fx')this.Fax=value;
    }
    crateHandkler(event){
      createAccount({Name:this.Name, Phone:this.Phone, Fax:this.Fax})
      alert('Account is created');
    }
}


// import { LightningElement } from 'lwc';
// import createContact from '@salesforce/apex/CreateContacklwc.createContact';
 
// export default class FirstComponent extends LightningElement {
//     //name="Akki";
//     Name;
//     Phone;
//     Email;
//     data=[];
//     handleChange(e){
//     let {name,value}=e.target;
//     if(name==='nme'){
//         this.Name=value;
//     }
//     if(name==='ph'){
//         this.Phone=value;
//     }
//     if(name==='emal'){
//         this.Email=value;
//     }
//     //this.name=value;
//     }
//   handleClick(event){
//    createContact({LastName:this.Name,Phone:this.Phone,Email:this.Email})
//   .then(result=>{
//       alert('Contact Created');
//   })  
// }
// }