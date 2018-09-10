/*
--1. product_name이 Banana인 데이터의 aisles명과 departments명을 찾아 보세요.
select product_name, a.aisle, d.department
from products as p
	inner join departments as d
		on p.department_id = d.department_id
	inner join aisles as a
		on a.aisle_id = p.aisle_id
where p.product_name = 'Banana'

--2. Banana가 들어가는 상품 명과 department명을 Like구문을 활용하여 모두 찾아 보세요.
select p.department_id, department, p.product_name
from products as p
	left join departments as d
		on p.department_id = d.department_id
where p.product_name like "%Banana%"
	and department = 'snacks'

--3. order 테이블의 eval_set이 test인 것을 기준으로 요일별 주문수량을 구해 보세요. (참고로 0부터 시작하며, 0은 토요일 입니다.)
select order_dow, count(*)
from orders
where eval_set = 'test'
group by order_dow
order by count(*) desc

-- 4. order 테이블의 eval_set이 test인 것을 기준으로 시간대별 주문수량을 구하고 주문량이 많은 순으로 정렬해 보세요.
select order_hour_of_day, count(*)
from orders
where eval_set = 'test'
group by order_hour_of_day
order by count(*) desc

--order_products__train 테이블을 기준으로 재주문(reorder)이 가장 많은 제품명 상위 10개와 재주문 수를 구해 보세요.
select p.product_name, sum(reordered)
from order_products__train as opt
	join products as p
		on p.product_id = opt.product_id
group by p.product_name
order by sum(reordered) desc
limit 10
--재주문 여부를 sum이 아닌 count로 세고 싶으면 where구문에 reordered = 1을 넣어주어야 함.

--6. 주말(토, 일)에 가장 주문량이 가장 많은 시간대 상위 3개 구해 보세요.
select order_dow, order_hour_of_day, count(*)
from orders
where order_dow  in (0,1) and eval_set = 'test'
group by order_hour_of_day
order by count(*) desc
limit 3
*/

--7. SELECT와 LIMIT 구문을 사용하고 주문수가 10,000건 이상인 department, aisle, product_name 과 주문 수를 많은 순으로 구해 보세요.
select d.department, a.aisle, p.product_name, count(distinct(order_id)) as "주문수" 
from order_products__train as o
	inner join products as p
		on p.product_id = o.product_id
	inner join aisles as a
		on a.aisle_id = p.aisle_id
	inner join departments as d
		on d.department_id = p.department_id
group by product_name
having count(*) > 10000
-- groupby 하는 등 추가로 내가 계산한 값들을 having으로 조건을 정해줄 수 있음
order by count(*) desc