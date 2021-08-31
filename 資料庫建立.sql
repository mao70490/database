--  create/alter database 作業
/*
建立資料庫TestDB,資料庫要有三個檔案群組(含預設群組),每群組需有二個資料檔,
每個資料檔初始容量5MB,每次成長30%,最大限制2G,
建立兩個記錄檔,初始容量5MB,成長5MB,最大限制2G,
資料檔請存D:\DataBase目錄,記錄檔請存D:\DBLog目錄
*/
CREATE DATABASE testdb
ON(
	NAME = testdb1,
	FileName = 'C:\database\testdb1.mdf',
	Size = 5,
	MaxSize = 2GB,
	filegrowth = 30%
	),
	(NAME = testdb2,
	FileName = 'C:\database\testdb2.mdf',
	Size = 5,
	MaxSize = 2GB,
	filegrowth = 30%
	),
	filegroup G2(
	NAME = g2_1,
	FileName = 'C:\database\g2_1.ndf',
	Size = 5,
	MaxSize = 2GB,
	filegrowth = 30%
	),
	(
	NAME = g2_2,
	FileName = 'C:\database\g2_2.ndf',
	Size = 5,
	MaxSize = 2GB,
	filegrowth = 30%
	),
	filegroup G3(
	NAME = g3_1,
	FileName = 'C:\database\g3_1.ndf',
	Size = 5,
	MaxSize = 2GB,
	filegrowth = 30%
	),
	(
	NAME = g3_2,
	FileName = 'C:\database\g3_2.ndf',
	Size = 5,
	MaxSize = 2GB,
	filegrowth = 30%
	)
	log on(
	NAME = test1_log,
	FileName = 'C:\dblog\test1_log.ldf',
	Size = 5,	
	MaxSize = 2GB,
	filegrowth = 5MB
	),
	(
	NAME = test2_log,
	FileName = 'C:\dblog\test2_log.ldf',
	Size = 5,	
	MaxSize = 2GB,
	filegrowth = 5MB
	)
GO 


drop database testdb
go



--卸離資料庫
sp_detach_db testdb
go






--附加資料庫
sp_attach_db testdb,'C:\database\testdb1.mdf'
go






--在Primary群組裡新增一個資料檔案 DB3.NDF
sp_helpdb testdb

alter database testdb 
add file (
          name=DB3,
		  filename='C:\database\DB3.ndf',
          size=5MB,
		  MaxSize = 2GB,
	      filegrowth = 30%
		  )
go




--刪除資料檔案 DB3.NDF
alter database testdb remove file DB3







/*
1.請新增一個檔案群組G4
2.在G4群組中新增一個資料檔案G4_DB1,
3.將檔案群組G4修改為Default群組
4.將Primary群組裡的資料檔案的不限制最大值
5.新增一個記錄檔DB_Log_4,檔案大小500MB
*/

--1.
alter database testdb add filegroup G4

--2.
alter database testdb 
add file(name=G4_DB1,
         filename='C:\database\G4_DB1.ndf',
		 size=5MB,
		  MaxSize = 2GB,
	      filegrowth = 30%
		  )
to filegroup G4
go

--3.
alter database testdb
modify filegroup G4 default
go


--4.
alter database testdb
modify file(name=testdb1,
            filename='C:\database\testdb1.mdf',
            maxsize=unlimited)

alter database testdb
modify file(name=testdb2,
		    filename='C:\database\testdb2.mdf',
		   maxsize=unlimited)
go
             






--5.
alter database testdb
add log file(name=DB_Log_4,
             filename='C:\dblog\DB_Log_4.ldf',
			 size=500MB)
go
              









