# 과제
# nobel.csv파일을 이용
# 파일에는 1901년 ~ 1965년까지 노벨상 수상자 현황이 있음
/*열
 * -year(int,수상 년도)
 * -subject(varchar(50),상 이름)
 * -winner(varchar(50),수상자 이름)*/

# 상의 종류를 알아보기 위해
select distinct subject  from nobel;
/*Chemistry => 화학상
 * Literature => 문학상
 * Medicine => 의학상
 * Peace => 평화상
 * Physics => 물리상*/

# 1번
# 1960년 노벨상 물리학상 또는 평화상 수상한 사람의 정보 출력
# 출력 칼럼: year, subject, winner
select n.year, n.subject, n.winner
from nobel n
where n.year='1960' and (n.subject='Physics' or n.subject='Peace');

# 2번
# Albert Einstein이 수상한 연도와 상 이름 출력
# 출력 칼럼: year, subject
select year, subject
from nobel
where winner='Albert Einstein';

# 3번
# 1910년 ~ 1950년 노벨 평화상 수상자 명단 출력
# 출력 칼럼: year, winner
select year, winner
from nobel 
where (year between 1910 and 1950) and subject='Peace';

# 4번
# 수상자 이름이 John으로 시작하는 수상자 모두 출력
# 출력 칼럼: subject, winner
select subject, winner
from nobel 
where winner like 'John%';

# 5번
# 1964년 수상자 중에 노벨화학상과 의학상을 제외한 수상자의 모든 정보를
# 수상자 이름을 기준으로 오름차순 정렬 후 출력
# 출력 칼럼: year,subject, winner
select year,subject, winner
from nobel
where year='1964' and (subject not in ('Chemistry','Medicine'));

# 6번
# 1910년 ~ 1960년 노벨문학상 수상자 명단 출력
# 출력 칼럼: winner
select winner
from nobel 
where year between 1910 and 1960 and subject='Literature';

# 7번
# 각 분야별 역대 수상자의 수를 내림차순으로 정렬 후 출력
# 출력 칼럼: count를 써서...
select subject, count(*) cou
from nobel 
group by subject
order by cou desc;

# 8번
# 노벨 의학상이 없었던 연도를 모두 출력
# 출력 칼럼: year
select distinct year
from nobel
where year not in (select distinct year
from nobel
where subject='Medicine');

# 40~42년도의 데이터가 한개도 없음

# 9번
# 노벨 의학상이 없었던 연도의 총 횟수를 출력
# 출력 칼럼: 
select count(*) co
from (select distinct year
from nobel
where year not in (select distinct year
from nobel
where subject='Medicine')) medxyear;
