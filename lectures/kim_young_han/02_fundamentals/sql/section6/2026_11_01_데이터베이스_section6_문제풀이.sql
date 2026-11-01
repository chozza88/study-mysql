-- 문제1 
-- products 테이블에서 상품의 category 컬럼 값을 영문으로 변경하여 조회해라. '전자기기'는 'Electronics', '도서'는 'Books'
-- '패션'은 'Fashion'으로 표시하고, category_english 라는 별칭을 사용해라. 상품 이름, 원래 카테고리, 그리고 영문 카테고리를 
-- 함께 출력해야 한다. 

select 
	name
    , category 
    , case category
		when '전자기기' then 'Electronics'
        when '도서' then 'Books'
        when '패션' then 'Fashion'
        else 'Etc'
      end as category_english
from products; 

-- 문제2 
-- orders 테이블의 주문들을 수량(quantity)에 따라 분류하고 싶다. 수량이 2개 이상이면 '다량 주문',
-- 1개이면 '단일 주문'으로 표시하는 order_type 컬럼을 만들어라. 
-- 주문 ID, 수량, 그리고 새로운 order_type 컬럼을 조회하되, '다량 주문'이 '단일 주문'보다 먼저 나오도록 정렬해라. 

select 
	order_id
    , quantity
    , case
		when quantity >= 2 then '다량 주문'
        else '단일 주문'
      end as order_type
from orders 
order by 
	case 
		when quantity >= 2 then 1
        else 0
	end desc
;

-- 문제3 
-- products 테이블의 상품들을 재고 수량(stock_quantity)에 따라 그룹화하여 각 그룹에 속한 상품의 수를 세어보아라. 
select 
	case 
		when stock_quantity >= 50 then '재고 충분'
        when stock_quantity >= 20 then '재고 보통'
        else '재고 부족'
    end as stock_level,
    count(*) as product_count
from products
group by stock_level;


-- 문제4
-- 각 사용자(users)가 카테고리별로 몇 건의 주문을 했는지 피벗 테이블 형태로 죄회해라. 사용자 이름, 총 주문 건수, '전자기기' 주문건수 
-- '도서' 주문 건수를 각각 suer_name, total_orders, electronics_orders, book_orders 컬럼으로 출력해야 한다. 
-- 한 번도 주문하지 않은 고객도 결과에 포함해야 한다. 

use my_shop2;
select 
	u.name as user_name
	, count(o.order_id) as total_orders
    , sum(case when p.category = '전자기기' then 1 else 0 end) as electronics_orders
    , sum(case when p.category = '도서' then 1 else 0 end) as book_orders
    , sum(case when p.category = '패션' then 1 else 0 end) as fashion_orders
from users u
left join orders o
on u.user_id = o.user_id
left join products p
on o.product_id = p.product_id
group by u.user_id;


select * from users;
select * from orders;
select * from products;


select 
	u.name as user_name
	, count(o.order_id) as total_orders
    , sum(case when p.category = '전자기기' then 1 else 0 end) as electronics_orders
    , sum(case when p.category = '도서' then 1 else 0 end) as book_orders
from users u
left join orders o
on u.user_id = o.user_id
left join products p
on o.product_id = p.product_id
group by u.user_id
having electronics_orders >= 2
;