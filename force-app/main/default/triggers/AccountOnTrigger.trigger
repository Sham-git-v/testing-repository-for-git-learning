trigger AccountOnTrigger on Account (before insert,after insert) {
    /*scenario-3 create contact record when account created*/
    if(trigger.isAfter && trigger.isInsert){
        list<Contact> conList=new list<Contact>();
        for(Account acc: trigger.new){
            Contact con=new Contact();
            con.LastName=acc.Name;
            con.AccountId=acc.Id;
            conList.add(con);
        }
        INSERT conList;
    }
    
    
    if(trigger.isBefore && trigger.isInsert){        
        /*scenario-1 populate field shippingAddress to billingAddress*/
        for(Account acc: trigger.new){
            
            /*scenario-2 trow an error*/
            if(acc.AnnualRevenue<1000){
                acc.addError('Amount must be greater than 1000');
            }
            
           if(acc.ShippingCity==null)
               acc.ShippingCity=acc.BillingCity;
            if(acc.ShippingCountry==null)
                acc.ShippingCountry=acc.BillingCountry;
            if(acc.ShippingState==null)
                acc.ShippingState=acc.BillingState;
            if(acc.ShippingStreet==null)
                acc.ShippingStreet=acc.BillingStreet;
            if(acc.ShippingPostalCode==null)
                acc.ShippingPostalCode=acc.BillingPostalCode;
        }
    }
}