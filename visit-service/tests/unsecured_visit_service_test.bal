import ballerina/http;
import ballerina/log;
import ballerina/test;

http:Client unsecuredTestClient = check new ("http://localhost:9091/visit");


function getNewScheduledVisitUnsecured() returns json {
    return {
        "houseNo": "ABC123",
        "visitorName": "John DoeX",
        "visitDate": "2023-08-03",
        "isApproved": true,
        "comment": "New visit"
    };
}
function getNewActualVisitUnsecured() returns json {
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
function getScheduledVisitsDataUnsecured() returns json {
    return [
      {"visitId":9705441,"houseNo":"9999","visitorName":"John DoeX","visitDate":"2023-08-03","isApproved":true,"comment":"New visit"}
    ];
}

@test:Config {}
function testGetScheduledVisitsUnsecured() returns error? {
    http:Response response = check testClient->get ("/scheduledVisits");
    test:assertEquals(response.statusCode, 200, "Response status code should be 200");
    //If need we can check with exact data with below code
    //json expectedData = getScheduledVisitsData();
    //json actualData = check response.getJsonPayload();
    //test:assertEquals(actualData, expectedData, "Response data should match expected data");
}


@test:Config {}
function testGetActualVisitsUnsecured() returns error? {
    http:Response response = check testClient->get ("/actualVisits");
    test:assertEquals(response.statusCode, 200, "Response status code should be 200");
    json actualData = check response.getJsonPayload();
    log:printInfo(actualData.toString());
    //If need we can check with exact data with below code
    //json expectedData = getScheduledVisitsData();
    //test:assertEquals(actualData, expectedData, "Response data should match expected data");
}


@test:Config {}
function testGetScheduledvisitsSearchUnsecured() returns error? {
    //json searchField = getSearchField();
    http:Response response = check testClient->/scheduledVisits/search(searchField = "HOUSE_NO", value="ABC123");
    test:assertEquals(response.statusCode, 200, "Response status code should be 200");
    //log:printInfo((check response.getJsonPayload()).toString());
    //json expectedData = getScheduledVisitsData();
    //json actualData = check response.getJsonPayload();
    //test:assertEquals(actualData, expectedData, "Response data should match expected data");
}

@test:Config{}
function testGetActualvisitsSearchUnsecured() returns error? {
    http:Response response = check testClient->/actualVisits/search(searchField = "HOUSE_NO", value="ABC123");
    test:assertEquals(response.statusCode, 200, "Response status code should be 200");
}


