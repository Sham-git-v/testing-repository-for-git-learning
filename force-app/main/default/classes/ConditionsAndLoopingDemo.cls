public with sharing class ConditionsAndLoopingDemo {
      //create one method which will take the age of type Integer
    //if age is less than 18 and greater than 12 : Elgigble for Vaccine
    //if age is greater than 18 and less than 65 : Vaccine completed
    //if age is greater than 65 : Eligible for Additonal Vaccine
    //if age is less than 12 : Not Eligible
    public static void vaccine(Integer age){
        if(age<18 && age>12){
            System.debug('You are Elgigble for vaccine');

        }else if (age>18 && age<65)
         {
           System.debug('Vaccine Complete');
          
        }else if (age>65) {
            System.debug('Elgigble for Additonal Vaccine');
        
        }else {
            System.debug('Not Elgigble');
        }
        
    }

    public static void cityName(){
        List<string> city = new List<string>();
         city.add('Delhi');
        city.add('Hyderabad');
        city.add('Bengaluru');
        city.add('Pune');
        city.add('Jaipur');
        
        for (string citys : city) {
            System.debug('Welcome to '+citys+', Have a nice trip.');
            
        }
    }
}