drop table member01; 

Create table member01 (
    id varchar2(50) not null primary key ,   -- 메일 주소 
    passwd varchar2(60) not null,           -- 암호화 해서 DB 저장 
    name varchar2(20) not null, 
    reg_date  date default sysdate not null  , 
    address varchar2(100) not null, 
    tel varchar2 (20) not null 
   ) 
   
select * from member01;

insert into member01 (id, passwd, name, reg_date, address, tel)
values ('admin@kosmo.com' , '1234', '관리자', default, '서울시', '010-1111-1111'); 

insert into member01 (id, passwd, name, reg_date, address, tel)
values ('hongkd@kosmo.com' , '1234', '홍길동', default, '경기도', '010-2222-2222'); 
commit;  

