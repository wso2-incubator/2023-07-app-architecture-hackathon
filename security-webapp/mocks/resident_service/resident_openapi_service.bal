import ballerina/http;

listener http:Listener ep0 = new (9090, config = {host: "localhost"});

service / on ep0 {
    # Description
    #
    # + return - returns can be any of following types
    # InternalServerErrorString (Internal server error)
    # Resident[] (Ok)
    resource function get residents() returns InternalServerErrorString|Resident[] {

        Resident[] residents = [
            {
                houseNo: "10",
                name: "John Doe",
                nic: "123456789V",
                phoneNo: "0770125223",
                email: "john@lotusgrove.lk"
            },
            {
                houseNo: "11",
                name: "Jane Doe",
                nic: "123456789V",
                phoneNo: "0112078654",
                email: "jane@lotusgrove.lk"
            },
            {
                houseNo: "12",
                name: "Jack Daniels",
                nic: "123456789V",
                phoneNo: "0112078654",
                email: "jack@gmail.com"
            },
            {
                houseNo: "13",
                name: "Jill Doe",
                nic: "07704577235",
                phoneNo: "0112078654",
                email: "jill@outlook.com"
            },
            {
                houseNo: "14",
                name: "James Doe",
                nic: "123456789V",
                phoneNo: "0112078654",
                email: "james@yahoo.com"
            }
        ];

        return residents;
    }

    # Description
    #
    # + searchField - parameter description 
    # + value - parameter description 
    # + return - returns can be any of following types
    # InternalServerErrorString (Internal server error)
    # Resident[] (Ok)
    resource function get residents/search(SearchField searchField, string value) returns InternalServerErrorString|Resident[] {

        Resident resident = {
            houseNo: "10",
            name: "John Doe",
            nic: "123456789V",
            phoneNo: "0770125223",
            email: "john@lotusgrove.lk"
        };
 
        match searchField {
            "HOUSE_NO" => {
                resident.houseNo = value;
            }
            "NAME" => {
                resident.name = value;
            }
            "NIC" => {
                resident.nic = value;
            }
            "PHONE_NO" => {
                resident.phoneNo = value;
            }
            "EMAIL" => {
                resident.email = value;
            }
        }

        Resident[] residents = [
            resident
        ];

        return residents;
    }
}
