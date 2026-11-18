public class AccountsRecords {
	@InvocableMethod
    public static list<list<Account>> toScreenFlowAccount(){
        list<Account> acclist=[SELECT id, name, phone from Account];
        return new list<list<Account>>{acclist};
    }
}