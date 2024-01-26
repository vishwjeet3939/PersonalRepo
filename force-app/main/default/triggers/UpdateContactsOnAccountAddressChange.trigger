trigger UpdateContactsOnAccountAddressChange on Account (after update) {
    // List to store Contact records to be updated
    List<Contact> contactsToUpdate = new List<Contact>();
    Set<Id> accId = new Set<Id>();

    // Iterate through the updated Account records
    for (Account updatedAccount : Trigger.new) {
        accId.add(updatedAccount.Id);

        // Check if the BillingStreet field has changed
        if (updatedAccount.BillingStreet != Trigger.oldMap.get(updatedAccount.Id).BillingStreet) {
            // Do nothing here, the actual update will be done after the loop
        }
    }

    // Query for related Contact records outside of the loop
    List<Contact> relatedContacts = [SELECT Id, MailingStreet, AccountId
                                    FROM Contact
                                    WHERE AccountId IN :accId];

    // Update the MailingStreet field on the related Contact records
    for (Contact con : relatedContacts) {
        con.MailingStreet = Trigger.newMap.get(con.AccountId).BillingStreet;
        contactsToUpdate.add(con);
    }
    
    // Update the Contact records
    if (!contactsToUpdate.isEmpty()) {
        update contactsToUpdate;
    
    }
}