import ballerina/http;
import ballerina/log;
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

function getNewScheduledVisit() returns json {
    return {
        "houseNo": "ABC123",
        "visitorName": "John DoeX",
        "visitDate": "2023-08-03",
        "isApproved": true,
        "comment": "New visit"
    };
}
function getNewActualVisit() returns json {
 return {
  "houseNo": "A123",
  "visitorName": "John Doe",
  "visitorNIC": "1234567890",
  "visitorPhoneNo": "1234567890",
  "vehicleNumber": "ABC123",
  "visitDate": "2023-08-01",
  "isApproved": true,
  "comment": "Please proceed with the visit."
};
}
function getScheduledVisitsData() returns json {
    return [
      {"visitId":9705441,"houseNo":"9999","visitorName":"John DoeX","visitDate":"2023-08-03","isApproved":true,"comment":"New visit"}
    ];
}
function getSearchField() returns json {
    return {
        "searchField": "HOUSE_NO",
        "value": "H0804"
    };
}

@test:Config {}
function testPostScheduledvisits() returns error? {
    json newScheduledVisit = getNewScheduledVisit();
    http:Response response = check testClient->post("/scheduledVisits", newScheduledVisit);
    test:assertEquals(response.statusCode, 201, "Response status code should be 201");
    //json actualData = check response.getJsonPayload();
    //log:printInfo(actualData.toString());
    //If need check payload data
    // test:assertEquals(actualData, newScheduledVisit, "Response data should match expected data");
}
@test:Config {}
function testGetScheduledVisits() returns error? {
    http:Response response = check testClient->get ("/scheduledVisits");
    test:assertEquals(response.statusCode, 200, "Response status code should be 200");
    //If need we can check with exact data with below code
    //json expectedData = getScheduledVisitsData();
    //json actualData = check response.getJsonPayload();
    //test:assertEquals(actualData, expectedData, "Response data should match expected data");
}


@test:Config {}
function testGetActualVisits() returns error? {
    http:Response response = check testClient->get ("/actualVisits");
    test:assertEquals(response.statusCode, 200, "Response status code should be 200");
    json actualData = check response.getJsonPayload();
    log:printInfo(actualData.toString());
    //If need we can check with exact data with below code
    //json expectedData = getScheduledVisitsData();
    //test:assertEquals(actualData, expectedData, "Response data should match expected data");
}

@test:Config {}
function testGetScheduledVisitsByIDNegativeTest() returns error? {
    string visitID = "9999999";
    http:Response response = check testClient->get ("/scheduledvisits/" + visitID);
    test:assertEquals(response.statusCode, 404, "Response status code should be 200");
}

@test:Config {}
function testGetActualVisitsByIDNegativeTest() returns error? {
    string visitID = "9999999";
    http:Response response = check testClient->get ("/actualVisits/" + visitID);
    test:assertEquals(response.statusCode, 404, "Response status code should be 200");
}

function testPostActualvisits() returns error? {
    json newScheduledVisit = getNewActualVisit();
    http:Response response = check testClient->post("/actualVisits", newScheduledVisit);
    test:assertEquals(response.statusCode, 201, "Response status code should be 201");
    //json actualData = check response.getJsonPayload();
    //log:printInfo(actualData.toString());
    //If need check payload data
    // test:assertEquals(actualData, newScheduledVisit, "Response data should match expected data");
}   

@test:Config {}
function testGetScheduledvisitsSearch() returns error? {
    //json searchField = getSearchField();
    http:Response response = check testClient->/scheduledVisits/search(searchField = "HOUSE_NO", value="ABC123");
    test:assertEquals(response.statusCode, 200, "Response status code should be 200");
    //log:printInfo((check response.getJsonPayload()).toString());
    //json expectedData = getScheduledVisitsData();
    //json actualData = check response.getJsonPayload();
    //test:assertEquals(actualData, expectedData, "Response data should match expected data");
}