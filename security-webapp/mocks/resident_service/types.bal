import ballerina/http;

public type InternalServerErrorString record {|
    *http:InternalServerError;
    string body;
|};

public type SearchField "HOUSE_NO"|"NAME"|"NIC"|"PHONE_NO"|"EMAIL";

public type Resident record {
    string houseNo;
    string name;
    string nic;
    string phoneNo;
    string email;
};
