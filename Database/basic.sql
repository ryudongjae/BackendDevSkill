// tablename에 해당하는 데이블의 모든 열을 읽는다.
select * from  tablename;

//검색 조건 지정
select 열1,열2 from 테이블이름 where 조건식;

//select 구 -> from 구 -> where 구
select 열 from 테이블명 where 조건식;

//수치형
select * from 테이블명 where id=2;
select * from 테이블명 where id<>2;

//문자열 형
select * from 테이블명 where name='아무개';

//null값
select * from 테이블명 where 조건1 is null;

