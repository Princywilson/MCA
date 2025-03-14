// Assuming you have a MongoDB connection established and databases named 'customerDB'

// --- CREATE Operations ---
db.createCollection("customer");
db.createCollection("account");

// Insert a new customer into the CUSTOMER collection
db.customer.insertMany(
   {
  CID: 1,
  CNAME: "John Smith"
},
 {
  CID: 2,
  CNAME: "Mary Johnson"
},
{
  CID: 3,
  CNAME: "David Lee"
}
);

// Output/Result:
// { "acknowledged" : true, "insertedId" : ObjectId("...") }

// Insert a new account into the ACCOUNT collection
db.account.insertMany(
  {
  ANO: "A001",
  ATYPE: "C",
  BALANCE: 20000,
  CID: 1,
  BCODE: "B001"
},
 {
  ANO: "A002",
  ATYPE: "S",
  BALANCE: 50000,
  CID: 2,
  BCODE: "B002"
},
  {
  ANO: "A003",
  ATYPE: "C",
  BALANCE: 10000,
  CID: 3,
  BCODE: "B003"
}
);

// Output/Result:
// { "acknowledged" : true, "insertedId" : ObjectId("...") }


// --- READ Operations ---

// Find all customers
db.customer.find({});

// Output/Result:
// [
//   { "_id": ObjectId("..."), "CID": 1, "CNAME": "John Smith" },
//   { "_id": ObjectId("..."), "CID": 2, "CNAME": "Mary Johnson" },
//   { "_id": ObjectId("..."), "CID": 3, "CNAME": "David Lee" }
// ]

// Find accounts for a specific customer (CID: 2)
db.account.find({ CID: 2 });

// Output/Result:
// [
//   { "_id": ObjectId("..."), "ANO": "A002", "ATYPE": "S", "BALANCE": 5000, "CID": 2, "BCODE": "B002" },
// ]

// Find a customer by CID
db.customer.findOne({ CID: 3 });

// Output/Result:
// { "_id": ObjectId("..."), "CID": 3, "CNAME": "David Lee" }


// --- UPDATE Operations ---

// Update a customer's name (CID: 4)
db.customer.updateOne(
  { CID: 3 },
  { $set: { CNAME: "Patricia Williams" } }
);

// Output/Result:
// { "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1 }

db.Employee.updateMany(
  { DEPT_NO: "D003" },
  { $mul: { BASIC: 1.1 } }
)

// Output:
// {
//   "acknowledged": true,
//   "matchedCount": 1,
//   "modifiedCount": 1
// }


// --- DELETE Operations ---

// Delete a customer (CID: 5)
db.customer.deleteOne({ CID: 3 });

// Output/Result:
// { "acknowledged" : true, "deletedCount" : 1 }

db.customer.deleteMany({ 
  BASIC: { $lt: 60000 }
})

// Output/Result:
// { "acknowledged" : true, "deletedCount" : 1 }
