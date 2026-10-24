-- 내부 조인 
select 
	users.user_id
    , users.name 
    , orders.order_date
from orders
inner join users
on orders.order_id = users.user_id
where orders.status = 'COMPLETED';

select 
	o.order_id
    , o.order_date
    , o.user_id as orders_user_id
    , u.user_id as users_user_id
    , u.name
from orders o
join users u
on o.user_id = u.user_id
order by o.order_id;

select 
	orders.order_id
    , orders.order_date
    , orders.user_id as orders_user_id
    , users.user_id as users_user_id
    , users.name
from users
join orders
on users.user_id = orders.user_id
order by orders.order_id;