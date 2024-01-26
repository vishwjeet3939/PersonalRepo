// ContactController.cls
public with sharing class ContactController {
    
    @AuraEnabled
    public static String createContacts(List<ContactData> contactsData) {
        List<Contact> newContacts = new List<Contact>();
        
        for (ContactData data : contactsData) {
            Contact newContact = new Contact(
                FirstName = data.firstName,
                LastName = data.lastName,
                Email = data.email,
                Phone = data.phone
            );
            newContacts.add(newContact);
        }

        try {
            insert newContacts;
            return 'Success';
        } catch (Exception e) {
            return 'Error: ' + e.getMessage();
        }
    }

    public class ContactData {
        @AuraEnabled public String firstName;
        @AuraEnabled public String lastName;
        @AuraEnabled public String email;
        @AuraEnabled public String phone;
    }
}