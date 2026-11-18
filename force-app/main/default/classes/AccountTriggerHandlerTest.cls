@isTest
private class AccountTriggerHandlerTest {
    
    @isTest
    static void testBeforeInsertLogic() {
        Account acc1 = new Account(Name = 'Acc Silver', AnnualRevenue = 40000);
        Account acc2 = new Account(Name = 'Acc Platinum', AnnualRevenue = 600000);
        Account acc3 = new Account(Name = 'Acc Gold', AnnualRevenue = 1000000); // Should fall into Platinum due to your logic

        List<Account> accList = new List<Account>{ acc1, acc2, acc3 };

        Test.startTest();
        AccountTriggerHandler.beforeInsert(accList);
        Test.stopTest();

        System.assertEquals('Silver', acc1.SLA__c);
        System.assertEquals('Platinum', acc2.SLA__c);
        System.assertEquals('Platinum', acc3.SLA__c); // Gold condition is unreachable due to logic
    }

    @isTest
    static void testBeforeUpdateLogic() {
        // Insert account with industry
        Account acc = new Account(Name = 'Test Industry', Industry = 'Technology', AnnualRevenue = 300000, SLA__c = 'Gold');
        insert acc;

        // Modify industry to blank to trigger SLA__c = ''
        acc.Industry = '';
        Map<Id, Account> oldMap = new Map<Id, Account>{
            acc.Id => [SELECT Id, Industry FROM Account WHERE Id = :acc.Id]
        };

        List<Account> updatedList = new List<Account>{ acc };

        Test.startTest();
        AccountTriggerHandler.beforeUpdate(updatedList, oldMap);
        Test.stopTest();

        System.assertEquals('', acc.SLA__c);
    }
}