-- 2025년 6월에 '서울'에 거주하는 고객이 주문한 모든 내역에 대해, 고객 이름, 고객 이메일, 주문 날짜, 주문한 상품명, 상품가격, 주문 수량 
-- 을 포함하는 상세 보고서를 최신 주문 순으로 작성하라. 
select 
	u.name as `고객 이름`
    , u.email as `고객 이메일`
    , o.order_date as `주문 날짜`
    , p.name as `주문한 상품명`
    , p.price as `상품가격`
    , o.quantity as `주문 수량`
from orders o
join users u
on o.user_id = u.user_id 
join products p 
on o.product_id = p.product_id
where o.order_date >= '2025-06-01'and o.order_date < '2025-07-01' and u.address like '서울%'
order by o.order_date desc;

-- 문제1
-- products 테이블과 orders 테이블을 LEFT JOIN하여 '전자기기'카테고리에 속하지만 단 한 번도 판매되지 않은
-- 상품의 이름과 가격을 조회하는 SQL을 작성해라. 
select 
	p.name 
    , p.price
from products p
left join orders o
on p.product_id = o.product_id
where p.category = '전자기기' and o.order_id is null;

-- 문제2
-- 모든 고객의 이름과 각 고객이 주문한 총 횟수를 조회하는 SQL을 작성해라. 주문을 한 번도 하지 않은 고객은 
-- 주문 횟수가 0으로 표시되어야 한다. 결과는 고객 이름으로 오름차순 정렬해라.

select
	u.name
    , count(o.order_id) as order_count
from users u
left join orders o 
on u.user_id = o.user_id
group by u.user_id, u.name
order by u.name asc;


-- 문제3 
-- RIGHT JOIN을 사용하여, 가입은 했지만 주문 기록이 없는 고객의 이름과 이메일을 찾는 SQL을 작성해라.
select 
	u.name
    , u.email
from orders o
right join users u
on o.user_id = u.user_id
where o.order_id is null;

-- 문제4
-- 모든 고객의 이름과 그 고객이 주문한 상품의 이름을 조회하는 SQL을 작성해라. 한 고객이 여러 상품을 주문했다면 모든 상품명이 
-- 나와야 하며, 주문 기록이 없는 고객의 상품명은 NULL로 표시되어야 한다. 결과는 고객 이름(user_name), 상품 이름 순 
-- (product_name)으로 정렬해라. 
select 
	u.name as user_name
    , p.name as product_name
from users u
left join orders o
on u.user_id = o.user_id 
left join products p
on o.product_id = p.product_id
order by user_name, product_name; 


-- 문제1 
-- employees 테이블을 셀프조인하여 '최과장'의 직속 부하 직원들의 이름과 직원 ID를 모두 조회하는 SQL 쿼리를 작성해라. 

use my_shop2;

select 
	m.employee_id
    , m.name
    , m.manager_id
    , e.name as manager_name
from employees e
join employees m 
on e.employee_id = m.manager_id
where e.name = '최과장';

-- 문제2
-- sizes와 colors 테이블을 CROSS JOIN하여 모든 색상과 사이즈 조합을 만들었던 것을 응용해 보자. 
-- '면(Cotton)'과'실크(Silk)'라는 두 가지 재질 옵션을 가진 meterials 테이블을 새로 만들고, 기존의 sizes, colors 테이블과 
-- 모두 CROSS JOIN하여 '상품명-색상-사이즈-재질' 형태의 모든 조합을 조회하는 쿼리를 작성해라. 

create table meterials (
	meterial varchar(20) not null
);

alter table meterials add primary key(meterial);

insert into meterials(meterial)
values('Cotton'),('Silk');

select 
	concat('기본티셔츠', '-', c.color, '-', s.size, '-', m.meterial) as product_full_name
	, s.size
    , c.color
    , m.meterial
from sizes s
cross join colors c
cross join meterials m
order by s.size, c.color, m.meterial;

-- 문제3 
-- users, orders, products 세 개의 테이블을 조인하여 '네이트' 고객이 주문한 모든 상품의 이름(product_name), 주문 날짜(order_date), 주문 수량(quantity)
-- 을 조회하는 SQL 쿼리를 작성해라. 결과는 주문 날짜 최신순으로 정렬해라. 
select 
	u.name as customer_name
    , p.name as product_name
    , o.order_date
    , o.quantity
from users u
join orders o
on u.user_id = o.user_id 
join products p
on o.product_id= p.product_id 
where u.name = '네이트'
order by o.order_date desc;

-- 문제4 
-- JOIN과 집계 함수를 함께 사용하는 종합 문제다. 
-- users, orders, products 테이블을 조인하여 '서울'에 거주하는 고객별로 총 주문 금액 (total_spent)을 계산하는 쿼리를 작성해라. 
-- 총 주문 금액은 각 주문의 가격(price) * 수량(quantity)의 합계이다. 결과는 총 주문 금액이 높은 순으로 정렬해라. 

select 
	u.name as customer_name
    , sum(o.quantity * p.price) as total_spent
from orders o 
join users u
on o.user_id = u.user_id
join products p
on p.product_id = o.product_id 
where u.address like ('서울%')
group by u.user_id, u.name
order by total_spent desc;
