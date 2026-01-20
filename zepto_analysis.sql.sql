create database zepto
use zepto
drop table if exists zepto;

create table zepto(
sku_id SERIAL PRIMARY KEY,
category Varchar(150),
name Varchar(120) not null,
mrp NUMERIC(8,2),
discountpercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
WeightinGms INTEGER,
outOfStock Varchar(5),
quantity INTEGER);

--DATA EXPLORATION--
SELECT COUNT(*) FROM ZEPTO

--Sample data--
select * from Zepto
limit 10

--Null Values--
Select * from zepto
where name is null
or
category is null
or
 mrp is null
or
 discountpercent is null
or
 availableQuantity is null
or
 discountedSellingPrice is null
or
 WeightinGms is null
or 
 outOfStock is null
or 
 quantity is null;

--Product Categories--
select distinct category from Zepto
order by category;

--products in stock--
select outOfStock, count(sku_id)
from zepto
group by outOfStock;

--product name multiple times--
select name, count(sku_id) as "Number of SKUs"
from zepto
group by name
having count(sku_id) > 1
order by count(sku_id) desc;

--product with price 0--
Select * from Zepto
where mrp = 0 or discountedsellingprice= 0;

delete from zepto 
where mrp = 0;

--convert paise to rupees--
update zepto 
set mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

--Business Insights--
1. Find the top 10 best-value products based on the discounted percentage
select distinct name, mrp, discountPercent
from zepto
order by discountPercent DESC
LIMIT 10;

2. WHat are the product having high mrp but are outof stock
select distinct name, mrp, outOfStock
from Zepto
where outOfStock = "TRUE" and mrp > 300
order by mrp DESC;

3. Calculate estimated revenue for each category
select category, sum(discountedSellingPrice * availableQuantity) as total_revenue
from zepto
group by category
order by total_revenue;

4. Find all product where MRP is greater than  rs 500 and discount is less than 10.
select distinct name, mrp, discountPercent
from Zepto
where discountPercent < 10 and mrp > 500
order by mrp DESC, discountPercent DESC

5. Isdentify the tp 5 categories offering the highest average disount percentage.
select category, round(avg(discountPercent),2) as avg_discount
from zepto
group by category
order by avg_discount DESC
limit 5;

6. Find the price per gram for products abover 100g and sort by best value.
SELECT distinct name, weightInGms, discountedSellingPrice,
round(discountedSellingPrice/weightInGms,2) as price_per_gram
from zepto
where weightInGms >= 100
order by price_per_gram;

7. Group the products into categories like low, medium, bulk.
select distinct name, weightInGms,
case
	 when weightInGms < 1000 then 'LOW'
     when weightInGms < 5000 then 'MED'
     ELSE 'BULK'
     END AS weight_category
     from Zepto;
     
8. What is the total inventory weight per category
select category,
sum( weightInGms * availableQuantity ) as total_weight
from Zepto
Group by Category
order by total_weight;  

9. Revenue vs Discount Analysis
select category,
round(avg(discountPercent),2) as avg_discount,
sum(discountedSellingPrice * quantity) as total_revenue
from zepto
group by category
order by total_revenue desc;   

---10.Identify products priced above category average--
SELECT name, category, mrp
FROM zepto z
WHERE mrp >
      (SELECT AVG(mrp)
       FROM zepto
       WHERE category = z.category);

11. Top 3 Expensive Products (Window Function)
SELECT name, category, mrp
FROM (
    SELECT name,
           category,
           mrp,
           ROW_NUMBER() OVER (ORDER BY mrp DESC) AS rn
    FROM zepto
) t
WHERE rn <= 3;

12. Highest Discount Product per Category
select name, category, discountPercent
from (select name, category, discountPercent,
Rank() over (partition by category 
             order by discountPercent desc) As rnk 
             from Zepto)t
where rnk = 1;
