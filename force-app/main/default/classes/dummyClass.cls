public class dummyClass {
    public static void insertDemo(){
		Account acc=new Account(name='test 1',phone='15447614651');
			try{
    			insert acc;
                system.debug(acc);
			}catch(DmlException ex){
    		
    		system.debug(ex);
			}
    }
}