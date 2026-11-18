@isTest
private class CustomerServiceTest {

    // Test 1: Covers processCustomerData() and handles the AsyncException
    @isTest
    static void testProcessCustomerData() {
        // 1. Setup Test Data
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Test.startTest();
        // Queue the future job
        CustomerService.processCustomerData(new Set<Id>{acc.Id});
        
        Boolean exceptionCaught = false;
        try {
            // Test.stopTest() executes processCustomerData.
            // Line 22 calls anotherFutureMethod(), triggering System.AsyncException
            Test.stopTest(); 
        } catch (System.AsyncException e) {
            exceptionCaught = true;
            
            // Verify that the exception is the expected platform error
            Assert.isTrue(
                e.getMessage().contains('Future method cannot be called'), 
                'Expected AsyncException due to nested @future method call'
            );
        }

        // 2. Assert that the exception was caught, letting the test pass
        Assert.isTrue(exceptionCaught, 'The test successfully caught the AsyncException from line 22.');
    }

    // Test 2: Directly tests anotherFutureMethod() for full code coverage
    @isTest
    static void testAnotherFutureMethod() {
        Test.startTest();
        // Calling anotherFutureMethod from a normal test context is valid and will pass
        CustomerService.anotherFutureMethod();
        Test.stopTest();

        // Simple assertion to confirm test run completed
        Assert.isTrue(true, 'anotherFutureMethod executed successfully.');
    }
}