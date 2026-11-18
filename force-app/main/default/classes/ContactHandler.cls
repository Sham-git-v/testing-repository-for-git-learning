public with sharing class ContactHandler {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(){
        return [select id,FirstName,LastName, Email,Phone from contact where Email!=null];
    }
    
    public static void duplicateContacts(List<Contact> conList){
		list<Contact> contoList=new list<Contact>();
        for(Contact acc: conList){
			Contact con=new Contact();
            con.LastName='dupicate contact';
            contoList.add(con);
        }
        INSERT contoList;
    }
}