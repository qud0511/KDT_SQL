-- create database sqlclass_db;
use sqlclass_db;

select * from nobel;
################################################################
-- 1) 1960년에 노벨상 물리학상 또는 노벨 평화상을 수상한 사람의 정보를 출력
# 출력 컬럼: year, subject, winner
select * from nobel n 
where `year` = 1960 and (subject in ('Peace', 'Physics'));
-- where `year` = 1960 and (subject = 'Peace' or subject = 'Physics');

################################################################
-- 2) Albert Einstein이 수상한 연도와 상 이름을 출력
# 출력 컬럼: year, subject
select year, subject from nobel n
where winner = 'Albert Einstein';

################################################################
-- 3) 1910년 부터 1950년까지 노벨 평화상 수상자 명단 출력
# 출력 컬럼: year, winner
-- select year, winner from nobel n 
-- where (year between 1910 and 1950)
-- and subject = 'Peace';
select year, winner from nobel n 
where (subject = 'Peace') and (year between 1910 and 1950);

################################################################
-- 4) 전체 테이블에서 수상자 이름이 ‘John’으로 시작하는 수상자 모두 출력
# 출력 컬럼: subject, winner
select subject, winner from nobel n 
where winner like 'John%';
# like 'Jphn____' => 4글자

################################################################
-- 5) 1964년 수상자 중에서 노벨화학상과 의학상을 제외한 수상자의 모든 정보를 수상자
# 이름을 기준으로 오름차순으로 정렬 후 출력
select * from nobel n
where (subject not in ('Chemistry', 'Medicine'))
and year = 1964
order by winner asc;

################################################################
-- 6) 1910년부터 1960년까지 노벨 문학상 수상자 명단 출력
select year, winner from nobel n 
where subject = 'Literature'
and (year between 1910 and 1960);

################################################################
-- 7) 각 분야별 역대 수상자의 수를 내림차순으로 정렬 후 출력(group by, order by)
select subject, count(*) as count from nobel n 
group by subject
order by count desc;
-- select subject, count(*) winner_num
-- from nobel n 
-- group by subject 
-- order by winner_num desc;

################################################################
-- 8) 노벨 의학상이 없었던 연도를 모두 출력 (distinct) 사용
-- select distinct year
-- from nobel n 
-- where year not in (select distinct `year` from nobel n2 
-- 	where subject = 'Medicine');
select distinct year from nobel n # distinct 중복 제거
where year not in (select year from nobel n2 where subject='Medicine');

select year from nobel n 
where year not in (select year from nobel n where subject = 'Medicine'); # => 같은 연도 여러 개를 볼 필요는 없으므로

################################################################
-- 9) 노벨 의학상이 없었던 연도의 총 회수를 출력
-- select count(distinct year) as 'no_Medicine_count'
-- from nobel n 
-- where year not in (select distinct year from nobel n2 
-- 	where subject = 'Medicine');
select count(*) as count_no_Medicine
from (select distinct year from nobel
where year 
not in (select year from nobel where subject='Medicine')) as n;
# (select distinct year from nobel where year not in (select year from nobel where subject='Medicine')) 테이블의 이름 => as n(n이라는 별칭을 줌)                                                                


-- count(*) => null 값을 카운트함.
-- count(컬럼명) => null 값 빼고 카운트함.

# 순서 select -> from -> where -> group by -> having -> order by
