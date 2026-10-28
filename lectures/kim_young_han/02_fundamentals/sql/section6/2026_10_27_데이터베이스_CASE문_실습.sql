use my_shop2;

select 
	order_id
    , user_id
    , product_id
    , quantity
    , status
    , CASE status
		WHEN 'PENDING' THEN '주문 대기'
        WHEN 'COMPLETED' THEN '결제 완료'
        WHEN 'SHIPPED' THEN '배송' 
        WHEN 'CANSELLED' THEN '주무 취소'
        ELSE '알 수 없음'
	  END AS status_korean
from orders;

select 
	name
    , price 
    , CASE
		WHEN price >= 100000 THEN '고가'
        WHEN price >= 30000 THEN '중가' 
        ELSE '저가'
	  END AS price_label
from products
order by 
	case 
		when price >= 100000 then 1
        when price >= 30000 then 2 
        else 3
	end asc,
    price desc
;

select 
	case 
		when year(birth_date) >= 1990 then '1990년대생'
		when year(birth_date) >= 1980 then '1980년대생'
		else '그 이전 출생'
    end as birth_decade
    , count(*) as customer_count  
from users
group by
	case 
		when year(birth_date) >= 1990 then '1990년대생'
        when year(birth_date) >= 1980 then '1980년대생'
		else '그 이전 출생'
	end
;
use my_shop2;


select 'Total' as category, count(*) as total_orders from orders
union all
select status as category, count(*) from orders
group by status;


select 
	(select count(*) from orders) as total_orders,
    (select count(*) from orders where status = 'COMPLETED') as completed_count,
    (select count(*) from orders where status = 'SHIPPED') as shipped_count,
    (select count(*) from orders where status = 'PENDING') as pending_count;

select 
	count(*) as total_orders,
    sum(case when status = 'COMPLETED' then 1 else 0 end) as completed_count,
    sum(case when status = 'SHIPPED' then 1 else 0 end) as shipped_count,
    sum(case when status = 'PENDING' then 1 else 0 end) as pending_count
from orders;

select 
	p.category,
	count(*) as total_orders,
    sum(case when status = 'COMPLETED' then 1 else 0 end) as completed_count,
    sum(case when status = 'SHIPPED' then 1 else 0 end) as shipped_count,
    sum(case when status = 'PENDING' then 1 else 0 end) as pending_count
from orders o 
join products p
on o.product_id = p.product_id 
group by p.category;