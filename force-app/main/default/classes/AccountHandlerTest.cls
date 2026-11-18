@isTest
private class AccountHandlerTest {

    @isTest
    static void testGetAccountByIndustry() {
        // Prepare test data
        Account acc1 = new Account(Name = 'Tech Corp', Industry = 'Technology', Phone = '1111111111');
        Account acc2 = new Account(Name = 'Finance Inc', Industry = 'Finance', Phone = '2222222222');
        insert new List<Account>{acc1, acc2};

        Test.startTest();
        List<Account> techAccounts = AccountHandler.getAccountByIndustry('Tech');
        Test.stopTest();

        System.assertNotEquals(0, techAccounts.size(), 'Should return matching industry records');
        System.assertEquals(true, techAccounts[0].Industry.contains('Tech'));
    }

    @isTest
    static void testGetAccountByIndustry_BlankInput() {
        Test.startTest();
        List<Account> result = AccountHandler.getAccountByIndustry('');
        Test.stopTest();
        System.assertEquals(0, result.size(), 'Should return empty list for blank input');
    }

    @isTest
    static void testGetAccRecByRating() {
        // Prepare test data
        Account acc1 = new Account(Name = 'Hot Deals', Rating = 'Hot', Phone = '3333333333');
        Account acc2 = new Account(Name = 'Warm Leads', Rating = 'Warm', Phone = '4444444444');
        insert new List<Account>{acc1, acc2};

        Test.startTest();
        List<Account> hotAccounts = AccountHandler.getAccRecByRating('Hot');
        Test.stopTest();

        System.assertNotEquals(0, hotAccounts.size(), 'Should return matching rating records');
        System.assertEquals('Hot', hotAccounts[0].Rating);
    }

    @isTest
    static void testGetAccRecByRating_BlankInput() {
        Test.startTest();
        List<Account> result = AccountHandler.getAccRecByRating('');
        Test.stopTest();
        System.assertEquals(0, result.size(), 'Should return empty list for blank input');
    }
}