-- char
	-- 고정 길이 문자열 자료형
	-- 지정한 크기보다 문자열이 작으면 나머지 공간을 공백으로 채움
	-- MySQL 255글자까지 허용

-- varchar(variable character)
	-- 가변 길이 문자열 자료형
	-- 크기만큼 데이터가 들어오지 않으면 그 크기에 맞춰 공간 할당
	-- 헤더에 길이 정보가 포함
	-- MySQL 최대 65,536 글자 허용

--  text
	--  매우 큰 가변 길이 문자열 저장
	--  MySQL: 최대 4 기가바이트 크기 문서 저장
	--  clob: 오라클 데이터베이스

# 테이블 생성
use testdb;
create table string_tbl (
char_fld char(30),
vchar_fld varchar(30),
text_fld text
);

# 문자열 데이터를 테이블에 추가
	# 문자열의 길이가 해당 열의 최대 크기를 초과하면 예외 발생
insert into string_tbl (char_fld,	vchar_fld,	text_fld)
values ('This	is	char	data＇,
'This	is	varchar	data＇,
'This	is	text	data');

# varchar 문자열 처리
	# update문으로 vchar_fld열 (varchar(30))에 설정 길이보다 더 긴 문자열 저장
	# MySQL 6.0 이전 버전: 문자열을 최대 크기로 자르고 경고 발생
	# MySQL 6.0 이후 기본 모드는 strict 모드로 예외 발생됨.
update string_tbl
set vchar_fld =	'This	is	a	piece	of	extremly long	varchar	data';

# -------------------------------
--  escape 문자 추가

-- • 작은 따옴표를 하나 더 추가
update string_tbl
set text_fld =	'This	string	didn''t	work,	but	it	does	now';

-- • 백슬래시(‘\’) 문자 추가
update string_tbl
set text_fld =	'This	string	didn\'t	work,	but	it	does	now';

select text_fld from string_tbl;

# ----------------------------------
# 작은 따옴표 포함 -> quote() 내장 함수
	# 전체 문자열을 따옴표로 묶고, 문자열 내의 작은 따옴표에 escape문자를 추가
select quote(text_fld)
from string_tbl;


-- length() 함수
-- - 문자열의 개수를 반환
delete from string_tbl;

insert into string_tbl (char_fld,	vchar_fld,	text_fld)
values ('This	string	is	28	characters',
	'This	string	is	28	characters',
	'This	string	is	28	characters')

select length(char_fld)	as char_length,
length(vchar_fld)	as varchar_length,
length(text_fld)	as text_length
from string_tbl;
-- • char열의 길이: 빈 공간을 공백으로 채우지만, 조회할 때 char 데이터에서 공백 제거

-- position() 함수
	-- 부분 문자열의 위치를 반환 (MySQL의 문자열 인덱스: 1부터 시작)
	-- 부분 문자열을 찾을 수 없는 경우, 0을 반환함
select position('characters' in vchar_fld)
from string_tbl;

-- locate(‘문자열’, 열이름, 시작위치) 함수
	-- 특정 위치의 문자부터 검색, 검색의 시작 위치 정의
select locate('is',	vchar_fld,	5)
from string_tbl;


-- strcmp(‘문자열1’, ‘문자열2’) 함수
	-- if 문자열1 < 문자열2, -1 반환
	-- if 문자열1 == 문자열2, 0 반환
	-- if	문자열1 > 문자열2, 1 반환

-- string_tbl 삭제 후 새로운 데이터 
delete from string_tbl;

insert into string_tbl(vchar_fld)
values ('abcd'),
('xyz'),
('QRSTUV'),
('qrstuv'),
('12345');

-- vchar_fld의 값을 오름 차순 정렬
select vchar_fld
from string_tbl
order by vchar_fld;

-- strcmp() 예제
	-- 5개의 서로 다른 문자열 비교
select strcmp('12345',	'12345')	12345_12345,
	strcmp('abcd',	'xyz')	abcd_xyz,
	strcmp('abcd',	'QRSTUV')	abcd_QRSTUV,
	strcmp('qrstuv',	'QRSTUV')	qrstuv_QRSTUV,
	strcmp('12345',	'xyz')	12345_xyz,
	strcmp('xyz',	'qrstuv')	xyz_qrstuv;

# ------------
# 문자열 비교
-- like 또는 regexp 연산자 사용
	-- select 절에 like 연산자나 regexp 연산자를 사용
		-- • 0 또는 1의 값을 반환
use sakila;
select name,	name	like '%y' as ends_in_y
from category;
select name,	name	REGEXP 'y$' ends_in_y
from category;

-- string_tbl 리셋
	delete from string_tbl;

	insert into string_tbl (text_fld)
	values ('This	string	was	29	characters');

-- concat() 함수
	-- 문자열 추가 함수
	-- concat() 함수를 사용하여 string_tbl의 text_fld열에 저장된 문자열 수정
		-- • 기존 text_fld의 문자열에 ',	but	now	it	is	longer’ 문자열 추가
update string_tbl
set text_fld =	concat(text_fld,	',	but	now	it	is	longer');


--  변경된 text_fld 열 확인
select text_fld
from string_tbl;

-- concat() 함수 활용
	-- 각 데이터 조각을 합쳐서 하나의 문자열 생성
		-- • concat() 함수 내부에서 date(create_date)를 문자열로 변환
use sakila;
#	concat()	함수 사용 #2
select concat(first_name, ' ', last_name,
'has been a customer since', date(create_date))	as cust_narrative
from customer;

--  insert() 함수
	--  4개의 인수로 구성
	--  insert(문자열, 시작위치, 길이, 새로운 문자열)
select insert('goodbye	world',	9,	0,	'cruel')	as string;
select insert('goodbye	world', 1,	7,	'hello')	as string;


-- replace() 함수
	-- replace(문자열, 기존문자열, 새로운 문자열)
	-- 기존 문자열을 찾아서 제거하고, 새로운 문자열을 삽입
select replace('goodbye	world',	'goodbye',	'hello') as replace_str;


-- substr() 함수
	-- substr(문자열, 시작위치, 개수)
	-- 문자열에서 시작 위치에서 개수만큼 추출
select substr('goodbye	cruel	world',	9,	5);

# ==============================================================================
# 산술 함수
-- cos(x) x의 코사인 계산
-- cot(x) x의 코탄젠트 계산
-- ln(x) x의 자연로그 계산
-- sin(x) x의 사인 계산
-- sqrt(x) x의 제곱근 계산
-- tan(x) x의 탄젠트 계산
-- exp(x) ex 를 계산
-- mod(a, b) a를 b로 나눈 나머지 구하기
-- pow(a, b) a의 b 제곱근 계산
-- sign(x) x가 음수이면 -1, 0이면 0, 양수이면 1 반환
-- abs(x) x의 절대값 계산
-- select account_id,	sign(balance),	abs(balance)
-- from account;

# 숫자 데이터 처리
-- 숫자 자릿수 관리
	-- ceil() 함수: 가장 가까운 정수로 올림
	-- • ceil(72.445) = 73

-- floor() 함수: 가장 가까운 정수로 내림
	-- • floor(72.445)	= 72

-- round() 함수: 반올림
	-- • 소수점 자리를 정할 수 있음
	-- • round(72.0909,	1)	= 72.1	
	-- • round(72.0909, 2) = 72.09
 
-- truncate() 함수: 원치 않는 숫자를 버림
	-- • truncate(72.0956,	1) = 72.0
	-- • truncate(72.0956,	2) = 72.09
	-- • truncate(72.0956, 3) = 72.095
select truncate(72.0956,	1),	truncate(72.0956,	2),	truncate(72.0956,	3);

# ==============================================================================

-- 시간대(time zone)처리
	-- 24개의 가상 영역으로 분할
	-- 협정 세계표준시(UTC:	Universal Time Coordinated) 사용
	-- utc_timestamp() 함수 제공

-- 시간 데이터 생성 방법
	-- 기존 date, datetime 또는 time 열에서 데이터 복사
	-- date, datetime 또는 time을 반환하는 내장 함수 실행
	-- 서버에서 확인된 시간 데이터를 문자열로 표현

-- 날짜 형식의 구성 요소
	-- 자료형 / 기본형식 / 허용값
	-- YYYY / 연도 / 1000 ~ 9999
	-- MM / 월 / 01(1월) ~ 12(12월)
	-- DD / 일 / 01 ~ 31
	-- HH / 시간 / 00 ~ 23
	-- MI / 분 / 00 ~ 59
	-- SS / 초 / 00 ~ 59

-- 필수 날짜 구성 요소
	-- date / YYYY-MM-DD / 1000-01-01 ~ 9999-12-31
	-- datetime / YYYY-MM-DD HH:MI:SS / 1000-01-01 00:00:00.000000 ~ 9999-12-31 23:59:59.999999
	-- timestamp / YYYY-MM-DD HH:MI:SS / 1970-01-01 00:00:00.000000 ~ 2038-01-18 22:14:07.999999
	-- time / HHH:MI:SS / −838:59:59.000000 ~ 838:59:59.000000

-- 시간 데이터의 문자열 표시
	-- datetime 기본 형식: YYYY-MM-DD HH:MI:SS
	-- datetime 열을 2022년 8월 1일 오전 09:30 으로 표현
		-- • ‘2022-08-01 09:30:00’ 의 문자열로 구성

-- MySQL 서버의 시간 데이터 처리
	-- • datetime 형식으로 표현된 문자열에서 6개의 구성요소를 분리해서 문자열을 변환

-- cast() 함수
	-- - 지정한 값을 다른 데이터 타입으로 변환
	-- - cast() 함수를 이용해서 datetime값을 반환하는 쿼리 생성
select cast('2019-09-17	15:30:00' as datetime);

	-- date 값과 time 값을 생성
select cast('2019-09-17' as date)	date_field,
cast('108:17:57' as time)	time_field;

-- MySQL의 문자열을 이용한 datetime 처리
	-- MySQL은 날짜 구분 기호에 관대
		-- • 2019년 9월 17일 오후 3시 30분에 대한 유효한 표현 방식
			-- '2019-09-17	15:30:00'
			-- '2019/09/17	15:30:00'
			-- '2019,09,17,15,30,00'
			-- '20190917153000'     # => 모두 유효함.
select cast('20190917153000' as datetime);

# -----
-- 날짜 생성 함수
	-- str_to_date()
		-- • 형식 문자열의 내용에 따라 datetime,	date 또는 time값을 반환
		-- • cast() 함수를 사용하기에 적절한 형식이 아닌 경우 사용
		-- • ‘September 17, 2019’ 문자열을 date 형식으로 변환
select str_to_date('September	17,	2019',	'%M	%d,	%Y')	as return_date;
-- - %M: 월 이름 (January ~ December)
-- - %d: 숫자로 나타낸 월(01 ~ 12)
-- - %Y: 연도, 4자리 숫자

-- 날짜 형식의 구성 요소
	-- 요소 - 정의 / 요소 - 정의
	-- %M - 월 이름(January	~	December) / %H - 시간 (00 ~ 23)
	-- %m - 숫자로 나타낸 월(01 ~12) / %h - 시간 (01 ~ 12)
	-- %d - 숫자로 나타낸 일(01 ~ 31) / %i - 분 (00 ~ 59)
	-- %j - 일년 중 몇 번째 날(001 ~ 366) / %s - 초 (00 ~ 59)
	-- %W - 요일 이름(Sunday	~	Saturday) / %f - 마이크로초(000000 ~ 999999)
	-- %Y - 연도, 4자리 숫자 / %p - 오전 또는 오후
	-- %y - 연도, 2자리 숫자

-- 현재 날짜/시간 생성
	-- 내장 함수가 시스템 시계를 확인해서 현재 날짜 및 시간을 문자열로 반환
	-- CURRENT_DATE(),	CURRENT_TIME(),	CURRENT_TIMESTAMP()
select CURRENT_DATE(),	CURRENT_TIME(),	CURRENT_TIMESTAMP();

-- 날짜를 반환하는 시간 함수
	-- date_add()
		-- • 지정한 날짜에 일정 기간(일, 월, 년 등)을 더해서 다른 날짜를 생성
select date_add(current_date(), interval 5 day); 

# 기간 자료형
-- 기간명 / 정의
-- second / 초
-- minute / 분
-- hour / 시간
-- day / 일 수
-- month / 개월 수
-- year / 년 수
-- minute_second / ‘:’으로 구분된 분, 초
-- hour_second / ‘:’으로 구분된 시, 분, 초
-- year_month / ‘-’	으로 구분된 년, 월
update rental
set return_date =	date_add(return_date,	interval '3:27:11' HOUR_SECOND)
where rental_id =	99999; # 데이터 타입을 안바꾸려고 이렇게?

-- 날짜를 반환하는 시간 함수
	-- last_day(date)
		-- • 해당월의 마지막 날짜 반환
select last_day('2022-08-01');

-- 문자열을 반환하는 시간 함수
	-- dayname(date) 함수
		-- • 해당 날짜의 영어 요일 이름을 반환
select dayname('2022-08-01');

-- 문자열을 반환하는 시간 함수
	-- extract() 함수
		-- • date의 구성 요소 중 일부를 추출
		-- • 기간 자료형으로 원하는 날짜 요소를 정의(p.27)
select extract(year from '2019-09-18 22:19:05');

-- 숫자를 반환하는 시간 함수
	-- datediff(date1, date2) 함수
		-- • 두 날짜 사이의 기간(년, 주, 일)을 계산
		-- • 시간 정보는 무시
select datediff('2019-09-03', '2019-06-21');

-- 변환 함수
	-- cast() 함수
		-- • 데이터를 한 유형에서 다른 유형으로 변환할 때 사용
		-- • cast(데이터 as 타입)
select cast('1456328' as signed	integer);

# 예시
select cast('20220101' as date);
select cast(20220101 as char);
select cast(now() as signed);

create database testdb;
use testdb;
create table customer(
name varchar(20),
category int,
region varchar(20));









