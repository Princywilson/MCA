
// Create the Department collection
db.createCollection("Department")

// Insert 3 records into Department collection
db.Department.insertMany([
  {
    DEPT_NO: "D001",
    NAME: "Human Resources",
    MENO: "HR",
    NOE: 15
  },
  {
    DEPT_NO: "D002",
    NAME: "Information Technology",
    MENO: "IT",
    NOE: 25
  },
  {
    DEPT_NO: "D003",
    NAME: "Finance",
    MENO: "FIN",
    NOE: 10
  }
])

// Output:
// {
//   "acknowledged": true,
//   "insertedIds": [
//     ObjectId("..."),
//     ObjectId("..."),
//     ObjectId("...")
//   ]
// }
// Comment: Successfully inserted 3 department records

// Create the Employee collection
db.createCollection("Employee")

// Insert 3 records into Employee collection
db.Employee.insertMany([
  {
    ENO: "E101",
    NAME: "John Smith",
    GENDER: "Male",
    DOB: ISODate("1985-06-15"),
    DOJ: ISODate("2020-03-10"),
    DESIGNATION: "HR Manager",
    BASIC: 75000,
    DEPT_NO: "D001",
    PANNO: "ABCDE1234F",
    SENO: "SE001"
  },
  {
    ENO: "E102",
    NAME: "Sarah Johnson",
    GENDER: "Female",
    DOB: ISODate("1990-11-22"),
    DOJ: ISODate("2021-08-15"),
    DESIGNATION: "Software Engineer",
    BASIC: 85000,
    DEPT_NO: "D002",
    PANNO: "FGHIJ5678K",
    SENO: "SE002"
  },
  {
    ENO: "E103",
    NAME: "Michael Chen",
    GENDER: "Male",
    DOB: ISODate("1988-04-30"),
    DOJ: ISODate("2019-05-20"),
    DESIGNATION: "Financial Analyst",
    BASIC: 70000,
    DEPT_NO: "D003",
    PANNO: "LMNOP9012Q",
    SENO: "SE003"
  }
])

// Output:
// {
//   "acknowledged": true,
//   "insertedIds": [
//     ObjectId("..."),
//     ObjectId("..."),
//     ObjectId("...")
//   ]
// }
// Comment: Successfully inserted 3 employee records


//Read
db.Department.find()

// Output:
// [
//   {
//     "_id": ObjectId("..."),
//     "DEPT_NO": "D001",
//     "NAME": "Human Resources",
//     "MENO": "HR",
//     "NOE": 15
//   },
//   {
//     "_id": ObjectId("..."),
//     "DEPT_NO": "D002",
//     "NAME": "Information Technology",
//     "MENO": "IT",
//     "NOE": 25
//   },
//   {
//     "_id": ObjectId("..."),
//     "DEPT_NO": "D003",
//     "NAME": "Finance",
//     "MENO": "FIN",
//     "NOE": 10
//   }
// ]
// Comment: Retrieved all department records, showing 4 departments

db.Employee.find({ 
  GENDER: "Female", 
  BASIC: { $gt: 60000 } 
})

// Output:
// [
//   {
//     "_id": ObjectId("..."),
//     "ENO": "E102",
//     "NAME": "Sarah Johnson",
//     "GENDER": "Female",
//     "DOB": ISODate("1990-11-22"),
//     "DOJ": ISODate("2021-08-15"),
//     "DESIGNATION": "Software Engineer",
//     "BASIC": 85000,
//     "DEPT_NO": "D002",
//     "PANNO": "FGHIJ5678K",
//     "SENO": "SE002"
//   }
// ]
// Comment: Found female employees with a basic salary greater than 60000, showing 2 employees

//Update
db.Department.updateOne(
  { DEPT_NO: "D002" },
  { $inc: { NOE: 2 } }
)

// Output:
// {
//   "acknowledged": true,
//   "matchedCount": 1,
//   "modifiedCount": 1
// }
// Comment: Updated the NOE field for the IT department, incrementing it by 2

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
// Comment: Updated all Finance department employees with a 10% salary increase


// Delete
db.Department.deleteOne({ DEPT_NO: "D004" })

// Output:
// {
//   "acknowledged": true,
//   "deletedCount": 1
// }
// Comment: Deleted the Marketing department (D004)

db.Employee.deleteMany({ DOJ: { $lt: ISODate("2020-01-01") } })

// Output:
// {
//   "acknowledged": true,
//   "deletedCount": 1
// }
// Comment: Deleted employees who joined before 2020
