use Data_bank;
##1 
select count(distinct node_id) as unique_nodes
from customer_nodes;

##2 How many nodes are there in each region
select region_id, count(node_id) as node_count
from customer_nodes
inner join regions
using (region_id)
group by region_id; 

##3 how many customers are divided among the regions
select region_id, count(distinct customer_id) as customer_count
from customer_nodes
inner join regions
using (region_id)
group by region_id;

##4 determine the total amount of transaction for each region name.
select region_name, sum(txn_amount) as
'Total transaction amount'
from regions,customer_nodes,customer_transactions
where regions.region_id=customer_nodes.region_id and
customer_nodes.customer_id=customer_transactions.customer_id
group by region_name
order by region_name;

##5 How long does it take on an average to move client to a new node?
select round(avg(datediff(end_date,start_date)),2) as avg_time
from customer_nodes
where end_date!='9999-12-31';

##6 what is the unique and the total amount for each transaction type?
select distinct(count(txn_type)) as unique_txn,txn_type, sum(txn_amount) as total_txn
from customer_transactions
group by txn_type;

##7 What is the average no. and size of past deposit across all customers?

SELECT round(count(customer_id)/
               (SELECT count(DISTINCT customer_id)
                FROM customer_transactions)) AS average_deposit_count,
       concat('$', round(avg(txn_amount), 2)) AS average_deposit_amount
FROM customer_transactions
WHERE txn_type = "deposit";