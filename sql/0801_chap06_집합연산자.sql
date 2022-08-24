-- 집합 연산 규칙
	-- 두 데이터셋 모두 같은 수의 열(column)을 가져야 됨
	-- 두 데이터셋의 각 열의 자료형은 서로 동일해야 됨
select 1 as num, 'abc' as str
union
select 9 as num, 'xyz' as str;

# union 연산자
	# 결합된 집합을 정렬하고 중복을 제거
# union all 연산자
	# 최종 데이터셋의 행의 수는 결합되는 집합의 행의 수의 총합과 같음
	# 중복되는 모든 값을 보여줌

# 집합 연산을 하기 전에 customer 테이블과 actor 테이블 구성 확인
# 두 테이블 모두, first_name, last_name이 존재하고 데이터타입도 동일
desc customer ;
desc actor ;

# -> customer 테이블과 actor 테이블 union all 연산 수행
select 'CUST' type1, c.first_name, c.last_name
from customer as c
union all
select 'ACTR' as type1, a.first_name, a.last_name
from actor as a;

select count(first_name) from customer;
select count(first_name) from actor; # 599 + 200 -> 중복되는 모든 값 포함해서 그대로 더해줌.

#actor 테이블에 union_all 연산 수행
	# 중복 항목 제거 안함
	# 총 데이터수가 400개로 늘어남
select 'ACTR' as typ,	a.first_name,	a.last_name
from actor	as a
union all
select 'ACTR' as typ,	a.first_name,	a.last_name
from actor	as a;
	# customer 테이블과 actor 테이블에서
	# 이름이 ‘J’로 시작하고 성은 ‘D’로 시작하는 사람들의 합집합: union all (중복)
select c.first_name,	c.last_name
from customer	as c
where c.first_name like 'J%' and c.last_name like 'D%'
union all
select a.first_name,	a.last_name
from actor	as a
where a.first_name like 'J%' and a.last_name like 'D%';

# -------중복 데이터 제거
# union 중복 데이터 제거
select c.first_name,	c.last_name
from customer	as c
where c.first_name like 'J%' and c.last_name like 'D%'
union
select a.first_name,	a.last_name
from actor	as a
where a.first_name like 'J%' and a.last_name like 'D%';

# ----------------------------
# intersect 연산자 -> MySQL 8.0 버전에서 지원 안함 => inner join으로 동일한 결과를 얻을 수 있음
select c.first_name, c.last_name
from customer as c
	inner join actor as a
	on (c.first_name =	a.first_name)
	and (c.last_name =	a.last_name);

select c.first_name,	c.last_name
from customer	as c
	inner join actor	as a
	on (c.first_name =	a.first_name)
	and (c.last_name =	a.last_name)
where a.first_name like 'J%' and a.last_name like 'D%';

# ------------------------------------
#복합 쿼리의 결과 정렬
	# order by 절을 쿼리 마지막에 추가
		# 열 이름 정의는 복합 쿼리의 첫 번째 쿼리에 있는 열의 이름을 사용해야 됨.
select a.first_name as fname,	a.last_name as lname
from actor	as a
where a.first_name like 'J%' and a.last_name like 'D%'
union all
select c.first_name,	c.last_name
from customer	as c
where c.first_name like 'J%' and c.last_name like 'D%'
order by lname,	fname;

# 집합 연산의 순서
	# 복합 쿼리는 위에서 아래의 순서대로 실행(집합연산의 순서에 따라 연산결과는 달라짐)
		# 예외 -> intersect 연산자가 다른 집합 연산자보다 우선 순위가 높음.
select a.first_name,	a.last_name
from actor	as a
where a.first_name like 'J%' and a.last_name like 'D%'
union all
select a.first_name,	a.last_name
from actor	as a
where a.first_name like 'M%' and a.last_name like 'T%'
union
select c.first_name,	c.last_name
from customer	as c
where c.first_name like 'J%' and c.last_name like 'D%';

# 성이 L로 시작하는 모든 배우와 고객의 이름과 성을 찾는 복합 쿼리 작성
select first_name, last_name
from actor
where last_name like 'L%'
union select first_name , last_name 
from customer
where last_name like 'L%';

# last_name 열을 기준으로 실습 6-2의 결과를 오름 차순 정렬하시오.
select first_name,	last_name from actor
where last_name like 'L%'
union
select first_name,	last_name from customer
where last_name like 'L%' order by last_name;








