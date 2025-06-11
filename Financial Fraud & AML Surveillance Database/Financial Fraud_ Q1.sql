-- Are any transactions linked to blacklisted customers or sanctioned entities?

select c.Name, c.Country, a.AccountType, a.Status,a.Balance, t.Amount as Transaction_Amount, t.Currency from Accounts A join Customers c 
on a.CustomerID = c.CustomerID
join Transactions t on t.FromAccountID = a.AccountID
where c.IsBlacklisted = 1

