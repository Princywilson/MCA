// MongoDB CRUD Operations for STUDENT and BRANCH collections

// Connect to MongoDB
use examination_system

// 1. Create Operations

// Create STUDENT collection
db.createCollection("student")

// Insert data into STUDENT collection
db.student.insertMany([
  {
    rollno: "S001",
    name: "John Doe",
    dob: new Date("2000-05-15"),
    gender: "M",
    doa: new Date("2020-08-01"),
    bcode: "CSE"
  },
  {
    rollno: "S002",
    name: "Jane Smith",
    dob: new Date("2001-03-21"),
    gender: "F",
    doa: new Date("2020-08-01"),
    bcode: "IT"
  },
  {
    rollno: "S003",
    name: "Robert Brown",
    dob: new Date("2000-11-10"),
    gender: "M",
    doa: new Date("2020-08-01"),
    bcode: "ECE"
  },
  {
    rollno: "S004",
    name: "Emily Davis",
    dob: new Date("2001-07-18"),
    gender: "F",
    doa: new Date("2020-08-01"),
    bcode: "EEE"
  },
  {
    rollno: "S005",
    name: "Michael Wilson",
    dob: new Date("2000-09-22"),
    gender: "M",
    doa: new Date("2020-08-01"),
    bcode: "MECH"
  }
])

// Create BRANCH collection
db.createCollection("branch")

// Insert data into BRANCH collection
db.branch.insertMany([
  {
    bcode: "CSE",
    bname: "Computer Science and Engineering",
    dno: 1
  },
  {
    bcode: "IT",
    bname: "Information Technology",
    dno: 2
  },
  {
    bcode: "ECE",
    bname: "Electronics and Communication Engineering",
    dno: 3
  },
  {
    bcode: "EEE",
    bname: "Electrical and Electronics Engineering",
    dno: 4
  },
  {
    bcode: "MECH",
    bname: "Mechanical Engineering",
    dno: 5
  }
])

// 2. Read Operations

// Read all students
db.student.find()

// Read all branches
db.branch.find()

// Read specific student
db.student.find({rollno: "S001"})

// Read students by branch
db.student.find({bcode: "CSE"})

// Read branches by department
db.branch.find({dno: 1})

// 3. Update Operations

// Update a student's name
db.student.updateOne(
  {rollno: "S001"},
  {$set: {name: "John Smith"}}
)

// Update multiple students' date of admission
db.student.updateMany(
  {bcode: "CSE"},
  {$set: {doa: new Date("2020-08-15")}}
)

// Update a branch name
db.branch.updateOne(
  {bcode: "CSE"},
  {$set: {bname: "Computer Science Engineering"}}
)

// 4. Delete Operations

// Delete a specific student
db.student.deleteOne({rollno: "S005"})

// Delete all students from a specific branch
db.student.deleteMany({bcode: "MECH"})

// Delete a branch
db.branch.deleteOne({bcode: "MECH"})

// Sample Results Display:

// Result of all students after operations
print("All students after operations:")
db.student.find().forEach(printjson)

// Result of all branches after operations
print("All branches after operations:")
db.branch.find().forEach(printjson)
