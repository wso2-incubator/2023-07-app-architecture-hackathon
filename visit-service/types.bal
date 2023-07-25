import ballerina/constraint;
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
    @constraint:String {pattern: re `^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$`}
    string visitDate;
    boolean isApproved;
    string comment;
};

public type NewActualVisit record {
    @constraint:String {pattern: re `^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$`}
    string inTime;
    @constraint:String {pattern: re `^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$`}
    string outTime;
    string houseNo;
    string visitorName;
    string visitorNIC?;
    string visitorPhoneNo?;
    string vehicleNumber?;
    @constraint:String {pattern: re `^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$`}
    string visitDate;
    boolean isApproved;
    string comment;
};

