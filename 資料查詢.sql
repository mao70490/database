select *  from northwindc.dbo.���u

select *  from ���u

SELECT ���u�s�� AS �s��,�m�W ���u�m�W,¾�� FROM ���u

--�p�����
SELECT ���*�ƶq AS ���� FROM �q�f����
go
SELECT �m�W+''+¾�� AS ���q���� FROM ���u
go
SELECT LEFT(�m�W,1)+¾�� +' ' +RIGHT(�m�W,len(�m�W)-1) AS ���q���� FROM ���u
go

--�������Э�DISTINCT
select distinct ¾�� from ���u

--���P��������B��,�L�k�ϥ����t�ഫ�A�B�⥢��
SELECT 14 + �m�W �L�� FROM ���u

--�ഫ���ۦP���A
SELECT convert(nvarchar(3),14) + �m�W �L�� FROM ���u

--WHERE��ƹL�o
select ���u�s��,�m�W,¾�� from ���u where ¾��='�~��'

--Like�ҽk���
select ���u�s��,�m�W,¾�� from ���u where ¾�� like '�~��_�z'


select �Ȥ�s��,���q�W�� from �Ȥ�

--�m��
--1.�Ч�X�Ȧ�Ȥ�
SELECT * FROM �Ȥ� WHERE ���q�W��  LIKE '%�Ȧ�'
GO
--2.�d�ߦb�������W��������
select * from ������ where �a�} like '%������%'
GO
--3.�d�߫Ȥ�W�ٲ�1�Ӧr�O�j�Τs�ΪF�����
select * from �Ȥ� where ���q�W�� like '[�j�s�F]%'
GO
--4.��X�Ȥ�s���̫�H AS �� AR �� OS �� OR ���������
select * from �Ȥ� where �Ȥ�s�� like '%[AO][SR]'
go
--5.��X�Ȥ�s���ĤG�Ӧr��NAO�γ̫�@�Ӧr��GHIJK���Ȥ���
select * from �Ȥ� where �Ȥ�s�� like '_[NAO]%[G-K]'
go

--�`�N�޿�B���u������
SELECT * FROM ���~��� WHERE �w�s�q<=�w���s�q and ���O�s�� =1 or ���O�s�� =3

SELECT * FROM ���~��� WHERE �w�s�q<=�w���s�q and (���O�s�� =1 or ���O�s�� =3)

--IN���Ϊk
SELECT * FROM ���~��� WHERE �w�s�q<=�w���s�q and 
(���O�s�� =1 or ���O�s�� =2 or ���O�s�� =3 or ���O�s�� =4 or ���O�s�� =5)

SELECT * FROM ���~��� WHERE �w�s�q<=�w���s�q and ���O�s�� in (1,2,3,4,5)

SELECT * FROM ���~��� WHERE �w�s�q<=�w���s�q and ���O�s�� not in (1,2,3,4,5)


select ���u�s��,�m�W,�ۤ� from ���u 
select ���u�s��,�m�W,isnull(�ۤ�,'��ú��ۤ�') �Ӥ� from ���u 

--���涶��
select ���u�s��,�m�W,¾��,�ۤ� from ���u where ¾��='�~��'


--�E�X�禡
SELECT SUM( �ƶq ) �q���`��,COUNT(�q�渹�X ) �q�浧��,
AVG(�ƶq ) �����ƶq,MIN(�ƶq ) �浧�q�ʳ̤p��,MAX(�ƶq ) �浧�q�ʳ̤j��
FROM dbo.�q�f����
WHERE ���~�s��=51


SELECT ���~�s��,SUM( �ƶq ) �q���`��,COUNT(�q�渹�X ) �q�浧��,
AVG(�ƶq ) �����ƶq,MIN(�ƶq ) �浧�q�ʳ̤p��,MAX(�ƶq ) �浧�q�ʳ̤j��
FROM dbo.�q�f����
WHERE ���~�s�� in(51,52)
group by ���~�s��





select ¾��,count(���u�s��) �H��
from ���u
group by ¾��

---Having
select ¾��,count(���u�s��) �H��
from ���u
group by ¾��
having count(���u�s��)>=2

--�p�p�P�`�p
SELECT ���~�s�� , ���, SUM(�ƶq) �`�ƶq
FROM �q�f����
WHERE ���~�s�� IN (50,51)
Group By ���~�s��,���
WITH ROLLUP

SELECT ���~�s�� , ���, SUM(�ƶq) �`�ƶq
FROM �q�f����
WHERE ���~�s�� IN (50,51)
Group By ���~�s��,���
WITH cube

SELECT ���~�s�� , ���, SUM(�ƶq) �`�ƶq
FROM �q�f����
WHERE ���~�s�� IN (50,51)
Group By Grouping sets(( ���~�s��,���),���~�s��,())

--top n
SELECT  Top 5 with ties *
FROM �q�f����
order by �ƶq desc


--OFFSET �M FETCH NEXT �����d��
select * from �q�f�D��
ORDER BY �q�渹�X OFFSET 5 ROW FETCH NEXT 5 ROWS ONLY
