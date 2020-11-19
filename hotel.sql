DROP DATABASE IF EXISTS HOTEL;
CREATE DATABASE HOTEL;
USE HOTEL;

DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS RoomType;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS BookingRecord;


CREATE TABLE User
(
    uID INT AUTO_INCREMENT,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    phone VARCHAR(15),
    age INT,
    PRIMARY KEY (uID)
);


CREATE TABLE RoomType (
    typeName VARCHAR(45),
    price INT,
    bedSize VARCHAR(15),
    numBeds INT,
    max_occupants INT,
    PRIMARY KEY(typeName)
);


CREATE TABLE Room
(
    rID INT,
    floorNumber INT,
    typeName VARCHAR(45),
    reserved BOOLEAN DEFAULT FALSE,
    smokeFree BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (rID),
    FOREIGN KEY (typeName) REFERENCES RoomType(typeName)
);


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


DROP TRIGGER IF EXISTS CheckIn;
DELIMITER //
CREATE TRIGGER CheckIn
BEFORE INSERT ON Booking
FOR EACH ROW
BEGIN
	UPDATE Room
	SET reserved = true
	WHERE Room.rID = new.rID
	AND new.startDate <= CURDATE()
	AND new.endDate > CURDATE();
END //
DELIMITER ;


DROP TRIGGER IF EXISTS CheckOut;
DELIMITER //
CREATE TRIGGER CheckOut
BEFORE DELETE ON Booking
FOR EACH ROW
BEGIN
UPDATE room
set room.reserved = False
WHERE old.rID = room.rID;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS recordBooking;
DELIMITER //
CREATE PROCEDURE recordBooking (IN cutOffDate DATE)
BEGIN
	INSERT INTO BookingRecord (uID, rID, startDate, endDate)
		SELECT uID, rID, startDate, endDate
		FROM Booking
		WHERE Booking.endDate < cutOffDate ;
	DELETE FROM Booking WHERE Booking.endDate < cutOffDate ;
END // 
DELIMITER ;


insert into user values(1,'Nabeel', 'Chen', '408-200-2090',30);
insert into user values(2,'Cherry', 'Blair', '408-207-3555',25);
insert into user values(3,'Matas', 'Grimes', '305-258-9383',48);
insert into user values(4,'Bob', 'Weeks', '408-224-6469',43);
insert into user values(5,'Asiyah', 'Salt', '408-210-5628',33);
insert into user values(6,'Courtney', 'Stafford', '831-844-3181',22);
insert into user values(7,'Jasmin', 'Quinn', '408-213-3853',33);
insert into user values(8,'Bentley', 'Perkins', '614-799-6254',65);
insert into user values(9,'Alivia', 'Pineda', '408-216-8042',38);
insert into user values(10,'Tj', 'Blundell', '408-217-0286',28);
insert into user values(11,'Gregory', 'Velazquez', '408-218-7135',25);
insert into user values(12,'Matas', 'Woods', '646-998-1245',65);
insert into user values(13,'Bob', 'Weeks', '408-219-2364',45);
insert into user values(14,'Florrie', 'Porter', '218-781-9042',21);
insert into user values(15,'Domas', 'Adam', '408-221-4657',25);
insert into user values(16,'Beverly', 'Walls', '408-223-2028',38);
insert into user values(17,'Bob', 'Weeks', '428-124-3449',36);
insert into user values(18,'Jasmin', 'Blundell', '408-225-3232',46);
insert into user values(19,'Simon', 'Enriquez', '408-226-2742',46);
insert into user values(20,'Tj', 'Chen', '408-227-0398',53);
insert into user values(21,'Leo', 'Britt', '979-532-7183',74);
insert into user values(22,'Mindy', 'Weeks', '608-515-2749',22);
insert into user values(23,'Harri', 'Olson', '856-756-7309',29);
insert into user values(24,'Ferne ', 'West', '559-446-6155',23);
insert into user values(25,'Shelbie ', 'Buck', '469-337-3581',55);
insert into user values(26,'Abi', 'Park', '408-229-5237',39);

insert into roomtype values('CLASSIC', 79,'Queen', 1,2);
insert into roomtype values('VALUE', 99,'King', 1, 4);
insert into roomtype values('PREMIUM', 119,'Queen', 2,4);
insert into roomtype values('PREMIUM KING', 139,'King', 2,4);
insert into roomtype values('DELUXE', 159,'King', 1,2);
insert into roomtype values('DELUXE KING', 189,'King', 2,6);
insert into roomtype values('DELUXE PREMIUM', 259,'King', 2,8);



insert into room values(201, 2, 'CLASSIC',True,True);
insert into room values(202, 2, 'CLASSIC',True,True);
insert into room values(203, 2, 'CLASSIC',True,True);
insert into room values(204, 2, 'CLASSIC',false,True);
insert into room values(205, 2, 'VALUE',True,false);
insert into room values(301, 3, 'VALUE',false,True);
insert into room values(302, 3, 'VALUE',True,True);
insert into room values(303, 3, 'VALUE',false,True);
insert into room values(304, 3, 'PREMIUM',True,True);
insert into room values(305, 3, 'PREMIUM',True,false);
insert into room values(401, 4, 'PREMIUM KING',false,True);
insert into room values(402, 4, 'PREMIUM KING',false,True);
insert into room values(403, 4, 'DELUXE',True,True);
insert into room values(404, 4, 'DELUXE',True,True);
insert into room values(405, 4, 'DELUXE KING',false,false);
insert into room values(501, 5, 'DELUXE KING',True,True);
insert into room values(502, 5, 'DELUXE PREMIUM',false,false);


insert into booking values(15,202,'CLASSIC','2020-08-20','2020-08-23',TRUE);
insert into booking values(16,205,'VALUE','2020-08-20','2020-08-21',TRUE);
insert into booking values(17,304,'PREMIUM','2020-08-22','2020-08-24',FALSE);
insert into booking values(18,203,'CLASSIC','2020-08-22','2020-08-25',TRUE);
insert into booking values(19,302,'VALUE','2020-08-23','2020-08-25',TRUE);
insert into booking values(20,403,'DELUXE','2020-08-23','2020-08-31',FALSE);
insert into booking values(21,501,'DELUXE KING','2020-08-24','2020-08-30',TRUE);
insert into booking values(22,305,'PREMIUM','2020-08-24','2020-08-25',FALSE);
insert into booking values(23,201,'CLASSIC','2020-08-24','2020-08-26',TRUE);
insert into booking values(24,404,'DELUXE','2020-08-25','2020-08-31',TRUE);



insert into bookingrecord values(1,202,'2020-06-23','2020-06-24');
insert into bookingrecord values(2,205,'2020-06-28','2020-06-30');
insert into bookingrecord values(3,201,'2020-07-13','2020-07-16');
insert into bookingrecord values(4,302,'2020-07-15','2020-07-24');
insert into bookingrecord values(5,402,'2020-07-15','2020-07-24');
insert into bookingrecord values(6,304,'2020-07-17','2020-07-20');
insert into bookingrecord values(7,305,'2020-07-19','2020-07-26');
insert into bookingrecord values(8,405,'2020-07-23','2020-07-24');
insert into bookingrecord values(9,501,'2020-07-23','2020-07-28');
insert into bookingrecord values(10,405,'2020-07-25','2020-07-30');
insert into bookingrecord values(11,302,'2020-07-26','2020-07-29');
insert into bookingrecord values(12,202,'2020-07-27','2020-07-31');
insert into bookingrecord values(13,204,'2020-08-10','2020-08-13');
insert into bookingrecord values(14,401,'2020-08-13','2020-08-15');
insert into bookingrecord values(15,301,'2020-08-18','2020-01-19');
