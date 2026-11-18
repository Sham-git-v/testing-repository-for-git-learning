@isTest
public class ConditionsAndLoopingDemoTest {

    @isTest
    static void testVaccineMethod() {
        // Age < 12: Not Eligible
        ConditionsAndLoopingDemo.vaccine(10);

        // Age > 12 and < 18: Eligible for Vaccine
        ConditionsAndLoopingDemo.vaccine(15);

        // Age > 18 and < 65: Vaccine Complete
        ConditionsAndLoopingDemo.vaccine(30);

        // Age > 65: Eligible for Additional Vaccine
        ConditionsAndLoopingDemo.vaccine(70);
    }

    @isTest
    static void testCityNameMethod() {
        // Just call the method to verify it runs without exceptions
        ConditionsAndLoopingDemo.cityName();
    }
}