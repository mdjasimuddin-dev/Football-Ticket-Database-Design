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
