trigger Parentchild on Student__c (before insert,before update) {
    // Helper method to recursively check for existing parent-child relationships
    // in the hierarchy
    Set<Id> existingChildIds = new Set<Id>();
    system.debug('existingChildIds'+existingChildIds);
    private static void checkExistingChildren(Map<Id, Student__c> existingParents, Student__c record) {
        if (record.P_Student__c != null) {
            existingChildIds.add(record.P_Student__c);
            Student__c parentRecord = existingParents.get(record.P_Student__c);
            if (parentRecord != null) {
                checkExistingChildren(existingParents, parentRecord);
            }
        }
    }

    Set<Id> parentIds = new Set<Id>();
    for (Student__c record : Trigger.new) {
        if (record.P_Student__c != null) {
            parentIds.add(record.P_Student__c);
        }
    }

    Map<Id, Student__c> existingParents = new Map<Id, Student__c>([
        SELECT Id, P_Student__c
        FROM Student__c
        WHERE Id IN :parentIds
    ]);

    // Check for existing parent-child relationships in the hierarchy
    for (Student__c record : Trigger.new) {
        if (record.P_Student__c != null) {
            checkExistingChildren(existingParents, record);
        }
    }

    for (Student__c record : Trigger.new) {
        if (record.P_Student__c != null && existingChildIds.contains(record.P_Student__c)) {
            record.addError('Record A is already a child of another record (B) which is a child of record C.');
        }
    }
}