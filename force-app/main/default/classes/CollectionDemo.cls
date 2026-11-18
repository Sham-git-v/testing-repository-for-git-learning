public with sharing class CollectionDemo {
    public static void listDemo()
    {
        List<string> city = new List<string>();
        city.add('Delhi');
        city.add('Hyderabad');
        city.add('Bengaluru');
        city.add('Pune');
        city.add('Jaipur');
        System.debug('Size of the List'+city.size());
        System.debug('The City present at the index'+city[3]);
        System.debug('The City present at the index'+city.get(3));
        System.debug('Remove the city at index 4'+city.remove(4));
        
    }

    public static void setDemo()
    {

    }

    public static void mapDemo()
    {
        Map<String,String> stateCity = new  Map<String,String>();
        stateCity.put('TS', 'Hyderabad');
        stateCity.put('MH', 'Pune');
        stateCity.put('DL', 'Delhi');
         stateCity.put('RJ', 'Jaipur');
         stateCity.put('KL','Bengalore');
         System.debug('City with states name'+stateCity.keySet());
         System.debug('city names'+stateCity.values());
         System.debug('state name of Bengalore'+stateCity.get('KL'));
         System.debug('pune is in the list'+stateCity.containsKey('MH'));
    }
    
    public void doWork (Account acct) {
        for (Integer i = 0; i <= 2007 ;i++){
            insert acct;
                }
    }

}