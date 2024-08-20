
/*
* Name            :    CountryInfoHandlerTest
* Description     :    This class is the test class for CountryInfoHandler
* Created Date    :    [19th Aug , 2024]
* Created By      :    [Gourav Bhowmik] 
*
*/
@isTest()
public class CountryInfoHandlerTest {
    private static User admUser1= TestUtility.createUser('System Administrator', true);
        @testSetup 
        /*
         * test data setup method
         */
        static void setup() {
            Lead lead = TestUtility.createLead(true);
            Country__c newCountry = TestUtility.createCountry(true, 'Spain');
        }
        static testmethod void getCountryTest() {
            Lead l = [select id, Country from lead limit 1];
            System.runAs(admUser1){
                System.Test.startTest();
                Country__c returnCountry = CountryInfoHandler.getCountry(String.valueOf(l.id));
                System.Test.stopTest();
                System.assertEquals(returnCountry.Name, l.Country);
            }
        }
    
       
}