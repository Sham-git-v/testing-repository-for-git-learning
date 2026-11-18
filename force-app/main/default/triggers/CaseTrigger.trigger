/*
*before+insert
*trigger.new
*/
trigger CaseTrigger on Case (before insert, before Update) {
    if(trigger.isBefore){
        if (trigger.isInsert) {
            CaseTriggerHandler.beforeInsert(trigger.new);
        }
        if (trigger.isUpdate) {
            CaseTriggerHandler.beforeUpdate(trigger.new,trigger.oldMap);
        }
    }
}