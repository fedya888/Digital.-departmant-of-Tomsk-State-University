--1. Вывести все параметры, относящиеся к покупкам, которые совершал Calvin Potter
select *
from coffe_shop.sales s 
where customer_name = 'Calvin Potter'
order by 1;

--2.Посчитать средний чек покупателей по дням
select transaction_date,
	   avg(quantity * unit_price) as avg_bill
from coffe_shop.sales
group by 1
order by 1;

/* 3.Преобразуйте дату транзакции в нужный формат: год, месяц, день. 
	 Приведите названия продуктов к стандартному виду в нижнем регистре 
*/
select transaction_date,
	   date_part('year', transaction_date) as trans_year,
	   date_part('month', transaction_date) as trans_month,
	   date_part('day', transaction_date) as trans_day,
	   lower(product_name)
from coffe_shop.sales s 
order by 1;

/* 4. Сделать анализ покупателей и разделить их по категориям. 
      Посчитать количество транзакций, сделанных каждым покупателем. 
      Разделить их на категории: 
  		Частые гости (>= 23 транзакций), 
  		Редкие посетители (< 10 транзакций), 
  		Стандартные посетители (все остальные) 
 */
select customer_id, 
	   customer_name, 
	   count(transaction_id) as transactions,
	   case when count(transaction_id) >= 23 then 'Частый гость'
	   		when count(transaction_id) < 10  then 'Редкий гость'
	   		else 'Стандартный посетитель'
	   end as customer_category
from coffe_shop.sales s
group by 1,2
order by 3 desc, 1 desc 

-- 5. Посчитать количество уникальных посетителей в каждом магазине каждый день */
select transaction_date, 
	   store_address, 
       count(distinct(customer_id)) as customers
from coffe_shop.sales s
group by 1,2
order by 2

--6. Посчитать количество клиентов по поколениям
select generation,
	   count(customer_id)
from coffe_shop.generations g
left join coffe_shop.customer c on c.birth_year = g.birth_year 
group by 1
order by 2 desc

/* 7. Найдите топ 10 самых продаваемых товаров каждый день 
	 и проранжируйте их по дням и кол-ву проданных штук 
*/
with q1 as (
select transaction_date,
	   p.product_name,
	   sum(sr.quantity) as quantity_sold_per_day
from coffe_shop.sales_reciepts sr 
left join coffe_shop.product p on sr.product_id = p.product_id 
group by 1,2
),

q2 as (
select *, 
	   row_number() over (partition by transaction_date order by quantity_sold_per_day desc) as rating
from q1
)

select *
from q2
where rating <= 10;

/* 8. Выведите только те названия регионов, в которых продавался
	  продукт “Columbian Medium Roast”, с последней датой продажи 
*/
select distinct(so.neighborhood), 
	   max(sr.transaction_date) over (partition by so.neighborhood) as last_transaction
from coffe_shop.sales_outlet so
left join coffe_shop.sales_reciepts sr on so.sales_outlet_id = sr.sales_outlet_id 
left join coffe_shop.product p on p.product_id = sr.product_id 
where p.product_name = 'Columbian Medium Roast'
order by 1

/* 9. Соберите витрину из следующих полей
      Transaction_date, sales_outlet_id, store_address, product_id,
      product_name, customer_id, customer_name, gender (заменить на Male,
      Female, Not Defined если пустое значение), unit_price, quantity,
      line_item_amount
*/
select sr.transaction_date,
	   sr.sales_outlet_id,
	   so.store_address,
	   p.product_id,
	   p.product_name,
	   c.customer_id, 
	   c.customer_name,
case 
	when c.gender = 'M' then 'Male'
	when c.gender = 'F' then 'Female'
	else 'Not Defined'
end as gender,
	   sr.unit_price,
	   sr.quantity,
	   sr.line_item_amount
from coffe_shop.sales_reciepts sr
left join coffe_shop.sales_outlet so on so.sales_outlet_id = sr.sales_outlet_id
left join coffe_shop.product p on p.product_id = sr.product_id 
left join coffe_shop.customer c on c.customer_id = sr.customer_id 

/* 10. Найдите разницу между максимальной и минимальной ценой
	   товара в категории
*/
select
    p.product_category,
    p.product_type,
    p.product_name,
    sr.unit_price as retail_price,
    max(sr.unit_price) over (partition by p.product_category) as max_retail_price,
    min(sr.unit_price) over (partition by p.product_category) AS min_retail_price,
    (max(sr.unit_price) over (partition by p.product_category) - min(sr.unit_price) over (partition by p.product_category)) as difference
from coffe_shop.product p
left join coffe_shop.sales_reciepts sr on sr.product_id = p.product_id
group by 1,2,3,4
order by 1,2;

/* *1. Сделать справочник клиентов. Посчитать возраст клиентов,
	   разделить имя и фамилию на 2 отдельных поля
*/
select customer_id,
	   customer_name as customer_full_name,
	   split_part(customer_name, ' ', 1) as customer_name,
       split_part(customer_name, ' ', 2) as customer_surname,
	   birthdate,
	   age(now(), date(birthdate)) as customer_age
from coffe_shop.customer c 

/* *2. Используя витрину в качестве табличного выражения или
	   подзапроса, посчитайте количество транзакций по полю gender
*/
with shop_wind as (
select sr.transaction_date,
	   sr.sales_outlet_id,
	   so.store_address,
	   p.product_id,
	   p.product_name,
	   c.customer_id, 
	   c.customer_name,
case 
	when c.gender = 'M' then 'Male'
	when c.gender = 'F' then 'Female'
	else 'Not Defined'
end as gender,
	   sr.unit_price,
	   sr.quantity,
	   sr.line_item_amount
from coffe_shop.sales_reciepts sr
left join coffe_shop.sales_outlet so on so.sales_outlet_id = sr.sales_outlet_id
left join coffe_shop.product p on p.product_id = sr.product_id 
left join coffe_shop.customer c on c.customer_id = sr.customer_id 
)
select gender, count(line_item_amount)
from shop_wind
group by 1
order by 2

