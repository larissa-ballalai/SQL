 -- ===================================================
-- Author: Larissa Ballalai
-- Create date: 7/15/2021
-- Description: Analytical functions SQL. 
-- 1. Row_number() over (order by x)
-- 2. Dense_rank() over (order by x): it allows repetition
-- 3. Row_number() over (partition by x order by x)
-- 4. Sum() + 1,3.
-- ====================================================

if not exists (select * from sysobjects where name='stadium_NEW' and xtype='U')
Create table stadium_NEW (id int, stadium_name varchar(255), visit_date DATE NULL, people int)

Truncate table stadium_NEW

insert into stadium_NEW (id, stadium_name, visit_date, people) values ('1', 'ANZ', '2017-01-01', '10')
insert into stadium_NEW (id, stadium_name, visit_date, people) values ('2', 'ANZ', '2017-01-02', '109')
insert into stadium_NEW (id, stadium_name, visit_date, people) values ('3', 'ANZ', '2017-01-03', '150')
insert into stadium_NEW (id, stadium_name, visit_date, people) values ('4', 'MOR', '2017-01-04', '99')
insert into stadium_NEW (id, stadium_name, visit_date, people) values ('5', 'MOR', '2017-01-05', '145')
insert into stadium_NEW (id, stadium_name, visit_date, people) values ('6', 'MOR', '2017-01-06', '1455')
insert into stadium_NEW (id, stadium_name, visit_date, people) values ('7', 'MOR', '2017-01-07', '199')
insert into stadium_NEW (id, stadium_name, visit_date, people) values ('8', 'MOR', '2017-01-09', '188')



-- QUERY
select ROW_NUMBER() over (order by stadium_name) as [id],	   
	   DENSE_RANK() over (order by stadium_name) as [id_stadium],
	   ROW_NUMBER() over (partition by stadium_name order by stadium_name) as [id_stadium_date],

	   stadium_name,
	   visit_date,

	   sum(people) over (partition by stadium_name order by visit_date) as sum_by_stadium_x_visit_date,
	   sum(people) over (order by visit_date) as sum_by_visit_date,	   	   	   
	   sum(people) over () as total	   

  from stadium_new
 order by id

