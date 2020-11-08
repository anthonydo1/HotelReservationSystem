DROP DATABASE IF EXISTS HOTEL;
CREATE DATABASE HOTEL;
USE HOTEL;

DROP TABLE IF EXISTS User;
CREATE TABLE User
(
    uID INT AUTO_INCREMENT,
    name VARCHAR(50),
    phone VARCHAR(15),
    age INT,
    PRIMARY KEY (uID)
);

DROP TABLE IF EXISTS Room;
CREATE TABLE Room
(
    rID INT,
    floorNumber INT,
    reserved BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (rID)
);

DROP TABLE IF EXISTS RoomType
CREATE TABLE RoomType (
    typeName VARCHAR(50),
    price INT,
    numBeds INT,
    numBaths INT,
    PRIMARY KEY (typeName)
);

DROP TABLE IF EXISTS Booking;
CREATE TABLE Booking
(
    uID INT,
    rID INT,
    typeName VARCHAR(50),
    startDate DATE,
    endDate DATE,
    deposit BOOLEAN,
    FOREIGN KEY (rID) REFERENCES Room (rID),
    FOREIGN KEY (uID) REFERENCES User (uID),
    FOREIGN KEY (typeName) REFERENCES RoomTyoe (typeName)
);

DROP TABLE IF EXISTS BookingHistory;
CREATE TABLE BookingRecord
(
    uID INT,
    rID INT,
    startDate DATE,
    endDate DATE,
);
