DROP DATABASE Ppost;
CREATE DATABASE Ppost;
USE Ppost;

#User

CREATE TABLE User(
userID CHAR(8) NOT NULL,
userName VARCHAR(20) NOT NULL,
userContactNo VARCHAR(20) NOT NULL,
registeredDate DATE NOT NULL,
userStatus CHAR(1) NOT NULL CHECK(userStatus in('A','B')),
PRIMARY KEY (userID));

DESC User;

#Driver

CREATE TABLE Driver(
driverID CHAR(8) NOT NULL,
driverName VARCHAR(20) NOT NULL,
driverContactNo VARCHAR(20) NOT NULL,
driverRating DECIMAL (5,2) NOT NULL,
driverVehicle VARCHAR(20) NOT NULL,
PRIMARY KEY (driverID));

DESC Driver;

#Feedback

CREATE TABLE Feedback(
feedbackID CHAR(8) NOT NULL,
date DATE NOT NULL,
time TIME NOT NULL,
comment VARCHAR(100) NOT NULL,
PRIMARY KEY (feedbackID));

DESC Feedback;

#Promotion

CREATE TABLE Promotion(
promoCode CHAR(8) NOT NULL,
promoTitle VARCHAR(20) NOT NULL,
promoType VARCHAR(20) NOT NULL,
discountAmount DECIMAL(5,2) NOT NULL,
promoExpiryDate DATE NOT NULL,
promoStatus CHAR (1) NOT NULL CHECK(promoStatus in('Y',"N")),
PRIMARY KEY (promoCode));

DESC Promotion;

#Service 

CREATE TABLE Service(
serviceTypeID CHAR(8) NOT NULL,
serviceTypeName	VARCHAR(20) NOT NULL,
auditLog VARCHAR(20) NOT NULL,
costBaseLine DECIMAL(5,2) NOT NULL,
PRIMARY KEY (serviceTypeID));

DESC Service;

#Shop

CREATE TABLE Shop(
shopID CHAR(8) NOT NULL,
addressNo VARCHAR(5) NOT NULL,
street VARCHAR(20) NOT NULL,
city VARCHAR(20) NOT NULL,
postCode VARCHAR(10) NOT NULL,
PRIMARY KEY (shopID));

DESC Shop;

#VehicleForRent

CREATE TABLE VehicleForRent(
vehicleID CHAR(8) NOT NULL,
carPlateNo VARCHAR(20) NOT NULL,
carBrand VARCHAR(20) NOT NULL,
carModel VARCHAR(20) NOT NULL,
carType VARCHAR(20) NOT NULL,
carColour VARCHAR(20) NOT NULL,
pax INT NOT NULL,
PRIMARY KEY (vehicleID));

DESC VehicleForRent;

#Transport Service

CREATE TABLE TransportService(
tReceiptNo CHAR(8) NOT NULL,
serviceTypeID CHAR(8) NOT NULL,
pickUpLocation VARCHAR(50) NOT NULL,
dropOffLocation VARCHAR(50) NOT NULL,
date DATE NOT NULL,
pickUpTime TIME NOT NULL,
dropOffTime TIME NOT NULL,
PRIMARY KEY (tReceiptNo),
FOREIGN KEY (serviceTypeID) REFERENCES Service (serviceTypeID));

DESC TransportService;

#Delivery Service

CREATE TABLE DeliveryService(
dReceiptNo CHAR(8) NOT NULL,
serviceTypeID CHAR(8) NOT NULL,
shopID CHAR(8) NOT NULL,
dropOffLocation VARCHAR(50) NOT NULL,
deliverDate Date NOT NULL,
deliverTime TIME NOT NULL,
arrivedDate DATE NOT NULL,
arrivedTime TIME NOT NULL,
PRIMARY KEY (dReceiptNo),
FOREIGN KEY (serviceTypeID) REFERENCES Service (serviceTypeID),
FOREIGN KEY (shopID) REFERENCES Shop (shopID));

DESC DeliveryService;

#Rent Service

CREATE TABLE RentService(
rentID CHAR(8) NOT NULL,
serviceTypeID CHAR(8) NOT NULL,
vehicleID CHAR(8) NOT NULL,
rentDateFrom DATE NOT NULL,
rentDateTo DATE NOT NULL,
rentTimeFrom TIME NOT NULL,
rentTimeTo TIME NOT NULL,
PRIMARY KEY (rentID),
FOREIGN KEY (serviceTypeID) REFERENCES Service (serviceTypeID),
FOREIGN KEY (vehicleID) REFERENCES VehicleForRent (vehicleID));

DESC RentService;

#Service Review 

CREATE TABLE ServiceRating(
reviewID CHAR(8) NOT NULL,
serviceTypeID CHAR(8) NOT NULL,
date DATE NOT NULL,
time TIME NOT NULL,
comment VARCHAR(100) NOT NULL,
PRIMARY KEY (reviewID),
FOREIGN KEY (serviceTypeID) REFERENCES Service (serviceTypeID));

DESC ServiceRating;

#Premium 

CREATE TABLE Premium(
eCardID CHAR(8) NOT NULL,
userID CHAR(8) NOT NULL,
premiumTier VARCHAR(20) NOT NULL,
memberSince DATE NOT NULL,
validTill DATE NOT NULL,
PRIMARY KEY (eCardID),
FOREIGN KEY (userID) REFERENCES User (userID));

DESC Premium;

#Transaction Card

CREATE TABLE TransactionCard(
cardNo CHAR(12) NOT NULL,
userID CHAR(8) NOT NULL,
issuingBank VARCHAR(20) NOT NULL,
holderName VARCHAR(20) NOT NULL,
PRIMARY KEY (cardNo),
FOREIGN KEY (userID) REFERENCES User (userID));

DESC TransactionCard;

#User History
CREATE TABLE UserHistory(
userHistoryID CHAR(8) NOT NULL,
userID CHAR(8) NOT NULL,
previousTransaction VARCHAR(30) NOT NULL,
amountPaid DECIMAL(5,2) NOT NULL,
date DATE NOT NULL,
time TIME NOT NULL,
PRIMARY KEY (userHistoryID),
FOREIGN KEY (userID) REFERENCES User (userID));

DESC UserHistory; 

#Driver History
CREATE TABLE DriverHistory(
driverHistoryID CHAR(8) NOT NULL,
driverID CHAR(8) NOT NULL,
previousOperation VARCHAR(30) NOT NULL,
amountReceived DECIMAL(5,2) NOT NULL,
date DATE NOT NULL,
time TIME NOT NULL,
PRIMARY KEY (driverHistoryID),
FOREIGN KEY (driverID) REFERENCES Driver (driverID));

DESC DriverHistory;

#Transaction

CREATE TABLE Transaction(
transactionID CHAR(8) NOT NULL,
paymentStatus VARCHAR(20) NOT NULL,
userID CHAR(8) NOT NULL,
driverID CHAR(8) NOT NULL,
serviceTypeID CHAR(8) NOT NULL,
shopID CHAR(8) NOT NULL,
promoCode CHAR(8) NOT NULL,
feedbackID CHAR(8) NOT NULL,
price DECIMAL(5,2) NOT NULL,
PRIMARY KEY (transactionID),
FOREIGN KEY (userID) REFERENCES User (userID),
FOREIGN KEY (driverID) REFERENCES Driver (driverID),
FOREIGN KEY (serviceTypeID) REFERENCES Service (serviceTypeID),
FOREIGN KEY (shopID) REFERENCES Shop (shopID),
FOREIGN KEY (promoCode) REFERENCES Promotion (promoCode),
FOREIGN KEY (feedbackID) REFERENCES Feedback (feedbackID));

DESC Transaction;

SHOW TABLES;
