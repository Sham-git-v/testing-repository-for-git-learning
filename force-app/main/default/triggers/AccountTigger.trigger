trigger AccountTigger on Account (After update) {
    if(trigger.isAfter && trigger.isUpdate){
        List<Contact> conList=new List<Contact>();
        for(Account acc: trigger.new){
            Contact con=new Contact();
            if(acc.Rating=='Hot'){
                con.AssistantName=acc.Rating;
                con.AccountId=acc.Id;
            }
            conList.add(con);
        }
        update conlist;
    }
}