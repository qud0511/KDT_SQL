# 데이터베이스 이름
create database sqlclass_db;
use sqlclass_db;

create table world
(country varchar(30),
continent varchar(30),
area int,
population int,
capital varchar(30),
top_level_domain varchar(3)
);

desc world;

# alter table [해당테이블명] change [해당필드] [바꿀필드명] [변경할필드속성];
# alter table world change population population bigint;

# alter table [테이블명] modify [필드명][타입];
# alter table world modify population bihint;

insert into world (country, continent, area, population, capital, top_level_domain)
values ('Afghanistan','Asia',652230,25500100,'Kabul','.af'),
('Algeria','Africa',2381741,38700000,'Algiers','.dz'),
('New Zealand','Oceania',270467,4538520,'Wellington','.nz'),
('Australia','Oceania',7692024,23545500,'Canberra','.au'),
('Brazil','South America',8515767,202794000,'Brasilia','.br'),
('China','Asia',9596961,1365370000,'Beijing','.cn'),
('India','Asia',3166414,1246160000,'New Delhi','.in'),
('Russia','Eurasia',17125242,146000000,'Moscow','.dz'),
('France', 'Europe', 640679, 65906000, 'Paris', '.fr'),
('Germany', 'Europe', 357114, 80716000, 'Berlin', '.de'),
('Denmark', 'Europe', 43094, 5634437, 'Copenhagen', '.dk'),
('Norway', 'Europe', 323802, 5124383, 'Oslo', '.no'),
('Sweden', 'Europe', 450295, 9675885, 'Stockholm', '.se'),
('South Korea', 'Asia', 100210, 50423955, 'Seoul', '.kr'),
('Canada', 'North America', 9984670, 35427524, 'Ottawa', '.ca'),
('United States', 'North America', 9826675, 318320000, 'Washington, D.C.', '.us'),
('Armenia', 'Eurasia', 29743, 3017400, 'Yerevan', '.am');

select * from world;

# select country, capital, top_level_domain from world w;

select country, capital, top_level_domain from world w 
where continent  = 'Europe';

select country, population from world
where continent = 'Asia' order by population desc;

select country, population from world w
where continent = 'Asia' order by population asc;


