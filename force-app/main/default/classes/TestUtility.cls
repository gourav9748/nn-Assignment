/*
* Name            :    TestUtility
* Description     :    This class is used as a utility class for creating test data in test class.
* Created Date    :    [19th Aug , 2024]
* Created By      :    [Gourav Bhowmik] 
*
*/
public class TestUtility {
    public static User createUser(String profileName, Boolean isInsert){
          Profile p;
  
          list<Profile> listProfile = [SELECT Id FROM profile WHERE Name = :profileName];
          
          if(listProfile.size() > 0) {
              p = listProfile[0];
          } else {
              return null;
          }
  
          User testUser = new User(alias = 'testUser', email='standarduser' + Math.random()  + '@testorg.com',
                                  emailencodingkey='UTF-8', lastname='Test', languagelocalekey='en_US',
                                  localesidkey='en_US', profileid = p.Id, timezonesidkey='America/New_York',
                                  username='teststandarduser' + Math.random() + '@testorg.com', IsActive=true,
                                  Extension='1234', CompanyName = 'test Company');
          if(isInsert){
              insert testUser;
          }
  
          
          system.assert(true);
  
          return testUser;
      }
      public static Lead createLead(Boolean isInsert) {
          Lead lead = new Lead(LastName = 'Test', Company = 'Test Company', Country = 'Spain');
  
          if(isInsert) {
            insert lead;
          }
          system.assert(true);
  
          return lead;
      }
      
      
      
      public static Country__c createCountry(Boolean isInsert, String countryName) {
        Country__c country = new Country__c(Name = countryName);
  
        if(isInsert) {
          insert country;
        }
        system.assert(true);

        return country;
      }
      
        
  }