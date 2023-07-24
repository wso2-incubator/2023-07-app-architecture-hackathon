import ballerina/http;

service / on new http:Listener(9090) {
    resource function get residents() returns error?|Resident[] {
        
    }
    resource function get residents/search(SearchField searchField, string value) returns error?|Resident[] {
        
    }

}

type Resident record {
    string houseNo;
    string name;
    string nic;
    string phoneNo;
    string email;
};

enum SearchField {
    HOUSE_NO,
    NAME,
    NIC,
    PHONE_NO,
    EMAIL
} 