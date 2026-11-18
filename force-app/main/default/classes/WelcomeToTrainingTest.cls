@isTest
public class WelcomeToTrainingTest {
    
    @isTest
    static void testWelcomeToTrainingClass() {
        // Call default constructor
        WelcomeToTraining obj = new WelcomeToTraining();
        
        // Call parameterized constructor
        WelcomeToTraining obj2 = new WelcomeToTraining('This is a test message');

        // Call static method
        WelcomeToTraining.printStaticMyName('Venkat', 'Kandula');

        // Call instance method
        obj.printInstanceMyName('Venkat', 'Kandula');

        // Access static variable
        Integer num = WelcomeToTraining.myNumber;
        System.assertEquals(45, num, 'Static variable value mismatch');

        // Access instance variable
        System.assertEquals('Venkat', obj.myName, 'Instance variable value mismatch');
    }
}