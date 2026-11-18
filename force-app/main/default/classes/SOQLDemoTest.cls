@isTest
public class SOQLDemoTest {
    @isTest
    static void testSOQLDemoMethods() {
        // Create Account with Rating = 'Hot'
        Account acc = new Account(Name = 'Test Account', Rating = 'Hot');
        insert acc;

        // Create Opportunities
        Opportunity opp1 = new Opportunity(
            Name = 'Opp 1',
            StageName = 'Closed Won',
            CloseDate = Date.today().addDays(10),
            Amount = 1000,
            AccountId = acc.Id
        );
        insert opp1;

        // Create a Case with Status = 'Closed'
        Case c = new Case(
            Subject = 'Test Case',
            Priority = 'High',
            Status = 'Closed'
        );
        insert c;

        // Create Case with Status = 'New'
        Case c2 = new Case(
            Subject = 'Open Case',
            Priority = 'Low',
            Status = 'New'
        );
        insert c2;

        // Call SOQLDemo methods
        Test.startTest();
        SOQLDemo.getAccountWithHotRating();
        SOQLDemo.getAccountWithHotRatingUsingForSOQL();
        SOQLDemo.getAllOpportunityWithStageClosedwon();
        SOQLDemo.getAllOpportunityWithStageClosedwon('Closed Won');
        SOQLDemo.getAllCasesWithStatusIsClosed('Closed');
        SOQLDemo.getAllCasesWithStatusIsClosed();
        SOQLDemo.getAllAccountWithAnnualRevenuebyINdustry();
        SOQLDemo.childOpportunityofAccount();
        SOQLDemo.childToParentRelationships();
        Test.stopTest();
    }
}