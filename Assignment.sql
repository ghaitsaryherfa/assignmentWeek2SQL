# setting autocommit
set sautocommit=0;

# start transaction
start transaction;

# before transaction
select * from offices;

# transaction 
# insert 5 record and commited
insert into offices
(officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory)
values
("8", "Bandung", "+6285123457", "K2 Gading Regency", "Block K", "Jawa Barat", "Indonesia", "40012", "ID"),
("9", "Bagdad", "+71129971", "177 Camel tree", "Apt 9F", "Bagdad", "Arab", "SAU 1287", "Arab"),
("10", "NYC", "+44187892811", "Orchid Street", "Suite 1203", "NY", "USA", "OST 1002", "WDC"),
("11", "Melbourne", "+2219829102", "Riverside Road", "Apt 5", "Aussie", "Australia", "109827", "Melbourne"),
("12", "Makudonarudo", "+67889021", "Hambaga Street", "Suite 10", "Tokyo", "Japan", "JPN 117", "Tokyo");

commit;

# after insert 5 record and commited
select * from offices order by cast(officeCode as unsigned);

# transaction insert/update/delete record 
insert into offices
values
("13", "Oregano", "+1 789 6541 322", "Park Venue", "Apt 101", "Zoho", "Italy", "EST 1903", "Roma");

# read table after insert
select * from offices order by cast(officeCode as unsigned);

# transaction rollback 
rollback;

# after rollback
select * from offices order by cast(officeCode as unsigned);

# SUBQUERY
# before SUBQUERY
select * from employees;

# subquery select statement
select * from employees
where officeCode in
(select distinct officeCode from employees where officeCode = "3");

# subquery insert statement
insert into employees_backup
select * from employees
where firstName in
(select firstName from employees where firstName like '%e');

#subquery update statement
update employees
set jobTitle = "Accounting"
where officeCode in
(select distinct officeCode from employees_backup where officeCode = "2");

# subquery delete statement
delete from employees_backup
where extension in
(select extension from employees where extension like '_2%');

# subquery filter statement from column max value
select * from payments
where amount = (
    select max(amount) from payments);

# show record before subquery sebagai source data 
select * from offices;

select * from employees;

# subquery sebagai source data
select e.employeeNumber, e.lastName, e.firstName, e.jobTitle, e.officeCode,
o.phone, o.addressLine1, o.city
from (select * from employees where jobTitle like "VP%") as e
left join offices as o
on e.officeCode = o.officeCode;

# Combine query UNION
select officeCode from employees
UNION
select officeCode from offices;

# Combine query Intersect
select lastName, firstName, jobTitle from employees
Intersect
select lastName, firstName, jobTitle from employees_backup;

