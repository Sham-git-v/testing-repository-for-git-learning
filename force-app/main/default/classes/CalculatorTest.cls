@isTest
public class CalculatorTest {
    @isTest
    static void testAddMethod() {
        // Create an instance of Calculator
        Calculator calc = new Calculator();

        // Call add method with double values (cast from Decimal)
        Double result1 = calc.add((Double)10.5);
        Double result2 = calc.add((Double)5.5);

        // Assert the result
        System.assertEquals(16.0, result2, 'Sum of all should be 16.0 after adding 10.5 and 5.5');
    }
}