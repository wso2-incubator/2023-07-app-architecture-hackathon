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

function getScheduledVisitsData() returns json[] {
    return [
        { "visitId": 1, "visitorName": "John Doe", "visitDate": "2023-08-01" },
        { "visitId": 2, "visitorName": "Jane Smith", "visitDate": "2023-08-02" }
    ];
}
function testGetScheduledVisits() returns error? {
    http:Response response = check testClient->get ("/scheduledVisits");
    test:assertEquals(response.statusCode, 200, "Response status code should be 200");
    json[] expectedData = getScheduledVisitsData();
    json actualData = check response.getJsonPayload();
    test:assertEquals(actualData, expectedData, "Response data should match expected data");
}

// Test function for postScheduledvisits endpoint
function getNewScheduledVisit() returns json {
    return {
        "houseNo": "123",
        "visitorName": "John Doe",
        "visitDate": "2023-08-03",
        "isApproved": true,
        "comment": "New visit"
    };
}
function testPostScheduledvisits() returns error? {
    json newScheduledVisit = getNewScheduledVisit();
    http:Response response = check testClient->post("/scheduledVisits", newScheduledVisit);
    test:assertEquals(response.statusCode, 201, "Response status code should be 201");
    json actualData = check response.getJsonPayload();
    test:assertEquals(actualData, newScheduledVisit, "Response data should match expected data");
}
function getSearchField() returns json {
    return {
        "searchField": "VISITOR_NAME",
        "value": "John Doe"
    };
}
function testGetScheduledvisitsSearch() returns error? {
    json searchField = getSearchField();
    http:Response response = check testClient->get("/scheduledVisits/search", <map<string|string[]>?>searchField);
    test:assertEquals(response.statusCode, 200, "Response status code should be 200");
    json[] expectedData = getScheduledVisitsData();
    json actualData = check response.getJsonPayload();
    test:assertEquals(actualData, expectedData, "Response data should match expected data");
}