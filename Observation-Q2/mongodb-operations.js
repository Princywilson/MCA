// Assuming you have a MongoDB connection established and databases named 'customerDB'

// --- CREATE Operations ---

// Insert a new customer into the CUSTOMER collection
db.customer.insertOne({
  CID: 6,
  CNAME: "David Lee"
});

// Output/Result:
// { "acknowledged" : true, "insertedId" : ObjectId("...") }

// Insert a new account into the ACCOUNT collection
db.account.insertOne({
  ANO: "A009",
  ATYPE: "C",
  BALANCE: 10000,
  CID: 6,
  BCODE: "B005"
});

// Output/Result:
// { "acknowledged" : true, "insertedId" : ObjectId("...") }


// --- READ Operations ---

// Find all customers
db.customer.find({});

// Output/Result:
// [
//   { "_id": ObjectId("..."), "CID": 1, "CNAME": "John Smith" },
//   { "_id": ObjectId("..."), "CID": 2, "CNAME": "Mary Johnson" },
//   // ... other customers
//   { "_id": ObjectId("..."), "CID": 6, "CNAME": "David Lee" }
// ]

// Find accounts for a specific customer (CID: 2)
db.account.find({ CID: 2 });

// Output/Result:
// [
//   { "_id": ObjectId("..."), "ANO": "A003", "ATYPE": "S", "BALANCE": 15000, "CID": 2, "BCODE": "B002" },
//   { "_id": ObjectId("..."), "ANO": "A004", "ATYPE": "C", "BALANCE": 30000, "CID": 2, "BCODE": "B003" }
// ]

// Find a customer by CID
db.customer.findOne({ CID: 3 });

// Output/Result:
// { "_id": ObjectId("..."), "CID": 3, "CNAME": "Robert Brown" }


// --- UPDATE Operations ---

// Update a customer's name (CID: 4)
db.customer.updateOne(
  { CID: 4 },
  { $set: { CNAME: "Patricia Williams" } }
);

// Output/Result:
// { "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1 }

// Update the balance of an account (ANO: "A001")
db.account.updateOne(
  { ANO: "A001" },
  { $inc: { BALANCE: 500 } } // Increment balance by 500
);

// Output/Result:
// { "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1 }


// --- DELETE Operations ---

// Delete a customer (CID: 5)
db.customer.deleteOne({ CID: 5 });

// Output/Result:
// { "acknowledged" : true, "deletedCount" : 1 }

// Delete an account (ANO: "A008")
db.account.deleteOne({ ANO: "A008" });

// Output/Result:
// { "acknowledged" : true, "deletedCount" : 1 }
