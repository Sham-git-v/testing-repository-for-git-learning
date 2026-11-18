@isTest
private class AccountOpportunityServiceTest {

    @isTest
    static void testGetHighValueOpportunities() {
        // Create Account
        Account acc = new Account(Name = 'Test Corp', Industry = 'Technology');
        insert acc;

        // Create Opportunities
        Opportunity opp1 = new Opportunity(
            Name = 'Opportunity 1',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            Amount = 15000,
            AccountId = acc.Id
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Opportunity 2',
            StageName = 'Proposal/Price Quote',
            CloseDate = Date.today().addDays(15),
            Amount = 8000,
            AccountId = acc.Id
        );

        insert new List<Opportunity>{ opp1, opp2 };

        Test.startTest();
        List<Opportunity> result = AccountOpportunityService.getHighValueOpportunities('Technology', 10000);
        Test.stopTest();

        // Verify the result
        System.assertEquals(1, result.size(), 'Only one opportunity should meet the criteria');
        System.assertEquals(opp1.Id, result[0].Id, 'Returned opportunity should be the one with amount > 10000');
    }
}