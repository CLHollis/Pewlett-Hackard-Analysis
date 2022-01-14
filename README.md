<image src="images/title_on_www.saturdayeveningpost.com-2019-06-how-to-retire-.jpg" width="600" height="400">[^1]   

# Mission
Baby boomers are retiring at Pewlett-Hackard and the company needs to help preparing for the volume of retirees (preparing retirement packages) and impact on the shift in job roles (such as new hires to replace vacant positions).  Finding out who will be retiring and how many positions will need to be filled is just the start. Building on the module code and datatables...
   1. Find the number of retiring employees grouped by title.
   2. List the retirees eligible to participate in a mentorship program.

# Resources
-	Software: Visual Studio Code, 1.63.0 | pgAdmin for PostgreSQL 14
- ERD tools: [Quick Database Diagrams](https://www.quickdatabasediagrams.com/)
-	Data Provided [6 .csv files in Data folder](Data)

# MODULE Process & Results
  
  1. Using provided [Data](Data), Create ERD using [Quick Database Diagrams](https://www.quickdatabasediagrams.com/) 
  
     <image src="images/EmployeeDB.png" width="400" height="500">

  2. Create a database: Right-click on "PostgreSQL 14" > hover over "Create" > pop-up menu: "Database" > Name it something relevant to the data it will house. 

  3. Create [schema.sql](Queries/schema.sql)  to import tables into pgAdmin using PostgreSQL

  4. Import data from tables: Right click on the table > Import/Export

# CHALLENGE Process & Results 
       
[Employee_Database_challenge.sql](Queries/Employee_Database_challenge.sql)
       
### Mission 1: Find the number of retiring employees grouped by title.
       
1. Create a [Retirement Titles](retirement_titles.csv) table using the `JOIN` function that holds all the titles of employees who were born between January 1, 1952 and December 31, 1955. Use `SELECT COUNT (emp_no) FROM retirement_titles` to find total eligible retirees: 133,776.
              
    <image src="images/retirement_titles.png" width="600" height="450">
      
2. There are duplicate entries for some employees because they have switched titles over the years. Create a [Unique Titles](unique_titles.csv) table with the function `DICTINCT ON` the employee number column to remove any duplicates by keeping only the most recent title of each employee. Also, filter out the people no longer employed at Pewlett-Hackard. Use `SELECT COUNT (emp_no) FROM unique_titles` to find the total: 72,458.
              
    <image src="images/unique_titles.png" width="455" height="450">
       
3. Create a [Retiring Titles](retiring_titles.csv) table using the `COUNT` on the title column to group the retiring employees by their most recent job title.
              
    <image src="images/retiring_titles.png" width="400" height="400">   

### Mission 2: 
4. Create a [Mentorship Eligibilty](mentorship_eligibilty.csv) table  that lists the retirees eligible to participate in a mentorship program. To do this we must join the Employees table, Departments table, and Titles table. Use the `DISTINCT ON` function on the Employee.Employee_Number to remove duplicates. Use the `WHERE` `BETWEEN` & `AND` functions to keep only eligible retirees (DOB in 1965 & still employed). Total = 1,549 eligible mentors.
      
<image src="images/mentorship_eligibilty.PNG" width="650" height="635"> 
   
## Summary
Two additional questions that could help the manager prepare are:
1. What are the total salaries of retirees so the company knows how much it can allocate to filling empty positions?
      
      [Total Salaries Retiring](total_salaries_retiring.csv)
   
      $ 81,583,447.00
   
      <image src="images/total_salaries_retiring.PNG" width="600" height="400"> 
         
2. Break that down by department.  *Note: they could reallocate funds and/or create new departments too.
      
      [Total Salaries Retiring by Department](total_salaries_retiring_by_dept.csv)
      
      | Salary Total | Department Name |
      | ---: | --- |
      | $ 5,802,278 | Customer Service |
      | $ 19,113,866 |	Development |
      | $ 3,735,618	| Finance |
      | $ 4,302,239	| Human Resources |
      | $ 7,218,620	| Marketing |
      | $ 15,984,009 | Production |
      | $ 3,885,346	| Quality Management |
      | $ 4,848,115	| Research |
      | $ 16,693,356 | Sales |
        
      <image src="images/total_salaries_retiring_by_dept.PNG" width="500" height="550"> 
  

[^1]: [The Saturday Evening Post. "How to Retire" by Dan Freedman](https://www.saturdayeveningpost.com/2019/06/how-to-retire/). Accessed Jan. 8, 2022.
