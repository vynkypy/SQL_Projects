# 🛡️ AML Surveillance SQL Project

This project simulates an Anti-Money Laundering (AML) surveillance system using a relational SQL database. It includes realistic data structures for customers, accounts, transactions, alerts, and sanctions, allowing for analysis of suspicious financial activities.

---

## 📂 Dataset Overview

### Tables

| Table Name        | Description                                                         |
|-------------------|---------------------------------------------------------------------|
| `Customers`       | Master data of clients including risk scoring and blacklist status |
| `Accounts`        | Linked financial accounts with current balance and status          |
| `Transactions`    | Financial transfers between accounts with international flags      |
| `Alerts`          | Generated alerts based on transaction red flags                    |
| `SanctionsList`   | External list of flagged individuals or entities                   |

---

## 🏗️ Schema Details

### Customers
- `CustomerID` (PK)
- `Name`
- `Country`
- `RiskScore` (1–10 scale)
- `IsBlacklisted` (bit)

### Accounts
- `AccountID` (PK)
- `CustomerID` (FK)
- `AccountType` (e.g., Savings, Checking)
- `OpenDate`
- `Status` (Active, Suspended, Closed)
- `Balance`

### Transactions
- `TransactionID` (PK)
- `FromAccountID` (FK)
- `ToAccountID` (FK)
- `TransactionDate`
- `Amount`
- `Currency`
- `TransactionType` (Transfer, Deposit, etc.)
- `IsInternational` (bit)

### Alerts
- `AlertID` (PK)
- `TransactionID` (FK)
- `AlertType` (e.g., High Value, Structuring)
- `AlertDate`
- `IsReviewed`

### SanctionsList
- `EntityName`
- `Country`
- `ListingDate`

---

## 📊 Views

### `CrossBorderTransactions`
Shows all transactions that occurred between accounts in different countries or explicitly marked as international.

### `AccountTransactionSummary`
Calculates net flow (incoming/outgoing) per account and estimates a derived balance based on transactions.

---

## 📌 Example Queries

- List high-risk customers with active accounts
- Identify cross-border transactions over $50,000
- Detect circular transaction patterns
- Show alerts not yet reviewed
- Rank customers by total suspicious funds moved

---

## 🧠 Use Cases

- AML Compliance Auditing
- Fraud Pattern Detection
- Risk-based Customer Profiling
- Alert Investigation Pipelines
- Sanctions Matching & Screening

---

## ✅ Getting Started

### 1. Create Database & Tables
Run the `Script 1` SQL file to set up schema and insert initial data.

### 2. Create Views
Run `Script 2` to generate analysis-ready views.

---

## 🤝 Contributions

This dataset can be extended with:
- Currency exchange tracking
- Geo-location data
- Enhanced fuzzy matching on sanctions

Feel free to fork and expand the dataset!

---

