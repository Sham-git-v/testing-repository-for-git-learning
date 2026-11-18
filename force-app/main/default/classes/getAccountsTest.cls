@isTest
public class getAccountsTest {

    @isTest
    static void testGetAccountContacts() {
        // Create a dummy account for test context
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Test.startTest();
        getAccounts.getAccountContacts();
        Test.stopTest();

        // Validate that 5 contacts are inserted
        List<Contact> contacts = [SELECT Id FROM Contact WHERE LastName = 'test contact related to Account'];
        System.assertEquals(4, contacts.size());

    }
}