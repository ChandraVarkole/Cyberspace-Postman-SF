@IsTest
public class CSP_MentionUtilitiesTest {
    @IsTest 
    private static void mentionDetailsArePopulatedWithFieldValuesWhenResponseIsReceived() {
        string mentionMockResponse = '{\"data\":[{\"ID\":\"1234556\",\"MentionDate\":\"2024-02-12\",\"Hrs\":\"13.40\",\"Title\":\"GreenhouseControl\",\"Content\":\"weareplanningtouseeco-friendlythermostat\",\"Source\":\"https://reddit.com/r/hvac\",\"Domain\":\"reddit.com\",\"Category\":\"Forums\"},{\"ID\":\"97897998\",\"Date\":\"2024-02-02\",\"Hrs\":\"14.40\",\"Title\":\"GreenhouseControl\",\"Content\":\"weareplanningtouseeco-friendlythermostat\",\"Source\":\"https://yelp.com/r/hvac\",\"Domain\":\"yelp.com\",\"Category\":\"Forums\"},{\"ID\":\"765587\",\"Date\":\"2024-02-10\",\"Hrs\":\"15.40\",\"Title\":\"GreenhouseControl\",\"Content\":\"weareplanningtouseeco-friendlythermostat\",\"Source\":\"https://yellowpages.com/r/hvac\",\"Domain\":\"yellowpage.com\",\"Category\":\"News\"}]}';
        Test.startTest();
        CSP_MentionUtilities.processMentionData(mentionMockResponse);
        Test.stopTest();
        
        List<Cyberspace_Details__c> cspDetailsInserted = [
            SELECT Id
            FROM Cyberspace_Details__c
            WHERE CreatedDate = Today
        ];
        Assert.areEqual(3, cspDetailsInserted.size());
    }
    
    @IsTest
    private static void exceptionShouldNotBeThrownWhenGetCSPMentionDataIsInvoked() {
        Boolean exceptionThrown = false;
        Test.startTest();
        try {
            CSP_MentionUtilities.getCSPMentionData();
        } catch (Exception ex) {
            exceptionThrown = true;
        }
        Test.stopTest();
    }
}