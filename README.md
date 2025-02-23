# Employee-table
The Employees table is a key table in the database that holds information about all employees within the organization.
 It stores essential details such as personal information, employment history, job position, salary, and department.
This table helps with employee management and is central to various reporting, payroll, and performance tracking systems
**Description of Columns**
employee_id: A unique identifier for each employee. This is the primary key of the table.
first_name: The employee's first name.
last_name: The employee's last name.
email: A unique email address for the employee used for internal communication.
phone_number: The employee’s contact phone number. This field is optional.
hire_date: The date the employee officially joined the company.
job_title: The employee's position/job role within the company (e.g., Software Developer, HR Manager).
salary: The annual salary of the employee. This field is a decimal with two decimal places.
commission_pct: If the employee earns a commission (e.g., salespersons), this field stores the commission percentage. This is optional and may be null.
manager_id: The ID of the employee's direct manager. This is a foreign key reference to the employee_id in the same table, allowing for a hierarchical reporting structure.
department_id: The ID of the department where the employee works. This is a foreign key reference to a Departments table (not shown here), enabling proper categorization of employees by department.
status: The employment status of the employee (e.g., Active, On Leave, Retired). This field helps track the current employment state.
**Relationships**
Self-Referencing Relationship: The manager_id column establishes a relationship with the same table, indicating an employee’s manager.
Foreign Key (Departments): The department_id column references the Departments table, which contains information about the different departments in the organization.
**Conclusion**
This table is central to the organization’s HR system, enabling effective management and reporting of employee data.
 Properly managing and securing access to the Employees table is critical to maintaining employee confidentiality and data integrity.
