trigger ConTrigger on Contact (before insert, before update) {
    for(Contact con: trigger.new){
        if(con.Phone!=null){
            //VerifyPhoneNumber.verifyNumber();
        }
    }
}