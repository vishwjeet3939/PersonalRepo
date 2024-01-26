public with sharing class PassPrimitiveTypeExample {
    public static void debugStatusMessage() {
        Account objAccount = new Account(); 
        objAccount.Name = 'Testr Account'; 
        objAccount.Description = 'Test Account';
        insert objAccount; 
        System.debug('Records Has been created '+objAccount);

        System.debug('Records  ');

        System.debug('Records  vishwa');
        System.debug('Records vishwa');
        System.debug('Records vishwa');

        System.debug('Records vishwa');
        System.debug('Records vishwa');
    }
}