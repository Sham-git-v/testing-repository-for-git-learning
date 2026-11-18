@isTest
public class ValidationEmailAddressTest {
    
    // Mock class to simulate HTTP response
    public class MockEmailValidationCallout implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(200);
            res.setBody(
                '{' +
                '"email":"venkateshwarraokandulk21@gmail.com",' +
                '"autocorrect":"",' +
                '"deliverability":"DELIVERABLE",' +
                '"quality_score":"0.80",' +
                '"is_valid_format":{"value":true,"text":"TRUE"},' +
                '"is_free_email":{"value":true,"text":"TRUE"},' +
                '"is_disposable_email":{"value":false,"text":"FALSE"},' +
                '"is_role_email":{"value":false,"text":"FALSE"},' +
                '"is_catchall_email":{"value":false,"text":"FALSE"},' +
                '"is_mx_found":{"value":true,"text":"TRUE"},' +
                '"is_smtp_valid":{"value":true,"text":"TRUE"}' +
                '}'
            );
            return res;
        }
    }

    @isTest
    static void testValidateEmail() {
        // Register mock
        Test.setMock(HttpCalloutMock.class, new MockEmailValidationCallout());

        Test.startTest();
        ValidationEmailAddress.validateEmail('venkateshwarraokandulk21@gmail.com');
        Test.stopTest();
        
        // No asserts required as this method doesn't return anything,
        // but you can verify in logs/debug or extend functionality.
    }
}