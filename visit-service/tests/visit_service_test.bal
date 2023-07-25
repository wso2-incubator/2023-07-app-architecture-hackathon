import ballerina/http;
import ballerina/test;

http:Client testClient = check new ("http://localhost:9090/visit");

@test:BeforeSuite
function setup() {
    // Perform any setup actions, if required
}
@test:AfterSuite
function cleanup() {
    // Perform any cleanup actions, if required
}

function testPostScheduledvisits() returns error? {
    json newScheduledVisit = getNewScheduledVisit();
    http:Response response = check testClient->post("/scheduledVisits", newScheduledVisit);
    test:assertEquals(response.statusCode, 201, "Response status code should be 201");
    json actualData = check response.getJsonPayload();
    test:assertEquals(actualData, newScheduledVisit, "Response data should match expected data");
}
@test:Config {}
function testGetScheduledVisits() returns error? {
    http:Response response = check testClient->get ("/scheduledVisits");
    test:assertEquals(response.statusCode, 200, "Response status code should be 200");
    //json expectedData = getScheduledVisitsData();
    //json actualData = check response.getJsonPayload();
    //test:assertEquals(actualData, expectedData, "Response data should match expected data");
}

// Test function for postScheduledvisits endpoint
function getNewScheduledVisit() returns json {
    return {
        "houseNo": "456",
        "visitorName": "John Doe",
        "visitDate": "2023-08-03",
        "isApproved": true,
        "comment": "New visit"
    };
}

function getScheduledVisitsData() returns json {
    return [
        { "visitId": 6, "visitorName": "John Doe", "visitDate": "2023-08-01" }
    ];
}
function getSearchField() returns json {
    return {
        "searchField": "VISITOR_NAME",
        "value": "John Doe"
    };
}
function testGetScheduledvisitsSearch() returns error? {
    //json searchField = getSearchField();
    map<string> keyValueMap = {
        "key1": "value",
        "key3": "value"
    };
    http:Response response = check testClient->get("/scheduledVisits/search", keyValueMap);
    test:assertEquals(response.statusCode, 200, "Response status code should be 200");
    json expectedData = getScheduledVisitsData();
    json actualData = check response.getJsonPayload();
    test:assertEquals(actualData, expectedData, "Response data should match expected data");
}