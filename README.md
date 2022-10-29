# BigBasketProductAnalysis

This is a Exploratory Data Analysis of products in Big Basket, a online e-commerce chain based in India. 

This Dataset is based on https://www.kaggle.com/datasets/surajjha101/bigbasket-entire-product-list-28k-datapoints by Suraj Jha.

There are three main objectives that we want to achieve in this EDA :

Find out the basic structure of the Data ( Categories, Sub_Categories)
Garner insight based on several data points (Rating, Sale_Price, Market_Price)
Visualise those insight into readable and digestible charts

We would be using SQL for our main data exploration and Tableau for visualisation of the result of our exploration. 


We would be using the SQL Query Below to look at the full data :
```
Select * From bbProducts
```
The data at first would look like this :

![Pic1](https://user-images.githubusercontent.com/38880564/197454382-0350edaf-77ba-49cc-829a-e11f724a9c89.PNG)


There are multiple columns in the data, namely :

Index : Index of the product
Product : Name of the product
Category : Main category of the Product
Sub_Category : The Sub Category under the Main Category 
Brand : The Brand of the product 
Sale_Price : The Sale Price of the Product
Market_Price : The Market Price of the Product 
Type : What type of product it is
Rating : The rating given to the product
Description : The description of the product. 



# General Structure

We need to find the general structure of the data. This is in order to find specific insight mostly related to the category and subcategory of the product list. Therefore we need to find all the listed categories and sub_category. 
```
Select distinct category from dbo.bbproducts
```
By using the SQL query above, we can find all the listed categories in the product list


```
Select category, sub_category from dbo.bbproducts group by category, sub_category order by category
```

By using the SQL Query above, we can figure out all the listed sub category and the main category it belongs to : 



# Insights

## Total Product count per Category 

The first insight that we could derive is the total product count for each category and how each category makes up the product list. 

By using the SQL Query below, we can figure out the number of the products per category  and If we sort it by using an order by statement we can sort the category from the highest product count to the lowest product count. 

```
Select category, count(product) as 'Number_Of_Products' from dbo.bbproducts group by category order by Number_Of_Products DESC
```

The result is as follow 

![Tot Product count category](https://user-images.githubusercontent.com/38880564/198824128-cfff874d-b717-442c-934d-ff05695c52a8.PNG)


We can see that beauty & hygiene has the most product count with 7867 products and Eggs, Meat and Fish has the least amount of products with 350 products.

## Highest Product count in the Sub-Category of each Category 

One of the other insights that we can derive is the highest product count of each sub category under the main category of products. This insight is useful to figure out which of the sub-category needs more products or even cut down on the product counts. We can derive this particular insight by using a Temporary table. 

```

WITH Highest_Product_Count_Per_Subcategory AS (

Select Category, sub_category, Count(product) As 'Product_Count' , ROW_NUMBER() OVER(Partition by category ORDER BY count(Product) DESC) AS 'Row_Number' from BBProducts group by category,sub_category

)

Select category,Sub_category, product_count from Highest_product_count_per_subcategory where ROW_NUMBER = 1

```

The result is as follows 

![High Product Count Per Sub_Cat](https://user-images.githubusercontent.com/38880564/198824082-75b8d1cf-ceeb-4aab-b62f-ea55daaec663.PNG)

## Average Market Price vs Sale Price

The next insight that we can derive is the average market price versus the sale price. This is quite an important information because the sale price is the price that bbproducts sells its products at, while the market price is the price of the product in the market. Finding out the difference could mean that we could know the biggest category of products that bbproducts is undercutting in terms of their price. 

The SQL function used in this insights is the aggregation function, namely AVG. We would also do additional calculation in the SQL query itself to calculate the difference in percentage between market price and sale price. The query is as follows : 

```
Select Category, Format(AVG(Sale_Price),'N2') as 'Average_Sale_Price', Format(Avg(Market_Price),'N2') as 'Average_Market_Price', Format((AVG(Market_Price)-AVG(SALE_PRICE))/((AVG(MARKET_PRICE)+AVG(SALE_PRICE))/2)*100,'N2') + ' %' AS 'Difference in percentage' from BBProducts group by Category
```

The result is as follows : 
![Average Market Price Vs Sale Price Per Diff](https://user-images.githubusercontent.com/38880564/198824077-4b54a6c9-3afe-4146-b2ae-c168b5ef9e3a.PNG)


## Average Market Price Vs Sale Price per top 3 Brand

One of the other possible information that we could derive from this data is the average market price vs sale price for the top 3 brand with the most product count. This is because these brands with high product counts will be more accessible to the customers due to their variety of products offering. As such finding the information regarding their market price and sale price could be valuable. 

The SQL Query used will use the CTE function along with partitioning as the query will have to rank each brand based on their product count. The query used is as follows : 

With AVG_Market_Sale_Brand AS(
Select Category,brand, Format(Avg(Market_Price),'N2') AS 'Market_Price', Format(Avg(Sale_Price),'N2') AS 'SALE_PRICE', Count(Brand) as 'Product_Quant', ROW_NUMBER() Over(Partition by Category Order by Count(brand) Desc) as 'Rows' from BBProducts group by category ,brand
)

Select Category,brand,Market_Price,SALE_PRICE,Product_Quant from AVG_Market_Sale_Brand where rows = 1 OR rows = 2 OR rows = 3

The result is as follows :

![AVG Mark Price V SP TOP 3 Brand](https://user-images.githubusercontent.com/38880564/198824061-b681e230-c9bd-4262-a71e-5bd334afdb5c.PNG)



## Average Rating 

The last possible information that might be useful is the average rating of each category. The data is structured in a way that each of the products will be given a rating from 1-5. By finding out the average rating we can know which category is rated highest or whichever is rated lowest.

The SQL Query used will have to use the Group By Function. It is written as follows :

Select Category, Format(AVG(Rating),'N2') From dbo.BBProducts Group by category order by category

![Rating](https://user-images.githubusercontent.com/38880564/198824065-d722c47f-5ed1-40dc-aa09-5e8ee7ba13ca.PNG)





