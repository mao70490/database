select *  from northwindc.dbo.員工

select *  from 員工

SELECT 員工編號 AS 編號,姓名 員工姓名,職稱 FROM 員工

--計算欄位
SELECT 單價*數量 AS 價格 FROM 訂貨明細
go
SELECT 姓名+''+職稱 AS 公司成員 FROM 員工
go
SELECT LEFT(姓名,1)+職稱 +' ' +RIGHT(姓名,len(姓名)-1) AS 公司成員 FROM 員工
go

--移除重覆值DISTINCT
select distinct 職稱 from 員工

--不同資料類型運算,無法使用隱含轉換，運算失敗
SELECT 14 + 姓名 尊稱 FROM 員工

--轉換為相同型態
SELECT convert(nvarchar(3),14) + 姓名 尊稱 FROM 員工

--WHERE資料過濾
select 員工編號,姓名,職稱 from 員工 where 職稱='業務'

--Like模糊比對
select 員工編號,姓名,職稱 from 員工 where 職稱 like '業務_理'


select 客戶編號,公司名稱 from 客戶

--練習
--1.請找出銀行客戶
SELECT * FROM 客戶 WHERE 公司名稱  LIKE '%銀行'
GO
--2.查詢在中正路上的供應商
select * from 供應商 where 地址 like '%中正路%'
GO
--3.查詢客戶名稱第1個字是大或山或東的資料
select * from 客戶 where 公司名稱 like '[大山東]%'
GO
--4.找出客戶編號最後以 AS 或 AR 或 OS 或 OR 結尾的資料
select * from 客戶 where 客戶編號 like '%[AO][SR]'
go
--5.找出客戶編號第二個字為NAO及最後一個字為GHIJK的客戶資料
select * from 客戶 where 客戶編號 like '_[NAO]%[G-K]'
go

--注意邏輯運算優先順序
SELECT * FROM 產品資料 WHERE 庫存量<=安全存量 and 類別編號 =1 or 類別編號 =3

SELECT * FROM 產品資料 WHERE 庫存量<=安全存量 and (類別編號 =1 or 類別編號 =3)

--IN的用法
SELECT * FROM 產品資料 WHERE 庫存量<=安全存量 and 
(類別編號 =1 or 類別編號 =2 or 類別編號 =3 or 類別編號 =4 or 類別編號 =5)

SELECT * FROM 產品資料 WHERE 庫存量<=安全存量 and 類別編號 in (1,2,3,4,5)

SELECT * FROM 產品資料 WHERE 庫存量<=安全存量 and 類別編號 not in (1,2,3,4,5)


select 員工編號,姓名,相片 from 員工 
select 員工編號,姓名,isnull(相片,'未繳交相片') 照片 from 員工 

--執行順序
select 員工編號,姓名,職稱,相片 from 員工 where 職稱='業務'


--聚合函式
SELECT SUM( 數量 ) 訂購總數,COUNT(訂單號碼 ) 訂單筆數,
AVG(數量 ) 平均數量,MIN(數量 ) 單筆訂購最小值,MAX(數量 ) 單筆訂購最大值
FROM dbo.訂貨明細
WHERE 產品編號=51


SELECT 產品編號,SUM( 數量 ) 訂購總數,COUNT(訂單號碼 ) 訂單筆數,
AVG(數量 ) 平均數量,MIN(數量 ) 單筆訂購最小值,MAX(數量 ) 單筆訂購最大值
FROM dbo.訂貨明細
WHERE 產品編號 in(51,52)
group by 產品編號





select 職稱,count(員工編號) 人數
from 員工
group by 職稱

---Having
select 職稱,count(員工編號) 人數
from 員工
group by 職稱
having count(員工編號)>=2

--小計與總計
SELECT 產品編號 , 單價, SUM(數量) 總數量
FROM 訂貨明細
WHERE 產品編號 IN (50,51)
Group By 產品編號,單價
WITH ROLLUP

SELECT 產品編號 , 單價, SUM(數量) 總數量
FROM 訂貨明細
WHERE 產品編號 IN (50,51)
Group By 產品編號,單價
WITH cube

SELECT 產品編號 , 單價, SUM(數量) 總數量
FROM 訂貨明細
WHERE 產品編號 IN (50,51)
Group By Grouping sets(( 產品編號,單價),產品編號,())

--top n
SELECT  Top 5 with ties *
FROM 訂貨明細
order by 數量 desc


--OFFSET 和 FETCH NEXT 分頁查詢
select * from 訂貨主檔
ORDER BY 訂單號碼 OFFSET 5 ROW FETCH NEXT 5 ROWS ONLY
