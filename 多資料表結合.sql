--1.�ЦC�X�q�渹�X10612���q�f���Ӥβ��~�W��
SELECT �q�f����.* , ���~���.���~ '���~�W��'
FROM  �q�f����, ���~���
WHERE �q�渹�X  = 10612 and �q�f����.���~�s�� = ���~���.���~�s��
go

--2.�ЦC�X�C�@���q��Ȥ᤽�q�W�١B�p���H�έt�d���~�ȤH��
SELECT�@���q�W��,�s���H,�s���H¾��
from �Ȥ�
where �s���H¾�١@LIKE '�~��%'
go

--3.�ЦC�X�������W���C�ӫȤ��ʶR��X�`���B�C
SELECT �q�f�D��.�e�f�a�}�@'�������W', ���*�ƶq*(1-�馩) AS ���� 
FROM �q�f�D��,�q�f����
where�@�e�f�a�}�@LIKE '%������%'
go

--4.�Ьd�ߨS���q���ƪ��Ȥ�C
select C.�Ȥ�s�� ,C.���q�W�� from �Ȥ� C 
where not exists (select 1 from �q�f�D�� O 
				�@where O.�Ȥ�s�� = C.�Ȥ�s��)
go

--5.�ϥΤl�d�߻y�k�d�߲��~�������Ӳ��~���O�����Ȫ���ơC
select ���~���.���,���~���O.���O�W��
from ���~��� inner join ���~���O
on ���~���.���O�s�� = ���~���O.���O�s��
where ��� >=all(select avg(���) from ���~���)
go

--6.�Ч�X������B�̰����q��B�ӿ�H���ΫȤ�C
select ���*�ƶq*(1-�馩) AS ����,�s���H,���q�W��
from �q�f����,�Ȥ�
where ���*�ƶq*(1-�馩) >= all(select distinct ���*�ƶq*(1-�馩) from �q�f����)

--7.�ЦC�X�̨��w�諸�e���W���~�W�١C(�H�ƶq�έp)
SELECT TOP�@5 with ties *
FROM �q�f����
ORDER by �ƶq desc
--8.�вέp���q�ʧO�H���`�H�ơC
select �٩I, count(���u�s��) �H�� 
from ���u
group by �٩I 
with rollup

--9.�вέp���u�t�d���q��ơB�P�ⲣ�~�ӼơB�P�ⲣ�~���O�ӼơC
select ���u�s��,count(distinct �q�f�D��.�q�渹�X) '�q���',count(distinct �q�f����.���~�s��) '���~�Ӽ�',
	   count(distinct ���O�s��) '���~���O�Ӽ�'
from �q�f�D�� inner join �q�f���� on �q�f�D��.�q�渹�X=�q�f����.�q�渹�X
	 inner join ���~��� on �q�f����.���~�s��=���~���.���~�s��
group by ���u�s��

--10.�вέp���u���~�~�Z�A�~�Z�p�Ʀ���ܲ�2��A��3��|�ˤ��J�A�åH�~�׬������ܲέp��ơA��~�רS���~�Z�̥H�L�����ܡC
select c.���u�s��,year(a.�q����) �~��,isnull(cast(round((sum(b.���*b.�ƶq*(1-b.�馩))),2)as varchar),'�L���') �~�Z, c.�m�W
from ���u c
left join �q�f�D�� a on a.���u�s��=c.���u�s��
left join �q�f���� b on a.�q�渹�X=b.�q�渹�X
group by c.���u�s��, year(a.�q����), c.�m�W 
order by �~��

--11.�N�����P���n�ܫȤ�̤֪��a�ϡA�}�ݷ~��
update ���u 
set ���� = ( select �Ȥ�.���� 
			 from  ( select top 1 ���� ,count(*) �Ȥ�� 
		             from �Ȥ� 
					 group by ���� 
					 order by �Ȥ�� ) �Ȥ� )
		where �m�W='�����P'
--12.���n1998�~�~�Z��2�n���~�ȦܫȤ�̤֪��a�ϡA�}�ݷ~��
UPDATE ���u SET ���� =
(SELECT TOP 1 ���� FROM �Ȥ� GROUP BY ���� ORDER BY  COUNT(����))
WHERE ���u�s�� =
(SELECT a.���u�s�� FROM
(SELECT c.���u�s��, SUM(b.�`���B) �~�`���B
FROM �q�f�D�� c JOIN
(SELECT �q�渹�X, SUM(�q�f����.���*�q�f����.�ƶq*(1-�q�f����.�馩))�`���B
FROM �q�f���� GROUP BY �q�渹�X) b ON c.�q�渹�X = b.�q�渹�X
WHERE YEAR(c.�q����) = 1998 GROUP BY c.���u�s�� ORDER BY �~�`���B DESC 
OFFSET 1 ROW FETCH NEXT 1 ROWS ONLY) a)

UPDATE ���u SET ���� = '�x�_��' WHERE ���u�s�� = 2