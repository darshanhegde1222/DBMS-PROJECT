create database mbook;
use mbook;

create table add_movie(M_id int(10),M_name varchar(28),director varchar(42),
release_date date,category varchar(20),
languagee varchar(20),Y_link varchar(20),showw varchar(20),
Actn varchar(20),descr varchar(20),image varchar(100),statuss int(10),
primary key(M_id,M_name));

INSERT INTO `add_movie` (`M_id`, `M_name`, `director`, `release_date`, `category`, `languagee`, `Y_link`, `showw`, `Actn`, `descr`, `image`, `statuss`) VALUES
(9, 'Avengers', 'Kevin Feige', 'April 11, 2012', 'Scince', 'English', 'https://www.youtube.com/embed/eOrNdBpGMv8', '21:00', 'running', '                ', 'aven.jpg', 1),
(10, 'Rampage', 'Brad Peyton', '13 April 2018', 'Adventure ', 'Hindi', '', '', 'upcoming', '                                Jumanji is a 1995 American fantasy adventure film directed by Joe Johnston from a screenplay by Jonathan Hensleigh, Greg Taylor, and Jim Strain. Loosely based on Chris Van Allsburg\'s picture book of the same name, the film is the first installment of the Jumanji franc', 'rampage.jpg', 1);

create table admin(id int(10),name varchar(20),email varchar(20),password varchar(20),
is_active enum('0','1') NOT NULL DEFAULT '0',primary key(id));

 INSERT INTO `admin` (`id`, `name`, `email`, `password`, `is_active`) VALUES
(1, 'darshan', 'darshan@gmail.com', 'admin', '1');

CREATE TABLE `customers` (
  `id` int(10) NOT NULL,
  `uid` int(10) NOT NULL,
  `movie` varchar(100) NOT NULL,
  `show_time` varchar(100) NOT NULL,
  `seat` varchar(100) NOT NULL,
  `totalseat` varchar(100) NOT NULL,
  `price` varchar(100) NOT NULL,
  `payment_date` varchar(100) NOT NULL,
  `booking_date` varchar(100) NOT NULL,
  `card_name` varchar(100) NOT NULL,
  `card_number` varchar(25) NOT NULL,
  `ex_date` varchar(100) NOT NULL,
  `cvv` int(5) NOT NULL,
  `custemer_id` int(15) NOT NULL,primary key(movie,card_number,id),
  foreign key (id) references add_movie(M_id));
  
  INSERT INTO `customers` (`id`, `uid`, `movie`, `show_time`, `seat`, `totalseat`, `price`, `payment_date`, `booking_date`, `card_name`, `card_number`, `ex_date`, `cvv`, `custemer_id`) VALUES
(9, 1, 'Chaal Jeevi Laiye', '15:00', 'G1,G2,D1,D2', '4', '500', 'Wed-09-21 ', 'Thu-09-21 ', 'pratik d', '7896', '2021-09-30', 789, 1869901767);
 INSERT INTO `customers` (`id`, `uid`, `movie`, `show_time`, `seat`, `totalseat`, `price`, `payment_date`, `booking_date`, `card_name`, `card_number`, `ex_date`, `cvv`, `custemer_id`) VALUES
(10, 1, 'Tanaji', '15:15', 'F7,F8,E7,E8,A7,A8', '6', '1200', 'Thu-09-21 ', 'Fri-09-21 ', 'pratik d', '145260', '2021-09-30', 349, 1890244096);

 CREATE TABLE `feedback` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `massage` varchar(100) NOT NULL,primary key(id),foreign key(id) references customers
  (id)
);

insert into feedback values(9,"Chandu","chandu@gmail.com","Good movie");
insert into feedback values(10,"Aman","aman@gmail.com","Good movie");

CREATE TABLE `theater_show` (
  `id` int(25) NOT NULL,
  `show` varchar(100) NOT NULL,
  `theater` varchar(100) NOT NULL,
  primary key(id),foreign key(id) references feedback(id));
  
  insert into theater_show values(9,"10:00","1");
  insert into theater_show values(9,"22:00","2");
  
  
  CREATE TABLE `user` (
  `id` int(25) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` int(10) NOT NULL,
  `city` varchar(25) NOT NULL,
  `password` varchar(12) NOT NULL,
  `image` varchar(100) NOT NULL,
  primary key(id),foreign key(id) references customers(id)
);


INSERT INTO `customers` (`id`, `uid`, `movie`, `show_time`, `seat`, `totalseat`, `price`, `payment_date`, `booking_date`, `card_name`, `card_number`, `ex_date`, `cvv`, `custemer_id`) VALUES
(9, 1, 'Chaal Jeevi Laiye', '15:00', 'G1,G2,D1,D2', '4', '500', 'Wed-09-21 ', 'Thu-09-21 ', 'pratik d', '7896', '2021-09-30', 789, 1869901767),
(10, 1, 'Tanaji', '15:15', 'F7,F8,E7,E8,A7,A8', '6', '1200', 'Thu-09-21 ', 'Fri-09-21 ', 'pratik d', '145260', '2021-09-30', 349, 1890244096);
  
DELIMITER //
CREATE TRIGGER price_trigger
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    IF NEW.ticket_type = 'gold' THEN
        UPDATE ticket_purchases
        SET amount = amount + 50
        WHERE customer_id = NEW.customer_id;
    ELSEIF NEW.ticket_type = 'platinum' THEN
        UPDATE ticket_purchases
        SET amount = amount + 150
        WHERE customer_id = NEW.customer_id;
    END IF;
END;
//
DELIMITER ;


//nested query
SELECT 
    u.id AS user_id,
    u.username AS user_name,
    u.email AS user_email,
    u.mobile AS user_mobile,
    u.city AS user_city,
    (
        SELECT 
            GROUP_CONCAT(c.movie SEPARATOR ', ') 
        FROM 
            customers AS c 
        WHERE 
            c.id = u.id
    ) AS booked_movies
FROM 
    `user` AS u;
    
    //aggregate
    SELECT 
    COUNT(totalseat) AS total_seats_booked,
    AVG(CAST(price AS DECIMAL(10,2))) AS average_price_paid
FROM 
    customers;
    
   // SELECT 
    COUNT(totalseat) AS total_seats_booked,
    AVG(CAST(price AS DECIMAL(10,2))) AS average_price_paid
FROM 
    customers;


