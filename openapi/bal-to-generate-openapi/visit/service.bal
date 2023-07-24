import ballerina/http;

service /visit on new http:Listener(9090) {
    resource function get scheduledVisits() returns error?|ScheduledVisit[] {
    }

    resource function get scheduledVisits/[int visitId]() returns error?|ScheduledVisit|http:Forbidden {
    }

    resource function post scheduledVisits(@http:Payload NewScheduledVisit payload) returns error?|CreatedScheduledVisit|http:Forbidden {

    }

    resource function put scheduledVisits/[int visitId](@http:Payload ScheduledVisit payload) returns error?|ScheduledVisit|http:Forbidden {

    }

    resource function get scheduledVisits/search(SearchField searchField, string value) returns error?|ScheduledVisit[] {

    }

    resource function get actualVisits() returns error?|ActualVisit[] {

    }

    resource function get actualVisits/[int visitId]() returns error?|ActualVisit|http:Forbidden {
    }

    resource function post actualVisits(@http:Payload NewActualVisit payload) returns error?|CreatedActualVisit {

    }

    resource function put actualVisits(@http:Payload ActualVisit payload) returns error?|ActualVisit {

    }

    resource function get actualVisits/search(SearchField searchField, string value) returns error?|ActualVisit[] {

    }
}

type CreatedActualVisit record {|
    *http:Created;
    ActualVisit body;
|};

type CreatedScheduledVisit record {|
    *http:Created;
    ScheduledVisit body;
|};

type NewScheduledVisit record {|
    string houseNo;
    string visitorName;
    string visitorNIC?;
    string visitorPhoneNo?;
    string vehicleNumber?;
    string visitDate;
    boolean isApproved;
    string comment;
|};

type ScheduledVisit record {|
    int visitId;
    *NewScheduledVisit;
|};

type NewActualVisit record {|
    *NewScheduledVisit;
    string inTime;
    string outTime;
|};

type ActualVisit record {|
    int visitId;
    *NewActualVisit;
|};

enum SearchField {
    HOUSE_NO,
    VISITOR_NAME,
    VISITOR_NIC,
    VISITOR_PHONE_NO,
    VEHICLE_NUMBER
}
