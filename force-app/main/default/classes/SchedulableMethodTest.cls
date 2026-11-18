@isTest
private class SchedulableMethodTest {

    @isTest
    static void testSchedulable() {
        // Create an Account that meets deletion criteria
        Account accToDelete = new Account(Name = 'Delete Me', Rating = 'Warm');
        insert accToDelete;

        // Create another account with an open Opportunity (should not be deleted)
        Account accWithOpp = new Account(Name = 'Keep Me', Rating = 'Warm');
        insert accWithOpp;

        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            CloseDate = Date.today().addDays(10),
            StageName = 'Prospecting',
            AccountId = accWithOpp.Id
        );
        insert opp;

        // Create another account with a Case (should not be deleted)
        Account accWithCase = new Account(Name = 'Also Keep Me', Rating = 'Warm');
        insert accWithCase;

        Case cs = new Case(Subject = 'Test Case', AccountId = accWithCase.Id);
        insert cs;

        // Call the scheduler logic
        Test.startTest();
        new SchedulableMethod().execute(null);
        Test.stopTest();

        // Verify only accToDelete was deleted
        List<Account> remaining = [SELECT Name FROM Account WHERE Id IN :new List<Id>{accToDelete.Id, accWithOpp.Id, accWithCase.Id}];
        System.assertEquals(2, remaining.size(), 'Only one account should be deleted');
        for (Account acc : remaining) {
            System.assertNotEquals('Delete Me', acc.Name);
        }
    }
}