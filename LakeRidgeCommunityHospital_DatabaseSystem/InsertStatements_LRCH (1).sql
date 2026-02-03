-- Insert Statements to populate designated tables in the database

USE LakeRidgeCommunityHospitalDB
GO
-- HOSPITALS
INSERT INTO Hospital (HospitalName, HospitalAddress, HospitalTelephone) VALUES
('Lake Ridge Community Hospital', '100 Main St, Oshawa, ON', '905-111-0001'),
('Central Health Clinic', '200 King St, Oshawa, ON', '905-222-0002'),
('Northside Medical', '350 College Ave, Oshawa, ON', '905-333-0003');

-- ROOMS
INSERT INTO Room (RoomType) VALUES
('Private'), ('SemiPrivate'), ('ICU'), ('Ward3'), ('Ward4');

-- BEDS
INSERT INTO Bed (BedType, BedName) VALUES
('Single','Bed-A'),('Single','Bed-B'),('Double','Bed-C'),('Double','Bed-D'),('Ward','Bed-E'),('Ward','Bed-F');

-- SPACES (link hospital + room + bed)
INSERT INTO Space (HospitalID, RoomID, BedID) VALUES
(1,1,1),(1,1,2),(1,2,3),(1,2,4),(1,3,5),(2,1,6),(2,4,NULL),(3,5,NULL);

-- DEPARTMENTS
INSERT INTO Department (DepartmentName, DepartmentDesc) VALUES
('Nursing','Inpatient nursing services'),
('Radiology','Imaging and X-ray services'),
('Laboratory','Lab tests and analysis'),
('Finance','Billing and accounts'),
('Emergency','Emergency department');

-- STAFF
INSERT INTO Staff (StaffName, StaffAddress, StaffEmail, StaffNumber, Role, DepartmentID) VALUES
('Alice Morgan','12 Oak St','alice.m@lrch.ca','S1001','Nurse',1),
('Bob Turner','45 Pine St','bob.t@lrch.ca','S1002','Technician',2),
('Carol Reeves','78 Maple St','carol.r@lrch.ca','S1003','Lab Tech',3),
('Dan Wells','11 Birch St','dan.w@lrch.ca','S1004','Accountant',4),
('Eve Scott','5 Elm St','eve.s@lrch.ca','S1005','Reception',1),
('Frank Diaz','21 Cedar St','frank.d@lrch.ca','S1006','Nurse',1),
('Gina Park','99 Spruce St','gina.p@lrch.ca','S1007','Radiologist',2),
('Hugo Bell','7 Aspen St','hugo.b@lrch.ca','S1008','ER Nurse',5),
('Ivy Nash','3 Willow St','ivy.n@lrch.ca','S1009','Clerk',4),
('Jake Long','18 Poplar St','jake.l@lrch.ca','S1010','Maintenance',NULL);

-- COST CENTRES
INSERT INTO CostCentre (CostCentreName, Address, DepartmentID) VALUES
('Room & Board','100 Main St',4),
('Laboratory','100 Main St',3),
('Radiology','100 Main St',2),
('Pharmacy','100 Main St',3);

-- PATIENTS
INSERT INTO Patient (PatientName, PatientAddress, Telephone, EmailAddress, Sex) VALUES
('Mary Baker','300 Oak St','905-555-0101','mary.b@example.com','F'),
('John Killy','45 Queen St','905-555-0102','john.k@example.com','M'),
('Peter Gonzalez','12 King St','905-555-0103','peter.g@example.com','M'),
('Marie Thomas','90 Lake St','905-555-0104','marie.t@example.com','F'),
('Lena Wu','22 Birch St','905-555-0105','lena.w@example.com','F'),
('Ola Ade','15 Elm St','905-555-0106','ola.a@example.com','M'),
('Sam Peters','47 Pine St','905-555-0107','sam.p@example.com','M'),
('Nora Fields','2 River Rd','905-555-0108','nora.f@example.com','F');

-- PHYSICIANS
INSERT INTO Physician (PhysicianName, Specialty, Telephone, Email) VALUES
('Dr. Browne','General','905-800-1001','browne@lrch.ca'),
('Dr. Dunn','Pediatrics','905-800-1002','dunn@lrch.ca'),
('Dr. Thayer','Cardiology','905-800-1003','thayer@lrch.ca'),
('Dr. Smith','Radiology','905-800-1004','smith@lrch.ca'),
('Dr. Lee','Emergency','905-800-1005','lee@lrch.ca');

-- ITEMS
INSERT INTO Item (CostCentreID, SpaceID, ItemName, ItemDesc, ItemType, ChargeAmount, ChargeType) VALUES
(1,1,'Semi-Private Room','Room charge per day','Accommodation',200.00,'Fixed'),
(1,2,'Private Room','Room charge per day','Accommodation',250.00,'Fixed'),
(2,3,'Glucose Test','Blood glucose analysis','Lab',25.00,'PerItem'),
(2,3,'Culture Test','Lab culture','Lab',20.00,'PerItem'),
(3,4,'Chest X-Ray','Radiology chest x-ray','Imaging',30.00,'PerItem'),
(4,1,'Medication A','Antibiotic dose','Pharmacy',15.00,'PerItem'),
(4,2,'Medication B','Painkiller dose','Pharmacy',10.00,'PerItem'),
(3,4,'CT Scan','CT Head','Imaging',300.00,'PerItem'),
(2,5,'CBC','Complete blood count','Lab',40.00,'PerItem'),
(1,6,'TV Rental','Television rental','Service',5.00,'Fixed');

-- BOOKINGS
INSERT INTO Booking (PatientID, SpaceID, CostCentreID, StaffID, BookingStart, BookingEnd) VALUES
(1,1,1,1,'2025-11-20 10:00','2025-11-23 10:00'),
(2,2,1,6,'2025-11-22 09:00','2025-11-25 12:00'),
(3,3,2,3,'2025-11-24 08:00','2025-11-26 12:00'),
(4,4,3,2,'2025-11-23 14:00','2025-11-24 09:00'),
(5,5,2,3,'2025-11-21 11:00','2025-11-22 15:00'),
(6,1,1,1,'2025-11-25 16:00',NULL),
(7,2,1,6,'2025-11-26 07:30',NULL),
(8,3,2,3,'2025-11-26 09:00',NULL),
(1,4,3,2,'2025-10-01 09:00','2025-10-04 10:00'),
(2,5,2,3,'2025-08-10 08:00','2025-08-12 12:00');

-- REVENUE (charges)
INSERT INTO Revenue (PatientID, BookingID, ItemCode, BalanceDue, FinancialSource, ChargeAmount, RevenueDate, PhysicianID) VALUES
(1,1,1,200.00,'Assure',200.00,'2025-11-21',1),
(1,1,10,5.00,'Assure',5.00,'2025-11-21',1),
(2,2,2,250.00,'ESI',250.00,'2025-11-22',2),
(3,3,3,25.00,'SelfPay',25.00,'2025-11-24',3),
(3,3,5,30.00,'SelfPay',30.00,'2025-11-24',3),
(4,4,8,300.00,'Assure',300.00,'2025-11-23',4),
(5,5,9,40.00,'None',40.00,'2025-11-21',2),
(6,6,1,200.00,'Assure',200.00,'2025-11-25',1),
(7,7,2,250.00,'ESI',250.00,'2025-11-26',2),
(8,8,3,25.00,'SelfPay',25.00,'2025-11-26',3),
(1,9,5,30.00,'Assure',30.00,'2025-10-02',1),
(2,10,3,25.00,'ESI',25.00,'2025-08-11',2),
(1,1,4,20.00,'Assure',20.00,'2025-11-21',1),
(4,4,6,15.00,'Assure',15.00,'2025-11-23',4),
(5,5,7,10.00,'None',10.00,'2025-11-21',3),
(6,6,10,5.00,'Assure',5.00,'2025-11-25',1),
(7,7,9,40.00,'ESI',40.00,'2025-11-26',2),
(8,8,8,300.00,'SelfPay',300.00,'2025-11-26',3),
(3,3,1,200.00,'SelfPay',200.00,'2025-11-24',3),
(2,2,10,5.00,'ESI',5.00,'2025-11-22',2);

-- INVOICES
INSERT INTO Invoice (PatientID, DateIssued, Telephone, EmailAddress) VALUES
(1,'2025-11-22','905-555-0101','mary.b@example.com'),
(2,'2025-11-23','905-555-0102','john.k@example.com'),
(3,'2025-11-24','905-555-0103','peter.g@example.com'),
(4,'2025-11-25','905-555-0104','marie.t@example.com'),
(5,'2025-11-21','905-555-0105','lena.w@example.com');

-- INVOICE LINES (link revenue to invoice)
INSERT INTO InvoiceLine (InvoiceID, RevenueID, LineQty, LineAmount) VALUES
(1,1,1,200.00),(1,2,1,5.00),(1,13,1,20.00),
(2,3,1,250.00),(2,20,1,5.00),
(3,4,1,25.00),(3,5,1,30.00),
(4,6,1,300.00),(4,14,1,15.00),
(5,7,1,40.00);

-- HISTORY (action / billing / location log)
INSERT INTO History (PatientID, SpaceID, CostCentreID, StaffID, ItemCode, FinancialSource, PhysicianID, RevenueID, StartDate, EndDate, Notes) VALUES
(1,1,1,1,1,'Assure',1,1,'2025-11-20 10:00','2025-11-23 10:00','Admitted to 100L, room charge applied'),
(1,1,1,1,10,'Assure',1,2,'2025-11-21 12:00','2025-11-21 12:10','TV rental'),
(2,2,1,6,2,'ESI',2,3,'2025-11-22 09:00','2025-11-25 12:00','Admitted to 101L'),
(3,3,2,3,3,'SelfPay',3,4,'2025-11-24 08:00','2025-11-26 12:00','Glucose test performed'),
(3,3,2,3,5,'SelfPay',3,5,'2025-11-24 09:00','2025-11-24 09:30','Chest X-Ray'),
(4,4,3,2,8,'Assure',4,6,'2025-11-23 14:00','2025-11-24 09:00','CT scan ordered'),
(5,5,2,3,9,'None',2,7,'2025-11-21 11:00','2025-11-22 15:00','CBC done'),
(6,1,1,1,1,'Assure',1,8,'2025-11-25 16:00',NULL,'Admitted'),
(7,2,1,6,2,'ESI',2,9,'2025-11-26 07:30',NULL,'Admitted'),
(8,3,2,3,3,'SelfPay',3,10,'2025-11-26 09:00',NULL,'Admitted'),
(1,4,3,2,5,'Assure',1,11,'2025-10-01 09:00','2025-10-04 10:00','Prior admission'),
(2,5,2,3,3,'ESI',2,12,'2025-08-10 08:00','2025-08-12 12:00','Prior tests'),
(3,3,2,3,1,'SelfPay',3,19,'2025-11-24 10:00','2025-11-24 10:15','Room charge logged'),
(4,4,3,2,6,'Assure',4,14,'2025-11-23 15:00','2025-11-23 15:10','Medication dispensed'),
(5,5,2,3,7,'None',3,15,'2025-11-21 12:30','2025-11-21 12:45','Medication dispensed');


/*
-- RESULT (status / booking/ result)
INSERT INTO Result (PatientID, BookingID, Status, Result) VALUES
    (1, 1, 'Completed', 'Negative'),
    (2, 2, 'Completed', 'Positive'),
    (3, 3, 'Pending',   'Awaiting Lab'),
    (4, 4, 'Completed', 'Inconclusive'),
    (5, 5, 'Cancelled', 'No Sample');
*/
