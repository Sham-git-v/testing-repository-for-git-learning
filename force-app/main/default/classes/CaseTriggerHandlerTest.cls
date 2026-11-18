@isTest
public class CaseTriggerHandlerTest {

    @testSetup
    static void setupData() {
        // Create an Account (as Case requires it optionally)
        Account acc = new Account(Name='Test Account');
        insert acc;

        // Insert Case with High priority to trigger beforeInsert logic
        Case c = new Case(
            Subject = 'Test Case',
            Priority = 'High',
            Reason = 'Initial Reason',
            AccountId = acc.Id
        );
        insert c;

        // Insert a Case with Reason (will be used to test beforeUpdate)
        Case c2 = new Case(
            Subject = 'To Update Case',
            Priority = 'Medium',
            Reason = 'Old Reason',
            AccountId = acc.Id
        );
        insert c2;
    }

    @isTest
    static void testBeforeInsertLogic() {
        Case newCase = new Case(
            Subject = 'Insert Check',
            Priority = 'High'
        );

        Test.startTest();
        CaseTriggerHandler.beforeInsert(new List<Case>{newCase});
        Test.stopTest();

        System.assertEquals('Working', newCase.Status, 'Status should be set to Working when Priority is High');
    }

    @isTest
    static void testBeforeUpdateLogic() {
        // Get the inserted case to update
        Case existing = [SELECT Id, Reason, Priority FROM Case WHERE Subject = 'To Update Case' LIMIT 1];
        existing.Reason = '';

        Map<Id, Case> oldMap = new Map<Id, Case>{
            existing.Id => new Case(Id = existing.Id, Reason = 'Old Reason')
        };

        Test.startTest();
        CaseTriggerHandler.beforeUpdate(new List<Case>{existing}, oldMap);
        Test.stopTest();

        System.assertEquals('Low', existing.Priority, 'Priority should change to Low if Reason is cleared');
    }

    @isTest
    static void testGetCaseByStatus() {
        // Insert a case with a known status
        Case c = new Case(Subject='Status Test', Status='New');
        insert c;

        Test.startTest();
        List<Case> result = CaseTriggerHandler.getCaseByStatus('New');
        Test.stopTest();

        System.assert(result.size() > 0, 'Should return at least one case with status like "New"');
    }

    @isTest
    static void testGetCaseByStatusBlank() {
        Test.startTest();
        List<Case> result = CaseTriggerHandler.getCaseByStatus('');
        Test.stopTest();

        System.assertEquals(0, result.size(), 'Blank status should return empty list');
    }
}