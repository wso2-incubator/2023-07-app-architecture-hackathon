import ballerina/http;

service / on new http:Listener(9090) {

    resource function get owners() returns error?|Owner[] {
        
    }
    resource function get owners/search(SearchField searchField, string value) returns error?|Owner[] {
        
    }

}

type Owner record {
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