public class AccountContactProcessor {
	public static void processAccountContacts() {
        Map<Id, List<Contact>> accountToContactsMap = new Map<Id, List<Contact>>();
 
        List<Account> accounts = [SELECT Id, Name,(SELECT Id, Name, Email FROM Contacts)FROM Account];
 
        for (Account acc : accounts) {
            accountToContactsMap.put(acc.Id, acc.Contacts);
        }
 
        for (Id accountId : accountToContactsMap.keySet()) {
            Account acc = [SELECT Id, Name FROM Account WHERE Id = :accountId];
            System.debug('Account Name: ' + acc.Name);
 
            List<Contact> contacts = accountToContactsMap.get(accountId);
            if (contacts != null) {
                for (Contact con : contacts) {
                    System.debug('Contact Name: ' + con.Name + ', Email: ' + con.Email);
                }
            } else {
                System.debug('No contacts found for this account.');
            }
        }
    }
    public static void processAccountContactsAlt() {
        List<Account> accounts = [SELECT Id, Name,(SELECT Id, Name, Email FROM Contacts)FROM Account];
        for (Account acc : accounts) {
            System.debug('Account Name: ' + acc.Name);
                for (Contact con : acc.Contacts) {
                    System.debug('Contact Name: ' + con.Name + ', Email: ' + con.Email);
                }
    	}
	}
}