public with sharing class AccountTriggerHandler {
    public static Set<Id> processedAccounts = new Set<Id>();
    
    public static void beforeInsert(List<Account> newAccoutnList){
        for(Account acc: newAccoutnList){
            if(acc.AnnualRevenue<50000){
                acc.SLA__c='Silver';
            }else if(acc.AnnualRevenue<500000 && acc.AnnualRevenue>2000000){
                acc.SLA__c='Gold';

            }else if(acc.AnnualRevenue>500000){
                acc.SLA__c='Platinum';
            }
        }

    }

    public static void beforeUpdate(List<Account> newAccoutnList,Map<id,Account> oldAccountMapList){
        for(Account newAcc: newAccoutnList){
            string newIndustryValue=newAcc.Industry;
            Account oldRecord=oldAccountMapList.get(newAcc.id);
            string oldIndustryValue=oldRecord.Industry;
            if(newIndustryValue != oldIndustryValue && String.isBlank(newIndustryValue)){
                newAcc.SLA__c='';
            }
        }
    }
    
    
}