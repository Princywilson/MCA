-- Query 1 Result: Customers who have both savings and current accounts
-- ----------------------------------------------------------------
| CID | CNAME         |
|-----|---------------|
| 1   | John Smith    |
| 2   | Mary Johnson  |
| 3   | Robert Brown  |
-- ----------------------------------------------------------------

-- Query 2 Result: Branches and the number of accounts in each branch
-- ----------------------------------------------------------------
| BCODE | BNAME              | ACCOUNT_COUNT |
|-------|--------------------| --------------|
| B002  | Downtown Branch    | 3             |
| B001  | Main Street Branch | 2             |
| B003  | North Hills Branch | 2             |
| B004  | University Branch  | 1             |
-- ----------------------------------------------------------------

-- Query 3 Result: Branches with account count less than average
-- ----------------------------------------------------------------
| BCODE | BNAME              | ACCOUNT_COUNT |
|-------|--------------------| --------------|
| B004  | University Branch  | 1             |
-- ----------------------------------------------------------------
-- (Average accounts per branch is 2, only B004 has less than average)

-- Query 4 Result: Customers who performed three transactions on a day
-- ----------------------------------------------------------------
| CID | CNAME      | TDATE       | TRANSACTION_COUNT |
|-----|------------|-------------| ----------------- |
| 1   | John Smith | 2023-01-18  | 3                 |
-- ----------------------------------------------------------------

-- View Result: BRANCH_ACCOUNT_SUMMARY
-- ----------------------------------------------------------------
| BCODE | BNAME              | ACCOUNT_COUNT | TOTAL_BALANCE |
|-------|--------------------| --------------|---------------|
| B001  | Main Street Branch | 2             | 37000.00      |
| B002  | Downtown Branch    | 3             | 42000.00      |
| B003  | North Hills Branch | 2             | 52000.00      |
| B004  | University Branch  | 1             | 8000.00       |
-- ----------------------------------------------------------------

-- MongoDB Query Results
-- ----------------------------------------------------------------
// Find customers with both account types
{
  "_id": 1,
  "cname": "John Smith"
},
{
  "_id": 2,
  "cname": "Mary Johnson"
},
{
  "_id": 3,
  "cname": "Robert Brown"
}

// Find branches with the most accounts
{
  "_id": "B002",
  "account_count": 3,
  "total_balance": 42000.00
},
{
  "_id": "B001",
  "account_count": 2,
  "total_balance": 37000.00
},
{
  "_id": "B003",
  "account_count": 2,
  "total_balance": 52000.00
},
{
  "_id": "B004",
  "account_count": 1,
  "total_balance": 8000.00
}

// Customer balance summary
{
  "customer_id": 2,
  "customer_name": "Mary Johnson",
  "total_balance": 45000.00,
  "account_count": 2
},
{
  "customer_id": 1,
  "customer_name": "John Smith",
  "total_balance": 37000.00,
  "account_count": 2
},
{
  "customer_id": 4,
  "customer_name": "Patricia Davis",
  "total_balance": 22000.00,
  "account_count": 1
},
{
  "customer_id": 3,
  "customer_name": "Robert Brown",
  "total_balance": 27000.00,
  "account_count": 2
},
{
  "customer_id": 5,
  "customer_name": "Michael Wilson",
  "total_balance": 8000.00,
  "account_count": 1
}
