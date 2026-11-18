public class getAccounts {
    public static void getAccountContacts(){
        Account acclist=[select id,name from Account limit 1];
        list<contact> conlist=new list<contact>();
        for(integer i=1;i<5; i++){
            Contact con=new Contact();
            con.lastName='test contact related to Account';
            con.AccountId=acclist.id;
            conlist.add(con);
        }
        system.debug(conlist);
        insert conlist;
        
        
    }
}