import ballerina/http;

listener http:Listener ep0 = new (9091, config = {host: "0.0.0.0"});


service /visit on ep0 {
    # Description
    #
    # + return - returns can be any of following types
    # InternalServerErrorString (Internal server error)
    # ScheduledVisit[] (Ok)
    resource function get scheduledVisits() returns InternalServerErrorString|ScheduledVisit[] {
    
        ScheduledVisit[] visits = [
            {
                visitId: 1,
                houseNo: "100",
                visitorName: "John",
                visitorNIC: "123456789V",
                visitorPhoneNo: "0771234567",
                vehicleNumber: "AB-1234",
                visitDate: "2021-10-10",
                isApproved: false,
                comment: "test"
            },
            {
                visitId: 2,
                houseNo: "150",
                visitorName: "Smith",
                visitorNIC: "123456789V",
                visitorPhoneNo: "0771234567",
                vehicleNumber: "AB-1234",
                visitDate: "2021-10-10",
                isApproved: true,
                comment: ""
        }
        ];

        return visits;
    }

    # Description
    #
    # + payload - parameter description 
    # + return - returns can be any of following types
    # InternalServerErrorString (Internal server error)
    # ScheduledVisit (Created)
    # http:Forbidden (Forbidden)
    resource function post scheduledVisits(@http:Payload NewScheduledVisit payload) returns InternalServerErrorString|ScheduledVisit|http:Forbidden {
        return {
            visitId: 1,
            houseNo: payload.houseNo,
            visitorName: payload.visitorName,
            visitorNIC: payload.visitorNIC,
            visitorPhoneNo: payload.visitorPhoneNo,
            vehicleNumber: payload.vehicleNumber,
            visitDate: payload.visitDate,
            isApproved: false,
            comment: payload.comment
        };
    }

    # Description
    #
    # + visitId - parameter description 
    # + return - returns can be any of following types
    # InternalServerErrorString (Internal server error)
    # ScheduledVisit (Ok)
    # http:Forbidden (Forbidden)
    resource function get scheduledVisits/[int visitId]() returns InternalServerErrorString|ScheduledVisit|http:Forbidden {
        return {
            visitId: visitId,
            houseNo: "100",
            visitorName: "John",
            visitorNIC: "123456789V",
            visitorPhoneNo: "0771234567",
            vehicleNumber: "AB-1234",
            visitDate: "2021-10-10",
            isApproved: false,
            comment: "test"
        };
    }
    # Description
    #
    # + visitId - parameter description 
    # + payload - parameter description 
    # + return - returns can be any of following types
    # InternalServerErrorString (Internal server error)
    # ScheduledVisit (Ok)
    # http:Forbidden (Forbidden)
    resource function put scheduledVisits/[int visitId](@http:Payload ScheduledVisit payload) returns InternalServerErrorString|ScheduledVisit|http:Forbidden {
        return {
            visitId: visitId,
            houseNo: payload.houseNo,
            visitorName: payload.visitorName,
            visitorNIC: payload.visitorNIC,
            visitorPhoneNo: payload.visitorPhoneNo,
            vehicleNumber: payload.vehicleNumber,
            visitDate: payload.visitDate,
            isApproved: payload.isApproved,
            comment: payload.comment
        };
    }

    # Description
    #
    # + searchField - parameter description 
    # + value - parameter description 
    # + return - returns can be any of following types
    # InternalServerErrorString (Internal server error)
    # ScheduledVisit[] (Ok)
    resource function get scheduledVisits/search(SearchField searchField, string value) returns InternalServerErrorString|ScheduledVisit[] {
        
        ScheduledVisit visit =
        {
            visitId: 1,
            houseNo: "100",
            visitorName: "John",
            visitorNIC: "123456789V",
            visitorPhoneNo: "0771234567",
            vehicleNumber: "AB-1234",
            visitDate: "2021-10-10",
            isApproved: false,
            comment: "test"
        };
        
        match searchField {
            "HOUSE_NO" => {
                visit.houseNo = value;
            }
            "VISITOR_NAME" => {
                visit.visitorName = value;
            }
            "VISITOR_NIC" => {
                visit.visitorNIC = value;
            }
            "VISITOR_PHONE_NO" => {
                visit.visitorPhoneNo = value;
            }
            "VEHICLE_NUMBER" => {
                visit.vehicleNumber = value;
            }
        }

        return [visit];
    }
    # Description
    #
    # + return - returns can be any of following types
    # InternalServerErrorString (Internal server error)
    # ActualVisit[] (Ok)
    resource function get actualVisits() returns InternalServerErrorString|ActualVisit[] {

        ActualVisit[] visits = [
            {
                visitId: 1,
                inTime: "10:00",
                outTime: "11:00",
                houseNo: "100",
                visitorName: "John",
                visitorNIC: "123456789V",
                visitorPhoneNo: "0771234567",
                vehicleNumber: "AB-1234",
                visitDate: "2021-10-10",
                isApproved: false,
                comment: "test"
            },
            {
                visitId: 2,
                inTime: "10:00",
                outTime: "11:00",
                houseNo: "150",
                visitorName: "Smith",
                visitorNIC: "123456789V",
                visitorPhoneNo: "0771234567",
                vehicleNumber: "AB-1234",
                visitDate: "2021-10-10",
                isApproved: true,
                comment: ""
        }
        ];

        return visits;
    }
    # Description
    #
    # + payload - parameter description 
    # + return - returns can be any of following types
    # InternalServerErrorString (Internal server error)
    # ActualVisit (Ok)
    resource function put actualVisits(@http:Payload ActualVisit payload) returns InternalServerErrorString|ActualVisit {
        ActualVisit visit = {
            visitId: payload.visitId,
            inTime: payload.inTime,
            outTime: payload.outTime,
            houseNo: payload.houseNo,
            visitorName: payload.visitorName,
            visitorNIC: payload.visitorNIC,
            visitorPhoneNo: payload.visitorPhoneNo,
            vehicleNumber: payload.vehicleNumber,
            visitDate: payload.visitDate,
            isApproved: payload.isApproved,
            comment: payload.comment
        };

        return visit;
    }

    # Description
    #
    # + payload - parameter description 
    # + return - returns can be any of following types
    # InternalServerErrorString (Internal server error)
    # ActualVisit (Created)
    resource function post actualVisits(@http:Payload NewActualVisit payload) returns InternalServerErrorString|ActualVisit {
        ActualVisit visit = {
            visitId: 999,
            inTime: payload.inTime,
            outTime: payload.outTime,
            houseNo: payload.houseNo,
            visitorName: payload.visitorName,
            visitorNIC: payload.visitorNIC,
            visitorPhoneNo: payload.visitorPhoneNo,
            vehicleNumber: payload.vehicleNumber,
            visitDate: payload.visitDate,
            isApproved: payload.isApproved,
            comment: payload.comment
        };

        return visit;
    }
    # Description
    #
    # + visitId - parameter description 
    # + return - returns can be any of following types
    # InternalServerErrorString (Internal server error)
    # ActualVisit (Ok)
    # http:Forbidden (Forbidden)
    resource function get actualVisits/[int visitId]() returns InternalServerErrorString|ActualVisit|http:Forbidden {
        ActualVisit visit = {
            visitId: visitId,
            inTime: "10:00",
            outTime: "11:00",
            houseNo: "100",
            visitorName: "John",
            visitorNIC: "123456789V",
            visitorPhoneNo: "0771234567",
            vehicleNumber: "AB-1234",
            visitDate: "2021-10-10",
            isApproved: false,
            comment: "test"
        };
    
        return visit;
    }

    # Description
    #
    # + searchField - parameter description 
    # + value - parameter description 
    # + return - returns can be any of following types
    # InternalServerErrorString (Internal server error)
    # ActualVisit[] (Ok)
    resource function get actualVisits/search(SearchField searchField, string value) returns InternalServerErrorString|ActualVisit[] {
        ActualVisit visit = {
            visitId: 1,
            inTime: "10:00",
            outTime: "11:00",
            houseNo: "100",
            visitorName: "John",
            visitorNIC: "123456789V",
            visitorPhoneNo: "0771234567",
            vehicleNumber: "AB-1234",
            visitDate: "2021-10-10",
            isApproved: false,
            comment: "test"
        };

        match searchField {
            "HOUSE_NO" => {
                visit.houseNo = value;
            }
            "VISITOR_NAME" => {
                visit.visitorName = value;
            }
            "VISITOR_NIC" => {
                visit.visitorNIC = value;
            }
            "VISITOR_PHONE_NO" => {
                visit.visitorPhoneNo = value;
            }
            "VEHICLE_NUMBER" => {
                visit.vehicleNumber = value;
            }
        }
        
        return [visit];
    }

}
