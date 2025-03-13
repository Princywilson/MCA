// Assuming you have a MongoDB database named 'company' and collections 'staff' and 'dept'

// CREATE operations
// Connect to MongoDB and create the company database
// Output: switched to db company

// Create the DEPT collection with initial departments
db.createCollection("dept");
// Output: { "ok" : 1 }

// Create the STAFF collection
db.createCollection("staff");
// Output: { "ok" : 1 }



// Insert initial departments
db.dept.insertMany([
  { DEPTNO: 1, NAME: "IT" },
  { DEPTNO: 2, NAME: "HR" },
  { DEPTNO: 3, NAME: "Finance" },
  { DEPTNO: 4, NAME: "Marketing" },
  { DEPTNO: 5, NAME: "Operations" }
]);
// Output: {
//   "acknowledged" : true,
//   "insertedIds" : [
//     ObjectId("64a1b2c3d4e5f6a7b8c9d0e1"),
//     ObjectId("64a1b2c3d4e5f6a7b8c9d0e2"),
//     ObjectId("64a1b2c3d4e5f6a7b8c9d0e3"),
//     ObjectId("64a1b2c3d4e5f6a7b8c9d0e4"),
//     ObjectId("64a1b2c3d4e5f6a7b8c9d0e5")
//   ]
// }

  // Insert initial staff members
db.staff.insertMany([
  {
    STAFFNO: 101,
    NAME: "John Smith",
    DOB: ISODate("1985-04-15"),
    GENDER: "M",
    DOJ: ISODate("2015-06-01"),
    DESIGNATION: "Senior Developer",
    BASIC_PAY: 85000,
    DEPTNO: 1
  },
  {
    STAFFNO: 102,
    NAME: "Emma Wilson",
    DOB: ISODate("1990-08-22"),
    GENDER: "F",
    DOJ: ISODate("2017-03-15"),
    DESIGNATION: "HR Manager",
    BASIC_PAY: 78000,
    DEPTNO: 2
  },
  {
    STAFFNO: 103,
    NAME: "Michael Brown",
    DOB: ISODate("1988-12-10"),
    GENDER: "M",
    DOJ: ISODate("2016-09-20"),
    DESIGNATION: "Finance Director",
    BASIC_PAY: 92000,
    DEPTNO: 3
  }
]);
// Output: {
//   "acknowledged" : true,
//   "insertedIds" : [
//     ObjectId("64a1b2c3d4e5f6a7b8c9d1e1"),
//     ObjectId("64a1b2c3d4e5f6a7b8c9d1e2"),
//     ObjectId("64a1b2c3d4e5f6a7b8c9d1e3"),
//     ObjectId("64a1b2c3d4e5f6a7b8c9d1e4"),
//     ObjectId("64a1b2c3d4e5f6a7b8c9d1e5"),
//     ObjectId("64a1b2c3d4e5f6a7b8c9d1e6"),
//     ObjectId("64a1b2c3d4e5f6a7b8c9d1e7"),
//     ObjectId("64a1b2c3d4e5f6a7b8c9d1e8"),
//     ObjectId("64a1b2c3d4e5f6a7b8c9d1e9"),
//     ObjectId("64a1b2c3d4e5f6a7b8c9d1f0")
//   ]
// }

// READ operations

// Find all departments
db.dept.find({});
// Output: [ { "_id" : ObjectId("..."), "DEPTNO" : 1, "NAME" : "IT" }, { "_id" : ObjectId("..."), "DEPTNO" : 2, "NAME" : "HR" }, ... ]

// Find staff members in the IT department (DEPTNO: 1)
db.staff.find({ DEPTNO: 1 });
// Output: [ { "_id" : ObjectId("..."), "STAFFNO" : 101, "NAME" : "John Smith", ... }, { "_id" : ObjectId("..."), "STAFFNO" : 106, "NAME" : "Jennifer Davis", ... }, { "_id" : ObjectId("..."), "STAFFNO" : 111, "NAME" : "Alice Johnson", ... } ]

// Find staff members with BASIC_PAY greater than 70000
db.staff.find({ BASIC_PAY: { $gt: 70000 } });
// Output: [ { "_id" : ObjectId("..."), "STAFFNO" : 101, "NAME" : "John Smith", ... }, { "_id" : ObjectId("..."), "STAFFNO" : 102, "NAME" : "Emma Wilson", ... }, { "_id" : ObjectId("..."), "STAFFNO" : 103, "NAME" : "Michael Brown", ... }, { "_id" : ObjectId("..."), "STAFFNO" : 105, "NAME" : "Robert Johnson", ... }, { "_id" : ObjectId("..."), "STAFFNO" : 106, "NAME" : "Jennifer Davis", ... } ]

// Find a staff member by STAFFNO
db.staff.findOne({ STAFFNO: 104 });
// Output: { "_id" : ObjectId("..."), "STAFFNO" : 104, "NAME" : "Sophia Lee", ... }


// UPDATE operations

// Update the designation of staff member with STAFFNO 106
db.staff.updateOne(
  { STAFFNO: 106 },
  { $set: { DESIGNATION: "Senior Developer" } }
);
// Output: { "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1, "upsertedCount" : 0 }

// Increase the BASIC_PAY of all staff members in the HR department by 10%
db.staff.updateMany(
  { DEPTNO: 2 },
  { $mul: { BASIC_PAY: 1.1 } }
);
// Output: { "acknowledged" : true, "matchedCount" : 2, "modifiedCount" : 2, "upsertedCount" : 0 }

// Update the name of the department with DEPTNO 4
db.dept.updateOne(
  { DEPTNO: 4 },
  { $set: { NAME: "Sales and Marketing" } }
);
// Output: { "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1, "upsertedCount" : 0 }


// DELETE operations

// Delete the staff member with STAFFNO 111
db.staff.deleteOne({ STAFFNO: 111 });
// Output: { "acknowledged" : true, "deletedCount" : 1 }

// Delete all staff members in the Finance department (DEPTNO: 3)
db.staff.deleteMany({ DEPTNO: 3 });
// Output: { "acknowledged" : true, "deletedCount" : 2 }

// Delete the department with DEPTNO 6
db.dept.deleteOne({ DEPTNO: 6 });
// Output: { "acknowledged" : true, "deletedCount" : 1 }
