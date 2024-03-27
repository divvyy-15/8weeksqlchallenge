/*the exclusions and extras column in customer_orders table has inconsistent manner of representing values - either NULL,blank or null written as a string.
As it is a varchar,we can represent these values as an empty string.
So we create a temp table, customer_orders_1, which would be a copy of the original table, customer_orders, keeping the source table untouched.*/

DROP TABLE IF EXISTS customer_orders_1

select order_id,customer_id,pizza_id,
case when exclusions is null or exclusions='null' then '' else exclusions end as exclusions,
case when extras is null or extras='null' then '' else extras end as extras,
	 order_time
into customer_orders1
from customer_orders

/*Similarly in runners_orders table we have the below issues:
a)The null string in columns pickup_time,distance,duration and cancellation needs to be removed
b)Need to remove 'km','mins','minute','minutes' string values form distance and duration columns
c)Datatype of columns pickup_time,distance,duration is varchar. It should be corrected to datetime,numeric and int respectively */

  
DROP TABLE IF EXISTS runner_orders_1

select order_id,runner_id,
case when pickup_time='null' then NULL else pickup_time end as pickup_time,
case when distance='null' then NULL
     when distance like '%km' then trim('km' from distance)
     else distance end as distance,
case when duration='null' then NULL 
     when duration like '%mins' then trim('mins' from duration)
	 when duration like '%minute' then trim('minute' from duration)
	 when duration like '%minutes' then trim('minutes' from duration)
     else duration end as duration,
case when cancellation is null or cancellation='null' then '' else cancellation end as cancellation
into runner_orders_1
from runner_orders

ALTER TABLE runner_orders_1
ALTER COLUMN pickup_time datetime,
ALTER COLUMN distance numeric,
ALTER COLUMN duration int;
