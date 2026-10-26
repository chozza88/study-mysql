use my_shop2;

-- 스칼라 서브쿼리
select 
	name, 
    address
from users 
where address = (
	select
		u.address
	from orders o
	join users u
	on o.user_id = u.user_id 
	where o.order_id = 1 
);

select
	*
from orders
where product_id in ( 
	select 
	product_id
	from products 
	where category = '전자기기'
)
order by order_id
;


select 
	*
from products
where price > any (
	select 
	price
	from products
	where category = '전자기기'
);

select 
	*
from products
where price > all (
	select 
	price
	from products
	where category = '전자기기'
);

select *
from products 
where price > (
	select 
		min(price)
	from products 
    where category = '전자기기'
);

select *
from products 
where price > (
	select
		max(price)
	from products 
    where category = '전자기기' 
);

-- 다중컬럼 서브쿼리 
-- 우리 쇼핑몰의 고객 '네이트'가 한 주문이 있다. 이 주문과 동일한 고객이면서 주문 처리상태도 같은 모든 주문을 찾아보자.

select user_id, status from orders where order_id = 3;

select 
	*
from orders 
where (user_id, status) = (
	select 
		user_id
        , status 
	from orders 
    where order_id = 3
);

use my_shop2;

select 
	o.order_id
    , o.user_id
    , u.name
    , p.name as product_name
    , o.order_date
from orders o 
join users u 
on o.user_id = u.user_id 
join products p 
on o.product_id = p.product_id
where (o.user_id, o.order_date) in (
	select 
	user_id
    , min(order_date)
	from orders 
	group by user_id
);


-- "각 상품별로, 자신이 속한 카테고리의 평균 가격 이상의 상품들을 찾아라." 

select *
from products p1 
where 
	price >= (select avg(p2.price) 
				from products p2 
                where p2.category = p1.category);
                
                
select 
	product_id
    , name
    , price
from products
where product_id in (select distinct product_id from orders);

select 
	product_id
    , name
    , price
from products p 
where exists (
	select 1
    from orders o
    where o.product_id = p. product_id
);

select 
	name
    , price 
    , (select avg(price) from products) as avg_price
from products;

select 
	p.product_id
    , p.name
    , p.price
    , ( select 
		count(*) 
		from orders o 
		where o.product_id = p.product_id) as order_count
from products p;

select 
	count(*) 
from orders o 
where o.product_id; 

select category, max(price) as max_price 
from products 
group by category;

select * from products 
where category = '전자기기';

select 
	p.product_id
    , p.name
    , p.price
    , p.category
from products p
join (
	select category, max(price) as max_price 
    from products 
    group by category) as cmp
on p.category = cmp.category and p.price = cmp.max_price
