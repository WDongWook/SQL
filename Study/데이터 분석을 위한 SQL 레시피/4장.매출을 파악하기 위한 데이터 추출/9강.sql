/* ���� ������ ����� */

create table purchase_log (dt date, order_id number(2), user_id varchar(255), purchase_amount number);

insert into purchase_log values('2014-01-01',1,'rhwpvvitou',13900);
insert into purchase_log values('2014-01-01',2,'hqnwoamzic',10616);
insert into purchase_log values('2014-01-02',3,'tzlmqryunr',21156);
insert into purchase_log values('2014-01-02',4,'wkmqqwbyai',14893);
insert into purchase_log values('2014-01-03',5,'ciecbedwbq',13054);
insert into purchase_log values('2014-01-03',6,'svgnbqsagx',24384);
insert into purchase_log values('2014-01-03',7,'dfgqftdocu',15591);
insert into purchase_log values('2014-01-04',8,'sbgqlzkvyn',3025);
insert into purchase_log values('2014-01-04',9,'lbedmngbol',24215);
insert into purchase_log values('2014-01-04',10,'itlvssbsgx',2059);
insert into purchase_log values('2014-01-04',11,'uwvexwncwp',7324);
insert into purchase_log values('2014-01-04',12,'nvlntuwtaz',9521);
insert into purchase_log values('2014-01-05', 13, 'pgeojzoshx', 16008);
insert into purchase_log values('2014-01-06', 14, 'msjberhxnx',  1980);
insert into purchase_log values('2014-01-06', 15, 'tlhbolohte', 23494);
insert into purchase_log values('2014-01-06', 16, 'gbchhkcotf',  3966);
insert into purchase_log values('2014-01-07', 17, 'zfmbpvpzvu', 28159);
insert into purchase_log values('2014-01-07', 18, 'yauwzpaxtx',  8715);
insert into purchase_log values('2014-01-07', 19, 'uyqboqfgex', 10805);
insert into purchase_log values('2014-01-08', 20, 'hiqdkrzcpq',  3462);
insert into purchase_log values('2014-01-08', 21, 'zosbvlylpv', 13999);
insert into purchase_log values('2014-01-08', 22, 'bwfbchzgnl',  2299);
insert into purchase_log values('2014-01-09', 23, 'zzgauelgrt', 16475);
insert into purchase_log values('2014-01-09', 24, 'qrzfcwecge',  6469);
insert into purchase_log values('2014-01-10', 25, 'njbpsrvvcq', 16584);
insert into purchase_log values('2014-01-10', 26, 'cyxfgumkst', 11339);


/* 1. ��¥�� ���� �����ϱ� */

select dt,count(*) as purchase_count, sum(purchase_amount) as total_amount, round(avg(purchase_amount),2) as avg_amount
from purchase_log
group by dt
order by dt;


/* 2. �̵������ ����� ��¥�� ���� ���� */

select dt, sum(purchase_amount) as total_amount, round(avg(sum(purchase_amount)) over(order by dt rows between 6 preceding and current row),2) as avg_seven_day,
case when 7 = count(*) over(order by dt rows between 6 preceding and current row) then round(avg(sum(purchase_amount)) over(order by dt rows between 6 preceding and current row),2) end as avg_seven_day_strict
from purchase_log
group by dt
order by dt;


/* 3. ��� ���� ���� ���ϱ� */

/* 3-1. ��¥�� ����� ���� ���� ���� ���� ����� */
select dt,substr(dt,1,5) as year_month, sum(purchase_amount) as total_amount,sum(sum(purchase_amount)) over(partition by substr(dt,1,5) order by dt rows unbounded preceding) as agg_amount
from purchase_log
group by dt
order by dt;

/* 3-2. ��¥�� ������ �Ͻ� ���̺�� ����� */

create table daily_purchase as select dt, extract(year from dt) as year, extract(month from dt) as month, extract(day from dt) as day, sum(purchase_amount) total_amount
from purchase_log
group by dt
order by dt;

/* 3-3 daily_purchase ���̺�� ��� ���� ������ �����ϴ� ���� ����� */

select dt,concat(year,'-') || month as year_month,total_amount, sum(total_amount) over(partition by year,month order by dt rows unbounded preceding) as agg_amount
from daily_purchase;


/* 4. ���� ������ �۴�� ���ϱ� */

/* purchase_log ���ο� ������ ���̺� ����� */

drop table purchase_log;
create table purchase_log (dt date, order_id number, user_id varchar(255), purchase_amount number);

insert into purchase_log values('2014-01-01',    1, 'rhwpvvitou', 13900);
insert into purchase_log values('2014-02-08',   95, 'chtanrqtzj', 28469);
insert into purchase_log values('2014-03-09',  168, 'bcqgtwxdgq', 18899);
insert into purchase_log values('2014-04-11',  250, 'kdjyplrxtk', 12394);
insert into purchase_log values('2014-05-11',  325, 'pgnjnnapsc',  2282);
insert into purchase_log values('2014-06-12',  400, 'iztgctnnlh', 10180);
insert into purchase_log values('2014-07-11',  475, 'eucjmxvjkj',  4027);
insert into purchase_log values('2014-08-10',  550, 'fqwvlvndef',  6243);
insert into purchase_log values('2014-09-10',  625, 'mhwhxfxrxq',  3832);
insert into purchase_log values('2014-10-11',  700, 'wyrgiyvaia',  6716);
insert into purchase_log values('2014-11-10',  775, 'cwpdvmhhwh', 16444);
insert into purchase_log values('2014-12-10',  850, 'eqeaqvixkf', 29199);
insert into purchase_log values('2015-01-09',  925, 'efmclayfnr', 22111);
insert into purchase_log values('2015-02-10', 1000, 'qnebafrkco', 11965);
insert into purchase_log values('2015-03-12', 1075, 'gsvqniykgx', 20215);
insert into purchase_log values('2015-04-12', 1150, 'ayzvjvnocm', 11792);
insert into purchase_log values('2015-05-13', 1225, 'knhevkibbp', 18087);
insert into purchase_log values('2015-06-10', 1291, 'wxhxmzqxuw', 18859);
insert into purchase_log values('2015-07-10', 1366, 'krrcpumtzb', 14919);
insert into purchase_log values('2015-08-08', 1441, 'lpglkecvsl', 12906);
insert into purchase_log values('2015-09-07', 1516, 'mgtlsfgfbj',  5696);
insert into purchase_log values('2015-10-07', 1591, 'trgjscaajt', 13398);
insert into purchase_log values('2015-11-06', 1666, 'ccfbjyeqrb',  6213);
insert into purchase_log values('2015-12-05', 1741, 'onooskbtzp', 26024);

select *
from purchase_log;

/* 4-1. ���� ����� �۴�� ����ϴ� ���� ����� */

select distinct extract(month from dt) as month, sum(case extract(year from dt) when 2014 then purchase_amount end) as amount_2014,
sum(case extract(year from dt) when 2015 then purchase_amount end) as amount_2015,
round(100 * (sum(case extract(year from dt) when 2015 then purchase_amount end) / sum(case extract(year from dt) when 2014 then purchase_amount end)),2) as rate
from purchase_log
group by extract(month from dt)
order by extract(month from dt);


/* 5. Z��Ʈ�� ������ ���� Ȯ���ϱ� */

/* 5-1. 2015�� ���⿡ ���� Z��Ʈ �ۼ��ϴ� ���� ����� */

create table purchase_df as select dt, extract(year from dt) year, extract(month from dt) month,purchase_amount
from purchase_log;

select *
from(select substr(dt,1,5) as year_month,purchase_amount, sum(case when year = 2015 then purchase_amount end) over(order by year,month rows unbounded preceding) as agg_amount,
sum(purchase_amount) over(order by year,month rows between 11 preceding and current row) as year_avg_amount
from purchase_df) a
where substr(year_month,1,2) = '15';