create table member02
    ( u_id varchar2(50) not null primary key,
      u_pass varchar2(50) not null,
      u_name varchar2(50) not null,
      r_date date default sysdate not null,
      u_address varchar2(200) not null,
      u_tel varchar2(50) not null,
      u_birthday date not null
      );

select * from member02;

insert into member02 values ('admin@kosmo.com', '1234', '관리자', default, '서울', '010-1111-1111',sysdate);
insert into member02 values ('hongkd@kosmo.com', '1234', '홍길동', default, '경기', '010-2222-2222',sysdate);

commit;