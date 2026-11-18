@isTest
private class BatchableMethodTest {

    @isTest
    static void testBatchableMethod() {
        // Insert only up to 2 records to match batch scope
        List<Case> caseList = new List<Case>();
        for (Integer i = 0; i < 2; i++) {
            caseList.add(new Case(Subject = 'Test Case ' + i, Origin = 'Email', Priority = 'Low'));
        }
        insert caseList;

        // Run the batch with batch size 2
        Test.startTest();
        Database.executeBatch(new BatchableMethod(), 2);
        Test.stopTest();

        // Assert case priority is updated
        for (Case c : [SELECT Priority FROM Case]) {
            System.assertEquals('High', c.Priority);
        }
    }
}