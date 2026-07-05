-- DDL Commands

use mydb;

create table employees(
id int primary key auto_increment,
name varchar(50) not null,
salary decimal(10,2),
dept_id int,
joined_date date default (current_date())
);