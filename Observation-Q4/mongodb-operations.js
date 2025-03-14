

// =============================================
// CREATE OPERATIONS
// =============================================

// 1. Create collection (if needed)
db.createCollection("departments");
db.createCollection("employees");

// Output:
// { "ok": 1 }

// 2. Insert a single department
db.departments.insertOne({
  DEPT_NO: "D001",
  NAME: "Engineering",
  MENO: "John Smith",
  NOE: 15
});

// Output:
// {
//   "acknowledged": true,
//   "insertedId": ObjectId("607f1f77bcf86cd799439011")
// }

// 3. Insert multiple departments
db.departments.insertMany([
  { DEPT_NO: "D002", NAME: "Finance", MENO: "Sarah Johnson", NOE: 8 },
  { DEPT_NO: "D003", NAME: "Marketing", MENO: "David Lee", NOE: 12 }
]);

// Output:
// {
//   "acknowledged": true,
//   "insertedIds": {
//     "0": ObjectId("607f1f77bcf86cd799439012"),
//     "1": ObjectId("607f1f77bcf86cd799439013")
//   }
// }


// 5. Insert multiple employees at once
db.employees.insertMany([
  { 
    ENO: "E002", 
    NAME: "Bob Richards", 
    GENDER: "M", 
    DOB: "1985-11-23", 
    DOJ: "2019-07-15", 
    DESIGNATION: "Financial Analyst", 
    BASIC: 68000, 
    DEPT_NO: "D002", 
    PANNO: "FGHIJ5678K", 
    SENO: 1002 
  },
  { 
    ENO: "E003", 
    NAME: "Carol Martinez", 
    GENDER: "F", 
    DOB: "1992-03-08", 
    DOJ: "2021-03-22", 
    DESIGNATION: "Marketing Specialist", 
    BASIC: 62000, 
    DEPT_NO: "D003", 
    PANNO: "LMNOP9012Q", 
    SENO: 1003 
  }
]);

// Output:
// {
//   "acknowledged": true,
//   "insertedIds": {
//     "0": ObjectId("607f1f77bcf86cd799439015"),
//     "1": ObjectId("607f1f77bcf86cd799439016")
//   }
// }

// =============================================
// READ OPERATIONS
// =============================================

// 1. Find all departments
db.departments.find();

// Output:
// [
//   {
//     "_id": ObjectId("607f1f77bcf86cd799439011"),
//     "DEPT_NO": "D001",
//     "NAME": "Engineering",
//     "MENO": "John Smith",
//     "NOE": 15
//   },
//   {
//     "_id": ObjectId("607f1f77bcf86cd799439012"),
//     "DEPT_NO": "D002",
//     "NAME": "Finance",
//     "MENO": "Sarah Johnson",
//     "NOE": 8
//   },
//   {
//     "_id": ObjectId("607f1f77bcf86cd799439013"),
//     "DEPT_NO": "D003",
//     "NAME": "Marketing",
//     "MENO": "David Lee",
//     "NOE": 12
//   }
// ]

// 2. Find a specific department
db.departments.findOne({ DEPT_NO: "D001" });

// Output:
// {
//   "_id": ObjectId("607f1f77bcf86cd799439011"),
//   "DEPT_NO": "D001",
//   "NAME": "Engineering",
//   "MENO": "John Smith",
//   "NOE": 15
// }

// 3. Find departments with more than 10 employees
db.departments.find({ NOE: { $gt: 10 } });

// Output:
// [
//   {
//     "_id": ObjectId("607f1f77bcf86cd799439011"),
//     "DEPT_NO": "D001",
//     "NAME": "Engineering",
//     "MENO": "John Smith",
//     "NOE": 15
//   },
//   {
//     "_id": ObjectId("607f1f77bcf86cd799439013"),
//     "DEPT_NO": "D003",
//     "NAME": "Marketing",
//     "MENO": "David Lee",
//     "NOE": 12
//   }
// ]

// 4. Find and sort employees by salary (descending)
db.employees.find().sort({ BASIC: -1 });

// Output:
// [
//   {
//     "_id": ObjectId("607f1f77bcf86cd799439014"),
//     "ENO": "E001",
//     "NAME": "Alice Cooper",
//     ...
//     "BASIC": 75000,
//     ...
//   },
//   {
//     "_id": ObjectId("607f1f77bcf86cd799439015"),
//     "ENO": "E002",
//     ...
//     "BASIC": 68000,
//     ...
//   },
//   ...
// ]

// =============================================
// UPDATE OPERATIONS
// =============================================

// 1. Increase the number of employees in a department
db.departments.updateOne(
  { DEPT_NO: "D002" },
  { $inc: { NOE: 2 } }
);

// Output:
// {
//   "acknowledged": true,
//   "matchedCount": 1,
//   "modifiedCount": 1
// }

// 2. Update salary for all engineers
db.employees.updateMany(
  { DESIGNATION: "Software Engineer" },
  { $mul: { BASIC: 1.1 } }
);

// Output:
// {
//   "acknowledged": true,
//   "matchedCount": 1,
//   "modifiedCount": 1
// }

// 3. Replace an entire employee document
db.employees.replaceOne(
  { ENO: "E003" },
  {
    ENO: "E003",
    NAME: "Carol Davidson", // Changed last name
    GENDER: "F",
    DOB: "1992-03-08",
    DOJ: "2021-03-22",
    DESIGNATION: "Senior Marketing Specialist", // Promotion
    BASIC: 68000, // Salary increase
    DEPT_NO: "D003",
    PANNO: "LMNOP9012Q",
    SENO: 1003
  }
);

// Output:
// {
//   "acknowledged": true,
//   "matchedCount": 1,
//   "modifiedCount": 1
// }

// 4. Update with upsert (insert if not exists)
db.departments.updateOne(
  { DEPT_NO: "D004" },
  { 
    $set: { 
      NAME: "Human Resources", 
      MENO: "Patricia Wilson", 
      NOE: 5 
    } 
  },
  { upsert: true }
);

// Output:
// {
//   "acknowledged": true,
//   "matchedCount": 0,
//   "modifiedCount": 0,
//   "upsertedCount": 1,
//   "upsertedId": ObjectId("607f1f77bcf86cd799439017")
// }

// =============================================
// DELETE OPERATIONS
// =============================================

// 1. Delete a department
db.departments.deleteOne({ DEPT_NO: "D003" });

// Output:
// {
//   "acknowledged": true,
//   "deletedCount": 1
// }

// 2. Delete all employees of a specific department
db.employees.deleteMany({ DEPT_NO: "D002" });

// Output:
// {
//   "acknowledged": true,
//   "deletedCount": 1
// }

// 3. Delete employees who joined before 2020
db.employees.deleteMany({ DOJ: { $lt: "2020-01-01" } });

// Output:
// {
//   "acknowledged": true,
//   "deletedCount": 1
// }

// 4. Remove a collection entirely
db.employees.drop();

// Output:
// true

