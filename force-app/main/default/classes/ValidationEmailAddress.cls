public with sharing class ValidationEmailAddress {
    public static void validateEmail(string EmailAddress){
        HTTP http = new HTTP();
        HttpRequest request=new HttpRequest();
        String ApiKey= '02e43bde2ded49eba13496135ea3fd3e';
       // Integration_Configuration__mdt intergrationConfig =Integration_Configuration__mdt.getInstance('EmailVerifcation');
       // String ApiKey=intergrationConfig.key__c;
        string endPoint=('callout:EmailVerifcation?api_key='+Apikey+'&email='+EmailAddress);
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug(response.getBody());
        if(response.getStatusCode() == 200){
        emailVarificationWrapper wrappedResponse=emailVarificationWrapper.parse(response.getBody());
        System.debug('Is Email Address Valid'+ wrappedResponse.deliverability);
        System.debug(response.getBody());
        }
    }
}