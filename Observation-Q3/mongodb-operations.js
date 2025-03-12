// javascript
// Assuming you have a MongoDB connection established and a database selected

// --- CREATE ---

// Insert a new branch
db.branches.insertOne({
  BCODE: "MECH",
  BNAME: "Mechanical Engineering",
  DNO: 4
});
// Output: { "acknowledged" : true, "insertedId" : ObjectId("...") }

// Insert a new student
db.students.insertOne({
  ROLLNO: "S005",
  NAME: "David Lee",
  DOB: new Date("2002-07-22"),
  GENDER: "M",
  DOA: new Date("2021-08-01"),
  BCODE: "MECH"
});
// Output: { "acknowledged" : true, "insertedId" : ObjectId("...") }


// --- READ ---

// Find all branches
db.branches.find({});
// Output: [ { "_id" : ObjectId("..."), "BCODE" : "CSE", "BNAME" : "Computer Science and Engineering", "DNO" : 1 }, ... ]

// Find a student by ROLLNO
db.students.findOne({ ROLLNO: "S002" });
// Output: { "_id" : ObjectId("..."), "ROLLNO" : "S002", "NAME" : "Jane Smith", "DOB" : ISODate("2001-03-21T00:00:00Z"), "GENDER" : "F", "DOA" : ISODate("2020-08-01T00:00:00Z"), "BCODE" : "IT" }

// Find all students in a specific branch
db.students.find({ BCODE: "CSE" });
// Output: [ { "_id" : ObjectId("..."), "ROLLNO" : "S001", "NAME" : "John Doe", "DOB" : ISODate("2000-05-15T00:00:00Z"), "GENDER" : "M", "DOA" : ISODate("2020-08-01T00:00:00Z"), "BCODE" : "CSE" } ]


// --- UPDATE ---

// Update the name of a branch
db.branches.updateOne(
  { BCODE: "IT" },
  { $set: { BNAME: "Information Technologies" } }
);
// Output: { "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1, "upsertedCount" : 0 }

// Update the DOB of a student
db.students.updateOne(
  { ROLLNO: "S003" },
  { $set: { DOB: new Date("2000-11-11") } }
);
// Output: { "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1, "upsertedCount" : 0 }


// --- DELETE ---

// Delete a branch
db.branches.deleteOne({ BCODE: "MECH" });
// Output: { "acknowledged" : true, "deletedCount" : 1 }

// Delete a student
db.students.deleteOne({ ROLLNO: "S005" });
// Output: { "acknowledged" : true, "deletedCount" : 1 }

