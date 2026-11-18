public class collections {
        
    public static void method1(){
		set<integer> strings=new set<integer>();
        strings.add(5);
        strings.add(3);
        
        system.debug(strings);
    }
    public static void Method3(){
        list<Contact> conList=[SELECT phone FROM Contact];
        set<Contact> duplicatCon=new set<Contact>(conList);
        system.debug(duplicatCon);
        for(Contact con: duplicatCon){
			system.debug(con.Phone);
        }
    }
    
    public static void Method4(){
        list<Contact> conlists=[select phone from Contact];
        set<String> setCon=new set<String>();
        for(Contact con: conlists){
            setCon.add(con.Phone);
        }
        for(String dupcons: setCon){
                system.debug(dupcons);
            }
    }
    
    public static void Method5(){
        list<string> listmethod = new  list<string>();
        listmethod.add('vasi');
        listmethod.add('raj');
        listmethod.add('ash');
        system.debug(listmethod);
        
    }
       public static void Method6(){
        Set<integer> setmethod = new Set<integer>();
           setmethod.add(9);
            setmethod.add(0);
            setmethod.add(1);
           system.debug(setmethod);
    }
    public static void Method7(){
        Map<String,integer> setmethod = new Map<String,integer>();
           setmethod.put('pramod',3);
            setmethod.put('ankith',4);
            setmethod.put('rajesh',8);  
        system.debug(setmethod);
    }
     
    public static void Method8(){
		list<map<string,integer>> myDetails =new list<map<string,integer>>();
        map<string,integer> dinesh=new map<string,integer>{'Dinesh'=>28};
            map<string,integer> Venkat=new map<string,integer>{'Venkat'=>25};
                myDetails.add(dinesh);
        		myDetails.add(Venkat);
        system.debug(dinesh);
        //1. dinesh.clear();
        system.debug(dinesh);
        
        boolean b;
        system.debug(b);
        for(map<string,integer> mps: myDetails){
            for(string lts: mps.keyset()){
				system.debug(lts);
            }
        }
        //2. clone();
    }
    
    public static void Method9(){

        List<Account> accList=[select id, name, phone from Account];
        system.debug(accList.size());
        Account acc=new Account();
        acc.Name='venkat003';
        acc.Phone='798498668';
        accList.add(1,acc);
        system.debug(accList.size());
        
    }
    
    public static list<Account> Method10(){
        list<Account> acclist=[select id, name, LastModifiedDate  from Account where LastModifiedDate  >= LAST_WEEK];
        return acclist;
        
        
        
    }
    
    
}