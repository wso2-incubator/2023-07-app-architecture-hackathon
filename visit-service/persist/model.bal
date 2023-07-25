import ballerina/time;
import ballerina/persist as _;

// VisitData (visitId, data)
// ActualVisit (id, visitId, intime, outTime, createdBy)
// ScheduledVisit (id, visitId, status (pending, done, cancelled), requestBy)


type VisitData record {|
    readonly int visitId; 
    string houseNo;
    string visitorName;
    string? visitorNIC;
    string? visitorPhoneNo;
    string? vehicleNumber;
    // time:Date visitDate;
    string visitDate;
    boolean isApproved;
    string comment;
    ScheduledVisit? scheduledVisit;
    ActualVisit? actualVisit;
|};

enum Status {
    PENDING,
    DONE,
    CANCELLED
}

type ScheduledVisit record {|
    readonly int id;
    VisitData visitData;
    string requestedBy;
    time:Date createdTime;
    Status status;
|};

type ActualVisit record {|
    readonly int id;
    VisitData visitData;
    // time:Date inTime;
    // time:Date outTime;
    string inTime;
    string outTime;
    string createdBy;
    time:Date createdTime;
|};


