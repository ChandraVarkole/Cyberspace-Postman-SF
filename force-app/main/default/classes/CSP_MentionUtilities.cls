public class CSP_MentionUtilities {
    public static void getCSPMentionData() {
        String endpoint = 'https://api.example.com/data';

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse response;
        if (!Test.isRunningTest()) {
        	response = http.send(req);
            if (response.getStatusCode() == 200) {
                processMentionData(response.getBody());
            } else {
                System.debug('Error: ' + response.getStatusCode() + ' - ' + response.getStatus());
            }
        } else {
			string mentionMockResponse = '{\"data\":[{\"ID\":\"1234556\",\"MentionDate\":\"2024-02-12\",\"Hrs\":\"13.40\",\"Title\":\"GreenhouseControl\",\"Content\":\"weareplanningtouseeco-friendlythermostat\",\"Source\":\"https://reddit.com/r/hvac\",\"Domain\":\"reddit.com\",\"Category\":\"Forums\"},{\"ID\":\"97897998\",\"Date\":\"2024-02-02\",\"Hrs\":\"14.40\",\"Title\":\"GreenhouseControl\",\"Content\":\"weareplanningtouseeco-friendlythermostat\",\"Source\":\"https://yelp.com/r/hvac\",\"Domain\":\"yelp.com\",\"Category\":\"Forums\"},{\"ID\":\"765587\",\"Date\":\"2024-02-10\",\"Hrs\":\"15.40\",\"Title\":\"GreenhouseControl\",\"Content\":\"weareplanningtouseeco-friendlythermostat\",\"Source\":\"https://yellowpages.com/r/hvac\",\"Domain\":\"yellowpage.com\",\"Category\":\"News\"}]}';
            processMentionData(mentionMockResponse);
        }
    }  
    
   	public static void processMentionData(String mentionResponse) {
        if (!Schema.sObjectType.Cyberspace_Details__c.isCreateable()) {
   			throw new CustomException('User does not have create permissions');
		}
        List<Cyberspace_Details__c> cspDetailsToInsert = new List<Cyberspace_Details__c>();
        Map<String, Object> mentionDetailsMap = (Map<String, Object>) JSON.deserializeUntyped(mentionResponse);
        List<Object> mentionData = (List<Object>) mentionDetailsMap.get('data');
        
        for (Object mentionObject : mentionData) {
            Map<String, Object> mentionDetails = (Map<String, Object>) mentionObject;
            Cyberspace_Details__c cspDetail = new Cyberspace_Details__c();
            cspDetail.Category__c = String.valueOf(mentionDetails.get('Category'));
            cspDetail.Content__c  = String.valueOf(mentionDetails.get('Content'));
            cspDetail.Domain__c  = String.valueOf(mentionDetails.get('Domain'));
            cspDetail.Mention_ID__c  = String.valueOf(mentionDetails.get('ID'));
            cspDetail.Source__c = String.valueOf(mentionDetails.get('Source'));
            cspDetail.Title__c  = String.valueOf(mentionDetails.get('Title'));
            //cspDetail.Mention_Datetime__c
            cspDetailsToInsert.add(cspDetail);   
        }
        insert cspDetailsToInsert;
    }
    public class CustomException extends Exception {}
}