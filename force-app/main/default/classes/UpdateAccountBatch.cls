global class UpdateAccountBatch implements Database.Batchable<sObject>,database.stateful {

    Integer count =0;
    static integer countStatic =0;
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query = 'SELECT Id, Description FROM Account';
        return Database.getQueryLocator(query);
       
        //description comments
    } 

    global void execute(Database.BatchableContext BC, List<Account> scope) {
        count=count+1;
        countStatic = countStatic+1;
        system.debug('countStatic'+countStatic);
        system.debug('count'+count);
        
        for (Account acc : scope) {
            acc.Description = 'Update Description vishwa';
        }
		system.debug('scope'+scope.size());
        update scope;
    }

    global void finish(Database.BatchableContext BC) {
    
        system.debug('above');
        system.debug('line 29');
       system.debug('Finish');
       system.debug('Line 31');
       system.debug('Finish in side finish method');
       // update comment
       system.debug('below');
    }
}