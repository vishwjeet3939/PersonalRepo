public with sharing class CampaignController {
    @AuraEnabled(cacheable=true)
    public static List<Campaign__c> getCampaignOptions() {
        return [SELECT Id, Name FROM Campaign__c];
    }
}