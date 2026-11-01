use my_shop2;


DROP VIEW IF EXISTS v_category_order_status; -- 만약 뷰가 이미 존재한다면 제거 

CREATE VIEW v_category_order_status AS
SELECT
	p.category
    , COUNT(*) AS total_orders
    , SUM(CASE WHEN o.status = 'COMPLETED' THEN 1 ELSE 0 END) AS completed_count
    , SUM(CASE WHEN o.status = 'SHIPPED' THEN 1 ELSE 0 END) AS shipped_count
    , SUM(CASE WHEN o.staTUS = 'PENDING' THEN 1 ELSE 0 END) AS pending_count
FROM orders o
JOIN products p 
ON o.product_id = p.product_id 
GROUP BY p.category;


select * from v_category_order_status
where category = '전자기기'
;

ALTER VIEW v_category_order_status AS
select 
	p.category
    , sum(p.price * o.quantity) AS total_salses
    , count(*) as total_orders
    , sum(case when o.status = 'COMPLETED' then 1 else 0 end) as completed_count
    , sum(case when o.status = 'SHIPPED' then 1 else 0 end) as shipped_count
    , sum(case when o.status = 'PENDING' then 1 else 0 end) as pending_count
from orders o
join products p
on o.product_id = p.product_id 
group by category;

select * from v_category_order_status;
drop view v_category_order_status;