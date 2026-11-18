public with sharing class caseHandler {
    @AuraEnabled(cacheable=true)
    public static List<Case> getTopCaseList() {
        return [SELECT Id, CaseNumber, Type, Status, subject, origin
            FROM Case where Status != null LIMIT 10];
    }
    
    @AuraEnabled
    public static void updateRecords(List<Case> caseList){
 
        for(Case cc : caseList){
            cc.Status = 'Closed';
        }
        if(caseList.size() > 0){
        try {
            update caseList;
        } catch (Exception ex) {
            System.debug(ex.getMessage());
        }
        }
    }
}