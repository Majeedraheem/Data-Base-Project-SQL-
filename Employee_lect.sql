#how to load data into table after creation LOAD DATA INFILE '/home/paul/clientdata.csv' INTO TABLE CSVImport;

#LOAD DATA INFILE "/home/paul/clientdata.csv"
#INTO TABLE CSVImport
#COLUMNS TERMINATED BY ','
#OPTIONALLY ENCLOSED BY '"'
#ESCAPED BY '"'
#LINES TERMINATED BY '\n'
#IGNORE 1 LINES;

use employees;
#select employees from table employee;
select * from employees where emp_no = emp_no;

#I'm retrive information about the employee and thier departements which is not in employee table
#its on the department table so forigner and praimary key connection is required  
select * from employees where emp_no = emp_no and  dept_no = emp_no ;
SELECT 
    *
FROM
    employees
WHERE
    employee.emp_no = dept_manager.emp_no and dept_manager.dept_no=departments.dept_no ;
SELECT 
    *
FROM
    departments;
    #checking the employees who's name is denis ;
    select * from  employees where first_name ='denis';
    
######operator and & or 
#checking employees firsname is denis  and gender is male  ;
SELECT 
    *
FROM
    employees
WHERE
    gender = 'M' and first_name='denis';
    
    #checking emmployee first name is kellie or first name is aruna ;
    select 
    * 
    from 
	employees 
    where first_name = 'kellie' or first_name = 'aruna'; 
    #if you want to apply and ,or operators at the same time because sql will always preforme and opertaor first 
    #so to make the object combain both condtion u need to have PRANTSES () after and operator 
    #if 'UNKNOWN' gender been added thats why u can check only both genders F M
    #checking one condition and two anthor addtion condtions to all be true 
    #sql consider the first condition si.mul.ta.ne .ous,ly
    #Example 
    select
    * 
    from 
    employees 
    where first_name ='denis' and (gender='F' or gender='M');
    #here the code below is less memory consuming is more into optmization:
    select * from employees where first_name in ('denis','elvis') and(gender='F');
    
    ########operator number 3 is IN is what tell Sql if they are is values are exisit get them all 
    #it faster insted of apply or operater on ccondtion 
    #here is the sql structure is quicker to fitch the data 
  SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Cathie' , 'mark', 'nathan');
    # here how you can get all the data except these 3 names ;
    SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('Cathie' , 'mark', 'nathan');
    ######### operater like%  :
#example for pattren match 
select * from employees where first_name like ('%ar');

#only match the end with ar
select * from employees where first_name like ('ar%');

#select with _ if want to have only pattren with specific number of letters 
select * from empolyees where first_name like('mar_');

#date is special when u tryong to fitch data with spesific date u need %date% 
select * from employees where hire_date like('%2000%');
select * from employees where hire_date like ('%2000_%');

# fitching data with like with interger coulmn
select * from employees where emp_no like('1000__');
select * from employees where first_name like ('%jack%');
select * from employees where first_name not like ('%jack%');

#operator BETWEEN & AND:
select * from salaries where salary  between 60000 and 80000;

#operator IS NOT NULL which is that field not null
#check the first name is null or not 
select * from employees where first_name is not null ;
select * from employees where first_name is null;
#note data need to be between quods in order to comapre in condition number could and couldnt wont make different 
#the different about data type DATES ARE DIFFERENT
select * from employees where hire_date >= '2000-01-01' and gender ='F' ;
select * from salaries where salary >= '152000';

#DISTINCT
select  distinct count(*) first_name from employees;
select distinct hire_date from employees;

# ORDER BY works for both numberic and string and you also can order by more than one column 
select * from employees order by hire_date;

#you can not order by more then one column if you oder by data at the first all other will be ignored 
#and its by default is ascending ASC
 select * from employees order by hire_date , first_name;
 
select * from employees order by first_name,last_name asc;
select * from employees order by hire_date desc;

######aggregate functions:


#count count non null value,max,vag,min
#no space after count
#count will not count null values so you cant check the null values with 
#1: count:
select count(*) from employees;
select count(emp_no) from employees;
# how many distict empolyees we have according to thier naame 
select count(distinct first_name) from employees;
	#how many employees had salaries higher than 100,000
select count(salary >= 100000) from salaries;
	#how many managers do we have in employees database 
    
select count(*) from dept_manager;

#2: GROUPBY:
	#group by will only select the distinct values ONLY example below it will just display the first_name and how many times 
    #this name appreas
    #  check the prantesis () for the count its the only way that the first_name shows with group by 
    /*whatsoever you selected on the group stateme*/
    
	SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name 
ORDER BY first_name
;
#Aliases is 
select first_name,last_name, count(first_name) as names_counts
from 
employees
group by first_name ,last_name
order by first_name
;
#excercise :
#Write a query that obtains an output whose first column must contain annual salaries higher than 80,000 dollars. 
#The second column, renamed to “emps_with_same_salary”, must show the number of employee contracts signed with this salary.
select  salary, count(emp_no) as emps_with_same_salary
from salaries 
where salary > 80000
group by salary  
order by salray;

#test how salray result will be without count 
select salary , count(salary) 
from salaries
where salary > 80000
group by salary 
order by salary desc ;
    
   # SHOW VARIABLES LIKE 'sql_mode';
   #HAVING need to be iserted between group by and ORDER BY having is like where but it apply on the group by block 
    
# we have to use "HAVING" mysqol keyword which is tell the object to get what we looking for inside the group condition 
use employees;
select hire_date,count(hire_date) as no_emphire_date_hire_date
from 
employees
group by hire_date
having count(hire_date) >= '1969-01-01'
order by hire_date ;
### Example  how many numbers each name show from employee have shown more than 250 times 
select first_name, count(first_name) as names_count 
from employees
group by first_name
having count(first_name)>250
order by names_count desc;

#Select all employees whose average salary is higher than $120,000 per annum.
#Hint: You should obtain 101 records.;



select avg(salary) , emp_no 
from salaries 
group by  emp_no
having  avg(salary)>120000
order by emp_no
;
#code below is not functioning 
select avg(salary), emp_no
from salaries
where avg(salary) > 120000# you cant use aggration function in where codition 
group by avg(salary)
order by avg(salary)
;

select avg(salary),emp_no
from salaries 
where salary > 120000
group by emp_no 
order by emp_no
;

# Extract  list of all names tat are encountered less than 300 times and begin hired after the 1st of january 1999
#aggragte by the first_name 
select first_name ,count(first_name) as no_names 
from employees 
where hire_date > '1999-1-1'
group by first_name 
having count(first_name) < 300
order by first_name desc
limit 300
;
#select first rows from dept_emp table'
select * from dept_emp limit 200;

;

#Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000
use employees ;

select emp_no ,count(from_date) as no_dates
from dept_emp
where from_date > '2000-01-01'
group by emp_no
having count(from_date) > 1
order by emp_no
;

# limit statement always check with what u order by 
select * 
from salaries 
order by salary desc
limit 10 
;
#insert same order u need to have ur values into  

insert into employee
( 	emp_no,
	birth_date,
	first_name,
	last_name,
	gender,
	hire_date
)values(
	999901,
    '2020-01-01',
    'covid_19',
    'carona',
    'virus',
    '2020-02-01'
);
#insert without column names 
insert into employee 
values(
	999999,
    '2020-01-01',
    'covid_19',
    'carona',
    'virus',
    '2020-02-01');
      
# insert into table 2 from table one with condition example:

create table dept_duplicate (
dep_no char(4) not null,
dept_name varchar(255) not null  
);
insert into dept_duplicate (
	dep_no,
	dept_name
)
select * from departments;
# after i inserted that data i need to select to make sure that data is sucessfuly inserted 
 insert into departments VALUES ('do10','data scientist');
 #for more accurcey need drop the data again because the data was inserte
 select * from departments 
 order by dept_no
 limit 10 ;# avioding many records  in decending order how many record manager looking for 
 select * from departments;

select * from salaries ;

#Exercise 1: Select ten records from the “titles” table to get a better idea about its content.
#Then, in the same table, insert information about employee number 999903. State that he/she is a “Senior Engineer”, 
#who has started working in this position on October 1st, 1997.
#At the end, sort the records from the “titles” table in descending order to check if you have successfully inserted the new record.
SELECT
   *
FROM
   dept_emp
ORDER BY emp_no DESC
LIMIT 10;
insert into dept_emp
(
	emp_no,
   dept_no,
   from_date,
   to_date
)
values
(
   999907,
   'd09',
   '1997-10-01',
   '9999-01-01'

);

select * from titles
limit 10 ;

insert into titles values(999905,'Senior Engineer','1997-10-01','9999-1-1');
use employees ;
select  * from employees
order by emp_no desc 
limit 10;

# UPDATE 
# check to update 
select * from employees where emp_no=499901;
#where is curcil in update command you should have WHERE if U DONT THE ALL TABLE WILL BE UPDATED WITH VALUES
#thats why we need COMMIT AND RROLL BACK BETWEEN THE UPDATE STATEMENT 
update employees set first_name='majeed',last_name='Raheem',birth_date='1982-04-11',gender='M',hire_date='2020-05-05' 
where emp_no=499901;

#u need to check the last 10 rows so u can add new or update from the last record 
select * from employees 
order by emp_no desc
limit 10;

#commit and rollback 
select * from dept_duplicate order by dep_no;
commit;
#please note that you are working on safe moood 
update dept_duplicate set dep_no='d011', dept_name='Control';
Rollback;#u are rolling back the last update command
update  dept_duplicate set dept_name ='Data Analysis'
where dept_name = 'Research';
commit; 
#Delete statement :
#delete from table_name where condition 
use employees ;
commit;
#
delete from employees where emp_no =999903;
select * from employees where emp_no=999903;
#always when u use delete u need to have where cluse because it will delete the whole table 
#Remove the department number 10 record from the “departments” table.
commit;
delete from departments where dept_no='do10';

#summarizing fuction : aggragate functions
#count wont count null values only if u use count(*) and count is applicable for numeric and chartcters 
#aggregate fuction typically ignore null values throught the field to which they are applied 
use employees;
select count(*)
from employees ;
#How many departments are there in the “employees” database? Use the ‘dept_emp’ table to answer the question.
select count(dept_no) from departments ;
select count(distinct dept_no) from departments;

#check how much the company spending 
select sum(salary) from salaries ;
# all other fuctions work only with numeric data and * only work with count function 
#What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997?

select sum(salary) from salaries where from_date > '1997-01-01';
#min and max 
select max(salary) from salaries ;
select min(salary) from salaries;
#1. Which is the lowest employee number in the database?
 select min(emp_no) from employees;
#2. Which is the highest employee number in the database?
select max(emp_no) from employees;
#What is the average annual salary paid to employees who started after the 1st of January 1997?
select avg(salary) from salaries where from_date > '1997-01-01'; 
#Round function 
select round(avg(salary)) from salaries where from_date > '1997-01-01'; 
#u can defined how many decimal as below 
select round(avg(salary,2)) from salaries where from_date > '1997-01-01'; 
#IFNULL()and COALESCE() used to subsitte the null value with values you need to 
select * from dept_duplicate;
#rename column 
alter table dept_duplicate 
rename column dep_no to dept_no;
#lets change the dept_duplicate table column 
alter table dept_duplicate 
change column dept_name dept_name varchar(50) null ;
insert into dept_duplicate(dept_no) values ('d010'),('d011');
select * from dept_duplicate 
order by dept_no desc;
# add coulmn to dept_manager to dept_duplicate and placed next to dept_name with AFTER  
alter table dept_duplicate 
add column dept_manager varchar(255) null after dept_name ;
commit ;
#if null how it works IFNULL only take two pqramters no more if the variable is not null then it display the the intial value from 
select * from dept_duplicate;
select dept_no, ifnull(dept_name,'departme nt name not provided ') as 'Department Name ' from dept_duplicate;  
#coalesce can take more than two paramters and will always return single value of the ones we gave  within parenthese and this value will be 
#the first non-null value of this list reading the value from the left to right 
#both isnull and coalesce() are not making any changes on dataset ;
select 
	dept_no,
	dept_name ,
	coalesce(dept_manager, dept_name,'N/A') As dept_manager 
	from dept_duplicate 
	order by dept_no asc;
#Exercise 1: Select the department number and name from the ‘departments_dup’ 
#table and add a third column where you name the department number (‘dept_no’) as ‘dept_info’. 
#If ‘dept_no’ does not have a value, use ‘dept_name’
select 
dept_no,
dept_name, 
coalesce(dept_no , dept_name) as dept_info 
from dept_duplicate
order by dept_no asc;
#Exercise 2: Modify the code obtained from the previous exercise in the following way. 
#Apply the IFNULL() function to the values from the first and second column, so that ‘N/A’ is displayed whenever a department number has no value, and 
#‘Department name not provided’ is shown if there is no value for ‘dept_name’.
select 
ifnull(dept_no , 'N/A') as dept_info ,
ifnull(dept_name,'Dept name not provided') as dept_name,
from dept_duplicate
order by dept_no asc;

SELECT

   IFNULL(dept_no, 'N/A') as dept_no,

   IFNULL(dept_name,

           'Department name not provided') AS dept_name,

   COALESCE(dept_no, dept_name) AS dept_info

FROM

   departments_dup

ORDER BY dept_no ASC;

use employees ;
commit;

commit;
#alter table dept_duplicate 
#change column dept_no to null ;
#alter table dept_duplicate modify dept_name varchar(255) null;
#alter table dept_duplicate modify dept_no char(4) null;
#copy data from table to another 
#insert into dept_duplicate (dept_name,dept_no)
#select dept_name , dept_no,now(),'Pending','Assigned'
#from departments;
# copy data from table to another easy way 
#insert into dept_duplicate select * from departments ;

delete from dept_depluicate where dept_no='d002';

drop table if exists dept_manager_dup;
create table dept_manager_dup
(
	emp_no int(11) not null,
    dept_no char(4) null,
    from_date date not null,
    to_date date null
    );

INSERT into dept_manager_dup select *
from dept_manager;

insert into dept_manager_dup(emp_no,from_date)
values ('999904','2017-01-01'),
		('999905','2017-01-01'),
        ('999906','2017-01-01'),
        ('999907','2017-01-01')
;
alter table dept_duplicate
drop column dept_manager ;

alter table dept_duplicate 
change column dept_no dept_no char(4) null;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;


delete from dept_manager_dup
where dept_no='d001';

insert into dept_duplicate(dept_name) values('Public Relations');
delete from dept_duplicate where dept_no='d011';
insert into dept_duplicate(dept_no) values ('d010'),('d011');
# different sqls have different sets of limits how the group by clause can be applied 
# u need to reconfigured sql_nmode 
#to view the configuration of sql_mode here is command :select @@global.sql_mode;
select @@global.sql_mode;
#after you apply the command above there are many variables 
#One of these values, ‘only_full_group_by’, blocks certain type of group statements and that can potentially lead to Error Code 1055. 
#The latter signifies the problem of listing fields in the SELECT statement that are not included in the GROUP BY clause.
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');
#REPLACE() is the function that will remove the “only_full_group_by” value from the expression here. 
#Thus, error 1055 will not show up in the future
#Finally, if for some reason you’d like to disallow this behavior 
#you can always execute the following command which will do exactly the opposite: it will add the “only_full_group_by” value to the expression.
#  set @@global.sql_mode := concat('ONLY_FULL_GROUP_BY,', @@global.sql_mode);
#That said, we must also add that there is a reason behind this functionality.-
#-If you think about it, it is not logical to allow a column value to be listed in the output alongside a value that has been included in -
#-the GROUP BY clause of the query. We just cannot be sure that the not-grouped value that has been retrieved is going to be correct. But for the sake of our exercises, 
#and for the purpose of making them clearer, we have allowed such syntax.

#GETTTING READY FOR JOIN 
alter table dept_duplicate change dept_no dept_no char(4)null;

#inner venn diagram is the matching result also called matching records you join tow tables with one column then 
#the result is the result set is the matching record between the two tables lets demostrate 
#table dept_manager_dup
use employees;
select * from dept_manager_dup
order by dept_no;
select * from dept_duplicate order by dept_no;

#JOIN JOIN JOIN INNER NEED TABLES NAME 
#select we write what we want to show in the select we spesifiy the tables table.column_name 
#u select from different tables so u need to mentation the table names first and from which table and join the another table does sequence matter ?
#
#select table1.coulmn_name1 table2.column_name2 from table1 join table2 ON table1.column_name =  table2.column_name (matching values) ;
#fundemental practices : from table 1 as t2 join table 2 as t2 you dont use alises 
#select t1.coulmn_name1 t2.column_name2 from table1 t1 join table2 t2 ON t1.column_name =  t2.column_name (matching values)
#Exersice Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date.
   use employees;
   
   select em.first_name, em.last_name, d.dept_no, d.from_date
		from employees em
        join dept_manager_dup d on em.emp_no = d.emp_no
        order by first_name desc
   ;

# join tow table dept_manager_dup and dept_duplicate  to optain list of managers and thier department name and no
#notes : on join you can add as many column you want unless these two column are in both tables which the joined tables 
#inner join is join u dont need to write it 
# u need table indication when u use large big hunge data sets  the  in order calsue 
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    dept_duplicate d ON m.dept_no = d.dept_no
    order by d.dept_no
    ;
    
    #duplicates record handeling :
    #group by the field that differs most among records 
    insert into dept_manager_dup values('110228','d003','1992-03-21','9999-01-01');
    insert into dept_duplicate values('d009','Customer Services');
    SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    dept_duplicate d ON m.dept_no = d.dept_no
    order by d.dept_no;
        
#NEED GROUP BY 
    SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    dept_duplicate d ON m.dept_no = d.dept_no
	group by m.emp_no
    order by d.dept_no
   ;
#Remove & delete the duplicate records 
delete from dept_duplicate where dept_no='d009';
delete from dept_manger_dup where emp_no='110228';

insert into dept_manager_dup values('110228','d003','1992-03-21','9999-01-01');
insert into dept_duplicate values('d009','customer services');

#left Join : 
#left outer join is the same you dont need to write 
#all list from the left that will always begin showed 
#  order of joining two tables matter how 
#join is example of one to many realtionship 
select d.dept_no,d.dept_name ,m.emp_no
from dept_duplicate d
left join  
dept_manager_dup m on m.dept_no=d.dept_no
order by m.dept_no
;

select * from dept_duplicate order by dept_no;
# how to get the null 
select * from dept_manager_dup order by dept_no;
# the table thats came after from is the join table column where all the values will appears and the other table matches will be too 
select m.dept_no,d.dept_name ,m.emp_no
from dept_manager_dup m
left join  
dept_duplicate  d on m.dept_no=d.dept_no
where dept_name is null
order by m.dept_no
;


select * from dept_duplicate order by dept_no;
select * from dept_manager_dup order by dept_no;

# u need to order by first selection which is dept_no indicate that the left table is the left join " from my the table that i want to left join the 
#other table which is come next after the left join 

select d.dept_no,d.dept_name ,m.emp_no
from dept_duplicate d
left join  
dept_manager_dup m on d.dept_no=m.dept_no
order by d.dept_no
;
#Exercise:

#Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. 
#See if the output contains a manager with that name.  

#Hint: Create an output containing information corresponding to the following fields: ‘emp_no’, ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’. Order by 'dept_no' descending, and then by 'emp_no'.
select m.emp_no , m.last_name ,m.first_name,d.dept_no ,d.from_date
from employees m
left join dept_manager d on m.emp_no = d.emp_no
where m.last_name = 'Markovitch'
order by d.dept_no desc, m.emp_no;
#Apply where to have same left join effect where is more consuming time and its not professtional 
select m.dept_no , m.emp_no ,d.dept_name 
from dept_manager_dup m,
	 dept_duplicate d
where d.dept_no = m.dept_no
order by m.dept_no
;
#Exercise:

#Extract a list containing information about all managers’ employee number, first and last name, 
#department number, and hire date. Use the old type of join syntax to obtain the result.

select m.first_name , m.last_name ,d.dept_no,d.from_date
from employees m,
	 dept_manager_dup d
where m.emp_no=d.emp_no
order by d.emp_no
;
#based on what condition to extract data from tables 
select e.emp_no,e.first_name, e.last_name, e.birth_date, s.salary
from employees e
join 
salaries s on e.emp_no=s.emp_no
where salary > 145000
group by  m.emp_no desc
; 
#Exercise:

#Select the first and last name, the hire date, and the job title of all employees whose first name is 
#“Margareta” and have the last name “Markovitch”.
select e.emp_no, e.first_name,e.last_name, e.hire_date ,t.title
from employees e
left join titles t on e.emp_no = t.emp_no
where e.first_name ='Margareta' and e.last_name='Markovitch'
order by e.emp_no
;
#inner join will connects only the matching values 
#cross join is connects all the values, not just those that match 
#the cartesian product of values of two or more sets meani all possible compination between values 
#particularly useful when the tabkes ub database are not well connected 
use employees;
#same as join result except no condtion 
select dm.*, d.*
from dept_manager dm
cross join 
departments d
order by dm.emp_no ,d.dept_no ;
#same as JOIN  only different is ON you writing in join  however in cross join you dont best pratctics 
select dm.*, d.*
from dept_manager dm
join 
departments d

;
#display all departement with the managers that they are head of 
select 
	dm.* , d.*
from 
	departments d 
cross join 
	dept_manager dm
where d.dept_no <> dm.dept_no
order by dm.emp_no , d.dept_no
 ;
 
 select 
	e.* , d.*
 from 
	departments d
 cross join 
	dept_manager dm
	join 
    employees e on dm.emp_no = e.emp_no 
    order by dm.emp_no , d.dept_no
    ;
    #Exercise 1:

#Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9.
#order of the table crossing it doesn't matter same result will always how up not the left join it matters 
select dm.*,d.*
from dept_manager dm
cross join departments d 
where d.dept_no ='d009'
order by  d.dept_name 
;
 select dm.*,d.*
from departments d 
cross join dept_manager dm 
where d.dept_no ='d009'
order by  d.dept_name 
;
#Exercise 2:

#Return a list with the first 10 employees with all the departments they can be assigned to. 
select e.*,d.*
from employees e
cross join departments d 
where d.dept_no < 10011 
order by  e.emp_no,ddept_name 
;
#check the AVG salraies for men and women in the comany 
#Error Code: 1140. In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'employees.e.gender'; this is incompatible with sql_mode=only_full_group_by
#u cant group by 
select e.gender , avg(s.salary) as Avarage_salaries 
from employees e 
#bad u can't use cross here its make error connection 
cross join salaries s 
group  by gender 
 ;
 select e.gender , avg(s.salary) as Avarage_salaries 
from employees e 
 join salaries s on e.emp_no= s.emp_no
group  by gender 
 ;
# if you wnat to join more than two table u need to back it with strong intuition and crystal clear 
#idea of how you would like the tables to be connected  
 
 # we want to connect 3 tables employees , departments, salaries
 
 
 select e.first_name,e.last_name , e.hire_date , dem.from_date,d.dept_name
 from employees e
 join dept_emp dem on  e.emp_no=dem.emp_no 
 join departments d on d.dept_no= dem.dept_no
 order by d.dept_no
 ;
  select e.first_name,e.last_name , e.hire_date , dem.from_date,d.dept_name
 from employees e
left join dept_manager dem on  e.emp_no=dem.emp_no join departments d on d.dept_no= dem.dept_no
 order by d.dept_no
 ;
 
 #Exercise:

#we want to know the first and last name for all  managers’ first and last name, hire date, job title, start date, and department name.
 SELECT

   e.first_name,

   e.last_name,

   e.hire_date,

   t.title,

   m.from_date,

   d.dept_name

FROM

   employees e

       JOIN

   dept_manager m ON e.emp_no = m.emp_no

       JOIN

   departments d ON m.dept_no = d.dept_no

       JOIN

   titles t ON e.emp_no = t.emp_no

WHERE t.title = 'Manager'

ORDER BY e.emp_no;


#2nd Solution:



SELECT

   e.first_name,

   e.last_name,

   e.hire_date,

   t.title,
 m.from_date,

   d.dept_name

FROM

   employees e

       JOIN

   dept_manager m ON e.emp_no = m.emp_no

       JOIN

   departments d ON m.dept_no = d.dept_no

       JOIN

   titles t ON e.emp_no = t.emp_no

       AND m.from_date = t.from_date

ORDER BY e.emp_no;
 
 #find the avag salaries for all manager and thier department name 
 select d.dept_name ,  avg(s.salary) as Avge_salries_Managers 
 from dept_manager dm
 join salaries s on  dm.emp_no=s.emp_no
 join departments d on dm.dept_no=d.dept_no
 group by d.dept_name
 ;
 #different approched 
select d.dept_name ,  avg(s.salary) as Avge_salries_Managers 
 from 
 departments d
 join 
 dept_manager dm on dm.dept_no=d.dept_no
 join 
 salaries s on  dm.emp_no=s.emp_no
 group by dept_name #only one column with name dept_name thats why we dont need abbrevation 
 #order by d.dept_no #the department names could be sorted after GROUP BY with filled that we didnt mentaion so we need order by 
 having Avge_salries_Managers > 60000
 order by Avge_salries_Managers DESC #nice to have and more meaniful 
 ;
 
 #Exercise: How many male and how many female managers do we have in the ‘employees’ database?
 use employees;
 select e.gender , d.dept_name ,count(dm.emp_no)
 from employees e
 join dept_manager dm on e.emp_no  =  dm.emp_no 
 join departments d on d.dept_no = dm.dept_no
 group by e.gender 
 order by d.dept_name desc
 ;
 SELECT

   e.gender, COUNT(dm.emp_no)

FROM

   employees e

       JOIN

   dept_manager dm ON e.emp_no = dm.emp_no

GROUP BY gender;

#UNION 
drop table if exists employyes_dup; 
create table employees_dup (
emp_no int(11) not null,
birth_date date,
first_name varchar(255) not null ,
last_name varchar(255) not null ,
gender enum('F','M'),
hire_date date 
)
;
#filling with 20 record 
insert into employees_dup select  e.* from employees e limit 20;
select * from employees_dup;
#we insert duplicate record into 
insert into employees_dup values ('1001','1953-09-02','Georgi','Facello','M','1986-06-26');
select * from employees_dup;
#union rules :
# unionize two tables must be AND TO PERSERVE THE CONFORMSTIR BETWEEN TABBLES : Same number of columns , same name of columns ,Sshould be in the same order, related data type 
#union display only distict values from input 
#union all display the duplicate as all 
#union is meroery counsuming remove duplicate and use union
#union all for better result  
select  
		e.emp_no,
		e.first_name,
		e.last_name,
        NULL AS dept_no,
        null as from_date
	from employees_dup e
        where e.emp_no=10001
	union all select
		null as emp_no,
		null as first_name,
		null as last_name,
		dm.dept_no,
		dm.from_date
	from dept_manager dm 
        ;
        
SELECT

   *

FROM

   (SELECT

       e.emp_no,

           e.first_name,

           e.last_name,

           NULL AS dept_no,

           NULL AS from_date

   FROM

       employees e

   WHERE

       last_name = 'Denis' UNION SELECT

       NULL AS emp_no,

           NULL AS first_name,

           NULL AS last_name,

           dm.dept_no,

           dm.from_date

   FROM

       dept_manager dm) as a

ORDER BY -a.emp_no desc;
#subquries = inner query , nested queries inner selected outer query outer selected
#no need for join here 	
select e.first_name ,e.last_name 
from employees e
where e.emp_no in (select dm.emP_no from dept_manager dm);

#Exercise:

#Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.
select dm.dept_no, dm.to_date , dm.to_date 
from dept_manager dm
where dm.dept_no in (select d.dept_no from  departments d);
#sec try
select dm.dept_no, dm.to_date , dm.from_date 
from dept_manager dm
#where dm.from_date ='1995-01-01' in (select d.dept_no = dm.dept_no from  departments d);
where dm.from_date  in (select dm.from_date = '1995-01-01 'from  dept_manager dm);

SELECT

   *

FROM

   dept_manager

WHERE

   emp_no IN (SELECT

           emp_no

       FROM

           employees

       WHERE

           hire_date BETWEEN '1990-01-01' AND '1995-01-01');
