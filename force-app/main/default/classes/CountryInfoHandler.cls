/**
* Name            :    CountryInfoHandler
* Description     :    This is the Apex handler class for Country_Information LWC 
* Created Date    :    [19th Aug, 2024]
* Created By      :    [Gourav Bhowmik] 
*
*/
public with sharing class CountryInfoHandler {
    /*
    * Description     :    This method will return the specific country record based on lead country
    * Created Date    :    [19th Aug, 2024]
    * Created By      :    [Gourav Bhowmik] 
    */
    @AuraEnabled
    public static Country__c getCountry(String leadId){
       Lead l = [select Id, country from lead where id =: leadId];
       Country__c c = [select Id, Name from Country__c where name =: l.country];
       return c;
    }
}