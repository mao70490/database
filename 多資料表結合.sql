--1.請列出訂單號碼10612的訂貨明細及產品名稱
SELECT 訂貨明細.* , 產品資料.產品 '產品名稱'
FROM  訂貨明細, 產品資料
WHERE 訂單號碼  = 10612 and 訂貨明細.產品編號 = 產品資料.產品編號
go

--2.請列出每一筆訂單客戶公司名稱、聯絡人及負責的業務人員
SELECT　公司名稱,連絡人,連絡人職稱
from 客戶
where 連絡人職稱　LIKE '業務%'
go

--3.請列出中正路上的每個客戶購買支出總金額。
SELECT 訂貨主檔.送貨地址　'中正路上', 單價*數量*(1-折扣) AS 價格 
FROM 訂貨主檔,訂貨明細
where　送貨地址　LIKE '%中正路%'
go

--4.請查詢沒有訂單資料的客戶。
select C.客戶編號 ,C.公司名稱 from 客戶 C 
where not exists (select 1 from 訂貨主檔 O 
				　where O.客戶編號 = C.客戶編號)
go

--5.使用子查詢語法查詢產品單價高於該產品類別平均值的資料。
select 產品資料.單價,產品類別.類別名稱
from 產品資料 inner join 產品類別
on 產品資料.類別編號 = 產品類別.類別編號
where 單價 >=all(select avg(單價) from 產品資料)
go

--6.請找出交易金額最高的訂單、承辦人員及客戶。
select 單價*數量*(1-折扣) AS 價格,連絡人,公司名稱
from 訂貨明細,客戶
where 單價*數量*(1-折扣) >= all(select distinct 單價*數量*(1-折扣) from 訂貨明細)

--7.請列出最受歡迎的前五名產品名稱。(以數量統計)
SELECT TOP　5 with ties *
FROM 訂貨明細
ORDER by 數量 desc
--8.請統計公司性別人數總人數。
select 稱呼, count(員工編號) 人數 
from 員工
group by 稱呼 
with rollup

--9.請統計員工負責的訂單數、銷售產品個數、銷售產品類別個數。
select 員工編號,count(distinct 訂貨主檔.訂單號碼) '訂單數',count(distinct 訂貨明細.產品編號) '產品個數',
	   count(distinct 類別編號) '產品類別個數'
from 訂貨主檔 inner join 訂貨明細 on 訂貨主檔.訂單號碼=訂貨明細.訂單號碼
	 inner join 產品資料 on 訂貨明細.產品編號=產品資料.產品編號
group by 員工編號

--10.請統計員工歷年業績，業績小數位取至第2位，第3位四捨五入，並以年度為欄位顯示統計資料，當年度沒有業績者以無交易顯示。
select c.員工編號,year(a.訂單日期) 年度,isnull(cast(round((sum(b.單價*b.數量*(1-b.折扣))),2)as varchar),'無交易') 業績, c.姓名
from 員工 c
left join 訂貨主檔 a on a.員工編號=c.員工編號
left join 訂貨明細 b on a.訂單號碼=b.訂單號碼
group by c.員工編號, year(a.訂單日期), c.姓名 
order by 年度

--11.將趙飛燕派駐至客戶最少的地區，開拓業務
update 員工 
set 城市 = ( select 客戶.城市 
			 from  ( select top 1 城市 ,count(*) 客戶數 
		             from 客戶 
					 group by 城市 
					 order by 客戶數 ) 客戶 )
		where 姓名='趙飛燕'
--12.派駐1998年業績第2好的業務至客戶最少的地區，開拓業務
UPDATE 員工 SET 城市 =
(SELECT TOP 1 城市 FROM 客戶 GROUP BY 城市 ORDER BY  COUNT(城市))
WHERE 員工編號 =
(SELECT a.員工編號 FROM
(SELECT c.員工編號, SUM(b.總金額) 年總金額
FROM 訂貨主檔 c JOIN
(SELECT 訂單號碼, SUM(訂貨明細.單價*訂貨明細.數量*(1-訂貨明細.折扣))總金額
FROM 訂貨明細 GROUP BY 訂單號碼) b ON c.訂單號碼 = b.訂單號碼
WHERE YEAR(c.訂單日期) = 1998 GROUP BY c.員工編號 ORDER BY 年總金額 DESC 
OFFSET 1 ROW FETCH NEXT 1 ROWS ONLY) a)

UPDATE 員工 SET 城市 = '台北市' WHERE 員工編號 = 2