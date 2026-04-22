-- =========================================
-- 1. Dimension Tables 
-- =========================================

CREATE TABLE Dim_Calendar (
    Date_Key DATE PRIMARY KEY,
    Year INT,
    Quarter INT,
    Month_Num INT,
    Month_Name NVARCHAR(20),
    Is_Weekend BIT
);

CREATE TABLE Dim_Geography (
    Region_Key INT PRIMARY KEY,
    Province NVARCHAR(50),
    City NVARCHAR(50),
    Territory NVARCHAR(50),
    Population_Density NVARCHAR(20),
    Warehouse_Name NVARCHAR(50)
);

CREATE TABLE Dim_Products (
    Product_Key INT PRIMARY KEY,
    Product_Name NVARCHAR(100),
    Brand NVARCHAR(50),
    Sub_Category NVARCHAR(50),
    Flavor NVARCHAR(50),
    Unit_Cost DECIMAL(10,2),
    Standard_Price DECIMAL(10,2),
    Capacity_Litre DECIMAL(5,2),
    Weight_Kg DECIMAL(5,2),
    Shelf_Life_Days INT
);

CREATE TABLE Dim_Stores (
    Store_Key INT PRIMARY KEY,
    Store_Name NVARCHAR(100),
    Channel NVARCHAR(50),
    Store_Grade NVARCHAR(20),
    Region_Key INT,
    Sub_Channel NVARCHAR(50),
    Payment_Term NVARCHAR(50),
    Latitude DECIMAL(9,6),
    Longitude DECIMAL(9,6)
);

CREATE TABLE Dim_Salesmen (
    Salesman_Key INT PRIMARY KEY,
    Salesman_Name NVARCHAR(100),
    Supervisor_Name NVARCHAR(100),
    Position NVARCHAR(50),
    Commission_Rate DECIMAL(5,3),
    Hiring_Date DATE,
    Sales_Tool NVARCHAR(50)
);

CREATE TABLE Dim_Promotions (
    Promo_Key INT PRIMARY KEY,
    Promo_Name NVARCHAR(100),
    Discount_Percentage DECIMAL(5,2),
    Promo_Budget DECIMAL(15,2),
    Min_Qty_To_Apply INT,
    Promo_Objective NVARCHAR(100)
);

-- =========================================
-- 2. Fact Tables 
-- =========================================

CREATE TABLE Fact_Sales (
    Transaction_ID INT,  
    Date_Key NVARCHAR(20), 
    Store_Key INT,
    Product_Key INT,
    Salesman_Key INT,
    Promo_Key INT,
    Order_Source NVARCHAR(50),
    Quantity_Cases INT,
    Qty_Returned INT,
    Return_Reason NVARCHAR(50),
    Gross_Sales DECIMAL(15,2),
    Discount_Amount DECIMAL(15,2),
    Net_Sales DECIMAL(15,2),
    COGS DECIMAL(15,2)
);

CREATE TABLE Fact_Targets (
    Salesman_Key INT,
    Target_Month DATE,
    Target_Amount_EGP DECIMAL(15,2)
);

CREATE TABLE Fact_Market_Share (
    Date_Key DATE,
    Region_Key INT,
    Brand_Name NVARCHAR(50),
    Volume_Share_Percentage DECIMAL(10,2),
    Value_Share_Percentage DECIMAL(10,2),
    Competitor_Price DECIMAL(10,2),
    Availability_Status NVARCHAR(10),
    Shelf_Space_Share DECIMAL(10,2)
);

CREATE TABLE Fact_Visits (
    Visit_ID INT PRIMARY KEY,
    Date_Key NVARCHAR(20),
    Store_Key INT,
    Salesman_Key INT,
    Is_Ordered BIT,
    OOS_Items_Count INT,
    Visit_Duration_Minutes INT,
    GPS_Distance_Check_Meters INT,
    Visit_Type NVARCHAR(50)
);


select Transaction_ID,count(*) as number_of_copies

from Fact_Sales 
group by Transaction_ID 
having count(*)>1 
order by number_of_copies desc;


select top 20
Transaction_ID,Date_Key

from Fact_Sales
where date_key like '%/%' 
      or isdate(date_key)=0;


select fs.Store_Key as ghost_store_key

from Fact_Sales fs 
left join Dim_Stores ds on fs.Store_Key=ds.Store_key
where ds.Store_Key is null


select 
Transaction_ID,
Quantity_Cases,
Qty_Returned,
Return_Reason
from fact_sales
where Qty_Returned>Quantity_Cases 


CREATE VIEW vw_Fact_Sales_Clean AS

WITH RankedSales AS (
    -- 1. حل مشكلة المكرر: إعطاء رقم تسلسلي لكل فاتورة
    SELECT 
        *,
        ROW_NUMBER() OVER(PARTITION BY Transaction_ID ORDER BY Date_Key DESC) as row_num
    FROM Fact_Sales
)
SELECT 
    Transaction_ID,
    
    -- 2. حل مشكلة التواريخ: تحويل النصوص لتواريخ صحيحة، وتوحيد الفورمات المصري (103) والأمريكي
    COALESCE(TRY_CAST(Date_Key AS DATE), TRY_CONVERT(DATE, Date_Key, 103)) AS Clean_Date,
    
    fs.Store_Key,
    fs.Product_Key,
    fs.Salesman_Key,
    fs.Promo_Key,
    Order_Source,
    Quantity_Cases,
    
    -- 3. حل مشكلة المنطق التجاري: لو المرتجع أكبر من المباع، خليه يساوي المباع كحد أقصى
    CASE 
        WHEN Qty_Returned > Quantity_Cases THEN Quantity_Cases 
        ELSE Qty_Returned 
    END AS Qty_Returned,
    
    Return_Reason,
    Gross_Sales,
    Discount_Amount,
    Net_Sales,
    COGS

FROM RankedSales fs
-- 4. حل مشكلة المحلات الوهمية: عرض الفواتير المربوطة بمحلات حقيقية فقط (INNER JOIN)
INNER JOIN Dim_Stores ds ON fs.Store_Key = ds.Store_Key

-- تفعيل فلتر المكرر: اختيار النسخة الأولى فقط من كل فاتورة
WHERE row_num = 1;  
  


select * from vw_Fact_Sales_Clean


select @@SERVERNAME
