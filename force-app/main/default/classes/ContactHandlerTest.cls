@isTest
private class ContactHandlerTest {

    @isTest
    static void testGetContactList() {
        // Create test data
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Contact c1 = new Contact(LastName = 'One', Email = 'one@test.com', AccountId = acc.Id);
        Contact c2 = new Contact(LastName = 'Two', Email = null, AccountId = acc.Id);
        insert new List<Contact>{ c1, c2 };

        Test.startTest();
        List<Contact> result = ContactHandler.getContactList();
        Test.stopTest();

        // Should return only contact with non-null Email
        System.assertEquals(2, result.size());
        System.assertEquals('one@test.com', result[0].Email);
    }

    @isTest
    static void testDuplicateContacts() {
        // Create sample contact list
        Contact sample = new Contact(LastName = 'Sample Contact');
        insert sample;

        List<Contact> inputList = new List<Contact>{ sample };

        Test.startTest();
        ContactHandler.duplicateContacts(inputList);
        Test.stopTest();

        // Query the inserted "duplicate" contact
        List<Contact> contacts = [SELECT Id, LastName FROM Contact WHERE LastName = 'dupicate contact'];
        System.assertEquals(1, contacts.size(), 'Should insert one duplicate contact');
    }
}