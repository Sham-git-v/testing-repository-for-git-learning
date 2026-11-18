public with sharing class AccountCreation {
    @auraenabled
    public static void createAcc(string Name, string Phone, string Fax){
        Account acc=new Account();
        acc.Name=Name;
        acc.Phone=Phone;
        acc.Fax=Fax;
        insert acc;
    }
   
}


// public with sharing class CreateContacklwc {
//     @AuraEnabled
//     public static void createContact(string LastName, string Phone, string Email){
//         contact c = new contact();
//         c.LastName = LastName;
//         c.Phone = Phone;
//         c.Email = Email;
//         insert c;
//     }
// }