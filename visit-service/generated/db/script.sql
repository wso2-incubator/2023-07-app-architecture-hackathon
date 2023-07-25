-- AUTO-GENERATED FILE.

-- This file is an auto-generated file by Ballerina persistence layer for model.
-- Please verify the generated scripts and execute them against the target DB server.

DROP TABLE IF EXISTS `ActualVisit`;
DROP TABLE IF EXISTS `ScheduledVisit`;
DROP TABLE IF EXISTS `VisitData`;

CREATE TABLE `VisitData` (
	`visitId` INT NOT NULL,
	`houseNo` VARCHAR(191) NOT NULL,
	`visitorName` VARCHAR(191) NOT NULL,
	`visitorNIC` VARCHAR(191),
	`visitorPhoneNo` VARCHAR(191),
	`vehicleNumber` VARCHAR(191),
	`visitDate` DATE NOT NULL,
	`isApproved` BOOLEAN NOT NULL,
	`comment` VARCHAR(191) NOT NULL,
	PRIMARY KEY(`visitId`)
);

CREATE TABLE `ScheduledVisit` (
	`id` INT NOT NULL,
	`requestedBy` VARCHAR(191) NOT NULL,
	`createdTime` DATE NOT NULL,
	`scheduledvisitVisitId` INT UNIQUE NOT NULL,
	FOREIGN KEY(`scheduledvisitVisitId`) REFERENCES `VisitData`(`visitId`),
	PRIMARY KEY(`id`)
);

CREATE TABLE `ActualVisit` (
	`id` INT NOT NULL,
	`inTime` DATE NOT NULL,
	`outTime` DATE NOT NULL,
	`createdBy` VARCHAR(191) NOT NULL,
	`createdTime` DATE NOT NULL,
	`actualvisitVisitId` INT UNIQUE NOT NULL,
	FOREIGN KEY(`actualvisitVisitId`) REFERENCES `VisitData`(`visitId`),
	PRIMARY KEY(`id`)
);
