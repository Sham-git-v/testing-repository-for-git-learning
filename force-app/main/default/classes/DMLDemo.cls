public with sharing class DMLDemo {
    public static void multipleContactInsert(list<string> ContactName){
        List<Contact> conList =new List<Contact>();
        for(String con: ContactName){
            Contact cons=new Contact(LastName=con, Email='default@gamil.com');
            conList.add(cons);
        }
        if (!conList.isEmpty()) {
            try {
                insert conList;
                for(Contact cont: conList){
                    System.debug('contact id: '+ cont.id);
                }
            } catch (Exception ex) {
                System.debug('Exception Message ' + ex.getMessage());
            }
        }
    }

    public static void updateRatingHotorCold(){
        
    }
}