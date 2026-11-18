public with sharing class AccountHandler {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountByIndustry(string inpIndustry){
        list<Account> accList= new list<Account>();
        if(string.isBlank(inpIndustry)){
            return accList;
        }else{
            string key= '%'+inpIndustry+'%';
            accList=[select id, Name, Rating, Phone, Industry, AnnualRevenue from Account where Industry like :key LIMIT 10];
            return accList;
        }
    }


    @AuraEnabled(cacheable=true)
    public static list<Account> getAccRecByRating(string InpRating){
       list<Account> accList= new list<Account>();
        if(string.isBlank(InpRating)){
            return accList;
        }else{
            string key= '%'+InpRating+'%';
            accList=[select id, Name, Rating, Phone, Industry, AnnualRevenue from Account where Rating like :key LIMIT 10];
            return accList;
        } 
        
    }
}