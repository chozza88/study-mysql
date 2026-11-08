-- 트랜잭션 
-- 실습준비: accounts 테이블 생성
use my_shop2;
 
drop table if exists accounts;
create table accounts (
	id int primary key comment '계좌 식별자'
    , owner_name varchar(255) not null comment '계좌 소유자 이름' 
    , balance int not null comment '계좌 잔액'
) comment = '은행 계좌 정보 테이블';

-- 초기 데이터 입력 
insert into accounts (id, owner_name, balance) values
(1, 'A 고객', 50000),
(2, 'B 고객', 20000);

select * from accounts;

start transaction;

update accounts 
set balance = balance - 10000
where id = 1;

update accounts 
set balance = balance + 10000
where id = 2;

commit;

start transaction;

update accounts
set balance = balance - 5000
where id = 1;

rollback;

set session transaction isolation level read committed;

-- 데이터 베이스 격리 수준 확인하기
select @@transaction_isolation;