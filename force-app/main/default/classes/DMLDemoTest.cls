@isTest
public class DMLDemoTest {
    @isTest
    static void testMultipleContactInsert() {
        // Prepare input data
        List<String> contactNames = new List<String>{'Test One', 'Test Two', 'Test Three'};

        // Start test context
        Test.startTest();
        DMLDemo.multipleContactInsert(contactNames);
        Test.stopTest();

        // Verify contacts were inserted
        List<Contact> insertedContacts = [SELECT Id, LastName, Email FROM Contact WHERE LastName IN :contactNames];
        System.assertEquals(3, insertedContacts.size(), 'Three contacts should be inserted.');
        for (Contact c : insertedContacts) {
            System.assertEquals('default@gamil.com', c.Email);
        }
    }
}