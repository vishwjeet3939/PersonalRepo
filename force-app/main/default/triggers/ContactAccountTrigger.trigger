trigger ContactAccountTrigger on Contact (before insert) {
     
    Set<Id> accIdSet = new Set<Id>();
     
    for(Contact con : trigger.new){
        if(String.isNotBlank(con.AccountId)){
            accIdSet.add(con.AccountId);
        }
    }
     
    if(accIdSet.size() > 0){
        
        Map<Id,Account> accMap = new Map<Id,Account>([Select Id, Phone From Account where id In:accIdSet]);
        
        
         system.debug(accMap);
        for(Contact con : trigger.new){
           
            if(con.AccountId != null && accMap.containskey(con.AccountId)){
                if(accMap.get(con.AccountId).Phone != null){
                    
                    con.OtherPhone = accMap.get(con.AccountId).Phone;
                }
            }
        }
         
    }
}