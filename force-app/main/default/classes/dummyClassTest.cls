@isTest
private class dummyClassTest {
    @isTest
    static void testInsertDemo() {
        Test.startTest();
        dummyClass.insertDemo();
        Test.stopTest();
        
        // Assert record was inserted
        List<Account> accounts = [SELECT Id, Name, Phone FROM Account WHERE Name = 'test 1'];
        System.assertEquals(1, accounts.size(), 'Account should be inserted');
    }
}