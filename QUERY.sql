-- =========================================================================
-- 0. CREATE Database
-- =========================================================================
create database football_ticket


-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================

create table users (
    user_id serial primary key,
    full_name varchar(25) not null,
    email varchar(25) unique not null ,
    role varchar(20) check( role in('Football Fan', 'Ticket Manager')) default 'Football Fan' not null,
    phone_number varchar(15)
);


-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================

  create table matches (
    match_id serial primary key,
    fixture varchar(30) not null,
    tournament_category varchar(25) not null,
    base_ticket_price int not null,
    match_status varchar(15) check(match_status in('Available', 'Selling Fast', 'Sold Out')) default  'Available' not null
);
