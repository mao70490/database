--  create/alter database �@�~
/*
�إ߸�ƮwTestDB,��Ʈw�n���T���ɮ׸s��(�t�w�]�s��),�C�s�ջݦ��G�Ӹ����,
�C�Ӹ���ɪ�l�e�q5MB,�C������30%,�̤j����2G,
�إߨ�ӰO����,��l�e�q5MB,����5MB,�̤j����2G,
����ɽЦsD:\DataBase�ؿ�,�O���ɽЦsD:\DBLog�ؿ�
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



--������Ʈw
sp_detach_db testdb
go






--���[��Ʈw
sp_attach_db testdb,'C:\database\testdb1.mdf'
go






--�bPrimary�s�ո̷s�W�@�Ӹ���ɮ� DB3.NDF
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




--�R������ɮ� DB3.NDF
alter database testdb remove file DB3







/*
1.�зs�W�@���ɮ׸s��G4
2.�bG4�s�դ��s�W�@�Ӹ���ɮ�G4_DB1,
3.�N�ɮ׸s��G4�קאּDefault�s��
4.�NPrimary�s�ո̪�����ɮת�������̤j��
5.�s�W�@�ӰO����DB_Log_4,�ɮפj�p500MB
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
              









