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
    time:Date visitDate;
    boolean isApproved;
    string comment;
    ScheduledVisit? scheduledVisit;
    ActualVisit? actualVisit;
|};

type ScheduledVisit record {|
    readonly int id;
    VisitData visitData;
    string requestedBy;
    time:Date createdTime;
|};

type ActualVisit record {|
    readonly int id;
    VisitData visitData;
    time:Date inTime;
    time:Date outTime;
    string createdBy;
    time:Date createdTime;
|};


