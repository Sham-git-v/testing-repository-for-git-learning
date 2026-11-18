@isTest
private class AccountContactProcessorTest {
    @isTest
    static void testProcessAccountContacts() {
        // Create test account
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Create related contacts
        List<Contact> contactList = new List<Contact>();
        for (Integer i = 0; i < 2; i++) {
            contactList.add(new Contact(LastName = 'Test ' + i, Email = 'test' + i + '@test.com', AccountId = acc.Id));
        }
        insert contactList;

        Test.startTest();
        AccountContactProcessor.processAccountContacts();
        Test.stopTest();
    }

    @isTest
    static void testProcessAccountContactsAlt() {
        // Create test account
        Account acc = new Account(Name = 'Test Account Alt');
        insert acc;

        // Create related contacts
        List<Contact> contactList = new List<Contact>();
        for (Integer i = 0; i < 1; i++) {
            contactList.add(new Contact(LastName = 'Alt Contact ' + i, Email = 'alt' + i + '@test.com', AccountId = acc.Id));
        }
        insert contactList;

        Test.startTest();
        AccountContactProcessor.processAccountContactsAlt();
        Test.stopTest();
    }
}