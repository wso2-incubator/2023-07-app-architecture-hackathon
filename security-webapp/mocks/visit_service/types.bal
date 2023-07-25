import ballerina/http;


public type InternalServerErrorString record {|
    *http:InternalServerError;
    string body;
|};

public type SearchField "HOUSE_NO"|"VISITOR_NAME"|"VISITOR_NIC"|"VISITOR_PHONE_NO"|"VEHICLE_NUMBER";

public type ActualVisit record {
    *NewActualVisit;
    int visitId;
};

public type ScheduledVisit record {
    *NewScheduledVisit;
    int visitId;
};

public type NewScheduledVisit record {
    string houseNo;
    string visitorName;
    string visitorNIC?;
    string visitorPhoneNo?;
    string vehicleNumber?;
    string visitDate;
    boolean isApproved;
    string comment;
};

public type NewActualVisit record {
    string inTime;
    string outTime;
    string houseNo;
    string visitorName;
    string visitorNIC?;
    string visitorPhoneNo?;
    string vehicleNumber?;
    string visitDate;
    boolean isApproved;
    string comment;
};
