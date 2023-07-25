// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/persist;
import ballerina/jballerina.java;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerinax/persist.sql as psql;

const VISIT_DATA = "visitdata";
const SCHEDULED_VISIT = "scheduledvisits";
const ACTUAL_VISIT = "actualvisits";

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final mysql:Client dbClient;

    private final map<psql:SQLClient> persistClients;

    private final record {|psql:SQLMetadata...;|} & readonly metadata = {
        [VISIT_DATA] : {
            entityName: "VisitData",
            tableName: "VisitData",
            fieldMetadata: {
                visitId: {columnName: "visitId"},
                houseNo: {columnName: "houseNo"},
                visitorName: {columnName: "visitorName"},
                visitorNIC: {columnName: "visitorNIC"},
                visitorPhoneNo: {columnName: "visitorPhoneNo"},
                vehicleNumber: {columnName: "vehicleNumber"},
                visitDate: {columnName: "visitDate"},
                isApproved: {columnName: "isApproved"},
                comment: {columnName: "comment"},
                "scheduledVisit.id": {relation: {entityName: "scheduledVisit", refField: "id"}},
                "scheduledVisit.scheduledvisitVisitId": {relation: {entityName: "scheduledVisit", refField: "scheduledvisitVisitId"}},
                "scheduledVisit.requestedBy": {relation: {entityName: "scheduledVisit", refField: "requestedBy"}},
                "scheduledVisit.createdTime": {relation: {entityName: "scheduledVisit", refField: "createdTime"}},
                "actualVisit.id": {relation: {entityName: "actualVisit", refField: "id"}},
                "actualVisit.actualvisitVisitId": {relation: {entityName: "actualVisit", refField: "actualvisitVisitId"}},
                "actualVisit.inTime": {relation: {entityName: "actualVisit", refField: "inTime"}},
                "actualVisit.outTime": {relation: {entityName: "actualVisit", refField: "outTime"}},
                "actualVisit.createdBy": {relation: {entityName: "actualVisit", refField: "createdBy"}},
                "actualVisit.createdTime": {relation: {entityName: "actualVisit", refField: "createdTime"}}
            },
            keyFields: ["visitId"],
            joinMetadata: {
                scheduledVisit: {entity: ScheduledVisit, fieldName: "scheduledVisit", refTable: "ScheduledVisit", refColumns: ["visitdataVisitId"], joinColumns: ["visitId"], 'type: psql:ONE_TO_ONE},
                actualVisit: {entity: ActualVisit, fieldName: "actualVisit", refTable: "ActualVisit", refColumns: ["visitdataVisitId"], joinColumns: ["visitId"], 'type: psql:ONE_TO_ONE}
            }
        },
        [SCHEDULED_VISIT] : {
            entityName: "ScheduledVisit",
            tableName: "ScheduledVisit",
            fieldMetadata: {
                id: {columnName: "id"},
                scheduledvisitVisitId: {columnName: "scheduledvisitVisitId"},
                requestedBy: {columnName: "requestedBy"},
                createdTime: {columnName: "createdTime"},
                "visitData.visitId": {relation: {entityName: "visitData", refField: "visitId"}},
                "visitData.houseNo": {relation: {entityName: "visitData", refField: "houseNo"}},
                "visitData.visitorName": {relation: {entityName: "visitData", refField: "visitorName"}},
                "visitData.visitorNIC": {relation: {entityName: "visitData", refField: "visitorNIC"}},
                "visitData.visitorPhoneNo": {relation: {entityName: "visitData", refField: "visitorPhoneNo"}},
                "visitData.vehicleNumber": {relation: {entityName: "visitData", refField: "vehicleNumber"}},
                "visitData.visitDate": {relation: {entityName: "visitData", refField: "visitDate"}},
                "visitData.isApproved": {relation: {entityName: "visitData", refField: "isApproved"}},
                "visitData.comment": {relation: {entityName: "visitData", refField: "comment"}}
            },
            keyFields: ["id"],
            joinMetadata: {visitData: {entity: VisitData, fieldName: "visitData", refTable: "VisitData", refColumns: ["visitId"], joinColumns: ["scheduledvisitVisitId"], 'type: psql:ONE_TO_ONE}}
        },
        [ACTUAL_VISIT] : {
            entityName: "ActualVisit",
            tableName: "ActualVisit",
            fieldMetadata: {
                id: {columnName: "id"},
                actualvisitVisitId: {columnName: "actualvisitVisitId"},
                inTime: {columnName: "inTime"},
                outTime: {columnName: "outTime"},
                createdBy: {columnName: "createdBy"},
                createdTime: {columnName: "createdTime"},
                "visitData.visitId": {relation: {entityName: "visitData", refField: "visitId"}},
                "visitData.houseNo": {relation: {entityName: "visitData", refField: "houseNo"}},
                "visitData.visitorName": {relation: {entityName: "visitData", refField: "visitorName"}},
                "visitData.visitorNIC": {relation: {entityName: "visitData", refField: "visitorNIC"}},
                "visitData.visitorPhoneNo": {relation: {entityName: "visitData", refField: "visitorPhoneNo"}},
                "visitData.vehicleNumber": {relation: {entityName: "visitData", refField: "vehicleNumber"}},
                "visitData.visitDate": {relation: {entityName: "visitData", refField: "visitDate"}},
                "visitData.isApproved": {relation: {entityName: "visitData", refField: "isApproved"}},
                "visitData.comment": {relation: {entityName: "visitData", refField: "comment"}}
            },
            keyFields: ["id"],
            joinMetadata: {visitData: {entity: VisitData, fieldName: "visitData", refTable: "VisitData", refColumns: ["visitId"], joinColumns: ["actualvisitVisitId"], 'type: psql:ONE_TO_ONE}}
        }
    };

    public isolated function init() returns persist:Error? {
        mysql:Client|error dbClient = new (host = host, user = user, password = password, database = database, port = port, options = connectionOptions);
        if dbClient is error {
            return <persist:Error>error(dbClient.message());
        }
        self.dbClient = dbClient;
        self.persistClients = {
            [VISIT_DATA] : check new (dbClient, self.metadata.get(VISIT_DATA), psql:MYSQL_SPECIFICS),
            [SCHEDULED_VISIT] : check new (dbClient, self.metadata.get(SCHEDULED_VISIT), psql:MYSQL_SPECIFICS),
            [ACTUAL_VISIT] : check new (dbClient, self.metadata.get(ACTUAL_VISIT), psql:MYSQL_SPECIFICS)
        };
    }

    isolated resource function get visitdata(VisitDataTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get visitdata/[int visitId](VisitDataTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post visitdata(VisitDataInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(VISIT_DATA);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from VisitDataInsert inserted in data
            select inserted.visitId;
    }

    isolated resource function put visitdata/[int visitId](VisitDataUpdate value) returns VisitData|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(VISIT_DATA);
        }
        _ = check sqlClient.runUpdateQuery(visitId, value);
        return self->/visitdata/[visitId].get();
    }

    isolated resource function delete visitdata/[int visitId]() returns VisitData|persist:Error {
        VisitData result = check self->/visitdata/[visitId].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(VISIT_DATA);
        }
        _ = check sqlClient.runDeleteQuery(visitId);
        return result;
    }

    isolated resource function get scheduledvisits(ScheduledVisitTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get scheduledvisits/[int id](ScheduledVisitTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post scheduledvisits(ScheduledVisitInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(SCHEDULED_VISIT);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ScheduledVisitInsert inserted in data
            select inserted.id;
    }

    isolated resource function put scheduledvisits/[int id](ScheduledVisitUpdate value) returns ScheduledVisit|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(SCHEDULED_VISIT);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/scheduledvisits/[id].get();
    }

    isolated resource function delete scheduledvisits/[int id]() returns ScheduledVisit|persist:Error {
        ScheduledVisit result = check self->/scheduledvisits/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(SCHEDULED_VISIT);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get actualvisits(ActualVisitTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "query"
    } external;

    isolated resource function get actualvisits/[int id](ActualVisitTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.MySQLProcessor",
        name: "queryOne"
    } external;

    isolated resource function post actualvisits(ActualVisitInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ACTUAL_VISIT);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from ActualVisitInsert inserted in data
            select inserted.id;
    }

    isolated resource function put actualvisits/[int id](ActualVisitUpdate value) returns ActualVisit|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ACTUAL_VISIT);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/actualvisits/[id].get();
    }

    isolated resource function delete actualvisits/[int id]() returns ActualVisit|persist:Error {
        ActualVisit result = check self->/actualvisits/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(ACTUAL_VISIT);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    public isolated function close() returns persist:Error? {
        error? result = self.dbClient.close();
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }
}

