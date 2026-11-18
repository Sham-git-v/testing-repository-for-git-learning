public class CustomerService {
    // Future method to process customer data
    @future
    public static void processCustomerData(Set<Id> customerIds) {
        System.debug('Executing Future Method');

        // Check if code is running within a future method
        /**if (System.isFuture()) {
            System.debug('Already running in a future method, skipping additional future call.');
            return;
        }**/

        // Perform some processing (e.g., query and update records)
        List<Account> customers = [SELECT Id, Name FROM Account WHERE Id IN :customerIds];

        for (Account acc : customers) {
            acc.Name = acc.Name + ' - Processed';
        }

        update customers;

        // Avoid calling another future method inside future context
        anotherFutureMethod(); 
    }

    // Another future method
    @future
    public static void anotherFutureMethod() {
        System.debug('This future method should not be called from another future method.');
    }

}