@isTest
private class AccountsRecordsTest {
    
    @isTest
    static void testToScreenFlowAccount() {
        // Prepare test data
        List<Account> accList = new List<Account>();
        for (Integer i = 0; i < 3; i++) {
            accList.add(new Account(Name = 'Test Account ' + i, Phone = '1234567890'));
        }
        insert accList;

        Test.startTest();
        List<List<Account>> result = AccountsRecords.toScreenFlowAccount();
        Test.stopTest();

        // Basic assertions
        System.assertNotEquals(null, result);
        System.assert(result[0].size() >= 3, 'Expected at least 3 accounts returned');
    }
}