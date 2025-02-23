create database github;
use github;
-- table creation--

CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY, -- Department ID (Primary Key)
    dept_name VARCHAR(50) NOT NULL -- Department Name
);

-- insert comments--
INSERT INTO departments (dept_name) 
VALUES ('Sales');
-- Department 2: Engineering
INSERT INTO departments (dept_name) 
VALUES ('Engineering');
-- Department 3: HR
INSERT INTO departments (dept_name) 
VALUES ('HR');
-- Department 4: Marketing
INSERT INTO departments (dept_name) 
VALUES ('Marketing');
-- Department 5: Finance
INSERT INTO departments (dept_name) 
VALUES ('Finance');
select * from departments;
-- creating a second table
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY, -- Employee ID (Primary Key)
    emp_name VARCHAR(50), -- Employee Name
    dept_id INT, -- Department ID (Foreign Key)
    salary DECIMAL(10, 2), -- Employee Salary
    job_title VARCHAR(50), -- Job Title of the employee
    hire_date DATE, -- Hire Date of the employee
    manager_id INT, -- Manager ID (References emp_id)
    promotion_date DATE, -- Date of last promotion
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id), -- Foreign Key linking to departments
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id) -- Foreign Key linking to another employee (Manager)
);
-- insert comments

INSERT INTO employees (emp_name, dept_id, salary, job_title, hire_date, manager_id, promotion_date)
VALUES ('Alice Johnson', 1, 60000.00, 'Manager', '2020-05-20', NULL, '2022-01-15'),
 ('Bob Smith', 1, 50000.00, 'Engineer', '2021-08-10', 1, NULL),
 ('Charlie Brown', 2, 55000.00, 'Engineer', '2019-04-17', 1, '2021-09-12'),
('David Williams', 3, 65000.00, 'Manager', '2018-11-21', NULL, '2022-05-10'),
 ('Eve Davis', 2, 70000.00, 'Engineer', '2017-02-12', 3, '2020-07-20'),
 ('Frank Miller', 4, 25000.00, 'Intern', '2022-02-05', 1, NULL),
  ('Grace Lee', 3, 58000.00, 'HR Specialist', '2021-06-15', 3, '2022-01-01'),
   ('Henry Clark', 4, 48000.00, 'Marketing Specialist', '2020-03-10', 1, '2021-05-25'),
   ('Iris Johnson', 5, 55000.00, 'Finance Analyst', '2019-11-01', 3, '2021-08-20'),
   ('Jack Turner', 2, 68000.00, 'Software Engineer', '2021-09-30', 1, '2022-03-10'),
   ('Kelly Adams', 1, 70000.00, 'Product Manager', '2019-07-25', 1, '2021-11-05');
   
   select * from employees;
   
   
#1.Retrieve the employee names, salaries, and departments from the Employees table for employees who earn more than the average salary of all employees.
select emp_name,salary,job_title from employees where salary>(select avg(salary) from employees);
#2.List the department IDs and names for all departments, showing how many employees belong to each department, sorted by the number of employees in descending order.
SELECT employees.dept_id, departments.dept_name, COUNT(employees.emp_id) 
FROM employees
JOIN departments ON employees.dept_id = departments.dept_id
GROUP BY employees.dept_id
ORDER BY COUNT(employees.emp_id) DESC;
#3.Show the names of employees who are either in department 2 or department 4 and whose salary is between 30000 and 50000.
select emp_name from employees where dept_id in(2,4) and salary between 30000 and 50000;
#4 Get the names of employees who joined after January 1, 2021, and earn more than the average salary of employees who joined before that date.
select emp_name from employees where hire_date>= "2021-01-01" and salary>(select avg(salary) from employees where hire_date<="2021-01-01");
#5. Display the names and salaries of employees, but exclude employees whose names start with 'A' or 'B'.
select emp_name,salary from employees where emp_name not like"a%" and emp_name not like "b%";
#6.Retrieve the employee names, their departments, and the date of their last promotion (assuming you have a promotion_date column), only for employees who have been promoted after 2019.
select emp_name,dept_id,hire_date from employees where year(promotion_date )>"2019";
#7.Get the department name and the average salary of employees in each department, but only for departments where the average salary is above 40000.
#select dept_id,avg(salary)as average_salary from employees  group by dept_id having avg(salary)>=40000;
SELECT departments.dept_name, AVG(employees.salary) AS average_salary
FROM employees
JOIN departments ON employees.dept_id = departments.dept_id
GROUP BY departments.dept_name
HAVING AVG(employees.salary) > 40000;
#8.Show the names of employees who either have "Manager" in their job title or work in department 3, and order the results by salary in descending order.
select emp_name from employees where job_title ="manager" or dept_id=3 order by salary desc;
#9.Retrieve the names of employees who work in departments 1, 2, or 5, and whose salary is greater than the average salary in department 2.
select emp_name from employees where dept_id in(1,2,5) and salary>(select avg(salary) from employees where dept_id=2);
#10. Find the employee with the highest salary in each department, showing the department name and the employee's name and salary.
select e.max(salary),e.emp_name from employees as e join departments as d on e.emp_id=d.emp_id
group by emp_id
having max(e.salary);
#11.Display all employees whose salaries are between 20000 and 60000, but also include the total salary in each department.
SELECT dept_id, SUM(salary) AS total_salary
FROM employees
GROUP BY dept_id
HAVING SUM(salary) BETWEEN 20000 AND 60000;
#12.Show the employee names and the names of their managers (assuming there is a manager_id column in the Employees table that links to emp_id), only for employees working in departments 3 and 4.
#select emp_name,manager_id,dept_id from employees where dept_id in(3,4);
#13.Retrieve the department names and the number of employees in each department, but only include departments that have at least 3 employees, sorted by department name.
SELECT d.dept_name, COUNT(e.emp_id) 
FROM departments d
JOIN employees e ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING COUNT(e.emp_id) >= 3
ORDER BY d.dept_name DESC;
#14.Display the names of employees who earn more than the highest salary in department 5 and sort the results by employee name.
select emp_name from employees where salary>(select max(salary) from employees where dept_id=5) order by emp_name;
#15. Get the names and salaries of employees who earn more than 50000 and work in departments 1, 2, or 3. Exclude employees with 'Intern' in their job title.
select emp_name, salary from  employees where salary>50000 and dept_id in(1,2,3) and job_title<>"Intern";
#16. Retrieve the department names and the total salary of employees working in each department, only for departments where the total salary exceeds 100000.
select d.dept_name,sum(e.salary) from departments as d join employees as e on
d.dept_id=e.dept_id
group by d.dept_id
having sum(e.salary)>100000;
#17. Show the names of employees and their hire dates, but only for those who were hired between January 1, 2019, and December 31, 2020, and order them by hire date
select emp_name,hire_date from  employees where hire_date between "2019-01-01" and "2020-12-31" order by hire_date;
#18.Find the average salary of employees who are not in department 1, but only for employees who have been working for more than 5 years.
select avg(salary) as average_salary from employees where dept_id!=1 and timestampdiff(year,hire_date,curdate())>5;
select * from employees;
#19. Retrieve the names of employees who were hired in 2021 and earn less than the highest salary in the Employees table.
select emp_name from employees where year(hire_date)="2021" and salary <(select max(salary) from employees); 
#20. Show the names of employees whose salaries are above average in their department, but exclude those with more than 10 years of experience (assuming there is a hire_date column).
SELECT e.emp_name, e.salary, e.hire_date
FROM employees e
JOIN employees e2 ON e.dept_id = e2.dept_id
GROUP BY e.emp_name
HAVING e.salary > AVG(e2.salary)
   AND TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE()) <= 10;






 



