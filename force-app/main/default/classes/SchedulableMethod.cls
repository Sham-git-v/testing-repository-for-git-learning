public class SchedulableMethod implements Schedulable{
    public void execute(SchedulableContext sc){
        list<Account> accIds=new list<Account>();
		list<Account> acclist=[select id from Account where rating='warm' AND ID NOT IN (SELECT accountId from Opportunity where isClosed=false) AND ID NOT IN (SELECT accountId from Case)];
        for(Account acc: acclist){
            if(acc.id!=null){
             	accIds.add(acc);   
            }
        }
        if(!accIds.isEmpty()){
            try{
                delete accIds;
            }catch(Exception ex){
                system.debug(ex.getMessage());
            }
        }
        
    }
}