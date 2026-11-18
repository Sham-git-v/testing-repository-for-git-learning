@isTest
public class SOSLDemoTest {
    @isTest
    static void testSoslMethodDemo() {
        // Create test user with unique first name
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        
        User u = new User(
            FirstName = 'VenkatSOSL',
            LastName = 'TestUser',
            Email = 'venkatsosl@example.com',
            Username = 'venkatsosluser@example.com.test',
            Alias = 'venkt',
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            ProfileId = p.Id
        );
        insert u;

        Test.startTest();
        SOSLDemo.soslMethodDemo('VenkatSOSL');
        Test.stopTest();
    }
}