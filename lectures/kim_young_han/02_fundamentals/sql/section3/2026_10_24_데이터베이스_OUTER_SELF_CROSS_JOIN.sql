use my_shop2;

-- 쇼핑몰에서 한번도 구매하지 않은 고객을 찾으시오. 
select 
	u.user_id
    , u.name
	, u.email
from users u
left join orders o 
on u.user_id = o.user_id
where o.order_id is null;

-- 단 한번도 팔리지 않은 상품을 찾으시오. 

select 
	p.product_id
    , p.name
from products p 
left join orders o
on p.product_id = o.product_id 
where o.order_id is null;

-- 셀프 조인
select * from employees;

select 
	e.name as employee_name
    , m.name as manager_name
from employees e
left join employees m 
on e.manager_id = m.employee_id;

-- CROSS JOIN
select * from sizes;
select * from colors;

select 
	concat('기본티셔츠-', c.color, '-', s.size) as product_name
	, s.size
    , c.color
from sizes s
cross join colors c;

create table product_option(
	option_id bigint auto_increment
    , product_name varchar(255) not null
    , size varchar(10) not null
    , color varchar(20) not null
    , primary key (option_id)
);

insert into product_option (product_name, size, color)
select
	concat('기본티셔츠-', c.color, '-', s.size) as product_name 
    , s.size
    , c.color 
from sizes s 
cross join colors c;

select * from product_option;
