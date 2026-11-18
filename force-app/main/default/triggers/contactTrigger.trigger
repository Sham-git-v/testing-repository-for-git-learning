trigger contactTrigger on Contact (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        ContactHandler.duplicateContacts(trigger.new);
    }
}