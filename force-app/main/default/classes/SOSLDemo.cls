public with sharing class SOSLDemo {
    public static void  soslMethodDemo(string searchItem){
       List<List<sObject>> searchItemList = [Find : searchItem IN ALL FIELDS returning user(FirstName,LastName,email,UserName)];

       List<User> userList =(List<User>) searchItemList.get(0);
       for(User use: userList){
        System.debug(use);
       }
    }
}