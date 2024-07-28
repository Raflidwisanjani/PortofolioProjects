--- join all table
select
	ooid.order_id ,
	ooid.order_item_id ,
	ood.order_purchase_timestamp ,
	ooid.product_id ,
	pcnt.product_category_name_english ,
	ooid.price ,
	opd.product_weight_g ,
	oopd.payment_type ,
	ood.customer_id ,
	ocd.customer_city ,
	ocd.customer_state 
from 
	"Olist".olist_order_items_dataset ooid
	left join "Olist".olist_products_dataset opd on ooid.product_id = opd.product_id
	left join "Olist".product_category_name_translation pcnt on opd.product_category_name  = pcnt.product_category_name 
	left join "Olist".olist_order_payments_dataset oopd on ooid.order_id = oopd.order_id 
	left join "Olist".olist_orders_dataset ood on ooid.order_id = ood.order_id
	left join "Olist".olist_customers_dataset ocd on ood.customer_id = ocd.customer_id
	
--- top 10 product category with highest total order (using table from previous queries result)
--- product category with blank value replaced by 'other'
select
	product_category,
	count(product_category) as total_order
from
	(select
	case 
		when product_category_name_english = '' then 'other' else product_category_name_english
	end as product_category
	from
		"Olist".olin_cleaned oc)
group by 1
order by 2 desc
limit 10

--- total order per day

select
	to_date(date, 'yyyy-mm-dd') as date_purchased,
	count(order_id) as total_order
from
(select  
	order_id,
	substring(order_purchase_timestamp,1,strpos(order_purchase_timestamp,' ')) as date,
	substring(order_purchase_timestamp,strpos(order_purchase_timestamp,' ')) as timestamp
from
	"Olist".olin_cleaned oc)
group by 1
order by 1 asc

--- total order per city

select
	customer_city,
	count(order_id) as total_order
from
	"Olist".olin_cleaned oc
group by 1
order by 2 desc

--- popular payment method

select 
	case
		when payment_type = '' then 'unknown' else payment_type end as payment_type,
	count(order_id) as total_order
from
	"Olist".olin_cleaned oc
group by 1
order by 2 desc
