public with sharing class SOQLDemo {
    public static void getAccountWithHotRating(){
        list<account> accList=[select id, name, rating from Account where Rating = 'Hot'];
        for(Account acc: accList){
            System.debug(acc.name);
        }
    }
    
    public static void getAccountWithHotRatingUsingForSOQL(){
        for(Account acc: [select id,name,Rating from Account where Rating='Hot']){
            System.debug(acc.name);
        }
    }

    public static void getAllOpportunityWithStageClosedwon(){
        for(Opportunity opp: [select id, Name, 	StageName,closeDate from Opportunity where 	StageName = 'Closed Won']){
            System.debug(opp.Name);
        }
    }

    public static void getAllOpportunityWithStageClosedwon(string inputString){
        for(Opportunity opp: [select id, Name, 	StageName,closeDate from Opportunity where 	StageName =: inputString]){
            System.debug(opp.Name);
        }
    }

    public static void getAllCasesWithStatusIsClosed(string input){
        String query = 'SELECT Id, CaseNumber, Subject, Priority';

    if(input != 'Closed'){
        query += ', Status';
    }

    query += ' FROM Case WHERE Status = :input';
    System.debug('Query string: ' + query);

    for(Case c : Database.query(query)){
        System.debug(c);
    }
    }

    public static void getAllCasesWithStatusIsClosed(){
        for(AggregateResult agg : [select count(id) countIdcase,priority from case group by Priority]){
            System.debug('Total cases are' + agg.get('countIdcase') + 'with priority ' + agg.get('priority'));
            Integer id=(Integer) agg.get('countIdcase');
            string Priority= (string) agg.get('priority');
        }
    }


    // select count(annualRevenue),count(industry),count(rating) from account
    public static void getAllAccountWithAnnualRevenuebyINdustry(){
        for(AggregateResult agg : [select count(annualRevenue) accountAnnualRavenue,count(industry) AccountIndustry,count(rating) AccountRating from account]){
            System.debug('Total Accounts are' + agg.get('accountAnnualRavenue') + 'with industry ' + agg.get('AccountIndustry')  +'with Rating'+ agg.get('AccountRating'));
            Integer annualRevenue=(Integer) agg.get('accountAnnualRavenue');
            Integer industry= (Integer) agg.get('AccountIndustry');
            Integer rating= (Integer) agg.get('AccountRating');
        }
    }

    public static void childToParentRelationship(){
        for(Trainer__c branch: [select id, Name, Training_Branch__r.Course_Amount__c from Trainer__c]){
            System.debug('Trainer Name'+ branch.Name + 'Course Amount is' + branch.Training_Branch__r.Course_Amount__c);
        }
    }


    public static void childOpportunityofAccount(){
        for(Opportunity child: [select id, name, Amount ,Account.Name, Account.Rating from Opportunity where Account.Rating = 'Hot' order by Amount]){
            System.debug('the Opportunity'+ child.Name);
        }

    }

    ////Select id,name,(select id,accountid,name,stageName from Opportunities where stagename = 'Closed Won') from Account where rating = 'Hot' and Id in (select accountId from Opportunity where stagename = 'Closed Won')

    public static void childToParentRelationships(){
        for(Account acc:[Select id,name,(select id,accountid,name,stageName from Opportunities where stagename = 'Closed Won') from Account where rating = 'Hot' and Id in (select accountId from Opportunity where stagename = 'Closed Won')]){
            System.debug('Account Name: '+ acc.Name);
            for(Opportunity opp : acc.Opportunities){
                System.debug('Opportunities StageName: closed won'+ opp.StageName);
                
            }
        
        }
    }
}