// MongoDB CRUD Operations for STAFF and DEPT collections

// 1. Creating collections
db.createCollection("staff")
db.createCollection("dept")

// 2. CREATE - Inserting departments
db.dept.insertMany([
  { deptNo: 1, name: "IT" },
  { deptNo: 2, name: "HR" },
  { deptNo: 3, name: "Finance" },
  { deptNo: 4, name: "Marketing" },
  { deptNo: 5, name: "Operations" }
])

// Result:
/*
{
  "acknowledged": true,
  "insertedIds": [
    ObjectId("..."),
    ObjectId("..."),
    ObjectId("..."),
    ObjectId("..."),
    ObjectId("...")
  ]
}
*/

// 3. CREATE - Inserting staff
db.staff.insertMany([
  {
    staffNo: 101,
    name: "John Smith",
    dob: new Date("1985-05-15"),
    gender: "M",
    doj: new Date("2010-06-20"),
    designation: "Senior Developer",
    basicPay: 85000.00,
    deptNo: 1
  },
  {
    staffNo: 102,
    name: "Emma Wilson",
    dob: new Date("1990-03-25"),
    gender: "F",
    doj: new Date("2015-04-10"),
    designation: "HR Manager",
    basicPay: 75000.00,
    deptNo: 2
  },
  {
    staffNo: 103,
    name: "Michael Brown",
    dob: new Date("1982-11-08"),
    gender: "M",
    doj: new Date("2009-01-15"),
    designation: "Financial Analyst",
    basicPay: 70000.00,
    deptNo: 3
  },
  {
    staffNo: 104,
    name: "Sophia Lee",
    dob: new Date("1988-07-19"),
    gender: "F",
    doj: new Date("2012-09-30"),
    designation: "Marketing Specialist",
    basicPay: 65000.00,
    deptNo: 4
  },
  {
    staffNo: 105,
    name: "Robert Johnson",
    dob: new Date("1980-02-28"),
    gender: "M",
    doj: new Date("2008-03-05"),
    designation: "Operations Manager",
    basicPay: 90000.00,
    deptNo: 5
  }
])

// Result:
/*
{
  "acknowledged": true,
  "insertedIds": [
    ObjectId("..."),
    ObjectId("..."),
    ObjectId("..."),
    ObjectId("..."),
    ObjectId("...")
  ]
}
*/

// 4. READ - Retrieving all departments
db.dept.find()

// Result:
/*
[
  { "_id": ObjectId("..."), "deptNo": 1, "name": "IT" },
  { "_id": ObjectId("..."), "deptNo": 2, "name": "HR" },
  { "_id": ObjectId("..."), "deptNo": 3, "name": "Finance" },
  { "_id": ObjectId("..."), "deptNo": 4, "name": "Marketing" },
  { "_id": ObjectId("..."), "deptNo": 5, "name": "Operations" }
]
*/

// 5. READ - Retrieving all staff
db.staff.find().pretty()

// Result:
/*
[
  {
    "_id": ObjectId("..."),
    "staffNo": 101,
    "name": "John Smith",
    "dob": ISODate("1985-05-15T00:00:00Z"),
    "gender": "M",
    "doj": ISODate("2010-06-20T00:00:00Z"),
    "designation": "Senior Developer",
    "basicPay": 85000,
    "deptNo": 1
  },
  {
    "_id": ObjectId("..."),
    "staffNo": 102,
    "name": "Emma Wilson",
    "dob": ISODate("1990-03-25T00:00:00Z"),
    "gender": "F",
    "doj": ISODate("2015-04-10T00:00:00Z"),
    "designation": "HR Manager",
    "basicPay": 75000,
    "deptNo": 2
  },
  ...
]
*/

// 6. READ - Finding staff in IT department (deptNo: 1)
db.staff.find({ deptNo: 1 }).pretty()

// Result:
/*
[
  {
    "_id": ObjectId("..."),
    "staffNo": 101,
    "name": "John Smith",
    "dob": ISODate("1985-05-15T00:00:00Z"),
    "gender": "M",
    "doj": ISODate("2010-06-20T00:00:00Z"),
    "designation": "Senior Developer",
    "basicPay": 85000,
    "deptNo": 1
  }
]
*/

// 7. UPDATE - Updating a staff member's basic pay
db.staff.updateOne(
  { staffNo: 101 },
  { $set: { basicPay: 90000.00, designation: "Lead Developer" } }
)

// Result:
/*
{
  "acknowledged": true,
  "matchedCount": 1,
  "modifiedCount": 1
}
*/

// 8. UPDATE - Updating a department name
db.dept.updateOne(
  { deptNo: 1 },
  { $set: { name: "Information Technology" } }
)

// Result:
/*
{
  "acknowledged": true,
  "matchedCount": 1,
  "modifiedCount": 1
}
*/

// 9. READ - Verify the updates
db.staff.findOne({ staffNo: 101 })

// Result:
/*
{
  "_id": ObjectId("..."),
  "staffNo": 101,
  "name": "John Smith",
  "dob": ISODate("1985-05-15T00:00:00Z"),
  "gender": "M",
  "doj": ISODate("2010-06-20T00:00:00Z"),
  "designation": "Lead Developer",
  "basicPay": 90000,
  "deptNo": 1
}
*/

db.dept.findOne({ deptNo: 1 })

// Result:
/*
{
  "_id": ObjectId("..."),
  "deptNo": 1,
  "name": "Information Technology"
}
*/

// 10. DELETE - Deleting a staff member
db.staff.deleteOne({ staffNo: 105 })

// Result:
/*
{
  "acknowledged": true,
  "deletedCount": 1
}
*/

// 11. DELETE - Deleting a department (note: this would require handling related staff!)
db.dept.deleteOne({ deptNo: 5 })

// Result:
/*
{
  "acknowledged": true,
  "deletedCount": 1
}
*/

// 12. READ - Verify the deletions
db.staff.find({ staffNo: 105 })
// Result: []

db.dept.find({ deptNo: 5 })
// Result: []

// 13. Advanced query - Aggregation to get department statistics
db.staff.aggregate([
  {
    $group: {
      _id: "$deptNo",
      numberOfStaff: { $sum: 1 },
      totalBasicPay: { $sum: "$basicPay" },
      avgBasicPay: { $avg: "$basicPay" }
    }
  },
  {
    $lookup: {
      from: "dept",
      localField: "_id",
      foreignField: "deptNo",
      as: "department"
    }
  },
  {
    $project: {
      _id: 0,
      deptNo: "$_id",
      departmentName: { $arrayElemAt: ["$department.name", 0] },
      numberOfStaff: 1,
      totalBasicPay: 1,
      avgBasicPay: 1
    }
  },
  {
    $sort: { deptNo: 1 }
  }
])

// Result:
/*
[
  {
    "deptNo": 1,
    "departmentName": "Information Technology",
    "numberOfStaff": 1,
    "totalBasicPay": 90000,
    "avgBasicPay": 90000
  },
  {
    "deptNo": 2,
    "departmentName": "HR",
    "numberOfStaff": 1,
    "totalBasicPay": 75000,
    "avgBasicPay": 75000
  },
  {
    "deptNo": 3,
    "departmentName": "Finance",
    "numberOfStaff": 1,
    "totalBasicPay": 70000,
    "avgBasicPay": 70000
  },
  {
    "deptNo": 4,
    "departmentName": "Marketing",
    "numberOfStaff": 1,
    "totalBasicPay": 65000,
    "avgBasicPay": 65000
  }
]
*/
