@isTest
private class caseHandlerTest {
    
    @testSetup
    static void setupData() {
        List<Case> testCases = new List<Case>();
        for (Integer i = 0; i < 5; i++) {
            testCases.add(new Case(
                Subject = 'Test Case ' + i,
                Status = 'New',
                Origin = 'Phone',
                Type = 'Problem'
            ));
        }
        insert testCases;
    }

    @isTest
    static void testGetTopCaseList() {
        Test.startTest();
        List<Case> cases = caseHandler.getTopCaseList();
        Test.stopTest();

        System.assertNotEquals(0, cases.size(), 'Should return some cases');
        System.assertEquals(true, cases[0].Status != null, 'Status should not be null');
    }

    @isTest
    static void testUpdateRecords() {
        List<Case> caseList = [SELECT Id, Status FROM Case LIMIT 3];

        for (Case c : caseList) {
            c.Status = 'Working';
        }
        update caseList;

        Test.startTest();
        caseHandler.updateRecords(caseList);
        Test.stopTest();

        List<Case> updatedCases = [SELECT Id, Status FROM Case WHERE Id IN :caseList];
        for (Case c : updatedCases) {
            System.assertEquals('Closed', c.Status, 'Status should be updated to Closed');
        }
    }
}