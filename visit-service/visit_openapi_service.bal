
import ballerina/http;
import ballerina/random;
import ballerina/log;
import visit_service.db;
import ballerina/persist;
import ballerina/time;

listener http:Listener httpListener = new (9090);

// Type driven query
type ScheduledVisitEntity record {|
    int id;
    record {|
        int visitId;
        string houseNo;
        string visitorName;
        string? visitorNIC;
        string? visitorPhoneNo;
        string? vehicleNumber;
        string visitDate;
        boolean isApproved;
        string comment;
    |} visitData;
|};

type ActualVisitEntity record {|
    int id;
    record {|
        int visitId;
        string houseNo;
        string visitorName;
        string? visitorNIC;
        string? visitorPhoneNo;
        string? vehicleNumber;
        string visitDate;
        boolean isApproved;
        string comment;
    |} visitData;
    string inTime;
    string outTime;
|};

service /visit on httpListener {
    private final db:Client db;

    function init() returns error? {
        self.db = check new ();
    }

    resource function get scheduledVisits() returns InternalServerErrorString|ScheduledVisit[] {
        stream<ScheduledVisitEntity, error?> scheduledVisitStream = self.db->/scheduledvisits;
        ScheduledVisit[]|error visits =
            from var {visitData} in scheduledVisitStream
        select {
            visitId: visitData.visitId,
            houseNo: visitData.houseNo,
            visitorName: visitData.visitorName,
            visitorNIC: visitData.visitorNIC,
            visitorPhoneNo: visitData.visitorPhoneNo,
            vehicleNumber: visitData.vehicleNumber,
            visitDate: visitData.visitDate,
            isApproved: visitData.isApproved,
            comment: visitData.comment
        };

        if visits is error {
            string msg = "Failed to retrieve scheduled visits.";
            log:printError(msg, 'error = visits);
            return <InternalServerErrorString>{body: msg};
        } else {
            return visits;
        }
    }

    resource function post scheduledVisits(NewScheduledVisit payload) returns InternalServerErrorString|ScheduledVisit|http:Forbidden {
        int|error visitId = random:createIntInRange(0, 10000000);
        if visitId is error {
            return <InternalServerErrorString>{body: "Failed to schedule the visit"};
        }

        db:VisitDataInsert visitDataInsert = {
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
        int[]|error insertedIds = self.db->/visitdata.post([visitDataInsert]);
        if insertedIds is error {
            string msg = "Failed to add the scheduled visit.";
            log:printError(msg, 'error = insertedIds);
            return <InternalServerErrorString>{body: msg};
        }

        time:Utc now = time:utcNow();
        time:Civil civilNow = time:utcToCivil(now);
        time:Date createdTime = {
            year: civilNow.year,
            month: civilNow.month,
            day: civilNow.day,
            hour: civilNow.hour,
            minute: civilNow.minute,
            second: civilNow.second
        };

        int|error scheduledVisitId = random:createIntInRange(0, 10000000);
        if scheduledVisitId is error {
            return <InternalServerErrorString>{body: "Failed to generate visit id."};
        }

        db:ScheduledVisitInsert scheduledVisitInsert = {
            id: scheduledVisitId,
            createdTime,
            requestedBy: "admin",
            scheduledvisitVisitId: visitId,
            status: db:PENDING
        };

        int[]|error scheduledVisitIds = self.db->/scheduledvisits.post([scheduledVisitInsert]);
        if scheduledVisitIds is error {
            string msg = "Failed to add the scheduled visit.";
            log:printError(msg, 'error = scheduledVisitIds);
            return <InternalServerErrorString>{body: msg};
        }

        return {
            visitId: visitDataInsert.visitId,
            houseNo: visitDataInsert.houseNo,
            visitorName: visitDataInsert.visitorName,
            visitorNIC: visitDataInsert.visitorNIC,
            visitorPhoneNo: visitDataInsert.visitorPhoneNo,
            vehicleNumber: visitDataInsert.vehicleNumber,
            visitDate: visitDataInsert.visitDate,
            isApproved: visitDataInsert.isApproved,
            comment: visitDataInsert.comment
        };
    }

    resource function get scheduledVisits/[int visitId]() returns InternalServerErrorString|ScheduledVisit|http:Forbidden {
        ScheduledVisitEntity|error scheduledVisitEntity = self.db->/scheduledvisits/[visitId];

        if scheduledVisitEntity is error {
            return <InternalServerErrorString>{body: "Failed to retrieve the scheduled visit"};
        }

        ScheduledVisit scheduledVisit = {
            visitId: scheduledVisitEntity.visitData.visitId,
            houseNo: scheduledVisitEntity.visitData.houseNo,
            visitorName: scheduledVisitEntity.visitData.visitorName,
            visitorNIC: scheduledVisitEntity.visitData.visitorNIC,
            visitorPhoneNo: scheduledVisitEntity.visitData.visitorPhoneNo,
            vehicleNumber: scheduledVisitEntity.visitData.vehicleNumber,
            visitDate: scheduledVisitEntity.visitData.visitDate,
            isApproved: scheduledVisitEntity.visitData.isApproved,
            comment: scheduledVisitEntity.visitData.comment
        };
        return scheduledVisit;
    }

    resource function put scheduledVisits/[int visitId](ScheduledVisit payload) returns InternalServerErrorString|ScheduledVisit|http:Forbidden {
        db:VisitDataUpdate visitDataUpdate = {
            houseNo: payload.houseNo,
            visitorName: payload.visitorName,
            visitorNIC: payload.visitorNIC,
            visitorPhoneNo: payload.visitorPhoneNo,
            vehicleNumber: payload.vehicleNumber,
            visitDate: payload.visitDate,
            isApproved: payload.isApproved,
            comment: payload.comment
        };
        db:VisitData|persist:Error updatedVisit = self.db->/visitdata/[visitId].put(visitDataUpdate);
        if updatedVisit is persist:Error {
            string msg = string `Failed to update the scheduled visit: ${visitId}`;
            log:printError(msg, 'error = updatedVisit);
            return <InternalServerErrorString>{body: msg};
        }

        return {
            visitId: updatedVisit.visitId,
            houseNo: updatedVisit.houseNo,
            visitorName: updatedVisit.visitorName,
            visitorNIC: updatedVisit.visitorNIC,
            visitorPhoneNo: updatedVisit.visitorPhoneNo,
            vehicleNumber: updatedVisit.vehicleNumber,
            visitDate: updatedVisit.visitDate,
            isApproved: updatedVisit.isApproved,
            comment: updatedVisit.comment
        };
    }

    resource function get scheduledVisits/search(SearchField searchField, string value) returns InternalServerErrorString|ScheduledVisit[] {
        stream<ScheduledVisitEntity, error?> scheduledVisitStream = self.db->/scheduledvisits();
        ScheduledVisit[]|error visits;

        match searchField {
            "HOUSE_NO" => {
                visits = from var {visitData} in scheduledVisitStream
                    where visitData.houseNo == value
                    select {
                        visitId: visitData.visitId,
                        houseNo: visitData.houseNo,
                        visitorName: visitData.visitorName,
                        visitorNIC: visitData.visitorNIC,
                        visitorPhoneNo: visitData.visitorPhoneNo,
                        vehicleNumber: visitData.vehicleNumber,
                        visitDate: visitData.visitDate,
                        isApproved: visitData.isApproved,
                        comment: visitData.comment
                    };
            }
            "VISITOR_NAME" => {
                visits = from var {visitData} in scheduledVisitStream
                    where visitData.visitorName == value
                    select {
                        visitId: visitData.visitId,
                        houseNo: visitData.houseNo,
                        visitorName: visitData.visitorName,
                        visitorNIC: visitData.visitorNIC,
                        visitorPhoneNo: visitData.visitorPhoneNo,
                        vehicleNumber: visitData.vehicleNumber,
                        visitDate: visitData.visitDate,
                        isApproved: visitData.isApproved,
                        comment: visitData.comment
                    };
            }
            "VISITOR_NIC" => {
                visits = from var {visitData} in scheduledVisitStream
                    where visitData.visitorNIC == value
                    select {
                        visitId: visitData.visitId,
                        houseNo: visitData.houseNo,
                        visitorName: visitData.visitorName,
                        visitorNIC: visitData.visitorNIC,
                        visitorPhoneNo: visitData.visitorPhoneNo,
                        vehicleNumber: visitData.vehicleNumber,
                        visitDate: visitData.visitDate,
                        isApproved: visitData.isApproved,
                        comment: visitData.comment
                    };
            }
            "VISITOR_PHONE_NO" => {
                visits = from var {visitData} in scheduledVisitStream
                    where visitData.visitorPhoneNo == value
                    select {
                        visitId: visitData.visitId,
                        houseNo: visitData.houseNo,
                        visitorName: visitData.visitorName,
                        visitorNIC: visitData.visitorNIC,
                        visitorPhoneNo: visitData.visitorPhoneNo,
                        vehicleNumber: visitData.vehicleNumber,
                        visitDate: visitData.visitDate,
                        isApproved: visitData.isApproved,
                        comment: visitData.comment
                    };
            }
            "VEHICLE_NUMBER" => {
                visits = from var {visitData} in scheduledVisitStream
                    where visitData.vehicleNumber == value
                    select {
                        visitId: visitData.visitId,
                        houseNo: visitData.houseNo,
                        visitorName: visitData.visitorName,
                        visitorNIC: visitData.visitorNIC,
                        visitorPhoneNo: visitData.visitorPhoneNo,
                        vehicleNumber: visitData.vehicleNumber,
                        visitDate: visitData.visitDate,
                        isApproved: visitData.isApproved,
                        comment: visitData.comment
                    };
            }
            _ => {
                visits = error("Invalid search field.");
            }
        }

        if visits is error {
            return <InternalServerErrorString>{body: "Failed to retrieve scheduled visits."};
        } else {
            return visits;
        }
    }

    resource function get actualVisits() returns InternalServerErrorString|ActualVisit[] {
        stream<ActualVisitEntity, error?> actualVisitStream = self.db->/actualvisits();
        ActualVisit[]|error visits =
                from var {visitData, inTime, outTime} in actualVisitStream
        select {

            visitId: visitData.visitId,
            houseNo: visitData.houseNo,
            visitorName: visitData.visitorName,
            visitorNIC: visitData.visitorNIC,
            visitorPhoneNo: visitData.visitorPhoneNo,
            vehicleNumber: visitData.vehicleNumber,
            visitDate: visitData.visitDate,
            isApproved: visitData.isApproved,
            comment: visitData.comment,
            inTime,
            outTime
        };

        if visits is error {
            string msg = "Failed to retrieve scheduled visits.";
            log:printError(msg, 'error = visits);
            return <InternalServerErrorString>{body: msg};
        } else {
            return visits;
        }
    }

    resource function put actualVisits(ActualVisit payload) returns InternalServerErrorString|ActualVisit {
        // TODO: Two inserts in a transaction

        int visitId = payload.visitId;
        db:VisitDataUpdate visitDataUpdate = {
            houseNo: payload.houseNo,
            visitorName: payload.visitorName,
            visitorNIC: payload.visitorNIC,
            visitorPhoneNo: payload.visitorPhoneNo,
            vehicleNumber: payload.vehicleNumber,
            visitDate: payload.visitDate,
            isApproved: payload.isApproved,
            comment: payload.comment
        };
        db:VisitData|persist:Error updatedVisit = self.db->/visitdata/[visitId].put(visitDataUpdate);
        if updatedVisit is persist:Error {
            string msg = string `Failed to update the scheduled vist: ${visitId}`;
            log:printError(msg, 'error = updatedVisit);
            return <InternalServerErrorString>{body: msg};
        }

        db:ActualVisit[]|error actualVisits = from var actualVisit in self.db->/actualvisits(targetType = db:ActualVisit)
            where actualVisit.actualvisitVisitId == visitId
            select actualVisit;
        if actualVisits is error {
            string msg = string `Failed to update the scheduled vist: ${visitId}`;
            log:printError(msg, 'error = actualVisits);
            return <InternalServerErrorString>{body: msg};
        }

        db:ActualVisitUpdate actualVisitUpdate = {
            inTime: payload.inTime,
            outTime: payload.outTime
        };

        db:ActualVisit|error updatedActualVisit = self.db->/actualvisits/[actualVisits[0].id].put(actualVisitUpdate);
        if updatedActualVisit is error {
            string msg = string `Failed to update the scheduled vist: ${visitId}`;
            log:printError(msg, 'error = updatedActualVisit);
            return <InternalServerErrorString>{body: msg};
        }

        return {
            visitId,
            inTime: updatedActualVisit.inTime,
            outTime: updatedActualVisit.outTime,
            houseNo: updatedVisit.houseNo,
            visitorName: updatedVisit.visitorName,
            visitorNIC: updatedVisit.visitorNIC,
            visitorPhoneNo: updatedVisit.visitorPhoneNo,
            vehicleNumber: updatedVisit.vehicleNumber,
            visitDate: updatedVisit.visitDate,
            isApproved: updatedVisit.isApproved,
            comment: updatedVisit.comment
        };
    }

    resource function post actualVisits(@http:Payload NewActualVisit payload) returns InternalServerErrorString|ActualVisit {
        int|error visitId = random:createIntInRange(0, 10000000);
        if visitId is error {
            return <InternalServerErrorString>{body: "Failed to generate visit id."};
        }

        db:VisitDataInsert visitDataInsert = {
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
        int[]|error insertedIds = self.db->/visitdata.post([visitDataInsert]);
        if insertedIds is error {
            string msg = "Failed to add the scheduled vist.";
            log:printError(msg, 'error = insertedIds);
            return <InternalServerErrorString>{body: msg};
        }

        time:Utc now = time:utcNow();
        time:Civil civilNow = time:utcToCivil(now);
        time:Date createdTime = {
            year: civilNow.year,
            month: civilNow.month,
            day: civilNow.day,
            hour: civilNow.hour,
            minute: civilNow.minute,
            second: civilNow.second
        };

        int|error actualVisitId = random:createIntInRange(0, 10000000);
        if actualVisitId is error {
            return <InternalServerErrorString>{body: "Failed to generate actual visit id."};
        }

        db:ActualVisitInsert actualVisitInsert = {
            id: actualVisitId,
            createdTime,
            actualvisitVisitId: visitId,
            // status: db:PENDING,
            inTime: payload.inTime,
            createdBy: "user",
            outTime: payload.outTime
        };

        int[]|error actualVisitIds = self.db->/actualvisits.post([actualVisitInsert]);
        if actualVisitIds is error {
            string msg = "Failed to add the actual vist.";
            log:printError(msg, 'error = actualVisitIds);
            return <InternalServerErrorString>{body: msg};
        }

        return {
            visitId: visitDataInsert.visitId,
            houseNo: visitDataInsert.houseNo,
            visitorName: visitDataInsert.visitorName,
            visitorNIC: visitDataInsert.visitorNIC,
            visitorPhoneNo: visitDataInsert.visitorPhoneNo,
            vehicleNumber: visitDataInsert.vehicleNumber,
            visitDate: visitDataInsert.visitDate,
            isApproved: visitDataInsert.isApproved,
            comment: visitDataInsert.comment,
            inTime: actualVisitInsert.inTime,
            outTime: actualVisitInsert.outTime
        };
    }

    resource function get actualVisits/[int visitId]() returns InternalServerErrorString|ActualVisit|http:Forbidden {

        ActualVisitEntity|error actualVisitEntry = self.db->/actualvisits/[visitId]();

        if actualVisitEntry is error {
            return <InternalServerErrorString>{body: "Failed to retrieve scheduled visits."};
        }

        ActualVisit actualVisit = {
            visitId: actualVisitEntry.visitData.visitId,
            houseNo: actualVisitEntry.visitData.houseNo,
            visitorName: actualVisitEntry.visitData.visitorName,
            visitorNIC: actualVisitEntry.visitData.visitorNIC,
            visitorPhoneNo: actualVisitEntry.visitData.visitorPhoneNo,
            vehicleNumber: actualVisitEntry.visitData.vehicleNumber,
            visitDate: actualVisitEntry.visitData.visitDate,
            isApproved: actualVisitEntry.visitData.isApproved,
            comment: actualVisitEntry.visitData.comment,
            inTime: actualVisitEntry.inTime,
            outTime: actualVisitEntry.outTime
        };

        return actualVisit;
    }

    resource function get actualVisits/search(SearchField searchField, string value) returns InternalServerErrorString|ActualVisit[] {
        stream<ActualVisitEntity, error?> actualVisitStream = self.db->/actualvisits();
        ActualVisit[]|error visits;

        match searchField {
            "HOUSE_NO" => {
                visits = from var actualVisitEntity in actualVisitStream
                where actualVisitEntity.visitData.houseNo == value
                select {
                    visitId: actualVisitEntity.visitData.visitId,
                    houseNo: actualVisitEntity.visitData.houseNo,
                    visitorName: actualVisitEntity.visitData.visitorName,
                    visitorNIC: actualVisitEntity.visitData.visitorNIC,
                    visitorPhoneNo: actualVisitEntity.visitData.visitorPhoneNo,
                    vehicleNumber: actualVisitEntity.visitData.vehicleNumber,
                    visitDate: actualVisitEntity.visitData.visitDate,
                    isApproved: actualVisitEntity.visitData.isApproved,
                    comment: actualVisitEntity.visitData.comment,
                    inTime: actualVisitEntity.inTime,
                    outTime: actualVisitEntity.outTime
                    
                };
            }
            "VISITOR_NAME" => {
                visits = from var actualVisitEntity in actualVisitStream
                where actualVisitEntity.visitData.visitorName == value
                select {
                    visitId: actualVisitEntity.visitData.visitId,
                    houseNo: actualVisitEntity.visitData.houseNo,
                    visitorName: actualVisitEntity.visitData.visitorName,
                    visitorNIC: actualVisitEntity.visitData.visitorNIC,
                    visitorPhoneNo: actualVisitEntity.visitData.visitorPhoneNo,
                    vehicleNumber: actualVisitEntity.visitData.vehicleNumber,
                    visitDate: actualVisitEntity.visitData.visitDate,
                    isApproved: actualVisitEntity.visitData.isApproved,
                    comment: actualVisitEntity.visitData.comment,
                    inTime: actualVisitEntity.inTime,
                    outTime: actualVisitEntity.outTime
                    
                };
            }
            "VISITOR_NIC" => {
                visits = from var actualVisitEntity in actualVisitStream
                where actualVisitEntity.visitData.visitorNIC == value
                select {
                    visitId: actualVisitEntity.visitData.visitId,
                    houseNo: actualVisitEntity.visitData.houseNo,
                    visitorName: actualVisitEntity.visitData.visitorName,
                    visitorNIC: actualVisitEntity.visitData.visitorNIC,
                    visitorPhoneNo: actualVisitEntity.visitData.visitorPhoneNo,
                    vehicleNumber: actualVisitEntity.visitData.vehicleNumber,
                    visitDate: actualVisitEntity.visitData.visitDate,
                    isApproved: actualVisitEntity.visitData.isApproved,
                    comment: actualVisitEntity.visitData.comment,
                    inTime: actualVisitEntity.inTime,
                    outTime: actualVisitEntity.outTime
                    
                };
            }
            "VISITOR_PHONE_NO" => {
                visits = from var actualVisitEntity in actualVisitStream
                where actualVisitEntity.visitData.visitorPhoneNo == value
                select {
                    visitId: actualVisitEntity.visitData.visitId,
                    houseNo: actualVisitEntity.visitData.houseNo,
                    visitorName: actualVisitEntity.visitData.visitorName,
                    visitorNIC: actualVisitEntity.visitData.visitorNIC,
                    visitorPhoneNo: actualVisitEntity.visitData.visitorPhoneNo,
                    vehicleNumber: actualVisitEntity.visitData.vehicleNumber,
                    visitDate: actualVisitEntity.visitData.visitDate,
                    isApproved: actualVisitEntity.visitData.isApproved,
                    comment: actualVisitEntity.visitData.comment,
                    inTime: actualVisitEntity.inTime,
                    outTime: actualVisitEntity.outTime
                    
                };
            }
            "VEHICLE_NUMBER" => {
                visits = from var actualVisitEntity in actualVisitStream
                where actualVisitEntity.visitData.vehicleNumber == value
                select {
                    visitId: actualVisitEntity.visitData.visitId,
                    houseNo: actualVisitEntity.visitData.houseNo,
                    visitorName: actualVisitEntity.visitData.visitorName,
                    visitorNIC: actualVisitEntity.visitData.visitorNIC,
                    visitorPhoneNo: actualVisitEntity.visitData.visitorPhoneNo,
                    vehicleNumber: actualVisitEntity.visitData.vehicleNumber,
                    visitDate: actualVisitEntity.visitData.visitDate,
                    isApproved: actualVisitEntity.visitData.isApproved,
                    comment: actualVisitEntity.visitData.comment,
                    inTime: actualVisitEntity.inTime,
                    outTime: actualVisitEntity.outTime
                    
                };
            }
            _ => {
                visits = error("Invalid search field.");
            }

        }

        if visits is error {
            return <InternalServerErrorString>{body: "Failed to search acutual visits."};
        } else {
            return visits;
        }

    }
}

