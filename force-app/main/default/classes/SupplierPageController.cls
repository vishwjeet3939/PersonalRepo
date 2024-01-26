public with sharing class SupplierPageController {

    public String name { get; set; }
    public String phone { get; set; }
    public String Fax { get; set; }
    //public String location { get; set; }

    public SupplierPageController() {
        // Initialize variables if needed
    }

    public PageReference saveAccount() {
        try {
            Account newAccount = new Account();
            newAccount.Name = name;
            newAccount.Phone = phone;
            newAccount.Fax = Fax;
           
            insert newAccount;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Account created successfully.'));
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'An error occurred: ' + e.getMessage()));
        }
        return null; 
    }
}