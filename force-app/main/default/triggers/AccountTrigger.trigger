/**
 * event:type of trigger+DML operation=Before insert
 * context variables: trigger.new
 */
trigger AccountTrigger on Account (before insert, before update, after update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            AccountTriggerHandler.beforeInsert(trigger.new);
        }
        if(trigger.isUpdate){
            AccountTriggerHandler.beforeUpdate(trigger.new,trigger.oldMap);
        }
    }
    
    
    List<Account> updatedAccounts = new List<Account>();

    for (Account acc : Trigger.new) {
        if (!AccountTriggerHandler.processedAccounts.contains(acc.Id) && acc.Name != Trigger.oldMap.get(acc.Id).Name) {
            acc.Description = 'Name changed to: ' + acc.Name;
            updatedAccounts.add(acc);
            AccountTriggerHandler.processedAccounts.add(acc.Id); // Track processed records
        }
    }

    if (!updatedAccounts.isEmpty()) {
        update updatedAccounts;
    }
    
}