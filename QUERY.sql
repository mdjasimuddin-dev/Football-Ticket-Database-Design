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

-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================

create table bookings (
    booking_id serial primary key,
    user_id int references users(user_id) on delete cascade,
    match_id int references matches(match_id) on delete cascade,
    seat_number varchar(10),
    payment_status varchar(20) check (payment_status in ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost int not null
    
);



-- =========================================================================
-- Multiple users sample data Insert  into USERS
-- =========================================================================

insert into users (full_name, email, role, phone_number)
values
  ('Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
  ('Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
  ('Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
  ('Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL)


  -- =========================================================================
-- Multiple matches sample data Insert  into matches table
-- =========================================================================

insert into matches ( match_id, fixture, tournament_category, base_ticket_price, match_status)
values
  (101, 'Real Madrid vs Barcelona', 'Champions League', 150, 'Available'),
  (102, 'Man City vs Liverpool', 'Premier League', 120, 'Selling Fast'),
  (103, 'Bayern Munich vs PSG', 'Champions League', 130, 'Available'),
  (104, 'AC Milan vs Inter Milan', 'Serie A', 90, 'Sold Out'),
  (105, 'Juventus vs Roma', 'Serie A', 80, 'Available');


-- =========================================================================
-- Multiple bookings sample data Insert into bookings table
-- =========================================================================

insert into bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) 
values
    (501, 1, 101, 'A-12', 'Confirmed', 150),
    (502, 1, 102, 'B-04', 'Confirmed', 120),
    (503, 2, 101, 'A-13', 'Confirmed', 150),
    (504, 2, 101, NULL, NULL, 150),
    (505, 3, 102, 'C-20', 'Pending', 120);




-- Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.
  select match_id, fixture, base_ticket_price from matches
  where tournament_category= 'Champions League'
  and match_status = 'Available'


-- Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).
  select user_id, full_name, email from users
  where full_name ilike 'Tanvir%' 
  or full_name ilike '%Haque%'


-- Query 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.
  select booking_id, user_id, match_id, coalesce(payment_status, 'Action Required') as systematic_status from bookings
  where payment_status is null


-- Query 4: Retrieve match booking details along with the User's full name and the scheduled Match fixture teams.
  select booking_id, full_name, fixture, total_cost from bookings
  inner join users on users.user_id = bookings.user_id
  inner join matches on matches.match_id = bookings.match_id
