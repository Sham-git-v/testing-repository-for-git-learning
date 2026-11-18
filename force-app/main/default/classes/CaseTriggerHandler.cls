public with sharing class CaseTriggerHandler {
  public static void beforeInsert(List<Case> newRecordList){
    for(Case cc: newRecordList){
        if(cc.Priority=='High'){
            cc.Status='Working';
        }

    }
  }
   public static void beforeUpdate(List<Case> newRecordList, map<id,Case> oldRecordList){
    for(Case newcc: newRecordList){
      String newValue= newcc.Reason;
      Case oldRecord = oldRecordList.get(newcc.id);
      string oldValueReason=oldRecord.Reason;
      if(newValue!=oldValueReason && String.isBlank(newValue)){
        newcc.Priority='Low';
      }
        
      
    }
   }
   @AuraEnabled(cacheable=false)
    public static List<Case> getCaseByStatus(String inpStatus){
        List<Case> csList = new List<Case>();
        if(String.isBlank(inpStatus)){
            return csList;
        }else{
            String key = '%'+inpStatus+'%';
            csList = [SELECT Id, AccountId, Origin, Reason,Priority,
                Status, Type
            FROM Case where Status like :key LIMIT 10];
            return csList;
        }
    }
    


}