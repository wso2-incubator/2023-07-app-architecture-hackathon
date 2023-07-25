import ballerina/io;
import ballerinax/googleapis.sheets as sheets;

configurable string refreshToken = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string spreadsheetId = ?;
configurable string sheetName = ?;

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
    Details details = {
        date: "2023-07-25",
        inTime: "15:00",
        outTime: "16:00",
        houseNumber: "16B",
        visitorName: "Nandika",
        visitorNic: "123456789V",
        vehicleNumber: "WP-1234",
        visitorPhone: "0712345678",
        comment: "VIP"
    };

    error? a = insertDetails(details);

    io:println("Hello, World!");
}