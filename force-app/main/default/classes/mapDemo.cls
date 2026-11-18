public class mapDemo {
    public static void iterateMap(){
        map<list<Account>,list<Contact>> accMap=new map<list<Account>,list<Contact>>();
        list<Account> accList=[select id,name,(select id,lastName from Contacts) from Account];
        list<Contact> conList=new list<Contact>();
        for(Account acc:accList){
            for(Contact con: acc.Contacts){
                conList.add(con);
                accMap.put(accList,conList);
            }
        }
        
        for(list<Account> acmm: accMap.keyset()){
            system.debug(acmm);
        }
        system.debug(accMap);
        system.debug(conList);
        system.debug(accList);
        
    }
}