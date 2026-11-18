@isTest
public class mapDemoTest {
    @isTest
    static void testIterateMap() {
        // Create test Accounts
        List<Account> accList = new List<Account>();
        for (Integer i = 0; i < 2; i++) {
            accList.add(new Account(Name = 'Test Account ' + i));
        }
        insert accList;

        // Create test Contacts related to those Accounts
        List<Contact> conList = new List<Contact>();
        for (Account acc : accList) {
            for (Integer i = 0; i < 2; i++) {
                conList.add(new Contact(LastName = 'Test Contact ' + i, AccountId = acc.Id));
            }
        }
        insert conList;

        // Call the method to test
        Test.startTest();
        mapDemo.iterateMap();
        Test.stopTest();

        // No asserts here since method has no return; we're just ensuring it runs without error
    }
}