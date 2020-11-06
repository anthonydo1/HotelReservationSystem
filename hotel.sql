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
    PRIMARY KEY (uid)
);

DROP TABLE IF EXISTS Room;
CREATE TABLE Room
(
    rID INT,
    floorNumber INT,
    reserved BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (roomNumber)
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
    startDate DATE,
    endDate DATE,
    PRIMARY KEY (uID, rID)
);

DROP TABLE IF EXISTS BookingHistory;
CREATE TABLE BookingRecord
(
    uID INT,
    rID INT,
    startDate DATE,
    endDate DATE,
    PRIMARY KEY (uID, rID, startDate)
);