
use my_shop2;
select * from items;

create index idx_items_item_name on items(item_name);

-- mysql에서는 primary key, foreign key, unique 키는 index를 자동으로 만들어 준다. 
show index from items;
show index from sellers;

drop index idx_items_item_name on items;

-- filtered는 대략 row의 결과중 나올(조건에 만족할 만한) %(퍼센트)를 표시하는 것이다. 
explain select * from items where item_name = '게이밍 노트북';

create index idx_items_item_name on items(item_name);
show index from items;


explain select * from items where price between 50000 and 100000;

create index idx_items_price on items(price);
select * from items where price between 50000 and 100000;

explain select * from items where item_name like '게이밍%';

explain select * from items
order by stock_quantity;

explain select * from items where price between 50000 and 100000
order by price desc;

drop index idx_items_price on items;

create index idx_items_price on items (price desc);

create index idx_items_price on items(price);

show index from items;
