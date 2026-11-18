/**
 * @description A reusable Apex controller to dynamically fetch data and column definitions
 *              based on a specified object and Field Set. It correctly handles related
 *              object fields (e.g., Account.Name from a Contact Field Set).
 */
public with sharing class FieldSetDatatableController {

    /**
     * @description Queries records and describes fields based on a given Field Set.
     * @param objectApiName The API name of the object to query (e.g., 'Contact').
     * @param fieldSetName The API name of the Field Set to use (e.g., 'Contact_List_with_Account').
     * @return A map containing a list of columns for the datatable and a list of SObject data.
     */
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getDataFromFieldSet(String objectApiName, String fieldSetName) {

        // --- 1. Get the fields from the Field Set ---
        List<String> fieldApiPaths = new List<String>();
        List<Map<String, String>> columns = new List<Map<String, String>>();

        // Defensive coding: Check if the object and field set exist.
        Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(objectApiName.toLowerCase());
        if (sObjectType == null) {
            throw new AuraHandledException('Invalid object API name: ' + objectApiName);
        }

        Map<String, Schema.FieldSet> fieldSetMap = sObjectType.getDescribe().fieldSets.getMap();
        if (!fieldSetMap.containsKey(fieldSetName)) {
            throw new AuraHandledException('Invalid field set name: ' + fieldSetName);
        }

        Schema.FieldSet fieldSet = fieldSetMap.get(fieldSetName);

        // Loop through each field in the Field Set
        for (Schema.FieldSetMember fsm : fieldSet.getFields()) {
            // Add the API path (e.g., 'Name' or 'Account.Name') to our list for the SOQL query
            fieldApiPaths.add(fsm.getFieldPath());

            // Create a column definition for the lightning-datatable
            columns.add(new Map<String, String>{
                'label' => fsm.getLabel(),
                'fieldName' => fsm.getFieldPath(), // The fieldName must match the flattened data key
                'type' => getDatatableType(fsm.getType())
            });
        }
        
        // Ensure there are fields to query
        if (fieldApiPaths.isEmpty()) {
            return new Map<String, Object>{
                'columns' => new List<Map<String, String>>(),
                'data' => new List<SObject>()
            };
        }

        // --- 2. Build and Execute the SOQL Query ---
        // We must include Id for the 'key-field' in the datatable.
        String query = 'SELECT Id, ' + String.join(fieldApiPaths, ',') +
                       ' FROM ' + objectApiName +
                       ' WITH SECURITY_ENFORCED LIMIT 20'; // Using security enforced is a best practice

        try {
            List<SObject> records = Database.query(query);

            // --- 3. Return the data in a structured map ---
            return new Map<String, Object>{
                'columns' => columns,
                'data' => records
            };
        } catch (System.QueryException e) {
            throw new AuraHandledException('You do not have permission to view one or more of the fields in this field set. Original error: ' + e.getMessage());
        }
    }

    /**
     * @description Helper method to map Salesforce Schema.DisplayType to lightning-datatable column types.
     * @param dataType The Schema.DisplayType of the field.
     * @return A string representing the datatable type.
     */
    private static String getDatatableType(Schema.DisplayType dataType) {
        if (dataType == Schema.DisplayType.Date) return 'date-local';
        if (dataType == Schema.DisplayType.DateTime) return 'datetime';
        if (dataType == Schema.DisplayType.Currency) return 'currency';
        if (dataType == Schema.DisplayType.Double || dataType == Schema.DisplayType.Integer || dataType == Schema.DisplayType.Long) return 'number';
        if (dataType == Schema.DisplayType.Email) return 'email';
        if (dataType == Schema.DisplayType.Phone) return 'phone';
        if (dataType == Schema.DisplayType.Url) return 'url';
        return 'text'; // Default type
    }
}