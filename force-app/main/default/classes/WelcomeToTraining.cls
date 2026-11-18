public class WelcomeToTraining 
{
	//variables
		//static variables
		public static integer myNumber=45;
    	//instance variables
    	public string myName='Venkat';
    
    //Constructor
    	//1. Default Constructor
    public WelcomeToTraining(){
        System.debug('Hello I am default Constructor');
    }
    	//2. Parameterized Constructor
    public WelcomeToTraining(String message){
        System.debug('Parameterized Constructor ' + message);
    }
    //Methods (void -- if method is not returning anything or data type)
    	//1. static Method
    public static void printStaticMyName(String firstName, String lastName){
        System.debug('Full Name ' + firstName + ' ' + lastName);
    }
    	//2. Instance Method	
    public void printInstanceMyName(String firstName, String lastName){
        System.debug('Full Name ' + firstName + ' ' + lastName);
    }
    
}