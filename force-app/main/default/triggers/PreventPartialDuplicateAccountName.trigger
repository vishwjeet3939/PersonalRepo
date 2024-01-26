trigger PreventPartialDuplicateAccountName on Account (before insert, before update) {
    // Map to store existing Account Names
    Map<String, Id> existingAccountNames = new Map<String, Id>();

    for (Account existingAccount : [SELECT Id, Name, Allow_duplicate__c FROM Account]) {
        if (existingAccount.Name != null && existingAccount.Name.length() > 0) {
            // Store the normalized Account Name
            existingAccountNames.put(existingAccount.Name.toLowerCase(), existingAccount.Id);
        }
    }

    for (Account newAccount : Trigger.new) {
        if (newAccount.Name != null && newAccount.Name.length() > 0) {
            // Check if a record with a similar name exists
            String normalizedNewName = newAccount.Name.toLowerCase();

            for (String existingName : existingAccountNames.keySet()) {
                if ((normalizedNewName.contains(existingName) || existingName.contains(normalizedNewName)) 
                    && existingAccountNames.get(existingName) != newAccount.Id
                    && !newAccount.Allow_duplicate__c) {
                        newAccount.Name.addError('Duplicate or partially matching Account Name found. Existing Account Id: ' + existingAccountNames.get(existingName));
                        break;
                }
            }
        }
    }
}