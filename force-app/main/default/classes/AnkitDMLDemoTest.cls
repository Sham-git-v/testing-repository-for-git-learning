@isTest
private class AnkitDMLDemoTest {

    @isTest
    static void testInsertSingleRecord() {
        Test.startTest();
        AnkitDMLDemo.insertSinglRecord('Single Account', 'Technology', '1234567890');
        Test.stopTest();
        
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'Single Account' LIMIT 1];
        System.assertEquals('Single Account', acc.Name);
    }

    @isTest
    static void testInsertAccountWithRelatedContact() {
        Test.startTest();
        AnkitDMLDemo.insertAccountWithRelatedContact('RelatedAcc');
        Test.stopTest();
        
        Account acc = [SELECT Id FROM Account WHERE Name = 'RelatedAcc' LIMIT 1];
        Contact con = [SELECT Id, LastName, AccountId FROM Contact WHERE LastName = 'RelatedAcc' LIMIT 1];
        System.assertEquals(acc.Id, con.AccountId);
    }

    @isTest
    static void testMultipleAccountsInsert() {
        List<String> accNames = new List<String>{'Acc1', 'Acc2', 'Acc3'};
        Test.startTest();
        AnkitDMLDemo.multipleAccountsInsert(accNames);
        Test.stopTest();
        
        Integer count = [SELECT COUNT() FROM Account WHERE Name IN :accNames];
        System.assertEquals(3, count);
    }

    @isTest
    static void testUpdateParentToChildRelatedRecords() {
        Account acc = new Account(Name = 'Parent Account', Description = 'Desc from parent');
        insert acc;
        Contact con = new Contact(LastName = 'Child', AccountId = acc.Id);
        insert con;

        Test.startTest();
        AnkitDMLDemo.updateParentToChildRelatedRecords();
        Test.stopTest();

        Contact updateddd = [SELECT Description, Email FROM Contact WHERE Id =:con.Id];
        System.assertEquals('Desc from parent', updateddd.Description);
        System.assertEquals('test@test.com', updateddd.Email);
    }

    @isTest
    static void testUpdateChildToParentRecords() {
        Account acc = new Account(Name = 'Parent A');
        insert acc;

        Contact con = new Contact(LastName = 'Test', Email = 'test@test.com', AccountId = acc.Id);
        insert con;

        Test.startTest();
        AnkitDMLDemo.updateChildToParentRecords('Updated Desc');
        Test.stopTest();

        Account updatedAcc = [SELECT Description FROM Account WHERE Id = :acc.Id];
        Contact updatedCon = [SELECT Description FROM Contact WHERE Id = :con.Id];
        System.assertEquals('Updated Desc', updatedAcc.Description);
        System.assertEquals('Updated Desc', updatedCon.Description);
    }
}