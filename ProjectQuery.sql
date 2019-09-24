CREATE TABLE [ad189641].[Patient] (
    [PatId]   INT NOT NULL IDENTITY(101, 1),
    [PatName] VARCHAR (30)  NULL,
    [Age]     INT         NULL,
    [Weight]  INT          NULL,
    [Gender] VARCHAR (120) NULL,
	[Address] VARCHAR (120) NULL,
	[PhoneNumber] Decimal  NULL,
	[Disease] VARCHAR (120) NULL,
    PRIMARY KEY CLUSTERED ([PatId] ASC),
	DoctorID int FOREIGN KEY REFERENCES ad189641.Doctor(DoctorID)
);

CREATE TABLE [ad189641].[Doctor] (
DoctorID int NOT NULL IDENTITY(101, 1),
DoctorName varchar,
Dept varchar,
 PRIMARY KEY CLUSTERED ([DoctorId] ASC)
 );

CREATE TABLE [ad189641].[Lab] (
LabID int NOT NULL IDENTITY(101, 1),
TestDate date,
TestType varchar,
PatientType Varchar,
 PRIMARY KEY CLUSTERED ([LabId] ASC),
PatID int FOREIGN KEY REFERENCES ad189641.Patient(PatID),
DoctorID int FOREIGN KEY REFERENCES ad189641.Doctor(DoctorID)

 );

 alter table ad189641.Lab drop column DoctorName
 select * from ad189641.Lab
 drop table ad189641.RoomData

 create table ad189641.RoomData(
 RoomNo int Not Null IDENTITY(101, 1),
 TreatmentDate date,
 DoctorID int FOREIGN KEY REFERENCES ad189641.Doctor(DoctorID),
 LabID int FOREIGN KEY REFERENCES ad189641.Lab(LabID)
     PRIMARY KEY CLUSTERED ([RoomNo] ASC),
 );

  create table ad189641.Outpatient(
  PatID int FOREIGN KEY REFERENCES ad189641.Patient(PatID),
 TreatmentDate date,
 DoctorID int FOREIGN KEY REFERENCES ad189641.Doctor(DoctorID),
 LabID int FOREIGN KEY REFERENCES ad189641.Lab(LabID)
     PRIMARY KEY CLUSTERED ([PatId] ASC),
 );

 create table ad189641.Inpatient(
  PatID int FOREIGN KEY REFERENCES ad189641.Patient(PatID),
  RoomNo int FOREIGN KEY REFERENCES ad189641.RoomData(RoomNo),
  DoctorID int FOREIGN KEY REFERENCES ad189641.Doctor(DoctorID),
 LabID int FOREIGN KEY REFERENCES ad189641.Lab(LabID),
 AdmissionDate date,
 DischargeDate date,
 AmountPerDay decimal
 );

 create table ad189641.BillData(
	BillNo int NOT NULL IDENTITY(101, 1),
	PatID int FOREIGN KEY REFERENCES ad189641.Patient(PatID),
	PatientType varchar,
    DoctorID int FOREIGN KEY REFERENCES ad189641.Doctor(DoctorID),
	DoctorFees bigint,
	RoomCharge	bigint,
	OperationCharges bigint,
	MedicineFees	bigint,
	TotalDays bigint,
	LabFees bigint,
	Amount bigint,
	 PRIMARY KEY CLUSTERED ([BillNo] ASC),
	);


