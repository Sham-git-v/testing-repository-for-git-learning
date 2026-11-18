public with sharing class OppRecordsTable {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpps(){
        return [Select Id, Name, StageName, Amount from Opportunity where Amount !=null order by Amount];
    }
}