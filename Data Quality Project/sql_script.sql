create database data_quality_project;
use data_quality_project;

select * from customers_raw;
select * from orders_raw;

-- missing customer id count --

select count(customer_id) as missing_cust_id from customers_raw
where customer_id is null or customer_id ='';

select ((select count(customer_id) as missing_cust_id from customers_raw
where customer_id is null or customer_id ='')  / count(*) )*100 as missing_customerid_per from customers_raw;

-- duplicate customer id --

select customer_id, 
row_number() over(partition by customer_id) as rn
from customers_raw;

with customer_id_duplicate_count_cte as
(
select customer_id, 
row_number() over(partition by customer_id) as rn
from customers_raw
)
select count(customer_id) 
from customer_id_duplicate_count_cte 
where rn >1 ;

-- missing email count --

select count(*) as missing_mail from customers_raw
where email is null or email ='' or email=' ';
-- invalid email count --
select count(*) as invalid_email_count from customers_raw
where email is not null and email !=' ' and email !='' and
(email not like '%@%' or email not like '%.%');
-- missing phone --

select count(*) as missing_phno from customers_raw 
where phone is null or phone ='' or phone=' ';
-- invalid phoneno --
select count(*) as invalid_phno from customers_raw
where phone is not null and phone !='' and phone !=' ' and
(phone regexp '[^0-9]'  or length(phone)!= 10);
-- missing country --
select count(*) as missing_country_count from customers_raw 
where country is null or country='' or country=' ';
-- invalid country --
select distinct(country) from customers_raw;
select count(*) as invalid_country from customers_raw
where country is not null and country != '' and country!=' ' and
country not in ('India','USA','UK','Canada','Australia');
-- missing signup date --
select count(*) as missing_date from customers_raw 
where signup_date is null or signup_date ='' or signup_date=' ';
-- invalid signup_date--
select count(signup_date) as invalid_date from customers_raw
where signup_date is not null and signup_date!='' and signup_date!=' ' and
signup_date > current_date();

select signup_date from customers_raw 
where signup_date > current_date();
-- missing status --
select count(*) as missing_status from customers_raw 
where status is null or status ='' or status=' ';
select status from customers_raw;

select count(`status`)as invalid_status from customers_raw
where `status` is not null and `status` !='' and `status`!=' '
and lower(`status`) not in('active','inactive','blocked');


-- orders_raw table -- 

-- missing orderid --

select count(*) as missing_order_id from orders_raw 
where order_id is null or 
	order_id ='' or
	order_id= ' ';

-- duplicate orderid --

select count(*) as duplicate_count from orders_raw;

select order_id ,
row_number() 
over(partition by order_id) as rn
from orders_raw;

with duplicate_count_cte as
(
select order_id ,
row_number() 
over(partition by order_id)as rn
from orders_raw 
) 
select count(order_id) as duplicate_counts from duplicate_count_cte
where rn >1;

-- missing customer id --

select count(*) as missing_cust_id_count from orders_raw
where customer_id is null or 
      customer_id ='' or
      customer_id=' ';

select * from  orders_raw;

-- invalid cust id--

select count(o.customer_id) from orders_raw as o 
left join customers_raw as c  
on o.customer_id = c.customer_id
where c.customer_id is null and
o.customer_id is not null and o.customer_id!='';

-- missing order date--
select count(*) as missing_date from orders_raw
where order_date is null or
      order_date ='' or
      order_date = ' ';
	
-- invalid order date --
 select count(*) as invalid_order_date from orders_raw
 where order_date is not null and
        order_date !='' and
		order_date!=' ' and
        order_date > current_date();

-- missing order amount--

select count(*) as missing_amt  from orders_raw 
where order_amount is null or
       order_amount ='' or 
       order_amount=' ';
       
-- invalid order amount --
 
 select count(*) as invalid_amt_count from orders_raw
 where order_amount is not null and
       order_amount!='' and
       order_amount!=' ' and
       order_amount <= 0;
       
-- missing payment method--

select count(*) as missing_paymentmethod from orders_raw
where payment_method is null or
   payment_method ='' or
payment_method= ' ';

-- invalid payment method --

select count(*) as invalid_payment_method from orders_raw 
where payment_method is not null and
   payment_method !='' and
payment_method != ' ' and
lower(payment_method) not in ('upi','card','cash');

-- missing order status--

select count(*) as missing_count from orders_raw
where order_status is null or
      order_status ='' or 
      order_status=' ';
      
-- invalid order status--

select count(*) as invalid_count from orders_raw
where order_status is not null and
      order_status !='' and
      order_status !=' ' and
      lower(order_status) not in('completed','pending','cancelled');
      
-- kpi summary --

select 'Missing Customer Id' as kpi_name,
        'customers_raw' as table_name,
		'customer_id' as column_name,
          0 as issue_count,
          'low' as risk_level,
        'No data quality issues detected' as business_impact
        
union all

select 'Duplicate Customer Id' as kpi_name,
        'customers_raw' as table_name,
		'customer_id' as column_name,
          0 as issue_count,
          'low' as risk_level,
        'No data quality issues detected' as business_impact
union all
select 'Missing Emails' as kpi_name,
        'customers_raw' as table_name,
		'email' as column_name,
		 4 as issue_count,
		'medium' as risk_level,
        'Reduces customer communication effectiveness and limit marketting reach' as business_impact
union all
select 'Invalid Emails' as kpi_name,
        'customers_raw' as table_name,
		'email' as column_name,
		 2 as issue_count,
		'medium' as risk_level,
        'Data entry errors that can impact customer communication effectiveness' as business_impact
union all
select 'Missing Phone' as kpi_name,
        'customers_raw' as table_name,
		'phone' as column_name,
		 0 as issue_count,
		'low' as risk_level,
        'No data quality issues detected' as business_impact
union all
select 'Invalid Phone' as kpi_name,
        'customers_raw' as table_name,
		'phone' as column_name,
		 1 as issue_count,
		'medium' as risk_level,
        'Causes failed customer connection and delivery issues' as business_impact
union all
select 'Missing Country' as kpi_name,
        'customers_raw' as table_name,
		'country' as column_name,
		 0 as issue_count,
		'low' as risk_level,
        'No data quality issues detected' as business_impact
union all
select 'Invalid Country' as kpi_name,
        'customers_raw' as table_name,
		'country' as column_name,
		 5 as issue_count,
		'medium' as risk_level,
        'Incorrect regional insights' as business_impact
union all
select 'Missing Signup Date' as kpi_name,
        'customers_raw' as table_name,
		'signup_date' as column_name,
		 2 as issue_count,
		'medium' as risk_level,
        'Breaks time based reports and growth trend analysis' as business_impact
union all
select 'Invalid Signup Date' as kpi_name,
        'customers_raw' as table_name,
		'signup_date' as column_name,
		 0 as issue_count,
		'low' as risk_level,
        'No data quality issues detected' as business_impact
union all
select 'Missing Status' as kpi_name,
        'customers_raw' as table_name,
		'status' as column_name,
		 2 as issue_count,
		'medium' as risk_level,
        'Affects customer tracking and marketing campaigns' as business_impact
union all
select 'Invalid Status' as kpi_name,
        'customers_raw' as table_name,
		'status' as column_name,
		 0 as issue_count,
		'low' as risk_level,
        'No data quality issues detected' as business_impact
union all
select 'Missing Order Id' as kpi_name,
        'orders_raw' as table_name,
		'order_id' as column_name,
		 0 as issue_count,
		'low' as risk_level,
        'No data quality issues detected' as business_impact
union all
select 'Duplicate Order Id' as kpi_name,
        'orders_raw' as table_name,
		'order_id' as column_name,
		 0 as issue_count,
		'low' as risk_level,
        'No data quality issues detected' as business_impact
union all
select 'Missing Customer Id' as kpi_name,
        'orders_raw' as table_name,
		'customer_id' as column_name,
		 1 as issue_count,
		'high' as risk_level,
        'Revenue becomes untraceable' as business_impact
union all
select 'Invalid Customer Id' as kpi_name,
        'orders_raw' as table_name,
		'customer_id' as column_name,
		 14 as issue_count,
		'high' as risk_level,
        'Untraceable revenue and unreliable customer analysis' as business_impact
union all
select 'Missing Order Date' as kpi_name,
        'orders_raw' as table_name,
		'order_date' as column_name,
		 1 as issue_count,
		'medium' as risk_level,
        'Affects time based revenue trend analysis' as business_impact
union all
select 'Invalid Order Date' as kpi_name,
        'orders_raw' as table_name,
		'order_date' as column_name,
		 1 as issue_count,
		'medium' as risk_level,
        'Data entry errors affect time-based trend analysis' as business_impact
union all
select 'Missing Order Amount' as kpi_name,
        'orders_raw' as table_name,
		'order_amount' as column_name,
		 2 as issue_count,
		'high' as risk_level, 
        'Incorrect revenue calculation and inaccurate financial reporting' as business_impact
union all
select 'Invalid Order Amount' as kpi_name,
        'orders_raw' as table_name,
		'order_amount' as column_name,
		 2 as issue_count,
		'high' as risk_level,
        'Incorrect revenue calculation and inaccurate profit reporting' as business_impact
union all
select 'Missing Payment Method' as kpi_name,
        'orders_raw' as table_name,
		'payment_method' as column_name,
		 0 as issue_count,
		'low' as risk_level,
        'No data quality issues detected' as business_impact
union all
select 'Invalid Payment Method' as kpi_name,
        'orders_raw' as table_name,
		'payment_method' as column_name,
		 0 as issue_count,
		'low' as risk_level,
        'No data quality issues detected' as business_impact
union all
select 'Missing Order Status' as kpi_name,
        'orders_raw' as table_name,
		'order_status' as column_name,
		 1 as issue_count,
		'medium' as risk_level,
        'Unclear lifecycle and revenue recognition' as business_impact
union all
select 'Invalid Order Status' as kpi_name,
        'orders_raw' as table_name,
		'order_status' as column_name,
		 0 as issue_count,
		'low' as risk_level,
        'No data quality issues detected' as business_impact;





