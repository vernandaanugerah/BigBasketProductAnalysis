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



General Structure

We need to find the general structure of the data. This is in order to find specific insight mostly related to the category and subcategory of the product list. Therefore we need to find all the listed categories and sub_category. 

Select distinct category from dbo.bbproducts

By using the SQL query above, we can find all the listed categories in the product list



Select category, sub_category from dbo.bbproducts group by category, sub_category order by category

By using the SQL Query above, we can figure out all the listed sub category and the main category it belongs to : 








