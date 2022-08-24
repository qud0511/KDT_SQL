# 0729 chap03 쿼리 입문.pdf

# sakila database 사용
USE sakila;

# -------- select절
select * from  `language` l ; # asterisk(*) 모든 열과 모든 행의 결과를 보여줌.

# 일부 column만 검색
select language_id, name, last_update from `language` l ;
select name from `language` l ;

# select절에 추가 할 수 있는 항목 -> 숫자, 문자열, 표현식, 내장 함수 호출, 사용자정 정의 함수 호출
select language_id,
'COMMON' language_usage,
language_id * 3.14 lang_pi_value,
upper(name) language_name
from language;
# 'COMMON' language_usage, 3.14 lang_pi_value은 가상 컬럼

# 열의 별칭(alias)
# 열의 레이블을 지정할 수 있음
# 출력을 이해하기 쉽게 함.
# as 키워드 사용 -> 가독성 향상
select language_id,
	'COMMON' as langeuage_usage,
	language_id * 3.14 as lang_pi_value,
	upper(name) as language_name
from `language` l ;

# 중복 제거
select actor_id from film_actor order by actor_id;
# 동일한 배구ㅏ 여러 영화에 출연 -> 중복된 actor_id 발생
# - all 키워드 -> 기본값, 명시적으로 저장할 필요 없음

# distinct 키워드 사용 -> 중복 제거
select distinct actor_id from film_actor order by actor_id;

# ---------- from절
# 쿼리에 사용되는 테이블을 명시, 테이블을 연결하는 수단

# 테이블 유형 -> from절에 포함
# 영구 테이블(permanent table) -> create table 문으로 생성
# 파생 테이블(derived table) -> 하위 쿼리(subquery)에서 반환하고 메모리에 보관된 행들
# 임시 테이블(temporary table) -> 메모리에 저장된 휘발성 데이터
# 가상 테이블(virtual table) -> create view문으로 생성

# 파생 테이블 -> from절에 위치한 select문은 실행 결과로 테이블을 생성한다.
# => 즉, 다른 테이블과의 상호작용을 할 수 있는 파생 테이블을 생성한다.
select concat(cust.last_name, ', ', cust.first_name) full_name
from
	(select first_name, last_name, email #
	from customer                        #
	where first_name = 'JESSIE'          # => 서브 쿼리
)as cust; # => 서브쿼리의 별칭
# concat(문자열1, 문자열2, ...) => 둘 이상의 문자열을 순서대로 합쳐서 반환

# 임시 테이블 -> 휘발성의 테이블 - 데이터베이스 세션이 닫힐 때 사라짐.
create temporary table actors_j # -> 임시테이블 (actors_J 생성)
	(actor_id smallint(5),  # -> smallint(5) => 화면 출력 시 5자리 맞춤
	first_name varchar(45), 
	last_name varchar(45)
);

insert into actors_j
select actor_id, first_name, last_name  #
from actor where last_name like 'J%';   # actor 테이블에서 ‘J’로 시작하는 데이터를 찾아서 actors_j 임시 테이블에 저장
select * from actors_j;









