# 출처
# 치매오늘은 https://www.nid.or.kr/info/today_list.aspx#a
# 국민건강보험공단_치매의료이용률 https://www.data.go.kr/data/15089354/fileData.do
# 전국치매센터표준데이터 https://www.data.go.kr/data/15021138/standard.do

# `억음 부호` grave accent
-- create database dementia_db;

# ------------
select * from 국민건강보험공단_치매의료이용률;
desc 국민건강보험공단_치매의료이용률;

# 치매의료 이용률 2015 ~ 2019년도 데이터만 가져오기
select * from 국민건강보험공단_치매의료이용률
where (연도 between 2015 and 2019);

# 연도를 기준으로 묶고, 평균내기
select 연도, `국민보험 가입자`, round(avg(`이용환자 수`)), round(avg(`지표값(퍼센트)`), 2) from 국민건강보험공단_치매의료이용률
group by 연도;

# ---------
select * from 치매유병현황;
desc 치매유병현황;

select 연도, `치매 환자수` from 치매유병현황
where 연령별 = '60세이상' and 성별 ='전체'
order by 연도;

# 치매유병현황 필요한 데이터만 가져오기
select 연도, 성별, 연령별, 노인인구수, `치매 환자수`, `치매 유병률`, `경도인지장애 환자수`, `경도인지장애 유병률` from 치매유병현황;

# ------------
# 국민건강보험공단_치매의료이용률, 치매유병현황 테이블 inner join
select 이용률.연도, 이용률.`국민보험 가입자`, 현황.노인인구수, 현황.`치매 환자수`, round(avg(`이용환자 수`)) as `이용환자 수`
from 국민건강보험공단_치매의료이용률 as 이용률 inner join 치매유병현황 as 현황
on 이용률.연도 = 현황.연도
where (이용률.연도 between 2015 and 2019)
group by 이용률.연도 ;

# ---------------
select * from 전국치매센터표준데이터;

# 치매센터 필요한 데이터만 가져오기
select 치매센터명, 제공기관명, 의사인원수 from 전국치매센터표준데이터;

# 의사 인원수가 0명인 센터 수
select distinct 의사인원수, count(의사인원수) from 전국치매센터표준데이터
where 의사인원수 in (select 의사인원수 from 전국치매센터표준데이터 where 의사인원수 = 0);

# 지역별 치매센터 수
select count(제공기관명) from 전국치매센터표준데이터;

select 제공기관명 from 전국치매센터표준데이터;

select '경기도', count(제공기관명) from 전국치매센터표준데이터
where 제공기관명 like '경기도%'; 

select '경상북도', count(제공기관명) from 전국치매센터표준데이터
where 제공기관명 like '경상북%';

# 시도 단위만 추출
# '^\w+\s$'
select substr(제공기관명, 1, position(' ' in 제공기관명)-1) from 전국치매센터표준데이터;

# 못 잡아내는게 생김
select substr(제공기관명, 1, position(' ' in 제공기관명)-1) as 지역, count(*) as `센터 개수` from 전국치매센터표준데이터
group by 지역;

# case
select case 
when position(' ' in 제공기관명) = 0 then 제공기관명
when position(' ' in 제공기관명) > 0 then substr(제공기관명, 1, position(' ' in 제공기관명)-1)
else null
end as 지역, count(*) as `센터 개수`
from 전국치매센터표준데이터
group by 지역;

#----------
select 연도, `치매 환자수`, `노인인구수` from 치매유병현황
where 연령별 = '60세이상' and 성별 ='전체'
order by 연도;

	




