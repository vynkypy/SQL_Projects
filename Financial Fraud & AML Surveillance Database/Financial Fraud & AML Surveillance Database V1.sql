-- Create the database
CREATE DATABASE AMLSurveillanceDB;
USE AMLSurveillanceDB;

-- 1. Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Country VARCHAR(50),
    RiskScore INT, -- 1 (low) to 10 (high risk)
    IsBlacklisted BIT
);

-- 2. Accounts
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountType VARCHAR(20),
    OpenDate DATE,
    Status VARCHAR(20), -- Active, Suspended, Closed
    Balance DECIMAL(12,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 3. Transactions
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    FromAccountID INT,
    ToAccountID INT,
    TransactionDate DATE,
    Amount DECIMAL(12,2),
    Currency VARCHAR(10),
    TransactionType VARCHAR(20), -- Transfer, Withdrawal, Deposit
    IsInternational BIT,
    FOREIGN KEY (FromAccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (ToAccountID) REFERENCES Accounts(AccountID)
);

-- 4. Alerts
CREATE TABLE Alerts (
    AlertID INT PRIMARY KEY,
    TransactionID INT,
    AlertType VARCHAR(50), -- High Value, Velocity, Cross-border, Structuring
    AlertDate DATE,
    IsReviewed BIT,
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID)
);

-- 5. Sanctions List
CREATE TABLE SanctionsList (
    EntityName VARCHAR(100),
    Country VARCHAR(50),
    ListingDate DATE
);

-- Sample Inserts
INSERT INTO Customers VALUES
(1, 'Alice Zhang', 'USA', 2, 0),
(2, 'Ivan Petrov', 'Russia', 9, 1),
(3, 'Carlos Mendez', 'Mexico', 6, 0),
(4, 'Li Wei', 'China', 8, 0),
(5, 'Ahmed Khan', 'Pakistan', 7, 0);

INSERT INTO Accounts VALUES
(1001, 1, 'Savings', '2022-01-10', 'Active', 150000.00),
(1002, 2, 'Business', '2021-06-15', 'Active', 300000.00),
(1003, 3, 'Savings', '2020-03-20', 'Active', 120000.00),
(1004, 4, 'Checking', '2023-01-12', 'Suspended', 70000.00),
(1005, 5, 'Savings', '2019-11-30', 'Active', 50000.00);

INSERT INTO Transactions VALUES
(20001, 1001, 1002, '2024-12-01', 100000.00, 'USD', 'Transfer', 1),
(20002, 1002, 1003, '2024-12-02', 99000.00, 'USD', 'Transfer', 0),
(20003, 1003, 1005, '2024-12-03', 98000.00, 'USD', 'Transfer', 0),
(20004, 1005, 1004, '2024-12-04', 97000.00, 'USD', 'Transfer', 1),
(20005, 1001, 1003, '2025-01-01', 10000.00, 'USD', 'Deposit', 0);

INSERT INTO Alerts VALUES
(1, 20001, 'High Value', '2024-12-01', 0),
(2, 20002, 'Structuring', '2024-12-02', 1),
(3, 20003, 'Velocity', '2024-12-03', 0);

INSERT INTO SanctionsList VALUES
('Ivan Petrov', 'Russia', '2023-05-01'),
('GlobalTech Holdings', 'Iran', '2023-08-20');
