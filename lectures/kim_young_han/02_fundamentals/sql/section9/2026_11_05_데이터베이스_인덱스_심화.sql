-- 커버링 인덱스
select item_id, price, item_name
from items 
where price between 50000 and 100000;

drop index idx_items_price on items;

create index idx_items_price_name on items (price, item_name);

-- 복합인덱스 
-- 복합인덱스 대원칙 
-- 1. 인덱스는 순서대로 사용하라! ( 왼쪽 접두어 규칙 )
-- 2. 등호(=) 조건은 앞으로, 범위 조건(<, >)은 뒤로! 
-- 3. 정렬(ORDER BY)도 인덱스 순서를 따르라!

-- 복합 인덱스 준비 과정(지금까지의 인덱스 삭제)
show index from items;

drop index idx_items_item_name on items;
drop index idx_items_price_name on items;

create index idx_items_category_price on items(category, price);

explain select * from items where category = '전자기기' and price > 100000
order by price;

use my_shop2;
explain select * from items where price = 80000;
explain select * from items where category >= '패션' and price = 20000;
explain select * from items where category in('패션', '헬스/뷰티') and price =20000;

create index idx_items_price_category_temp on items(price, category);
drop index idx_items_price_category_temp on items;

show index from items;

explain select 
	s.seller_name
    , i.item_name
    , i.price
from items i
join sellers s 
on i.seller_id = s.seller_id
where s.seller_name = '행복쇼핑';

show index from sellers;