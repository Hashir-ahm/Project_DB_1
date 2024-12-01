-- Database creation
create database if not exists vendormanagementsystem;
use vendormanagementsystem;

-- 1. department table
create table department (
    departmentid int auto_increment primary key,
    departmentname varchar(100) not null,
    managername varchar(100),
    contactinfo varchar(255)
);

-- 2. vendor table
create table vendor (
    vendorid int auto_increment primary key,
    vendorname varchar(100) not null,
    contactinfo varchar(255),
    servicecategory varchar(100)
);

-- 3. contract table
create table contract (
    contractid int auto_increment primary key,
    vendorid int not null,
    contractterms text,
    startdate date not null,
    enddate date not null,
    foreign key (vendorid) references vendor(vendorid) on delete cascade
);

-- 4. purchaseorder table
create table purchaseorder (
    orderid int auto_increment primary key,
    vendorid int not null,
    contractid int not null,
    departmentid int not null,
    itemdetails text,
    quantity int not null,
    amount decimal(10, 2) not null,
    foreign key (vendorid) references vendor(vendorid) on delete cascade,
    foreign key (contractid) references contract(contractid) on delete cascade,
    foreign key (departmentid) references department(departmentid) on delete cascade
);

-- 5. budget table
create table budget (
    budgetid int auto_increment primary key,
    departmentid int not null,
    allocatedamount decimal(10, 2) not null,
    spentamount decimal(10, 2) default 0.00,
    remainingamount decimal(10, 2) generated always as (allocatedamount - spentamount) stored,
    foreign key (departmentid) references department(departmentid) on delete cascade
);

-- 6. performance table
create table performance (
    performanceid int auto_increment primary key,
    vendorid int not null,
    rating int check (rating between 1 and 5),
    feedback text,
    foreign key (vendorid) references vendor(vendorid) on delete cascade
);

-- 7. userinfo table
create table userinfo (
    userid int auto_increment primary key,
    username varchar(100) not null,
    email varchar(255) unique not null,
    userrole varchar(255) not null,
    userpassword varchar(255) not null
);

-- Insert admin user into userinfo table
insert into userinfo (username, email, userrole, userpassword)
values ('hashir', 'hashirahmed@gmail.com', 'admin', '12345678');

ALTER TABLE vendor ADD certifications TEXT NOT NULL;
ALTER TABLE userinfo MODIFY userrole VARCHAR(255) NOT NULL DEFAULT 'vendor';
ALTER TABLE performance ADD COLUMN score INT GENERATED ALWAYS AS (rating * 10) STORED;



