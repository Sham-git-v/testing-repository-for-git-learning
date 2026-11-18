@isTest
public class emailVarificationWrapperTest {
    @isTest
    static void testParseMethod() {
        String jsonStr = '{' +
            '"email":"venkateshwarraokandulk21@gmail.com",' +
            '"autocorrect":"",' +
            '"deliverability":"UNDELIVERABLE",' +
            '"quality_score":"0.00",' +
            '"is_valid_format":{"value":true,"text":"TRUE"},' +
            '"is_free_email":{"value":true,"text":"TRUE"},' +
            '"is_disposable_email":{"value":false,"text":"FALSE"},' +
            '"is_role_email":{"value":false,"text":"FALSE"},' +
            '"is_catchall_email":{"value":false,"text":"FALSE"},' +
            '"is_mx_found":{"value":true,"text":"TRUE"},' +
            '"is_smtp_valid":{"value":false,"text":"FALSE"}' +
        '}';

        emailVarificationWrapper wrapperObj = emailVarificationWrapper.parse(jsonStr);

        System.assertNotEquals(null, wrapperObj);
        System.assertEquals('venkateshwarraokandulk21@gmail.com', wrapperObj.email);
        System.assertEquals('UNDELIVERABLE', wrapperObj.deliverability);
        System.assertEquals('0.00', wrapperObj.quality_score);
        // Inner class fields tested indirectly through parse
    }
}