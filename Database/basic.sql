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

//검색조건
select * from 테이블명 where a<>0 and b<>0; //a,b열이 모두 0이 아닌 행 검색

select * from 테이블명 where a<>0 or b<>0; // a열이 0이 아니거나 b열이 0이 아닌 행 검색

select * from 테이블명 where not(a<>0 or b<>0);

//패턴 매칭에 의한 검색
select * from 테이블명 where text like 'sql%'; //전방일치
select * from 테이블명 where text like '%sql%'; //중간일치

select * from 테이블명 where text LIKE '%\%%'; //text 열에 '%'(메타문자)를 포함하는 행을 검색

select * from 테이블명 where text LIKE 'is''s';//text 열에 is,s를 포함하는 행을 검색