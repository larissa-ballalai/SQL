 -- =============================================
-- Author: Larissa Ballalai
-- Create date: 7/14/2021
-- Description: Leetcode exercise 262. Trips and Users
-- https://leetcode.com/problems/trips-and-users
-- =============================================

if not exists (select * from sysobjects where name='Trips' and xtype='U')
Create table Trips (
	Id int, 
	Client_Id int, 
	Driver_Id int, 
	City_Id int, 
	Status varchar(255) not null, 
	Request_at varchar(50)
)

if not exists (select * from sysobjects where name='Users' and xtype='U')
Create table Users (
	Users_Id int, 
	Banned varchar(50), 
	Role varchar(100)
)

Truncate table Trips

insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03')

Truncate table Users

insert into Users (Users_Id, Banned, Role) values ('1', 'No', 'client')
insert into Users (Users_Id, Banned, Role) values ('2', 'Yes', 'client')
insert into Users (Users_Id, Banned, Role) values ('3', 'No', 'client')
insert into Users (Users_Id, Banned, Role) values ('4', 'No', 'client')
insert into Users (Users_Id, Banned, Role) values ('10', 'No', 'driver')
insert into Users (Users_Id, Banned, Role) values ('11', 'No', 'driver')
insert into Users (Users_Id, Banned, Role) values ('12', 'No', 'driver')
insert into Users (Users_Id, Banned, Role) values ('13', 'No', 'driver')

-- QUERY       
select a.request_at as day,
	   convert(decimal(10,2), round(sum(status) / sum(qtd), 2)) as cancellation_rate
  from
(
	select convert(decimal(10,2), count(*)) qtd,
		   sum(case when t.status <> 'completed' then 1 else 0 end) as status,
		   request_at
	  from trips t  
	 inner join users client on t.client_id = client.users_id and client.banned = 'no' 
	 inner join users driver on t.driver_id = driver.users_id and driver.banned = 'no'       
	 where t.request_at between '2013-10-01' and '2013-10-03'
	 group by       
		   t.client_id,
		   t.driver_id,	 
		   request_at,
		   case when t.status <> 'completed' 
				then 0 else 1
			end 
) a
group by a.request_at