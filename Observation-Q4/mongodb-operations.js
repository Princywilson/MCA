// MongoDB CRUD Operations for EMPLOYEE and DEPARTMENT collections

// Connect to the database
const { MongoClient } = require('mongodb');
const uri = "mongodb://localhost:27017";
const client = new MongoClient(uri);

async function runCRUDOperations() {
    try {
        // Connect to the MongoDB server
        await client.connect();
        console.log("Connected to MongoDB");
        
        // Use the company database
        const database = client.db("company_db");
        
        // Get references to the collections
        const employeeCollection = database.collection("employee");
        const departmentCollection = database.collection("department");
        
        // 1. CREATE Operations
        console.log("\n--- CREATE Operations ---");
        
        // 1.1 Drop existing collections to start fresh
        await employeeCollection.drop().catch(() => console.log("Employee collection does not exist yet."));
        await departmentCollection.drop().catch(() => console.log("Department collection does not exist yet."));
        
        // 1.2 Create departments
        const departments = [
            { dept_no: 101, name: "IT", meno: 1001, noe: 3 },
            { dept_no: 102, name: "HR", meno: 1002, noe: 3 },
            { dept_no: 103, name: "Finance", meno: 1003, noe: 3 },
            { dept_no: 104, name: "Marketing", meno: 1004, noe: 3 },
            { dept_no: 105, name: "Operations", meno: 1005, noe: 2 }
        ];
        
        const departmentResult = await departmentCollection.insertMany(departments);
        console.log(`${departmentResult.insertedCount} departments inserted`);
        
        // 1.3 Create employees
        const employees = [
            { eno: 1001, name: "John Smith", gender: "M", dob: new Date("1980-05-15"), doj: new Date("2010-01-10"), designation: "Manager", basic: 80000.00, dept_no: 101, panno: "ABCPX1234Y", seno: null },
            { eno: 1002, name: "Sarah Johnson", gender: "F", dob: new Date("1985-08-22"), doj: new Date("2011-03-15"), designation: "Manager", basic: 78000.00, dept_no: 102, panno: "DEFPX5678Z", seno: null },
            { eno: 1003, name: "Michael Brown", gender: "M", dob: new Date("1978-11-30"), doj: new Date("2009-07-20"), designation: "Manager", basic: 85000.00, dept_no: 103, panno: "GHIPX9012A", seno: null },
            { eno: 1004, name: "Emily Davis", gender: "F", dob: new Date("1982-04-18"), doj: new Date("2012-05-05"), designation: "Manager", basic: 76000.00, dept_no: 104, panno: "JKLPX3456B", seno: null },
            { eno: 1005, name: "Robert Wilson", gender: "M", dob: new Date("1975-09-25"), doj: new Date("2008-11-12"), designation: "Manager", basic: 90000.00, dept_no: 105, panno: "MNOPX7890C", seno: null },
            { eno: 1006, name: "Patricia Moore", gender: "F", dob: new Date("1988-07-14"), doj: new Date("2014-02-20"), designation: "Developer", basic: 65000.00, dept_no: 101, panno: "PQRPX1234D", seno: 1001 },
            { eno: 1007, name: "James Anderson", gender: "M", dob: new Date("1990-03-08"), doj: new Date("2015-09-17"), designation: "Developer", basic: 62000.00, dept_no: 101, panno: "STUPA5678E", seno: 1001 },
            { eno: 1008, name: "Jennifer White", gender: "F", dob: new Date("1987-12-03"), doj: new Date("2013-11-25"), designation: "HR Assistant", basic: 58000.00, dept_no: 102, panno: "VWXPY9012F", seno: 1002 },
            { eno: 1009, name: "David Miller", gender: "M", dob: new Date("1989-06-27"), doj: new Date("2016-04-10"), designation: "Accountant", basic: 64000.00, dept_no: 103, panno: "ZABPC3456G", seno: 1003 },
            { eno: 1010, name: "Lisa Taylor", gender: "F", dob: new Date("1991-10-11"), doj: new Date("2017-08-03"), designation: "Marketing Exec", basic: 56000.00, dept_no: 104, panno: "DEFPG7890H", seno: 1004 }
        ];
        
        const employeeResult = await employeeCollection.insertMany(employees);
        console.log(`${employeeResult.insertedCount} employees inserted`);
        
        // 2. READ Operations
        console.log("\n--- READ Operations ---");
        
        // 2.1 Read all departments
        console.log("\nAll Departments:");
        const allDepartments = await departmentCollection.find().toArray();
        console.table(allDepartments);
        
        // 2.2 Read all employees
        console.log("\nAll Employees:");
        const allEmployees = await employeeCollection.find().toArray();
        console.table(allEmployees);
        
        // 2.3 Read employees with specific criteria (similar to SQL query #3)
        console.log("\nEmployees with salary below average:");
        const avgBasic = await employeeCollection.aggregate([
            { $group: { _id: null, avgBasic: { $avg: "$basic" } } }
        ]).toArray();
        
        const lowSalaryEmployees = await employeeCollection.find(
            { basic: { $lt: avgBasic[0].avgBasic } }
        ).toArray();
        console.table(lowSalaryEmployees);
        
        // 2.4 Read departments with specific criteria (similar to SQL query #4)
        console.log("\nDepartments with more than 6 employees:");
        const largeDepartments = await departmentCollection.find(
            { noe: { $gt: 6 } }
        ).toArray();
        console.table(largeDepartments);
        
        // 3. UPDATE Operations
        console.log("\n--- UPDATE Operations ---");
        
        // 3.1 Update an employee's salary
        const updateSalaryResult = await employeeCollection.updateOne(
            { eno: 1006 },
            { $set: { basic: 68000.00 } }
        );
        console.log(`Updated employee salary: ${updateSalaryResult.modifiedCount} document modified`);
        
        // 3.2 Update a department name
        const updateDeptNameResult = await departmentCollection.updateOne(
            { dept_no: 101 },
            { $set: { name: "Information Technology" } }
        );
        console.log(`Updated department name: ${updateDeptNameResult.modifiedCount} document modified`);
        
        // 3.3 Update employee department (transfer) and manually update department NOE
        // In a real application, this would be handled by transactions or triggers
        const transferEmployee = async (employeeEno, fromDeptNo, toDeptNo) => {
            // Update employee department
            await employeeCollection.updateOne(
                { eno: employeeEno },
                { $set: { dept_no: toDeptNo } }
            );
            
            // Decrement old department NOE
            await departmentCollection.updateOne(
                { dept_no: fromDeptNo },
                { $inc: { noe: -1 } }
            );
            
            // Increment new department NOE
            await departmentCollection.updateOne(
                { dept_no: toDeptNo },
                { $inc: { noe: 1 } }
            );
            
            console.log(`Transferred employee ${employeeEno} from department ${fromDeptNo} to ${toDeptNo}`);
        };
        
        await transferEmployee(1006, 101, 104);
        
        // 4. DELETE Operations
        console.log("\n--- DELETE Operations ---");
        
        // 4.1 Delete an employee
        const deleteEmployeeResult = await employeeCollection.deleteOne({ eno: 1010 });
        console.log(`Deleted employee: ${deleteEmployeeResult.deletedCount} document deleted`);
        
        // Manual update of department NOE after employee deletion
        // In a real application, this would be handled by triggers
        await departmentCollection.updateOne(
            { dept_no: 104 },
            { $inc: { noe: -1 } }
        );
        console.log("Updated department NOE after employee deletion");
        
        // 5. Final state after all operations
        console.log("\n--- Final State After All Operations ---");
        
        console.log("\nFinal Departments:");
        const finalDepartments = await departmentCollection.find().toArray();
        console.table(finalDepartments);
        
        console.log("\nFinal Employees:");
        const finalEmployees = await employeeCollection.find().toArray();
        console.table(finalEmployees);
        
        // 6. Aggregation operations (similar to SQL view)
        console.log("\n--- Aggregation Operations ---");
        
        console.log("\nDepartment Statistics (similar to SQL view):");
        const departmentStats = await employeeCollection.aggregate([
            {
                $group: {
                    _id: "$dept_no",
                    total_basic_pay: { $sum: "$basic" },
                    employee_count: { $count: {} }
                }
            },
            {
                $lookup: {
                    from: "department",
                    localField: "_id",
                    foreignField: "dept_no",
                    as: "dept_info"
                }
            },
            {
                $unwind: "$dept_info"
            },
            {
                $project: {
                    dept_no: "$_id",
                    name: "$dept_info.name",
                    noe: "$dept_info.noe",
                    total_basic_pay: 1,
                    employee_count: 1
                }
            },
            {
                $sort: { dept_no: 1 }
            }
        ]).toArray();
        
        console.table(departmentStats);
        
    } finally {
        // Close the connection
        await client.close();
        console.log("MongoDB connection closed");
    }
}

// Run the CRUD operations
runCRUDOperations().catch(console.error);

/* Expected Output:

Connected to MongoDB

--- CREATE Operations ---
5 departments inserted
10 employees inserted

--- READ Operations ---

All Departments:
┌─────────┬─────────┬─────────────────┬──────┬─────┐
│ (index) │ dept_no │      name       │ meno │ noe │
├─────────┼─────────┼─────────────────┼──────┼─────┤
│    0    │   101   │      'IT'       │ 1001 │  3  │
│    1    │   102   │      'HR'       │ 1002 │  3  │
│    2    │   103   │   'Finance'     │ 1003 │  3  │
│    3    │   104   │   'Marketing'   │ 1004 │  3  │
│    4    │   105   │  'Operations'   │ 1005 │  2  │
└─────────┴─────────┴─────────────────┴──────┴─────┘

All Employees:
┌─────────┬──────┬────────────────┬────────┬─────────────────────┬─────────────────────┬─────────────────┬────────┬─────────┬──────────────┬──────┐
│ (index) │ eno  │      name      │ gender │        dob          │        doj          │   designation    │ basic  │ dept_no │    panno     │ seno │
├─────────┼──────┼────────────────┼────────┼─────────────────────┼─────────────────────┼─────────────────┼────────┼─────────┼──────────────┼──────┤
│    0    │ 1001 │  'John Smith'  │  'M'   │ 1980-05-15T00:00:00 │ 2010-01-10T00:00:00 │    'Manager'    │ 80000  │   101   │ 'ABCPX1234Y' │ null │
│    1    │ 1002 │'Sarah Johnson' │  'F'   │ 1985-08-22T00:00:00 │ 2011-03-15T00:00:00 │    'Manager'    │ 78000  │   102   │ 'DEFPX5678Z' │ null │
│    2    │ 1003 │'Michael Brown' │  'M'   │ 1978-11-30T00:00:00 │ 2009-07-20T00:00:00 │    'Manager'    │ 85000  │   103   │ 'GHIPX9012A' │ null │
│    3    │ 1004 │ 'Emily Davis'  │  'F'   │ 1982-04-18T00:00:00 │ 2012-05-05T00:00:00 │    'Manager'    │ 76000  │   104   │ 'JKLPX3456B' │ null │
│    4    │ 1005 │'Robert Wilson' │  'M'   │ 1975-09-25T00:00:00 │ 2008-11-12T00:00:00 │    'Manager'    │ 90000  │   105   │ 'MNOPX7890C' │ null │
│    5    │ 1006 │'Patricia Moore'│  'F'   │ 1988-07-14T00:00:00 │ 2014-02-20T00:00:00 │   'Developer'   │ 65000  │   101   │ 'PQRPX1234D' │ 1001 │
│    6    │ 1007 │'James Anderson'│  'M'   │ 1990-03-08T00:00:00 │ 2015-09-17T00:00:00 │   'Developer'   │ 62000  │   101   │ 'STUPA5678E' │ 1001 │
│    7    │ 1008 │'Jennifer White'│  'F'   │ 1987-12-03T00:00:00 │ 2013-11-25T00:00:00 │  'HR Assistant' │ 58000  │   102   │ 'VWXPY9012F' │ 1002 │
│    8    │ 1009 │ 'David Miller' │  'M'   │ 1989-06-27T00:00:00 │ 2016-04-10T00:00:00 │  'Accountant'   │ 64000  │   103   │ 'ZABPC3456G' │ 1003 │
│    9    │ 1010 │ 'Lisa Taylor'  │  'F'   │ 1991-10-11T00:00:00 │ 2017-08-03T00:00:00 │'Marketing Exec' │ 56000  │   104   │ 'DEFPG7890H' │ 1004 │
└─────────┴──────┴────────────────┴────────┴─────────────────────┴─────────────────────┴─────────────────┴────────┴─────────┴──────────────┴──────┘

Employees with salary below average:
┌─────────┬──────┬────────────────┬────────┬─────────────────────┬─────────────────────┬─────────────────┬────────┬─────────┬──────────────┬──────┐
│ (index) │ eno  │      name      │ gender │        dob          │        doj          │   designation    │ basic  │ dept_no │    panno     │ seno │
├─────────┼──────┼────────────────┼────────┼─────────────────────┼─────────────────────┼─────────────────┼────────┼─────────┼──────────────┼──────┤
│    0    │ 1006 │'Patricia Moore'│  'F'   │ 1988-07-14T00:00:00 │ 2014-02-20T00:00:00 │   'Developer'   │ 65000  │   101   │ 'PQRPX1234D' │ 1001 │
│    1    │ 1007 │'James Anderson'│  'M'   │ 1990-03-08T00:00:00 │ 2015-09-17T00:00:00 │   'Developer'   │ 62000  │   101   │ 'STUPA5678E' │ 1001 │
│    2    │ 1008 │'Jennifer White'│  'F'   │ 1987-12-03T00:00:00 │ 2013-11-25T00:00:00 │  'HR Assistant' │ 58000  │   102   │ 'VWXPY9012F' │ 1002 │
│    3    │ 1009 │ 'David Miller' │  'M'   │ 1989-06-27T00:00:00 │ 2016-04-10T00:00:00 │  'Accountant'   │ 64000  │   103   │ 'ZABPC3456G' │ 1003 │
│    4    │ 1010 │ 'Lisa Taylor'  │  'F'   │ 1991-10-11T00:00:00 │ 2017-08-03T00:00:00 │'Marketing Exec' │ 56000  │   104   │ 'DEFPG7890H' │ 1004 │
└─────────┴──────┴────────────────┴────────┴─────────────────────┴─────────────────────┴─────────────────┴────────┴─────────┴──────────────┴──────┘

Departments with more than 6 employees:
┌─────────┐
│ (index) │
└─────────┘
// Empty array - no departments have more than 6 employees

--- UPDATE Operations ---
Updated employee salary: 1 document modified
Updated department name: 1 document modified
Transferred employee 1006 from department 101 to 104

--- DELETE Operations ---
Deleted employee: 1 document deleted
Updated department NOE after employee deletion

--- Final State After All Operations ---

Final Departments:
┌─────────┬─────────┬────────────────────────┬──────┬─────┐
│ (index) │ dept_no │          name          │ meno │ noe │
├─────────┼─────────┼────────────────────────┼──────┼─────┤
│    0    │   101   │'Information Technology' │ 1001 │  2  │
│    1    │   102   │          'HR'          │ 1002 │  3  │
│    2    │   103   │       'Finance'        │ 1003 │  3  │
│    3    │   104   │      'Marketing'       │ 1004 │  3  │
│    4    │   105   │     'Operations'       │ 1005 │  2  │
└─────────┴─────────┴────────────────────────┴──────┴─────┘

Final Employees:
┌─────────┬──────┬────────────────┬────────┬─────────────────────┬─────────────────────┬─────────────────┬────────┬─────────┬──────────────┬──────┐
│ (index) │ eno  │      name      │ gender │        dob          │        doj          │   designation    │ basic  │ dept_no │    panno     │ seno │
├─────────┼──────┼────────────────┼────────┼─────────────────────┼─────────────────────┼─────────────────┼────────┼─────────┼──────────────┼──────┤
│    0    │ 1001 │  'John Smith'  │  'M'   │ 1980-05-15T00:00:00 │ 2010-01-10T00:00:00 │    'Manager'    │ 80000  │   101   │ 'ABCPX1234Y' │ null │
│    1    │ 1002 │'Sarah Johnson' │  'F'   │ 1985-08-22T00:00:00 │ 2011-03-15T00:00:00 │    'Manager'    │ 78000  │   102   │ 'DEFPX5678Z' │ null │
│    2    │ 1003 │'Michael Brown' │  'M'   │ 1978-11-30T00:00:00 │ 2009-07-20T00:00:00 │    'Manager'    │ 85000  │   103   │ 'GHIPX9012A' │ null │
│    3    │ 1004 │ 'Emily Davis'  │  'F'   │ 1982-04-18T00:00:00 │ 2012-05-05T00:00:00 │    'Manager'    │ 76000  │   104   │ 'JKLPX3456B' │ null │
│    4    │ 1005 │'Robert Wilson' │  'M'   │ 1975-09-25T00:00:00 │ 2008-11-12T00:00:00 │    'Manager'    │ 90000  │   105   │ 'MNOPX7890C' │ null │
│    5    │ 1006 │'Patricia Moore'│  'F'   │ 1988-07-14T00:00:00 │ 2014-02-20T00:00:00 │   'Developer'   │ 68000  │   104   │ 'PQRPX1234D' │ 1001 │
│    6    │ 1007 │'James Anderson'│  'M'   │ 1990-03-08T00:00:00 │ 2015-09-17T00:00:00 │   'Developer'   │ 62000  │   101   │ 'STUPA5678E' │ 1001 │
│    7    │ 1008 │'Jennifer White'│  'F'   │ 1987-12-03T00:00:00 │ 2013-11-25T00:00:00 │  'HR Assistant' │ 58000  │   102   │ 'VWXPY9012F' │ 1002 │
│    8    │ 1009 │ 'David Miller' │  'M'   │ 1989-06-27T00:00:00 │ 2016-04-10T00:00:00 │  'Accountant'   │ 64000  │   103   │ 'ZABPC3456G' │ 1003 │
└─────────┴──────┴────────────────┴────────┴─────────────────────┴─────────────────────┴─────────────────┴────────┴─────────┴──────────────┴──────┘

--- Aggregation Operations ---

Department Statistics (similar to SQL view):
┌─────────┬─────────┬────────────────────────┬─────┬────────────────┬───────────────┐
│ (index) │ dept_no │          name          │ noe │ total_basic_pay │ employee_count │
├─────────┼─────────┼────────────────────────┼─────┼────────────────┼───────────────┤
│    0    │   101   │'Information Technology' │  2  │     142000     │       2       │
│    1    │   102   │          'HR'          │  3  │     136000     │       2       │
│    2    │   103   │       'Finance'        │  3  │     149000     │       2       │
│    3    │   104   │      'Marketing'       │  3  │     144000     │       2       │
│    4    │   105   │     'Operations'       │  2  │      90000     │       1       │
└─────────┴─────────┴────────────────────────┴─────┴────────────────┴───────────────┘

MongoDB connection closed
*/
