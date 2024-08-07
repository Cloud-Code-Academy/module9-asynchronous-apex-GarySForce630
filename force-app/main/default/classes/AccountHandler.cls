public with sharing class AccountHandler {
    public static Account insertNewAccount(String accountName) {
        if(accountName == '') {
            return null;
        }
        Account acc = new Account();
        acc.Name = accountName;
        try {
            upsert acc;
        } catch (DMLException e) {
            System.debug('A DML exception has occured: ' + e.getMessage());
        }
        
         return acc;
    }

    }
