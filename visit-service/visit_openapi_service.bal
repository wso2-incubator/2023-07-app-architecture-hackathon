
import ballerina/http;
import visit_service.db;
import ballerina/time;

listener http:Listener ep0 = new (9090, config = {host: "localhost"});

// Type drived query
type ScheduledVisitEntity record {|
    int id;
    record {|
        int visitId;
        string houseNo;
        string visitorName;
        string? visitorNIC;
        string? visitorPhoneNo;
        string? vehicleNumber;
        string visitDate;
        boolean isApproved;
        string comment;
    |} visitData;
|};

type ActualVisitEntity record {|
    int id;
    record {|
        int visitId;
        string houseNo;
        string visitorName;
        string? visitorNIC;
        string? visitorPhoneNo;
        string? vehicleNumber;
        string visitDate;
        boolean isApproved;
        string comment;
    |} visitData;
    string inTime;
    string outTime;
|};

service /visit on ep0 {
    private final db:Client db;

    function init() returns error? {
        self.db = check new ();
    }

    resource function get scheduledVisits() returns InternalServerErrorString|ScheduledVisit[] {
        stream<ScheduledVisitEntity, error?> scheduledVisitStream = self.db->/scheduledvisits();
        ScheduledVisit[]|error visits =
            from var {visitData} in scheduledVisitStream
        select {
            visitId: visitData.visitId,
            houseNo: visitData.houseNo,
            visitorName: visitData.visitorName,
            visitorNIC: visitData.visitorNIC,
            visitorPhoneNo: visitData.visitorPhoneNo,
            vehicleNumber: visitData.vehicleNumber,
            visitDate: visitData.visitDate,
            isApproved: visitData.isApproved,
            comment: visitData.comment
        };

        if visits is error {
            return <InternalServerErrorString>{body: "Failed to retrieve scheduled visits."};
        } else {
            return visits;
        }
    }

    resource function post scheduledVisits(@http:Payload NewScheduledVisit payload) returns InternalServerErrorString|ScheduledVisit|http:Forbidden {
    }

    resource function get scheduledVisits/[int visitId]() returns InternalServerErrorString|ScheduledVisit|http:Forbidden {
    }

    resource function put scheduledVisits/[int visitId](@http:Payload ScheduledVisit payload) returns InternalServerErrorString|ScheduledVisit|http:Forbidden {
    }

    resource function get scheduledVisits/search(SearchField searchField, string value) returns InternalServerErrorString|ScheduledVisit[] {
    }

    resource function get actualVisits() returns InternalServerErrorString|ActualVisit[] {
        stream<ActualVisitEntity, error?> actualVisitStream = self.db->/actualvisits();
        ActualVisit[]|error visits =
                from var {visitData, inTime, outTime} in actualVisitStream
        select {

            visitId: visitData.visitId,
            houseNo: visitData.houseNo,
            visitorName: visitData.visitorName,
            visitorNIC: visitData.visitorNIC,
            visitorPhoneNo: visitData.visitorPhoneNo,
            vehicleNumber: visitData.vehicleNumber,
            visitDate: visitData.visitDate,
            isApproved: visitData.isApproved,
            comment: visitData.comment,
            inTime,
            outTime
        };

        if visits is error {
            return <InternalServerErrorString>{body: "Failed to retrieve scheduled visits."};
        } else {
            return visits;
        }
    }

    resource function put actualVisits(@http:Payload ActualVisit payload) returns InternalServerErrorString|ActualVisit {
    }

    resource function post actualVisits(@http:Payload NewActualVisit payload) returns InternalServerErrorString|ActualVisit {

    }

    resource function get actualVisits/[int visitId]() returns InternalServerErrorString|ActualVisit|http:Forbidden {

    }

    resource function get actualVisits/search(SearchField searchField, string value) returns InternalServerErrorString|ActualVisit[] {

    }
}
