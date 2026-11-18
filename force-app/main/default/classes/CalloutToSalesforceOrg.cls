public class CalloutToSalesforceOrg {
    public static void getAccounts(string byIndustry){
        Http https=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndPoint('callout:SFDC_TO_SFDC/services/apexrest/getaccounts/?Industry=' + EncodingUtil.urlEncode(byIndustry, 'UTF-8'));
        request.setMethod('GET');
        HttpResponse response=https.send(request);
        system.debug('response'+response.getBody());
        system.debug('response code'+response.getStatusCode());
        system.debug('response');
    }
}