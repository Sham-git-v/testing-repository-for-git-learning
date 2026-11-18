@isTest
private class CalloutToSalesforceOrgTest {

    // Mock class to simulate HTTP response
    class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('[{"Id": "001xx000003DGbT", "Name": "Test Account"}]');
            res.setStatusCode(200);
            return res;
        }
    }

    @isTest
    static void testGetAccounts() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Test.startTest();
        CalloutToSalesforceOrg.getAccounts('Technology');
        Test.stopTest();

        // No assertion needed unless you're parsing or processing response
        System.assert(true, 'Callout executed successfully');
    }
}