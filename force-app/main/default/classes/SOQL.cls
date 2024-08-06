/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Gary Tibbetts
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads() {
        return [SELECT Id, Lastname, Company, Phone, Email FROM Lead];
        
   
    
   }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> getContactsByFirstName() {       
        return [SELECT Id, Name, AccountId, FirstName, LastName FROM Contact WHERE FirstName = 'John'];
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactIdsByLastName() {
        List<Contact> contactIdLastName = [SELECT ID, Name, LastName FROM Contact WHERE LastName = 'Smith' OR LastName = 'Jones']; 
        List<Id> idsToReturn = new List<Id>();
        for (Contact idToReturn : contactIdLastName){
            idsToReturn.add(idToReturn.Id);
        }
        return idsToReturn;
    
    }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> getClosedWonOpportunityCountByAccount (Id accountId) {
        return [SELECT Id, Name, Account.Id, StageName, CloseDate, Amount FROM Opportunity WHERE Account.Id = :accountId AND StageName = 'Closed Won'];
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer getAccountCount() {
        return [SELECT COUNT() FROM Account]; 

       // return accountCount;
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id, Task> getTasksDueNextWeek() {
        Date today = Date.today();
        Date nextWeek = today.addDays(7);
        Map<Id, Task> taskDate = new Map<Id, Task>();
        List<Task> taskInfo = [SELECT Id, ActivityDate FROM Task WHERE ActivityDate >= :today AND ActivityDate <= :nextWeek];
        for (Task t : taskInfo) {
            taskDate.put(t.Id, t);
        }
        return taskDate;
    }
    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> getContactsByEmailDomain () {  
        return [SELECT Name, Email FROM Contact WHERE Email LIKE '%@example.com' ];
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        return [SELECT Name FROM Opportunity WHERE Name LIKE : '%' + keyword + '%'];
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        return [SELECT Id, Origin FROM Case WHERE Origin != 'Web' AND Origin != 'Email' AND Origin != NULL]; 
    }
        
   

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> getLeadsBySourceOrTitle(String leadSource, String keyword) {
        
        return [SELECT Id, FirstName, LastName, LeadSource, Title, Company, Phone, Email FROM Lead WHERE LeadSource LIKE :'%' + leadsource + '%' OR Title LIKE :'%' + keyword + '%']; 
    }    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        // Create a list to hold the Contact LastNames
        List<String> contactNames = new List<String>();       
        // Query the Contacts
        List<Contact> contacts = [SELECT Id, Name, LastName, AccountId FROM Contact WHERE AccountId = :accountId];          
        // Loop through each Contact and add the LastName to the list
        for (Contact c : contacts) {
            contactNames.add(c.LastName);
        }        
        return contactNames;// Replace null with the variable you used to store the result        
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
       // Use AggregateQuery to get the total revenue           
       List<AggregateResult> results = [SELECT SUM(Amount) sum FROM Opportunity WHERE StageName = :stage OR Amount > 10000];// Replace null with the variable you used to store the result
       return (Decimal) results[0].get('sum');
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        return [SELECT Id, Name FROM Account ORDER BY Name ASC NULLS LAST LIMIT 10];// Replace null with the variable you used to store the result
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {

        return [SELECT Id, Name, CloseDate, Amount FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate LIMIT 5];// Replace null with the variable you used to store the result
    }
       
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {

        return [SELECT Id, Name, BirthDate FROM Contact ORDER BY BirthDate DESC LIMIT 3];// Replace null with the variable you used to store the result
    }
    
    /**
  
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {        
        return [SELECT Id, CreatedDate, Status FROM Case WHERE Status = 'Open' ORDER BY CreatedDate LIMIT 10 OFFSET 5];
    } 

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
        Set<Id> caseIds = new Set<Id>();
        // Query the Cases  
        list<Case> casesToSort = [SELECT Id FROM Case WHERE AccountId = :accountId];        
        // Loop through each Case and add the Id to the set
        for (Case current : casesToSort) {
            caseIds.add(current.Id);
        }       
        return caseIds;// Replace null with the variable you used to store the result
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountIds = new Map<Id, String>();
        // Query the Accounts
        List<Account> accountsToSort = [SELECT Id, Name, BillingCountry FROM Account WHERE BillingCountry!= :country];
        // Loop through each Account and add the Id and Name to the map
        for (Account idMap : accountsToSort) {
            accountIds.put(idMap.Id, idMap.Name);
        }
        return accountIds;// Replace null with the variable you used to store the result
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
 
       Contact contactName = [SELECT AccountId FROM Contact WHERE Id = :contactId];
       String accountName = [SELECT Name FROM Account WHERE Id = :contactName.AccountId].Name;
        // Replace null with the variable you used to store the result
        return accountName;
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {

        return [SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Id = :accountId];// Replace null with the variable you used to store the result
        }

        /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */  
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account 
        Account account = [SELECT BillingState FROM Account WHERE Id = :accountId LIMIT 1];
    
        // Check if the account was found and has a BillingState
        if (account == null || account.BillingState == null) {
            return new List<Contact>(); // Return an empty list if the account is not found or has no BillingState
        }
    
        // Store the Account's BillingState
        String billingState = account.BillingState;
    
        // Query the Contacts 
        List<Contact> contacts = [SELECT Id, FirstName, LastName, MailingState FROM Contact WHERE MailingState = :billingState];
        
        return contacts; // Replace null with the variable you used to store the result
    }

     /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads
      List<Lead> leadsToCheck = [SELECT Email FROM Lead WHERE Id IN :leadIds];
        // Create a set of email domains from the Leads
       Set<String> emails = new Set<String>();
        // Loop through each Lead
        for (Lead test: leadsToCheck) {
            // Get the email from the Lead
            String email = test.Email;
            // Check if the email is not null
            if (email != Null && email.contains('@')) {
            // Extract the domain from the email
                String domain = email.substring(email.indexOf('@') + 1);
            // Add the email domain to the set
                emails.add(domain);
            }
        }
        Set<String> formattedDomains = new Set<String>();

        for (String domain : emails) {
             formattedDomains.add('www.' + domain);
             formattedDomains.add(domain);
  }
  // Query the Accounts/Replace null with the variable you used to store the result  
  return [SELECT Id, Name, Website FROM Account WHERE Website IN :formattedDomains];    
       
  }

     /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items
        List<OpportunityLineItem> originalLineItems = [SELECT PricebookEntryId, Quantity, UnitPrice, Discount, Description FROM OpportunityLineItem WHERE OpportunityId = :origOppId];
    
        // Create a list to hold the new line items
        List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();
    
        Integer min = 1;
        Integer max = 3;
    
        // Loop through each cloned Opportunity Id
        for (Id cloneOppId : cloneOppIds) {
            // Loop through each original line item
            for (OpportunityLineItem origLineItem : originalLineItems) {
                // Clone the original line item and add the random number to the quantity
                OpportunityLineItem newLineItem = new OpportunityLineItem(
                    OpportunityId = cloneOppId,
                    PricebookEntryId = origLineItem.PricebookEntryId,
                    UnitPrice = origLineItem.UnitPrice,
                    Discount = origLineItem.Discount,
                    Description = origLineItem.Description
                );
                
                // Generate a random number between 1 and 3                
                Double randomQuantityIncrease = Math.floor(Math.random() * (max - min + 1)) + min;   
                // Add the random number to the quantity
                newLineItem.Quantity = origLineItem.Quantity + randomQuantityIncrease;
    
                // Add the new line item to the list
                newLineItems.add(newLineItem);
                    }
        }    
        // Insert the new line items
        if (!newLineItems.isEmpty()) {
            insert newLineItems;
        }
    }    
    
     /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {
        
        List<Opportunity> closedWonOpportunities = [SELECT Name, Account.Name, Owner.Name FROM Opportunity WHERE StageName = 'Closed Won'];
        return closedWonOpportunities; // Replace null with the variable you used to store the result
    }
   

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
    */
    public static void setPrimaryContact() {
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
        List<Opportunity> closedWonOpps = getOpportunityDetailsForClosedWon();
        
        // Create a set of Account Ids from the Opportunities
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : closedWonOpps) {
            accountIds.add(opp.AccountId);
        }
        // Query the Contacts       
        Map<Id, Contact> contactsMap = new Map<Id, Contact>();
        // Loop through each Opportunity
        List<Account> getContacts = [SELECT Id, (SELECT ID, Name, AccountId, FirstName FROM Contacts ORDER BY FirstName) FROM Account WHERE ID IN :accountIds];
        for (Account currentAccount : getContacts) {
            contactsMap.put(currentAccount.Id, currentAccount.Contacts[0]);
            for (Opportunity currentOpp : closedWonOpps) {
                if (contactsMap.containsKey(currentOpp.AccountId)) {

                    currentOpp.Primary_Contact__c = contactsMap.get(currentOpp.AccountId).Id;
                }
            }
        }
        if (!closedWonOpps.isEmpty()) { 
                   update closedWonOpps;
        }
    }   

        
}