// Assuming you have a MongoDB connection established and databases named 'employeeDB'

// 1. CREATE (Insert) a new department
db.department.insertOne({
  DEPT_NO: "D006",
  NAME: "Sales",
  MENO: "E006",
  NOE: 4
});
// Output: { "acknowledged" : true, "insertedId" : ObjectId("...") }

// CREATE (Insert) a new employee
db.employee.insertOne({
  ENO: "E012",
  NAME: "Alice Johnson",
  GENDER: "F",
  DOB: "1992-03-10",
  DOJ: "2018-01-15",
  DESIGNATION: "Sales Representative",
  BASIC: 58000,
  DEPT_NO: "D004",
  PANNO: "PAN012",
  SENO: "E004"
});
// Output: { "acknowledged" : true, "insertedId" : ObjectId("...") }

// 2. READ (Find) all departments
db.department.find({});
// Output: [
//   { DEPT_NO: "D001", NAME: "Human Resources", MENO: "E001", NOE: 2, _id: ObjectId("...") },
//   { DEPT_NO: "D002", NAME: "Engineering", MENO: "E002", NOE: 3, _id: ObjectId("...") },
//   ...
//   { DEPT_NO: "D006", NAME: "Sales", MENO: "E006", NOE: 4, _id: ObjectId("...") }
// ]


// READ (Find) all employees
db.employee.find({});
// Output: [
//   { ENO: "E001", NAME: "John Smith", GENDER: "M", DOB: "1980-05-15", DOJ: "2010-01-10", DESIGNATION: "HR Manager", BASIC: 85000, DEPT_NO: "D001", PANNO: "PAN001", SENO: "E001", _id: ObjectId("...") },
//   { ENO: "E002", NAME: "Jane Doe", GENDER: "F", DOB: "1985-08-20", DOJ: "2012-03-15", DESIGNATION: "Senior Engineer", BASIC: 80000, DEPT_NO: "D002", PANNO: "PAN002", SENO: "E002", _id: ObjectId("...") },
//   ...
//   { ENO: "E012", NAME: "Alice Johnson", GENDER: "F", DOB: "1992-03-10", DOJ: "2018-01-15", DESIGNATION: "Sales Representative", BASIC: 58000, DEPT_NO: "D004", PANNO: "PAN012", SENO: "E004", _id: ObjectId("...") }
// ]

// READ (Find) a specific employee by ENO
db.employee.findOne({ ENO: "E007" });
// Output: { ENO: "E007", NAME: "David Lee", GENDER: "M", DOB: "1987-09-30", DOJ: "2014-02-15", DESIGNATION: "Software Engineer", BASIC: 75000, DEPT_NO: "D002", PANNO: "PAN007", SENO: "E002", _id: ObjectId("...") }


// READ (Find) a specific department by DEPT_NO
db.department.findOne({ DEPT_NO: "D003" });
// Output: { DEPT_NO: "D003", NAME: "Finance", MENO: "E003", NOE: 2, _id: ObjectId("...") }

// 4. UPDATE (Update) the name of a department
db.department.updateOne(
  { DEPT_NO: "D004" },
  { $set: { NAME: "Marketing and Communications" } }
);
// Output: { "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1 }

// UPDATE (Update) the designation and basic salary of an employee
db.employee.updateOne(
  { ENO: "E008" },
  { $set: { DESIGNATION: "Senior Financial Analyst", BASIC: 72000 } }
);
// Output: { "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1 }

// 5. DELETE (Delete) an employee
db.employee.deleteOne({ ENO: "E012" });
// Output: { "acknowledged" : true, "deletedCount" : 1 }

// DELETE (Delete) a department
db.department.deleteOne({ DEPT_NO: "D006" });
// Output: { "acknowledged" : true, "deletedCount" : 1 }

