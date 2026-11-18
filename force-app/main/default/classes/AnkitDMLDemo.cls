public with sharing class AnkitDMLDemo {
      public static void insertSinglRecord(String accountName,String accountIndustry, String phoneNumber){
 
        //1. Instantite the account record
        Account acc = new Account(Name=accountName, Industry = accountIndustry, Phone = phoneNumber);
 
        // //2. Populate the fields of Account
        // acc.Name = accountName;
        // acc.Industry = accountIndustry;
        // acc.Phone = phoneNumber;
       //3.Insert the Account.
       try {
            insert acc;
            System.debug('Inserted Record Id ' + acc.Id);
       } catch (Exception ex) {
            System.debug('Exception MEssage ' + ex.getMessage());
       }
 
    }
    //Account name must be same as lastname of contact
    public static void insertAccountWithRelatedContact(String accountName){
        Account acc = new Account(Name = accountName);
        try {
            insert acc;
        } catch (Exception ex) {
            System.debug('Exception MEssage ' + ex.getMessage());
        }
        System.debug('Account Id' + acc.Id);
        Contact con = new Contact(lastname = accountName,AccountId = acc.Id,Email = 'test@test.com');
        try {
            insert con;
            System.debug('Contact Id' + con.Id);
 
        } catch (Exception ex) {
           System.debug('Exception MEssage ' + ex.getMessage());
        }
    }
 
    public static void multipleAccountsInsert(List<String> accountNameList){
        List<Account> accList = new List<Account>();
        for(String accName : accountNameList){
            Account acc = new Account(Name = accName);
           accList.add(acc);
        }
 
        if(!accList.isEmpty()){
             try {
                insert accList;
                for(Account acc : accList){
                    System.debug('Account Id' + acc.Id);
                }
            } catch (Exception ex) {
                System.debug('Exception Message ' + ex.getMessage());
            }
        }
    }
 
    /**
     List<String> accountNameList = new List<String>();
    accountNameList.add('Test Account 1');
    accountNameList.add('Test Account 2');
    accountNameList.add('Test Account 3');
    accountNameList.add('Test Account 4');
    DMLDemo.multipleAccountsInsert(accountNameList);
     */
 
    //one Apex Method -- getting multiple contact names as input, create the contacts with default email : test@test.com

    // Update the rating as Hot if revenue is greater than 5M else update the rating as Cold
// Get the related contact based on phone number and update the same phone number on related cases.  
 
 //Rule : subquery and child relationship name            
    public static void updateParentToChildRelatedRecords(){
        List<Contact> updatedContactList = new List<Contact>();
        List<Account> accList = [Select id,Description,(select Id,Description from contacts) from Account WHERE Id IN (SELECT AccountId FROM Contact)];
        for(Account acc : accList){
            for(Contact con : acc.Contacts){
                con.Description = acc.Description;
                con.Email = 'test@test.com';
                //update con;
                updatedContactList.add(con);
            }
        }
        if(!updatedContactList.isEmpty()){
             try {
                update updatedContactList;
            } catch (Exception ex) {
                System.debug(ex.getMessage());
            }
        }
    }
 
     //whenever exising contact is updated, update the contact name to account name in description field.
    public static void updateChildToParentRecords(String updatedDescription){
 
        List<Contact> conList = [select id,AccountId,description from Contact where Email = 'test@test.com' ];
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact con : conList){
            con.Description = updatedDescription;
           
            if(string.isNotBlank(con.AccountId)){
                accountIdSet.add(con.AccountId);
            }
        }
 
        List<Account> accList = [select id,name,description from Account where id in :accountIdSet];
        for(Account acc: accList){
            acc.Description = updatedDescription;
        }
 
        try {
            if(!conList.isEmpty()) {
                update conList;
            }
            if(!accList.isEmpty()){
                update accList;
            }
        } catch (Exception ex) {
            System.debug(Ex.getMessage());
        }
    }
 
    //one Apex Method -- getting multiple contact names as input, create the contacts with default email : test@test.com
    //if the case is in closed state, then update the account with the SLA as 'Platinum'
    //select id,Status,AccountId,Account.SLA__C from Case where Status = 'Closed'
 
 

}