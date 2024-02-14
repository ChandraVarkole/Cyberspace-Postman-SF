public class CSP_MentionUtilities {
    public static void processMentionData() {
        String endpoint = 'https://api.example.com/data';

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse response = http.send(req);

        if (response.getStatusCode() == 200) {
            Map<String, Object> mentionResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        } else {
            System.debug('Error: ' + response.getStatusCode() + ' - ' + response.getStatus());
        }
    }
}