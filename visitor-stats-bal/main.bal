import ballerina/io;
import ballerinax/googleapis.sheets as sheets;
import ballerina/http;

configurable string refreshToken = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string spreadsheetId = ?;
configurable string sheetName = ?;
configurable string visitStatAPIUrl = ?;
configurable string visitStatAPITokenURL = ?;
configurable string visitStatAPIConsumerKey = ?;
configurable string visitStatAPIConsumerSecret = ?;

// Configuring Google Sheets API
sheets:ConnectionConfig spreadsheetConfig = {
    auth: {
        clientId: clientId,
        clientSecret: clientSecret,
        refreshUrl: sheets:REFRESH_URL,
        refreshToken: refreshToken
    }
};

// A record to store PR/issue related data
public type Details record {
    string date;
    string inTime;
    string outTime;
    string houseNumber;
    string visitorName;
    string visitorNic;
    string vehicleNumber;
    string visitorPhone;
    string comment;
};

type VisitSvcResponse record {
    string comment;
    string houseNo;
    string inTime;
    boolean isApproved;
    string outTime;
    string visitDate;
    string visitorName;
    int visitId;
    string visitorNIC;
    string vehicleNumber;
    string visitorPhoneNo;
};

sheets:Client spreadsheetClient = check new (spreadsheetConfig);


public function insertDetails(Details details) returns error? {
    error? clearAllBySheetName = spreadsheetClient->clearAllBySheetName(spreadsheetId, sheetName);
    error? append = check spreadsheetClient->appendRowToSheet(spreadsheetId, sheetName,
    ["Date", "In Time", "Out Time", "House", "Visitor Name", "Visitor NIC", "Vehicle Number", "Visitor Phone", "Comment"]);
    append = check spreadsheetClient->appendRowToSheet(spreadsheetId, sheetName,
    [details.date, details.inTime, details.outTime, details.houseNumber, details.visitorName, details.visitorNic, details.vehicleNumber, details.visitorPhone, details.comment]);
}

public function main() {

    http:Client|error visitClient = new (visitStatAPIUrl,
        auth = {
            tokenUrl: visitStatAPITokenURL,
            clientId: visitStatAPIConsumerKey,
            clientSecret: visitStatAPIConsumerSecret
        }
    );
    if visitClient is error {
        io:println("Error while initializing the client.");
        return;
    }

    Details[]|error detailsResponse = visitClient->/actualVisits;
    if detailsResponse is error {
        io:println("Error while getting the response.");
        return;
    }
    foreach Details detail in detailsResponse {
       error? insertDetailResponse = insertDetails(detail);
    }

    io:println("Hello, World!");
}