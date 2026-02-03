-- =============================================================
--  CREATE TABLE STATEMENTS FOR LAKE RIDGE COMMUNITY HOSPITAL
--  DATABASE MANAGEMENT SYSTEM (LRCH DBMS)
-- =============================================================

CREATE DATABASE LakeRidgeCommunityHospitalDB;
GO
USE LakeRidgeCommunityHospitalDB;
GO


/* =============================================================
   HOSPITAL TABLE
   Stores basic information about each hospital location.
   ============================================================= */
DROP TABLE IF EXISTS Hospital;
CREATE TABLE Hospital (
  HospitalID INT IDENTITY(1,1) PRIMARY KEY,
  HospitalName VARCHAR(150) NOT NULL,
  HospitalAddress VARCHAR(255),
  HospitalTelephone VARCHAR(25)
);
-- DISPLAY
SELECT * FROM Hospital;


/* =============================================================
   ROOM TABLE
   Contains all room types used in the hospital.
   ============================================================= */
DROP TABLE IF EXISTS Room;
CREATE TABLE Room (
  RoomID INT IDENTITY(1,1) PRIMARY KEY,
  RoomType VARCHAR(50) NOT NULL
);
-- DISPLAY
SELECT * FROM Room;


/* =============================================================
   BED TABLE
   Holds details about beds found inside hospital rooms.
   ============================================================= */
DROP TABLE IF EXISTS Bed;
CREATE TABLE Bed (
  BedID INT IDENTITY(1,1) PRIMARY KEY,
  BedType VARCHAR(50),
  BedName VARCHAR(50)
);
-- DISPLAY
SELECT * FROM Bed;


/* =============================================================
   SPACE TABLE
   Links each hospital to its room and specific bed.
   Represents a physical space where patients can be placed.
   ============================================================= */
DROP TABLE IF EXISTS Space;
CREATE TABLE Space (
  SpaceID INT IDENTITY(1,1) PRIMARY KEY,
  HospitalID INT NOT NULL,
  RoomID INT NOT NULL,
  BedID INT NULL
);
-- DISPLAY
SELECT * FROM Space;

/* =============================================================
   DEPARTMENT TABLE
   Stores all departments within the hospital.
   ============================================================= */
DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
  DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
  DepartmentName VARCHAR(100) NOT NULL,
  DepartmentDesc VARCHAR(255)
);

-- DISPLAY
SELECT * FROM Department;


/* =============================================================
   STAFF TABLE
   Stores information about all hospital staff members.
   Includes optional link to a department.
   ============================================================= */
DROP TABLE IF EXISTS Staff;
CREATE TABLE Staff (
  StaffID INT IDENTITY(1,1) PRIMARY KEY,
  StaffName VARCHAR(150) NOT NULL,
  StaffAddress VARCHAR(255),
  StaffEmail VARCHAR(150),
  StaffNumber VARCHAR(25),
  Role VARCHAR(100),
  DepartmentID INT NULL
);

-- DISPLAY
SELECT * FROM Staff;


/* =============================================================
   COST CENTRE TABLE
   Tracks financial and operational cost centres.
   ============================================================= */
DROP TABLE IF EXISTS CostCentre;
CREATE TABLE CostCentre (
  CostCentreID INT IDENTITY(1,1) PRIMARY KEY,
  CostCentreName VARCHAR(150),
  Address VARCHAR(255),
  DepartmentID INT NULL
);
-- DISPLAY
SELECT * FROM CostCentre;


/* =============================================================
   PATIENT TABLE
   Stores demographic and contact information about patients.
   ============================================================= */
DROP TABLE IF EXISTS Patient;
CREATE TABLE Patient (
  PatientID INT IDENTITY(1,1) PRIMARY KEY,
  PatientName VARCHAR(150) NOT NULL,
  PatientAddress VARCHAR(255),
  Telephone VARCHAR(25),
  EmailAddress VARCHAR(150),
  Sex CHAR(1)
);

-- DISPLAY
SELECT * FROM Patient;

/* =============================================================
   PHYSICIAN TABLE
   Contains physician information and specialties.
   ============================================================= */
DROP TABLE IF EXISTS Physician;
CREATE TABLE Physician (
  PhysicianID INT IDENTITY(1,1) PRIMARY KEY,
  PhysicianName VARCHAR(150) NOT NULL,
  Specialty VARCHAR(100),
  Telephone VARCHAR(25),
  Email VARCHAR(150)
);

-- DISPLAY
SELECT * FROM Physician;


/* =============================================================
   ITEM TABLE
   Stores billable items such as tests, medications, and services.
   Includes links to cost centres and physical spaces.
   ============================================================= */
DROP TABLE IF EXISTS Item;
CREATE TABLE Item (
  ItemCode INT IDENTITY(1,1) PRIMARY KEY,
  CostCentreID INT NULL,
  SpaceID INT NULL,
  ItemName VARCHAR(150),
  ItemDesc VARCHAR(255),
  ItemType VARCHAR(50),
  ChargeAmount DECIMAL(10,2),
  ChargeType VARCHAR(50)
);

-- DISPLAY
SELECT * FROM Item;


/* =============================================================
   BOOKING TABLE
   Records patient admissions or usage of a space.
   Tracks start and end times for each booking.
   ============================================================= */
DROP TABLE IF EXISTS Booking;
CREATE TABLE Booking (
  BookingID INT IDENTITY(1,1) PRIMARY KEY,
  PatientID INT NOT NULL,
  SpaceID INT NOT NULL,
  CostCentreID INT NULL,
  StaffID INT NULL,
  BookingStart DATETIME,
  BookingEnd DATETIME
);

-- DISPLAY
SELECT * FROM Booking;


/* =============================================================
   REVENUE TABLE
   Stores financial charges generated from items and bookings.
   ============================================================= */
DROP TABLE IF EXISTS Revenue;
CREATE TABLE Revenue (
  RevenueID INT IDENTITY(1,1) PRIMARY KEY,
  PatientID INT NOT NULL,
  BookingID INT NULL,
  ItemCode INT NULL,
  BalanceDue DECIMAL(10,2) DEFAULT 0.00,
  FinancialSource VARCHAR(100),
  ChargeAmount DECIMAL(10,2) DEFAULT 0.00,
  RevenueDate DATETIME DEFAULT GETDATE(),
  PhysicianID INT NULL
);

-- DISPLAY
SELECT * FROM Revenue;


/* =============================================================
   INVOICE TABLE
   Generates invoices for patients with summary contact details.
   ============================================================= */
DROP TABLE IF EXISTS Invoice;
CREATE TABLE Invoice (
  InvoiceID INT IDENTITY(1,1) PRIMARY KEY,
  PatientID INT NOT NULL,
  DateIssued DATETIME NOT NULL DEFAULT GETDATE(),
  Telephone VARCHAR(25),
  EmailAddress VARCHAR(150)
);

-- DISPLAY
SELECT * FROM Invoice;


/* =============================================================
   INVOICE LINE TABLE
   Holds detailed billing lines linked to revenue entries.
   ============================================================= */
DROP TABLE IF EXISTS InvoiceLine;
CREATE TABLE InvoiceLine (
  LineID INT IDENTITY(1,1) PRIMARY KEY,
  InvoiceID INT NOT NULL,
  RevenueID INT NOT NULL,
  LineQty INT DEFAULT 1,
  LineAmount DECIMAL(10,2) NOT NULL
);

-- DISPLAY
SELECT * FROM InvoiceLine;


/* =============================================================
   HISTORY TABLE
   Logs all patient actions, treatments, staff involvement,
   item usage, and linked revenue. Acts as the audit trail.
   ============================================================= */
DROP TABLE IF EXISTS History;
CREATE TABLE History (
  HistoryID INT IDENTITY(1,1) PRIMARY KEY,
  PatientID INT NOT NULL,
  SpaceID INT NULL,
  CostCentreID INT NULL,
  StaffID INT NULL,
  ItemCode INT NULL,
  FinancialSource VARCHAR(100),
  PhysicianID INT NULL,
  RevenueID INT NULL,
  StartDate DATETIME,
  EndDate DATETIME,
  Notes VARCHAR(400)
);

-- DISPLAY
SELECT * FROM History;


/* =============================================================
   RESULT TABLE
   Stores outcomes or results linked to bookings.
   ============================================================= */
DROP TABLE IF EXISTS Result;
CREATE TABLE Result (
  ResultID INT IDENTITY(1,1) PRIMARY KEY,
  PatientID INT NOT NULL,
  BookingID INT NOT NULL,
  Status VARCHAR(150),
  Result VARCHAR(150)
);

-- DISPLAY
SELECT * FROM Result;



-- =============================================================
--  FOREIGN KEY CONSTRAINTS
--  (All constraints are written out fully and clearly explained)
-- =============================================================

/* SPACE foreign keys */
ALTER TABLE Space
  ADD CONSTRAINT FK_Space_Hospital FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID);

ALTER TABLE Space
  ADD CONSTRAINT FK_Space_Room FOREIGN KEY (RoomID) REFERENCES Room(RoomID);

ALTER TABLE Space
  ADD CONSTRAINT FK_Space_Bed FOREIGN KEY (BedID) REFERENCES Bed(BedID);


/* STAFF foreign key */
ALTER TABLE Staff
  ADD CONSTRAINT FK_Staff_Department FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);


/* COST CENTRE foreign key */
ALTER TABLE CostCentre
  ADD CONSTRAINT FK_CostCentre_Department FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);


/* ITEM foreign keys */
ALTER TABLE Item
  ADD CONSTRAINT FK_Item_CostCentre FOREIGN KEY (CostCentreID) REFERENCES CostCentre(CostCentreID);

ALTER TABLE Item
  ADD CONSTRAINT FK_Item_Space FOREIGN KEY (SpaceID) REFERENCES Space(SpaceID);


/* BOOKING foreign keys */
ALTER TABLE Booking
  ADD CONSTRAINT FK_Booking_Patient FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

ALTER TABLE Booking
  ADD CONSTRAINT FK_Booking_Space FOREIGN KEY (SpaceID) REFERENCES Space(SpaceID);

ALTER TABLE Booking
  ADD CONSTRAINT FK_Booking_CostCentre FOREIGN KEY (CostCentreID) REFERENCES CostCentre(CostCentreID);

ALTER TABLE Booking
  ADD CONSTRAINT FK_Booking_Staff FOREIGN KEY (StaffID) REFERENCES Staff(StaffID);


/* REVENUE foreign keys */
ALTER TABLE Revenue
  ADD CONSTRAINT FK_Revenue_Patient FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

ALTER TABLE Revenue
  ADD CONSTRAINT FK_Revenue_Booking FOREIGN KEY (BookingID) REFERENCES Booking(BookingID);

ALTER TABLE Revenue
  ADD CONSTRAINT FK_Revenue_Item FOREIGN KEY (ItemCode) REFERENCES Item(ItemCode);

ALTER TABLE Revenue
  ADD CONSTRAINT FK_Revenue_Physician FOREIGN KEY (PhysicianID) REFERENCES Physician(PhysicianID);


/* INVOICE foreign key */
ALTER TABLE Invoice
  ADD CONSTRAINT FK_Invoice_Patient FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);


/* INVOICE LINE foreign keys */
ALTER TABLE InvoiceLine
  ADD CONSTRAINT FK_InvoiceLine_Invoice FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID);

ALTER TABLE InvoiceLine
  ADD CONSTRAINT FK_InvoiceLine_Revenue FOREIGN KEY (RevenueID) REFERENCES Revenue(RevenueID);


/* HISTORY foreign keys */
ALTER TABLE History
  ADD CONSTRAINT FK_History_Patient FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

ALTER TABLE History
  ADD CONSTRAINT FK_History_Space FOREIGN KEY (SpaceID) REFERENCES Space(SpaceID);

ALTER TABLE History
  ADD CONSTRAINT FK_History_CostCentre FOREIGN KEY (CostCentreID) REFERENCES CostCentre(CostCentreID);

ALTER TABLE History
  ADD CONSTRAINT FK_History_Staff FOREIGN KEY (StaffID) REFERENCES Staff(StaffID);

ALTER TABLE History
  ADD CONSTRAINT FK_History_Item FOREIGN KEY (ItemCode) REFERENCES Item(ItemCode);

ALTER TABLE History
  ADD CONSTRAINT FK_History_Physician FOREIGN KEY (PhysicianID) REFERENCES Physician(PhysicianID);

ALTER TABLE History
  ADD CONSTRAINT FK_History_Revenue FOREIGN KEY (RevenueID) REFERENCES Revenue(RevenueID);


/* RESULT foreign keys */
ALTER TABLE Result
ADD CONSTRAINT FK_Result_Patient FOREIGN KEY (PatientID) REFERENCES Patient(PatientID);

ALTER TABLE Result 
ADD CONSTRAINT FK_Result_Booking FOREIGN KEY (BookingID) REFERENCES Booking(BookingID);

