create database shoppingmall;
use shoppingmall;
create table user_table
	(userID char(8) not null, # not null primary key # 사용자 ID
	userName varchar(10) not null, # not null # 이름
	birthYear int not null, # not null # 출생년도
	addr char(2) not null, # not null # 지역(경기,서울, 경남, 2 글자)
	mobile1 char(3), # 휴대폰 국번
	mobile2 char(8), # 휴대폰 나머지 전화번호 (하이픈 제외)
	height smallint, # 키
	mDate date, # 회원 가입일
	constraint primary key (userID)
	);

desc user_table ;

insert into user_table (userID, userName, birthYear, addr, mobile1, mobile2, height, mDate)
values ('KHD', '강호동', 1970, '경북', '011', 22222222, 182, '2007-07-07'),
('KJD', '김제동', 1974, '경남', null, null, 173, '2013-03-03'),
('KKJ', '김국진', 1965, '서울', '019', 33333333, 171, '2009-09-09'),
('KYM', '김용만', 1967, '서울', '010', 44444444, 177, '2015-05-05'),
('LHJ', '이휘재', 1972, '경기', '011', 88888888, 180, '2006-04-04'),
('LKK', '이경규', 1960, '경남', '018', 99999999, 170, '2004-12-12'),
('NHS', '남희석', 1971, '충남', '016', 66666666, 180, '2017-04-04'),
('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-05-05'),
('SDY', '신동엽', 1971, '경기', null, null, 176, '2008-10-10'),
('YJS', '유재석', 1972, '서울', '010', 11111111, 178, '2008-08-08');

select * from user_table;

create table buy_table
(num INT auto_increment, # auto_increment not null primary key # 순번
userID CHAR(8) not null, # not null # 아이디 (FK)
prodName CHAR(6) not null, # not null # 물품명
groupName CHAR(4), # 분류
price INT not null, # not null # 단가
amount smallint not null, # not null # 수량
constraint primary key (num));

-- set foreign_key_checks=0;
-- alter table buy_table modify num int unsigned auto_increment;
-- set foreign_key_checks=1;

select * from buy_table;
desc buy_table ;

insert into buy_table (userID, prodName, groupName, price, amount)
values ('KHD', '운동화', null, 30, 2),
('KHD', '노트북', '전자', 1000, 1),
('KYM', '모니터', '전자', 200, 1),
('PSH', '모니터', '전자', 200, 5),
('KHD', '청바지', '의류', 50, 3),
('PSH', '메모리', '전자', 80, 10),
('KJD', '책', '서적', 15, 5),
('LHJ', '책', '서적', 15, 2),
('LHJ', '청바지', '의류', 50, 1),
('PSH', '운동화', null, 30, 2),
('LHJ', '책', '서적', 15, 1),
('PSH', '운동화', null, 30, 2);

select * from buy_table;

# 2-1번
select u.userName, b.prodName, u.addr, concat(u.mobile1, u.mobile2)
from user_table as u inner join buy_table as b
on u.userID = b.userID;

# 2-2번
select u.userName, b.prodName, u.addr, concat(u.mobile1, u.mobile2)
from user_table as u inner join buy_table as b
on u.userID = b.userID
where b.userID = 'KYM';

# 3번
select u.userID, u.userName, b.prodName, u.addr, concat(u.mobile1, u.mobile2) as '연락'
from user_table as u inner join buy_table as b
on u.userID = b.userID
order by b.userID;

# 4번
-- select * from buy_table
-- where amount != 0;

select distinct u.userID, u.userName, u.addr
from user_table as u inner join buy_table as b
on u.userID = b.userID
order by b.userID;

# 5번
select distinct userID, userName, addr, concat(mobile1, mobile2) as '연락'
from user_table
-- where addr = '경북' or addr = '경남';
where addr in ('경북', '경남');





