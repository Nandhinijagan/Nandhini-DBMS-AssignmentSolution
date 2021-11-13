Drop database if exists `travel_on_the_go`; 
create database travel_on_the_go;
use travel_on_the_go;
 -- Question 1:
/*
 You are required to create two tables PASSENGER and PRICE with the following
attributes and properties
PASSENGER
(Passenger_name varchar
 Category varchar
 Gender varchar
 Boarding_City varchar
 Destination_City varchar
 Distance int
 Bus_Type varchar
);
PRICE
(
 Bus_Type varchar
 Distance int
 Price int
 )
*/
  create table if not exists `travel_details`(
  `id` int,
  `Bus_Type` varchar(50),
  `Distance` int,
  PRIMARY KEY (`id`)
  );

create table if not exists `passenger`(
`Passenger_name` varchar(100) ,
`Category` varchar(50),
`Gender` varchar(10),
`Boarding_City` varchar(50),
`Destination_City` varchar(50),
`Distance` int,
`Bus_Type` varchar(50),
`travel_detail_id` INT,
FOREIGN KEY (`travel_detail_id`) REFERENCES travel_details (`id`)
);

  CREATE TABLE IF NOT EXISTS `price` (
  `Price` int,
  `travel_detail_id` INT NOT NULL,
  FOREIGN KEY (`travel_detail_id`) REFERENCES travel_details (`id`)
  );
  
  -- Question 2: 
  /*Insert the following data in the tables*/
INSERT INTO travel_details VALUES (1, 'Sleeper', 350);
INSERT INTO travel_details VALUES (2, 'Sleeper', 500);
INSERT INTO travel_details VALUES (3, 'Sleeper', 600);
INSERT INTO travel_details VALUES (4, 'Sleeper', 700);
INSERT INTO travel_details VALUES (5, 'Sleeper', 1000);
INSERT INTO travel_details VALUES (6, 'Sleeper', 1200);
INSERT INTO travel_details VALUES (7, 'Sitting', 500);
INSERT INTO travel_details VALUES (8, 'Sitting', 600);
INSERT INTO travel_details VALUES (9, 'Sitting', 700);
INSERT INTO travel_details VALUES (10, 'Sitting', 1000);
INSERT INTO travel_details VALUES (11, 'Sitting', 1200);
INSERT INTO travel_details VALUES (12, 'Sitting', 1500);


INSERT INTO price VALUES (770, 1); 
INSERT INTO price VALUES (1100, 2);
INSERT INTO price VALUES (1320, 3);
INSERT INTO price VALUES (1540, 4);
INSERT INTO price VALUES (2200, 5);
INSERT INTO price VALUES (2640, 6);
INSERT INTO price VALUES (434, 1);
INSERT INTO price VALUES (620, 7);
INSERT INTO price VALUES (744, 8);
INSERT INTO price VALUES (868, 9);
INSERT INTO price VALUES (1240, 10);
INSERT INTO price VALUES (1488, 11);
INSERT INTO price VALUES (1860, 12);

 INSERT INTO passenger VALUES ('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper', 1);
  INSERT INTO passenger VALUES ('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting', 9);
  INSERT INTO passenger VALUES ('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper', 3);
  INSERT INTO passenger VALUES ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper', null);
  INSERT INTO passenger VALUES ('Udit', 'Non-AC', 'M', 'Trivandrum', 'Panaji', 1000, 'Sleeper', 5);
  INSERT INTO passenger VALUES ('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting', 7);
  INSERT INTO passenger VALUES ('Hemant', 'Non-AC', 'M', 'Panaji', 'Mumbai', 700, 'Sleeper', 4);
  INSERT INTO passenger VALUES ('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting', 7);
  INSERT INTO passenger VALUES ('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting', 9);
  
  
 -- Question 3:
 /*How many females and how many male passengers travelled for a minimum distance of
600 KM s?*/
select count(*), Gender FROM passenger where distance >= 600 group by Gender;

 -- Question 4:
/*Find the minimum ticket price for Sleeper Bus. */
select min(price) from price join travel_details on price.travel_detail_id = travel_details.id where bus_type = 'sleeper';

 -- Question 5:
/*Select passenger names whose names start with character 'S'*/
select * from passenger where Passenger_name like 'S%';

 -- Question 6:
/*Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output*/
select passenger_name, boarding_city, destination_city, p.bus_type, price from passenger p left join price pr on p.travel_detail_id = pr.travel_detail_id order by passenger_name;

 -- Question 7:
/*What is the passenger name and his/her ticket price who travelled in Sitting bus for a
distance of 1000 KM s*/
select * from passenger p join travel_details t on p.travel_detail_id = t.id where t.distance = 1000 and t.bus_type = 'Sitting';

 -- Question 8:
/*What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?
 join price on passenger.travel_detail_id = price.travel_detail_id */
select travel_details.bus_type, price.price from passenger join travel_details on travel_details.distance = passenger.distance join price on travel_details.id = price.travel_detail_id  where passenger_name = 'Pallavi' and  boarding_city = 'Panaji' and destination_city = 'Bengaluru' or boarding_city = 'Bengaluru' and destination_city = 'Panaji';

 -- Question 9:
/*List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order*/

select distance from passenger group by distance order by distance desc;

 -- Question 10:
/*Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables*/

select passenger_name, (distance/ (select sum(distance) from passenger)) * 100 as distance_percent from passenger;

 -- Question 11:
/*Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise*/         

select distance, price,
case 
	when price >= 1000 then 'Expensive'
	when price > 500 and price < 1000 then 'Average Cost'
	else 'Cheap'
end as verdict
from  price join travel_details  on travel_details.id = price.travel_detail_id  order by Distance; 
