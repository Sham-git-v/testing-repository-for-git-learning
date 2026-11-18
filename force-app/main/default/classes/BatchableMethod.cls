public class BatchableMethod implements Database.Batchable<sObject>{
    public Database.QueryLocator Start(Database.BatchableContext dbc){
        return Database.getQueryLocator('SELECT id, origin, priority FROM Case');
    }
    
    public void execute(Database.BatchableContext dbs, list<Case> caseList){
        for(Case cs: caseList){
            if(cs.Origin=='Email'){
            	cs.Priority='High';                
            }
        }
        if(!caseList.isEmpty()){
            try{
                update caseList;
            }catch(Exception ex){
                system.debug(ex.getMessage());
            }
        }
    }
    
    public void finish(Database.BatchableContext dbc){
        AsyncApexJob jobDetails=[SELECT Id, JobItemsProcessed, Status, CreatedBy.Email, NumberOfErrors FROM AsyncApexJob where id=:dbc.getJobId()];
        Messaging.singleEmailMessage email=new Messaging.singleEmailMessage();
        list<string> emailAddresses=new list<string>();
        emailAddresses.add(jobDetails.Createdby.email);
        email.setToAddresses(emailAddresses);
        email.setSubject('This is Batch Method for processing Case');
        email.setPlainTextBody('This process updates the case record which are having the origin as email and updating the Priority as High.');
        list<Messaging.SingleEmailMessage> emailList=new list<Messaging.SingleEmailMessage>();
        emailList.add(email);
        Messaging.sendEmail(emailList);
    }
}