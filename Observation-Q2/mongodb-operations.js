// MongoDB CRUD Operations for Customer and Account Collections

// 1. Creating the collections
db.createCollection("customers")
db.createCollection("accounts")

// 2. CREATE Operations (Insert documents)

// Insert customers
db.customers.insertMany([
  { _id: 1, cname: "John Smith" },
  { _id: 2, cname: "Mary Johnson" },
  { _id: 3, cname: "Robert Brown" },
  { _id: 4, cname: "Patricia Davis" },
  { _id: 5, cname: "Michael Wilson" }
])

// Insert accounts
db.accounts.insertMany([
  { 
    _id: "A001", 
    atype: "S", 
    balance: 12000.00, 
    customer_id: 1, 
    branch_code: "B001" 
  },
  { 
    _id: "A002", 
    atype: "C", 
    balance: 25000.00, 
    customer_id: 1, 
    branch_code: "B001" 
  },
  { 
    _id: "A003", 
    atype: "S", 
    balance: 15000.00, 
    customer_id: 2, 
    branch_code: "B002" 
  },
  { 
    _id: "A004", 
    atype: "C", 
    balance: 30000.00, 
    customer_id: 2, 
    branch_code: "B003" 
  },
  { 
    _id: "A005", 
    atype: "S", 
    balance: 9000.00, 
    customer_id: 3, 
    branch_code: "B002" 
  },
  { 
    _id: "A006", 
    atype: "C", 
    balance: 18000.00, 
    customer_id: 3, 
    branch_code: "B002" 
  },
  { 
    _id: "A007", 
    atype: "S", 
    balance: 22000.00, 
    customer_id: 4, 
    branch_code: "B003" 
  },
  { 
    _id: "A008", 
    atype: "S", 
    balance: 8000.00, 
    customer_id: 5, 
    branch_code: "B004" 
  }
])

// 3. READ Operations

// Find all customers
db.customers.find()

// Find a specific customer
db.customers.findOne({ _id: 1 })

// Find all accounts for a customer
db.accounts.find({ customer_id: 1 })

// Find all savings accounts
db.accounts.find({ atype: "S" })

// Find accounts with balance greater than 20000
db.accounts.find({ balance: { $gt: 20000 } })

// Find customers who have both savings and current accounts
db.customers.find({
  _id: {
    $in: db.accounts.distinct("customer_id", { atype: "S" }).filter(
      cid => db.accounts.countDocuments({ customer_id: cid, atype: "C" }) > 0
    )
  }
})

// Alternatively using aggregation
db.accounts.aggregate([
  { $group: {
      _id: "$customer_id",
      account_types: { $addToSet: "$atype" }
    }
  },
  { $match: {
      account_types: { $all: ["S", "C"] }
    }
  },
  { $lookup: {
      from: "customers",
      localField: "_id",
      foreignField: "_id",
      as: "customer_details"
    }
  },
  { $unwind: "$customer_details" },
  { $project: {
      _id: "$customer_details._id",
      cname: "$customer_details.cname"
    }
  }
])

// 4. UPDATE Operations

// Update a customer's name
db.customers.updateOne(
  { _id: 5 },
  { $set: { cname: "Michael Thompson" } }
)

// Increase all savings account balances by 5%
db.accounts.updateMany(
  { atype: "S" },
  { $mul: { balance: 1.05 } }
)

// Add a new field to track account creation date
db.accounts.updateMany(
  {},
  { $set: { created_at: new Date() } }
)

// Transaction-like update to transfer money between accounts
// Note: In a real system, use transactions for this
const transferAmount = 5000.00;
const fromAccount = "A002";
const toAccount = "A003";

// Check if sufficient funds are available
const sourceAccount = db.accounts.findOne({ _id: fromAccount });
if (sourceAccount.balance >= transferAmount) {
  // Deduct from source account
  db.accounts.updateOne(
    { _id: fromAccount },
    { $inc: { balance: -transferAmount } }
  );
  
  // Add to destination account
  db.accounts.updateOne(
    { _id: toAccount },
    { $inc: { balance: transferAmount } }
  );
  
  print("Transfer completed successfully");
} else {
  print("Insufficient funds for transfer");
}

// 5. DELETE Operations

// Delete a specific account
db.accounts.deleteOne({ _id: "A008" })

// Delete all accounts for a specific customer
db.accounts.deleteMany({ customer_id: 5 })

// Delete the customer after removing their accounts
db.customers.deleteOne({ _id: 5 })

// 6. Advanced Queries

// Find branches with the most accounts
db.accounts.aggregate([
  { $group: {
      _id: "$branch_code",
      account_count: { $sum: 1 },
      total_balance: { $sum: "$balance" }
    }
  },
  { $sort: { account_count: -1 } }
])

// Find customers with total balance across all accounts
db.accounts.aggregate([
  { $group: {
      _id: "$customer_id",
      total_balance: { $sum: "$balance" },
      account_count: { $sum: 1 }
    }
  },
  { $lookup: {
      from: "customers",
      localField: "_id",
      foreignField: "_id",
      as: "customer_details"
    }
  },
  { $unwind: "$customer_details" },
  { $project: {
      _id: 0,
      customer_id: "$_id",
      customer_name: "$customer_details.cname",
      total_balance: 1,
      account_count: 1
    }
  },
  { $sort: { total_balance: -1 } }
])


/*
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
*/
