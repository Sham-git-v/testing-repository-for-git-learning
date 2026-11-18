public with sharing class DynamicTableController {

    @AuraEnabled(cacheable=true)
    public static List<Object> getDynamicTableData(String objectApiName, List<String> fieldApiNames) {
        // Build the SOQL query string dynamically
        String query = 'SELECT ' + String.join(fieldApiNames, ',') + ' FROM ' + objectApiName + ' LIMIT 10';
        
        // Execute the query
        List<SObject> records = Database.query(query);

        // Get the field labels and create a list of columns
        List<Map<String, Object>> columns = new List<Map<String, Object>>();
        Map<String, SObjectField> fieldMap = Schema.getGlobalDescribe().get(objectApiName).getDescribe().fields.getMap();

        for (String fieldApiName : fieldApiNames) {
            Map<String, Object> column = new Map<String, Object>();
            column.put('label', fieldMap.get(fieldApiName).getDescribe().getLabel());
            column.put('fieldName', fieldApiName);
            column.put('type', getFieldType(fieldMap.get(fieldApiName).getDescribe().getType()));
            columns.add(column);
        }

        // Create a list containing both columns and data
        List<Object> result = new List<Object>();
        result.add(columns);
        result.add(records);
        return result;
    }

    // Helper method to map Schema.DisplayType to lightning-datatable types
    private static String getFieldType(Schema.DisplayType dataType) {
        if (dataType == Schema.DisplayType.Date) return 'date';
        if (dataType == Schema.DisplayType.DateTime) return 'datetime';
        if (dataType == Schema.DisplayType.Currency) return 'currency';
        if (dataType == Schema.DisplayType.Double) return 'number';
        if (dataType == Schema.DisplayType.Integer) return 'number';
        if (dataType == Schema.DisplayType.Url) return 'url';
        return 'text';
    }
}