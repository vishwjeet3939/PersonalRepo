trigger AddCampaignToJunction on Contact (after insert, after update) {
    List<Con_Campaign_assignment__c> junctionRecords = new List<Con_Campaign_assignment__c>();
    Set<Id> contactIds = new Set<Id>();

    // Collect Contact Ids from the trigger records
    for (Contact contact : Trigger.new) {
        contactIds.add(contact.Id);
    }

    // Query existing junction records for the Contact and Campaign combination
    Map<String, Con_Campaign_assignment__c> existingJunctionRecords = new Map<String, Con_Campaign_assignment__c>();
    for (Con_Campaign_assignment__c junctionRecord : [
        SELECT Id, Contact__c, Campaign2__c
        FROM Con_Campaign_assignment__c
        WHERE Contact__c IN :contactIds
    ]) {
        String key = junctionRecord.Contact__c + '-' + junctionRecord.Campaign2__c;
        existingJunctionRecords.put(key, junctionRecord);
    }

    for (Contact contact : Trigger.new) {
        if (contact.Campaign2__c != null) {
            // Create a key using Contact Id and Campaign Id for comparison
            String key = contact.Id + '-' + contact.Campaign2__c;
            
            // Check if a junction record already exists for the Contact and Campaign combination
            Con_Campaign_assignment__c existingRecord = existingJunctionRecords.get(key);
            if (existingRecord == null) {
                // Create a new junction record
                Con_Campaign_assignment__c junctionRecord = new Con_Campaign_assignment__c();
                junctionRecord.Contact__c = contact.Id;
                junctionRecord.Campaign2__c = contact.Campaign2__c;
                junctionRecords.add(junctionRecord);
                existingJunctionRecords.put(key, junctionRecord);
            }
        }
    }

    if (!junctionRecords.isEmpty()) {
        insert junctionRecords;
    }
}