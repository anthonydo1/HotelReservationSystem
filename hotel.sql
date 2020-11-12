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

DROP TABLE IF EXISTS RoomType;
CREATE TABLE RoomType (
    typeName VARCHAR(45),
    price INT,
    bedSize VARCHAR(15),
    numBeds INT,
    max_occupants INT,
    PRIMARY KEY(typeName)
);


DROP TABLE IF EXISTS Room;
CREATE TABLE Room
(
    rID INT,
    floorNumber INT,
    typeName VARCHAR(45),
    reserved VARCHAR(10) DEFAULT 'N',
    smokeFree BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (rID),
    FOREIGN KEY (typeName) REFERENCES RoomType(typeName)
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
    FOREIGN KEY (typeName) REFERENCES RoomType (typeName)
);

DROP TABLE IF EXISTS BookingRecord;
CREATE TABLE BookingRecord
(
    uID INT,
    rID INT,
    startDate DATE,
    endDate DATE,
    PRIMARY KEY(uID, rID, startDate),
    FOREIGN KEY(uID) REFERENCES user(uID),
    FOREIGN KEY(rID) REFERENCES room(rID)
);
