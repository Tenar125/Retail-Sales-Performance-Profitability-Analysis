use retaildb;
select * from SalesData;
-- Question 1:
-- Do different product categories contribute significantly differently to total revenue?
select Product_name,Category,round(sum(Sales),2) as Total_Sales
from SalesData 
group by Product_name,Category ;
-- Insights:
-- Some product categories generate significantly more revenue than others.
-- Question 2 :
-- Does lower price actually lead to higher sales volume?
select Product_name,sum(Quantity) as Total_Quantity ,
round((sum(Sales)/sum(Quantity)),2) as Price,Category
from SalesData
group by Product_name,Category
order by Total_Quantity desc  ;
-- Insights:
-- Basic  Office supplies with lower product price show higher  purchase volumn,
-- however product necessity and customer prefrence also play an important role.
-- Question 3 
-- Do repeat customers generate more revenue than one-time customers?
select Customer_Type,
count(Customer_id) as Total_Customer,
round(sum(Total_Sales),2) as Total_Revenue,
ROUND(AVG(Total_Sales),2) AS Avg_Revenue_per_Customer
from (
select Customer_id ,
case 
when count(*)  > 1 then 'Repeat' else 'One-Time' End as 'Customer_Type', 
round(sum(Sales),2) as Total_Sales
from SalesData
group by  Customer_id) 
as Customer_Summary
group by Customer_Type ;
-- Insights:
-- Repeat customer generate significantly more revenue per customer compared to one-time buyers.
-- investing in loyalty  programs recommended. 
-- Question 4 :
-- Are sales significantly higher in certain months or seasons?
select Order_month,round(sum(Sales),2) as Total_Sales
from SalesData 
group by Order_month 
order by Total_Sales desc ;
-- Insights:
-- Sales peak in November,December and September.Inventory planning
-- and  marketing campaigns should be focused on these months.
-- Question 5 : Do certain regions contribute more to total revenue?
select Region,round(sum(Sales),2) as Total_Sales
from SalesData 
group by Region 
order by Total_Sales desc;
-- Insights
-- The West generates the Highest revenue.
-- Question 6:
-- Is there a small group of customers contributing most of the revenue (Pareto Principle)?
select 
    round((sum(Total_Sales) / (select sum(Sales) from SalesData))*100, 2) as Top20_Percentage
from (
    select Customer_id, sum(Sales) as Total_Sales
    from SalesData
    group by Customer_id
    order by Total_Sales desc
    limit 20  
) as TopCustomers;
-- Insights : Revenue is evenly distributed among customers.
-- Question 7:
-- Do customers show clear preference for certain categories?
select Category,Sub_category ,round(sum(Sales),2) as Total_Sales 
from SalesData 
group by Category,Sub_category
order by Total_Sales desc;
-- Insights:
-- Customers prefer specific categories,especially Technology.Business should invest more in 
-- promotions for phones.
-- Question no 8 :
-- which city or state contribute more in revenue?
select count(*) as Orders,City, round(sum(Sales),2) as Total_Sales 
from SalesData 
group by City
order by Total_Sales desc ;
-- Insights:
-- The new York City generates the highest revenue and order volumn.Introducing
-- speciall offers and deals in this city  can further increase sales. 
-- Question 9 :
-- Do discounted products generate significantly higher revenue?
select 
    Product_name,
    round(avg(Discount), 2) as Avg_Discount,
    round(sum(Sales), 2) as Total_Sales,
    round(avg(Sales), 2) as Avg_Sales_Per_Transaction
from SalesData
group by Product_name
order by Avg_Discount desc;
-- Insights:
-- High discount alone isn’t generating higher revenue. In fact, products with slightly lower 
-- discount can generate much more revenue if they are in-demand or expensive.
-- Question 10 
-- Which customer segments contribute most to revenue?
select count(distinct Customer_id)as Num_customer,Segment,round(sum(Sales),2) as Total_Sales
from SalesData
group by Segment
order by Total_Sales desc;
-- Insights
-- The Consumer segment generates the highest
-- revenue due to a large number of buyers.Focus on volume for consumers and 
-- high-value deals for corporate clients.
