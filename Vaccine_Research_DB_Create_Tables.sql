create database vaccine_research_db;

use vaccine_research_db;

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    EnrollmentDate DATE
);

CREATE TABLE Visits (
    VisitID INT PRIMARY KEY,
    PatientID INT,
    VisitDate DATE,
    VisitType VARCHAR(50),  -- e.g. Screening, Dose 1, Dose 2, Follow-up
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE LabResults (
    ResultID INT PRIMARY KEY,
    VisitID INT,
    TestName VARCHAR(100),
    ResultValue DECIMAL(10,2),
    Units VARCHAR(20),
    FOREIGN KEY (VisitID) REFERENCES Visits(VisitID)
);


INSERT INTO Patients VALUES
(1, 'Alice Smith', 34, 'Female', '2023-01-05'),
(2, 'Bob Johnson', 45, 'Male', '2023-01-10'),
(3, 'Charlie Lee', 29, 'Male', '2023-01-15'),
(4, 'Diana King', 52, 'Female', '2023-02-01'),
(5, 'Ethan Wright', 37, 'Male', '2023-02-10'),
(6, 'Fiona Davis', 28, 'Female', '2023-02-18'),
(7, 'George Hill', 60, 'Male', '2023-03-01'),
(8, 'Hannah Young', 41, 'Female', '2023-03-12'),
(9, 'Ivan Scott', 33, 'Male', '2023-03-15'),
(10, 'Jane Baker', 50, 'Female', '2023-03-20');


INSERT INTO Visits VALUES
(101, 1, '2023-01-05', 'Screening'),
(102, 1, '2023-01-12', 'Dose 1'),
(103, 1, '2023-01-26', 'Follow-up'),
(104, 2, '2023-01-10', 'Screening'),
(105, 2, '2023-01-18', 'Dose 1'),
(106, 3, '2023-01-15', 'Screening'),
(107, 3, '2023-01-22', 'Dose 1'),
(108, 3, '2023-02-05', 'Follow-up'),
(109, 4, '2023-02-01', 'Screening'),
(110, 4, '2023-02-15', 'Dose 1');


INSERT INTO LabResults VALUES
(201, 101, 'Antibody Level', 5.2, 'AU/mL'),
(202, 102, 'Antibody Level', 28.5, 'AU/mL'),
(203, 103, 'Antibody Level', 35.6, 'AU/mL'),
(204, 104, 'Antibody Level', 6.1, 'AU/mL'),
(205, 105, 'Antibody Level', 30.2, 'AU/mL'),
(206, 106, 'Antibody Level', 4.9, 'AU/mL'),
(207, 107, 'Antibody Level', 27.0, 'AU/mL'),
(208, 108, 'Antibody Level', 36.1, 'AU/mL'),
(209, 109, 'Antibody Level', 5.7, 'AU/mL'),
(210, 110, 'Antibody Level', 29.8, 'AU/mL');


