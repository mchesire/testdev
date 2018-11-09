public with sharing class CampaignExtension {
public String campId {get; set;}
public String opportunityName {get; set;}
public String opportunityStage {get; set;}
public String opportunityType {get; set;}
public String opportunityDate {get; set;}
public List<Contact> myContacts {get; set;}
public Opportunity myOpportunity {get; set;}
public Opportunity tempOpportunity {get; set;}
public List<Opportunity> opportunities {get; set;}
public Date tempDate {get; set;}

public Pagereference nextPage;

// constructor
public CampaignExtension (ApexPages.StandardController stdController){
 myContacts = new List <Contact> ();
 myOpportunity = new Opportunity ();
 opportunities = new List <Opportunity> (); 
  
 tempDate = Date.today();
 
 campId = ApexPages.currentPage().getParameters().get('CampaignId');  
 if (campId != NULL) {
    myContacts = [Select c.Id, c.AccountId, Account.Name  From Contact c where c.Id in (Select ContactId From CampaignMember where CampaignId=: campId)];
 } else {
    campId = '';
 }
 
 
} // end constructor


public PageReference createOpportunity()
{
       if (myContacts.size() > 0) {
            
            for(Contact c: myContacts) {
              tempOpportunity = new Opportunity ();
              opportunityName = 'Test ' + c.Account.Name + ' ' + String.valueOf(tempDate.year());
              tempOpportunity.Name = opportunityName;
              tempOpportunity.AccountId = c.AccountId;
              tempOpportunity.StageName = myOpportunity.StageName;
              tempOpportunity.Type = myOpportunity.Type;
              tempOpportunity.CloseDate = myopportunity.CloseDate;
              opportunities.add(tempOpportunity);
            } 
            insert opportunities;
       }
       nextPage = new PageReference('/006/o');
       nextPage.setRedirect(true);
       return nextPage; 


}


}