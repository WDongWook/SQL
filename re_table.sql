/*********** �籸���� �� �����ֱ� ���̺� ����� **********/

create table re_table as
select mem_no,ù����,�ֱ�,Ƚ��,case when (�ֱ� - ù����) = 0 then 'N' else 'Y' end as �籸�ſ���, �ֱ� - ù���� as ���Ű���, (�ֱ� - ù����)  / (Ƚ��-1) as �����ֱ� 
from(select mem_no, min(order_date) as ù���� ,max(order_date) as �ֱ�, count(order_no) as Ƚ��
from sales
group by mem_no)
order by mem_no;


/* ���� */

select *
from re_table;


/* 1. ȸ��(1000021)�� �������� */

select *
from re_table
where mem_no = 1000021;

select *
from sales
where mem_no = 1000021;


/* 2. �籸�� ȸ���� ����(%)*/

select count(mem_no) as ����ȸ����, count(case when �籸�ſ��� ='Y' then mem_no end) as �籸��ȸ����, round(count(case when �籸�ſ��� ='Y' then mem_no end) / count(mem_no),2) as ����
from re_table;


/* 3. ��� �����ֱ� �� �����ֱ� ������ ȸ���� */

select round(avg(�����ֱ�),2) as ��ձ����ֱ�
from re_table
where �����ֱ� > 0;

select �ֱ�Ⱓ, count(�ֱ�Ⱓ) as ������_ȸ����
from(select mem_no,�����ֱ�, case when �����ֱ� < 8 then '7�� �̳�' 
when �����ֱ� < 15 then '2�� �̳�' when �����ֱ� < 22 then '3�� �̳�' 
when �����ֱ� < 29 then '4�� �̳�' else '4�� �̻�' end as �ֱ�Ⱓ
from re_table
where �����ֱ� > 0)
group by �ֱ�Ⱓ 
order by ������_ȸ����;