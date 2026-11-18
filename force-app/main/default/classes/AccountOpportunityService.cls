public with sharing class AccountOpportunityService {
    public static List<Opportunity> getHighValueOpportunities(string inpIndustry, Decimal inpminAmount){
        List<Opportunity> oppList=[SELECT Id, Name, Amount, StageName, CloseDate,
                   Account.Id, Account.Name, Account.Industry, Account.OwnerId FROM Opportunity WHERE Amount > :inpminAmount AND Account.Industry = :inpIndustry];
        
        return oppList;
    }
}