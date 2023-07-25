// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/time;

public enum Status {
    PENDING,
    DONE,
    CANCELLED
}

public type VisitData record {|
    readonly int visitId;
    string houseNo;
    string visitorName;
    string? visitorNIC;
    string? visitorPhoneNo;
    string? vehicleNumber;
    string visitDate;
    boolean isApproved;
    string comment;
|};

public type VisitDataOptionalized record {|
    int visitId?;
    string houseNo?;
    string visitorName?;
    string? visitorNIC?;
    string? visitorPhoneNo?;
    string? vehicleNumber?;
    string visitDate?;
    boolean isApproved?;
    string comment?;
|};

public type VisitDataWithRelations record {|
    *VisitDataOptionalized;
    ScheduledVisitOptionalized scheduledVisit?;
    ActualVisitOptionalized actualVisit?;
|};

public type VisitDataTargetType typedesc<VisitDataWithRelations>;

public type VisitDataInsert VisitData;

public type VisitDataUpdate record {|
    string houseNo?;
    string visitorName?;
    string? visitorNIC?;
    string? visitorPhoneNo?;
    string? vehicleNumber?;
    string visitDate?;
    boolean isApproved?;
    string comment?;
|};

public type ScheduledVisit record {|
    readonly int id;
    int scheduledvisitVisitId;
    string requestedBy;
    time:Date createdTime;
    Status status;
|};

public type ScheduledVisitOptionalized record {|
    int id?;
    int scheduledvisitVisitId?;
    string requestedBy?;
    time:Date createdTime?;
    Status status?;
|};

public type ScheduledVisitWithRelations record {|
    *ScheduledVisitOptionalized;
    VisitDataOptionalized visitData?;
|};

public type ScheduledVisitTargetType typedesc<ScheduledVisitWithRelations>;

public type ScheduledVisitInsert ScheduledVisit;

public type ScheduledVisitUpdate record {|
    int scheduledvisitVisitId?;
    string requestedBy?;
    time:Date createdTime?;
    Status status?;
|};

public type ActualVisit record {|
    readonly int id;
    int actualvisitVisitId;
    string inTime;
    string outTime;
    string createdBy;
    time:Date createdTime;
|};

public type ActualVisitOptionalized record {|
    int id?;
    int actualvisitVisitId?;
    string inTime?;
    string outTime?;
    string createdBy?;
    time:Date createdTime?;
|};

public type ActualVisitWithRelations record {|
    *ActualVisitOptionalized;
    VisitDataOptionalized visitData?;
|};

public type ActualVisitTargetType typedesc<ActualVisitWithRelations>;

public type ActualVisitInsert ActualVisit;

public type ActualVisitUpdate record {|
    int actualvisitVisitId?;
    string inTime?;
    string outTime?;
    string createdBy?;
    time:Date createdTime?;
|};

