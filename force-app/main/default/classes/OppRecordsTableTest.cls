@isTest
private class OppRecordsTableTest {

    @isTest
    static void testGetOpps() {
        // Setup test data
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Opportunity opp1 = new Opportunity(
            Name = 'Opp A',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            Amount = 5000,
            AccountId = acc.Id
        );
        
        Opportunity opp2 = new Opportunity(
            Name = 'Opp B',
            StageName = 'Qualification',
            CloseDate = Date.today().addDays(60),
            Amount = 10000,
            AccountId = acc.Id
        );

        Opportunity opp3 = new Opportunity(
            Name = 'Opp C',
            StageName = 'Needs Analysis',
            CloseDate = Date.today().addDays(90),
            Amount = null, // Should be excluded
            AccountId = acc.Id
        );

        insert new List<Opportunity>{opp1, opp2, opp3};

        Test.startTest();
        List<Opportunity> result = OppRecordsTable.getOpps();
        Test.stopTest();

        // Assert only 2 opportunities with non-null amount
        System.assertEquals(2, result.size(), 'Should return only opportunities with non-null Amount');

        // Assert ordering by Amount
        System.assert(result[0].Amount <= result[1].Amount, 'Opportunities should be ordered by Amount');
    }
}