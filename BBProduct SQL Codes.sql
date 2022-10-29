
select type, count(type) from dbo.bbproducts group by type 

WITH Highest_Price_Per_SubCategory AS(
select category, SUB_CATEGORY, FORMAT(max(market_price),'N2') as 'Max_Price', ROW_NUMBER() OVER(PARTITION BY CATEGORY ORDER BY max(market_price) DESC) as 'rows' from dbo.bbproducts group by category,sub_category
)
select * from Highest_Price_Per_SubCategory where rows = 1

select Distinct category from bbproducts order by category 


select * from dbo.BBProducts

--Total Products Per Category
Select category, count(product) as 'Number_Of_Products' from dbo.bbproducts group by category


--Higher Products in each subcategory grouped by category
WITH Highest_Product_Count_Per_Subcategory AS (

Select Category, sub_category, Count(product) As 'Product_Count' , ROW_NUMBER() OVER(Partition by category ORDER BY count(Product) DESC) AS 'Row_Number' from BBProducts group by category,sub_category 

)

Select category,Sub_category, product_count from Highest_product_count_per_subcategory where ROW_NUMBER = 1

select * from BBProducts where brand is null

--Highest Brand Count Per Sub Cateogry Grouped By Category
WITH Highest_Brand_Count_Per_SubCategory  AS(
Select Category, Sub_Category, Brand, count(brand)as 'Product_Quantity', ROW_NUMBER() OVER(Partition by category order by count(brand) DESC) as 'Row_Number' from bbProducts group by category,sub_category,brand 
)

Select Category,Sub_Category, Brand, Product_Quantity from Highest_Brand_Count_Per_SubCategory where ROW_NUMBER = 1


--Avg Market Price vs Sale Price per category

Select Category, Format(AVG(Sale_Price),'N2') as 'Average_Sale_Price', Format(Avg(Market_Price),'N2') as 'Average_Market_Price' from BBProducts group by Category

--Min Market Price vs Max Market Price Per Category

Select Category, Max(Market_Price) as 'Max_Market_Price', Min(Market_Price) as 'Min_Market_Price' from BBProducts group by Category 

--Min Sale Price vs Max Sale Pice Per Category

Select Category, Max(Sale_Price) as 'Max_Sale_Price', Min(Sale_Price) as 'Min_Sale_Price' from BBProducts group by Category 


--Brand by the most expensive Per Category

WITH Brand_Number_1_Per_Category AS (
Select Category, Sub_Category, Brand, Market_Price , Product, ROW_NUMBER() OVER(PARTITION BY CATEGORY ORDER BY Market_Price DESC) as 'Rows_Number' From BBProducts group by category,sub_category,brand,Product,market_price
)

Select Category, Sub_Category, Brand, Market_Price , Product from Brand_Number_1_Per_Category where rows_number = 1;

--Average Price with Brand That has the most product 

With AVG_Market_Sale_Brand AS(
Select Category,brand, Format(Avg(Market_Price),'N2') AS 'Market_Price', Format(Avg(Sale_Price),'N2') AS 'SALE_PRICE', Count(Brand) as 'Product_Quant', ROW_NUMBER() Over(Partition by Category Order by Count(brand) Desc) as 'Rows' from BBProducts group by category ,brand
)

Select Category,brand,Market_Price,SALE_PRICE,Product_Quant from AVG_Market_Sale_Brand where rows = 1 OR rows = 2 OR rows = 3


--Rating Average Per Category

With Rating_Table_With_No_Null AS (

Select Category, Brand, Count(Brand),Avg(Rating), ROW_NUMBER() OVER(Partition by Category Order by Count(Brand) Desc,AVG(Rating) Desc) from BBProducts where Rating is not null group by Category, brand

)


Select Category, Format(AVG(Rating),'N2') From Rating_Table_With_No_Null group by category order by category


--Highest_Rating_For_Sub_Category_by_Brand

WITH High_Rate_Per_Sub AS (

Select Category,Sub_Category,Brand,((Rating*count(rating)) + (Avg(rating)*3)/(count(rating) + 3)) , ROW_NUMBER() Over(Partition by Category order by ((Rating*count(rating)) + (Avg(rating)*3)/(count(rating) + 3)) DESC) from dbo.bbproducts where rating is not null group by category,Sub_Category,Brand,Rating

)

Select Category, Format(AVG(Rating),'N2') from bbproducts group by category order by category