##### **Zepto Product \& Pricing Analysis (Advanced SQL)**



###### **Project Overview**



This project focuses on analyzing product pricing, discounts, and revenue performance for a Zepto-like quick commerce platform using SQL.

The objective is to derive business insights by applying advanced SQL concepts such as window functions, subqueries, ranking, and aggregations.



###### **Business Objectives**



1. Identify high-priced and high-discount products
2. Analyze category-wise pricing and discount patterns
3. Rank products based on price and discount
4. Compare product performance against category averages
5. Support data-driven pricing and promotion decisions



###### **Dataset Description**



The dataset contains product-level data with the following key fields:



1. name – Product name
2. category – Product category
3. mrp – Maximum Retail Price
4. selling\_price – Final price paid by customer
5. discountPercent – Discount percentage (already provided in data)
6. quantity – Units sold



**Note:** selling\_price represents the discounted final price.

discountPercent is sourced directly from the dataset and validated where required.



###### **🛠 SQL Concepts Used**

###### 

This project demonstrates strong command over:



* Window Functions (ROW\_NUMBER, RANK, DENSE\_RANK)
* PARTITION BY and ORDER BY
* Correlated Subqueries
* Aggregations (SUM, AVG)
* Business Metric Calculations
* Ranking \& Filtering Logic
* Subqueries with Aliases



###### **Key Analysis \& Queries**



1. **Top Expensive Products**

* Identified the most expensive products based on MRP
* Used ordering and ranking logic



**2. Category-wise Top Products**

* Ranked products within each category
* Handled ties using RANK()



**3. Highest Discounted Product per Category**

* Extracted products with maximum discount in each category
* Ensured correct tie handling



**4. Products Above Category Average Price**

* Used correlated subquery to compare product MRP with category average



**5. Revenue Analysis**

* Calculated category-level revenue
* Analyzed revenue contribution using SQL aggregations



**Sample Advanced Query**

SELECT name,

&nbsp;      category,

&nbsp;      discountPercent

FROM (

&nbsp;   SELECT name,

&nbsp;          category,

&nbsp;          discountPercent,

&nbsp;          RANK() OVER (

&nbsp;              PARTITION BY category

&nbsp;              ORDER BY discountPercent DESC

&nbsp;          ) AS rnk

&nbsp;   FROM zepto

) t

WHERE rnk = 1;



###### **Key Insights**



1. Certain categories contribute disproportionately to total revenue
2. High discounts are not always associated with high revenue
3. Premium-priced products tend to cluster within specific categories
4. Category-level analysis provides better insights than overall averages
