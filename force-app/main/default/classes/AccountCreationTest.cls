@isTest
private class AccountCreationTest {
    
    @isTest
    static void testCreateAcc() {
        Test.startTest();
        AccountCreation.createAcc('Test Account', '1234567890', '123-456');
        Test.stopTest();

        // Verify account was created
        List<Account> accList = [SELECT Id, Name, Phone, Fax FROM Account WHERE Name = 'Test Account'];
        System.assertEquals(1, accList.size());
        System.assertEquals('1234567890', accList[0].Phone);
        System.assertEquals('123-456', accList[0].Fax);
    }
}