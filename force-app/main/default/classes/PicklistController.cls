public with sharing class PicklistController {
    public class PicklistOption {
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String value {get;set;}
    }

    @AuraEnabled(cacheable=true)
    public static List<PicklistOption> getDynamicValues() {
        List<PicklistOption> options = new List<PicklistOption>();
        Dynamic_Picklist_Value__c config = [SELECT Name FROM Dynamic_Picklist_Value__c LIMIT 1];

        if (config != null && String.isNotBlank(config.Name)) {
            for (String val : config.Name.split(',')) {
                PicklistOption opt = new PicklistOption();
                opt.label = val.trim();
                opt.value = val.trim();
                options.add(opt);
            }
        }
        return options;
    }
}