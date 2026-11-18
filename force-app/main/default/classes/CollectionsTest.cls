@isTest
public class CollectionsTest {
    
    @isTest
    static void testMethod1_And5_And6_And7() {
        collections.method1();
        collections.Method5();
        collections.Method6();
        collections.Method7();
    }

    @isTest
    static void testMethod8() {
        collections.Method8(); // No DML, only list/map logic
    }
    
    @isTest
    static void testMethod9() {
    insert new Account(Name='A1', Phone='111');
    insert new Account(Name='A2', Phone='222');

    collections.Method9();
    }

    @isTest
    static void testMethod10() {
        Account acc = new Account(Name = 'Recent Acc', Phone = '9999999999');
        insert acc;

        Test.startTest();
        List<Account> result = collections.Method10();
        Test.stopTest();

        System.assert(result != null);
    }

    @isTest
    static void testMethod3_And4() {
        Contact c = new Contact(LastName = 'Test', Phone = '12345');
        insert c;

        collections.Method3();
        collections.Method4();
    }
}