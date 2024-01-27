public with sharing class PassPrimitiveTypeExample {
    public static void debugStatusMessage() {
        Account objAccount = new Account(); 
        objAccount.Name = 'Testr Account'; 
        objAccount.Description = 'Test Account';
        insert objAccount; 
        System.debug('Records Has been created '+objAccount);

    
    }
    public static void debugStatusMessage2() {

        system.debug('New method');

    }
}