create table employee(
empid int primary key,
id varchar (9) ,
LName varchar (20),
FName varchar (20),
birthday date,
mid char,
phone varchar(10),
adress varchar (30),
city varchar (20),
position varchar(1),
dateHire date
)
insert employee
values(1,'111111111',' לוי','דני','1975/02/01',null,'3232222','רבי עקיבא','ירושליים','1','1995/01/01'),
	  (2,'222222222',' כהן','צחי','1990/05/30','1','5454444','נרקיס','תל-אביב','3','2010/01/01'),
	  (3,'333333333',' ברגר','משה','1973/02/01','4','8884544','שושנה','רמת-גן','4',null),
	  (4,'444444444',' אלוני','דוד','1974/03/01',null,'8999999','פרחים','גבעתיים','1',null),
	  (5,'555555555',' כהן','אהרון','1975/01/01','1','8888885','צבי','בני-ברק','3',null),
	  (6,'666666666',' שרוני','רמי','1975/08/01','1','6565656','אביבים','תל-אביב','3',null),
	  (7,'777777777',' נחומי','אברהם','1975/08/01','4','5455554','חבצלת','ירושליים','4',null),
	  (8,'888888888',' שרעבי','יצחק','1923/02/01','4','534989','שושנים ','בני-ברק','4',null)


-------משכורות-------

create table employee_pay(
payid int identity(1,1)primary key,
EmpID int foreign key(EmpID) references employee(empid),
payrate int,
PeriodDate date,
monthhours float,
salary float,
Bonus int 

)

insert employee_pay
values (1,60,'2019/01/01',200,6500,120),
	   (2,100,'2020/02/01',300,5000,30),
	   (1,25,'2022/01/01',100,1500,300),
	   (4,50,'2022/08/01',150,6500,300),
	   (2,30,'2021/10/06',180,5500,400)

-------מתקנים-------

create table luna(
lunaName varchar(20),
Lid int primary key,
cost int,
waitTime int,
actTime float,
age int
)


insert luna
values('balarina',1,50,30,3,8),
	  ('train'   ,2,60,40,3.5,10),
	  ('airplain',3,100,38,4,12)
	  
-------לקוחות------

create table customers(
custId int identity(1,1) primary key,
custName varchar (20),
custadress varchar (20),
custCity varchar (20),
custPhone  varchar (10),
custAge int
)

insert customers
values('דני','רשבם ','ירושלים','26565555',10),
		('דוד','רבנו תם ','בני-ברק','4534544',15),
		('נתי','הנרקיס','רמת-גן','4545444',20),
		('אברהם ','החבצלת ','בני-ברק','8773222',13),
		('יצחק','רקפת','חולון','6756756',12)


-------הזמנות-------

create table orders(
ordnum int identity(1,1) primary key,
custID int foreign key(custID) references customers(custId),
lid int foreign key (lid) references luna(Lid),
orddate date

)

insert orders
values(2,2,'2023/01/03'),
	  (1,3,'2023/02/05'),
	  (3,2,'2023/03/08')

-----פעילויות----

create table activities(
	  acttype int,
	  act varchar(30),
	  actdate datetime,
	  actCost int
)
insert activities
values(2,'הצגה','2020/05/09 14:03:00 ',20),
	(2,'מופע','2024/05/17 12:03:00 ',20),
	(2,'הצגה','2024/05/09 17:03:00 ',20)
	  


 create table empDate (
  Edate date,
  lid int,
  EmpID int,
  primary key (Edate, lid, EmpID),
  foreign key (lid) references luna(lid),
  foreign key (EmpID) references employee(empid)
)

insert empDate
values('2024/5/16',2,6),
	  ('2024/5/17',3,3)

select* from employee
select* from employee_pay
select* from customers
select* from orders
select* from luna
select* from activities
select *from empDate

--------אילוצים-------
alter table employee add constraint age check(DATEDIFF(d, birthday,GETDATE()) >=18*365)
alter table employee add constraint empid check( len(empid)=9 
alter table employee add constraint empid check(empid between '0' and '9')
alter table luna add constraint lunaName check (lunaName between 'a' and 'z' )
alter table employee_pay add constraint bonus check (bonus<= 800)
alter table employee_pay add constraint payrate check (payrate between 30 and 200)
alter table orders add constraint lid check(lid between 1 and 6)
alter table custumers add constraint custphone check(len(custphone)=10 or len(custphone)=9)

---טבלה מדומה---
create view ProfitableLuna (lid, lunaname,total)
as
    SELECT l.Lid, l.lunaName, l.cost* COUNT(o.ordnum) AS orders_count
    FROM luna l
    LEFT JOIN orders o ON l.Lid = o.lid
    GROUP BY l.Lid, l.lunaName,l.cost
--------------------
select *from ProfitableLuna

--------------------------מטרות--------------------------

-------	באיזה חודש בשנה הכי הרבה מגיעים ---

select top 1 with ties
MONTH(orddate) as mon, count(lid) as cnt 
from orders group by MONTH(orddate)
order by count(lid) desc


-------איזה מתקן הכי פחות רווחי------------
select top 1 *from ProfitableLuna order by total
------- הרווח השנתי השנה לעומת שנה שעברה----
select dbo.checkk('שנה')
--------הגיל הממוצע של המבקרים--------------
select avg(custAge) as average from customers 
-------העיר שיש בה הכי הרבה לקוחות----------


select top 1 with ties custcity from customers 
where custCity not like 'תל אביב' 
group by custcity order by count(custId) desc


------- שמות המתקנים שעלו עליהם יותר מ 10000 בשנה---

SELECT lunaName, COUNT(o.ordnum) AS order_count
FROM luna l
JOIN orders o ON l.Lid = o.lid
WHERE  DATEDIFF(d,orddate,getdate())<365
GROUP BY lunaName  
HAVING COUNT(o.ordnum) > 2


------------------------פרוצדורות--------------------------

-------מחיקת עובד שבשנה האחרונה לא עבד-------

create function empNotWork(@empid int)
returns int
as
begin
declare @date date
declare @days int
--מביא את התאריך האחרון שהעובד עבד
set @date=(select top 1 PeriodDate from employee_pay where empid=@empid order by PeriodDate desc)
set @days=DATEDIFF(d, @date,GETDATE())
return @days
end

create procedure deleteEmp
as
begin
declare @empid int=(select count(*) from employee)
declare @days int
	WHILE(@empid!=0)
		begin
			set @days= (select dbo.empNotWork(@empid))
		if(@days>=365)
		begin
		print @empid
			delete from employee_pay where EmpID=@empid
			delete from empDate where EmpID=@empid
			delete from employee where empid=@empid
		end
		set @empid-=1
	end
end


---------שליפת מנהל על ידי קוד עובד----
--create procedure mid(@empid varchar(9)) 
--as
--begin
--select e.empid,e.FName,e.phone 
--FROM employee e left join employee e1 on e.empid=e1.mid 
--where e1.empid=@empid
--end
--exec mid '3'
--drop proc mid
-----------------------------------------
-------שליפת עובדים שתחת מנהל מסוים----

create procedure checkEmployees(@empid int) 
as
begin
if exists(select mid from employee where empid=@empid and mid IS NULL)
	begin
		select e.empid,e.FName,e.phone 
		FROM employee e left join employee e1 on e.mid=e1.empid 
		where e1.empid=@empid
	end
else
	begin
	  print 'טעות קוד זה לא שייך למנהל'
	end
end


exec checkEmployees 4

-----------------------------------------


--------אם זמן ההמתנה עולה על  שעה ירד זמן ההפעלה של המתקן ב 10%------
create procedure waiting
as
begin
update luna set actTime *=0.9 where waitTime>=60 and acttime>2
end
-------------




---------פרוצדורה טבלת עובדים---------
create procedure inemployee(@id varchar(10) ,@emptz int  ,@LName varchar(10) ,@FName varchar(10) ,@birthday date, @mid char, @phone varchar(10), @adress varchar(10), @city varchar(10),@position varchar, @dateHire date)
as 
begin
INSERT INTO employee (id,empid,LName,FName,birthday,mid,phone,adress,city ,position ,dateHire )
values(@id,@emptz,@LName,@FName,@birthday, @mid, @phone, @adress, @city,@position, @dateHire)
end
exec inemployee '123456789',9,'cohen','gabi','2000/4/4',1,'033333333','rashi','bb','2','2023/7/1'
select * from employee
-----------------------------------------

---------פרוצדורה טבלת  מתקנים---------
create procedure inluna(@lunaName varchar(20),@Lid int ,@cost int,@waitTime int,@actTime float,@age int)
as
begin
INSERT luna
values(@lunaName,@Lid,@cost,@waitTime,@actTime,@age)
end
drop proc inluna
exec inluna 'candy',4,70,50,2.2,15
-----------------------------------------

--------פרוצדורה טבלת לקוחות---------
create procedure incustomers(@custname varchar(20),@custaddress varchar(20),@custcity varchar(20),@custphone varchar(10),@custage int)
as
begin
    insert into customers (custname, custadress, custcity, custphone, custage)
    values (@custname, @custaddress, @custcity, @custphone, @custage)
end

 
 ----------------------------------------

 ---------פרוצדורה טבלת הזמנות-----------

create procedure inorders(@custID int ,@lid int,@orddate date)
as
begin
if exists(select custAge 
	from customers c inner join luna l 
	on c.custId=l.Lid
	where c.custAge>=l.age)
		begin
			insert orders
			values(@custID,@lid,@orddate)
		end
else
	begin
	print 'הגיל לא תואם למתקן'
	end
end
	
drop proc inorders
select*from orders
--------------
--exec inorders 2,2,'2020/05/09'
--exec inorders 3,2,'2024/04/12'
--exec inorders 3,3,'2024/02/12'
--exec inorders 3,2,'2023/03/09'
--exec inorders 3,2,'2022/03/12'
--exec inorders 3,2,'2022/03/13'
--exec inorders 4,2,'2024/03/13'
--exec inorders 4,2,'2024/05/17'
--exec inorders 5,2,'2024/05/10'
--exec inorders 4,2,'2024/05/17'
--exec inorders 5,2,'2024/05/10'
--exec inorders 5,2,'2024/05/18'
--exec inorders 3,3,'2024/04/20'
--exec inorders 3,3,'2023/04/20'
--exec inorders 5,4,'2023/04/20'
--exec inorders 5,4,'2023/04/20'
--exec inorders 5,1,'2023/03/20'
--exec inorders 3,4,'2023/03/20'
--exec inorders 5,4,'2023/03/20'

select *from orders


-----------------------------------------

------פרוצדורה טבלת תאריכי עבודה-----
create procedure inempDate(@Edate date,@lid int,@EmpID int)
as
begin
INSERT empDate
values(@edate,@lid,@EmpID)
end
-------פרוצדורה טבלת פעילויות------

create procedure inactivities( @acttype int,@act varchar(30), @actdate datetime,  @actCost int ) 	
as
begin
insert activities
values( @acttype,@act , @actdate, @actCost)
end

---------טריגר--------

create trigger actday on orders 
after insert
as
	select top 1 act,actdate
	from activities a inner join orders o on o.orddate=cast(actdate as date) 
	where orddate=cast(actdate as date) order by ordnum 


------------------------

------פרוצדורה שמקבלת שנה ומחזירה את היום שהגיעו הכי הרבה ---

create procedure MostComing(@year int)
as
begin
select top 1 with ties orddate,COUNT(ordnum), a.act from orders o 
inner join activities a on a.actdate=o.orddate 
where YEAR(orddate)=2024 group by orddate,a.act order by  COUNT(ordnum) desc
end

----------------------------------------------------------


-----פרוצדורה שמקבלת תאריך ומתקן ומראה את פרטי העובד שפנוי אותו יום---
------פרוצדורה שניה שמראה באיזה תראיכים החודש שי מתקנים שאין שם עובדים ומשבצת את העובדים הפנויים--
create view empCanWorkView as
select empid, newid() as random
from employee

create function empCanWork (@date date)
returns table
as
return (
    select empid, ROW_NUMBER() over (order by random) as row_num
    from empCanWorkView
    where empid not in
        (select ed.empid
         from empDate ed
         inner join employee e on ed.EmpID = e.empid
         where @date = Edate)
)
select * from employee_pay
--create function empCanWork (@date date)
--returns table
--as
--return (
--    with cte as (
--            select empid, newid() as random from employee
--    )

--	select  ROW_NUMBER() over (order by random) as row_num
--        from cte
--        where empid not in (
--            select ed.empid
--            from empDate ed
--            inner join employee e on ed.EmpID = e.empid
--            where  Edate= '2024/3/3'
--        ) 

--)

select*from dbo.empCanWork('2024/05/16')

create procedure checkLunaEmp(@day int)
AS begin
    WHILE (@day != 0)
    begin
        declare @empid int
        declare @num int = (SELECT COUNT(*) FROM luna)
        WHILE (@num != 0)
        begin
            if not exists (
                select empid 
                from empDate 
                where MONTH(Edate) = (MONTH(GETDATE()) + 1) and 
				YEAR(Edate) = (YEAR(GETDATE())) and DAY(Edate) = @day and lid = @num
)  
            begin
                declare @year INT = YEAR(GETDATE())
                declare @month INT = (MONTH(GETDATE()) + 1);
                declare @newDay INT = @day;
                declare @date DATE = CONCAT(@year, '/', @month, '/', @newDay)
                
                set @empid = (SELECT TOP 1 empid FROM dbo.empCanWork(@date))

                if (@empid is not null)
                begin
                    insert into empDate (Edate, lid, empid)
                    VALUES (@date, @num, @empid);
                end
              else
                begin
                    PRINT 'חסר עובד בתאריך: ' + CONVERT(varchar, @date, 103) + ' מתקן: ' + CAST(@num AS NVARCHAR)
                end
            end
            set @num -= 1
        end
        set @day -= 1
    end
end




exec inempDate '2024/05/16',4,7
exec inempDate '2024/07/1',4,7
exec inempDate '2024/07/2',2,1
exec inempDate '2024/07/4',1,8
exec inempDate '2024/07/5',1,6
exec inempDate '2024/07/5',2,5

exec checkEmpLuna @day = 30;




---------------

---------פונקציות----------

--------בדיקת רווח שנתי או רבעוני לעומת השנה הקודמת---

create function checkk (@type varchar(6))
returns int
as begin
declare @total int
if @type='שנה'
  begin
	set @total=
	(select sum(l.cost) from luna l 
	inner join orders o on l.Lid=o.lid
	 where year(orddate)=year(GETDATE())-1)

	set @total=@total-
	(select sum(l.cost) from luna l 
	inner join orders o on l.Lid=o.lid
	 where year(orddate)=year(GETDATE())-2)
  end

if @type='רבעון'
  begin
	set @total=(select sum(l.cost) from luna l 
	inner join orders o on l.Lid=o.lid
		where year(orddate)=year(GETDATE()) 
		and (MONTH(orddate)=MONTH(GETDATE())-1 
		or MONTH(orddate)=MONTH(GETDATE())-2
		or MONTH(orddate)=MONTH(GETDATE())-3))
		
	set @total=@total-(select sum(l.cost) from luna l
	inner join orders o on l.Lid=o.lid
		where year(orddate)=year(GETDATE())-1 
		and (MONTH(orddate)=MONTH(GETDATE())-1 
		or MONTH(orddate)=MONTH(GETDATE())-2
		or MONTH(orddate)=MONTH(GETDATE())-3))
  end
  
 return @total
end

-----------------------------------
select dbo.checkk('שנה')

--------פונקציה שמקבלת שם מתקן ומחזירה את הגיל הממוצע של המשתמשים בו------

create function avgAge(@name varchar(20))
returns int
as
begin
declare @age int
set @age=(select avg(custAge) 
from customers c inner join orders o on o.custID=c.custId
    inner join luna l on o.lid=l.Lid
	where lunaName=@name)
return @age
end


-----------------------------------
select dbo.avgAge('airplain')

-----------טרנזקציה-----------------

create procedure inemployeePay( @EmpID int,@payrate int,@PeriodDate date,@monthhours float)
	as
	begin
	begin try
	begin tran

	update employee_pay set payrate+=1 where @EmpID in
	(select e.empid from employee e  join employee_pay ep on e.empid=ep.EmpID
	where YEAR(datehire) not like YEAR(getdate()) and month(datehire) = month(getdate()))

	insert employee_pay
	values (@EmpID,@payrate,@PeriodDate,@monthhours,@monthhours*@payrate,0)

	  update employee_pay
	  set Bonus = monthhours * payrate * 0.1
	  where EmpID = @EmpID
	  and monthhours > 150
commit tran	
end try
	begin catch
	rollback tran
		print 'שגיאה'
		select ERROR_MESSAGE()
		select ERROR_NUMBER()
		select ERROR_SEVERITY()
	end catch
end
drop proc inemployeePay
exec inemployeePay 1,40,'2024/3/4',100
-----------------------------------------


---הרשאות---
create login customer with password='1111'
create user user1 for login customer

create login employee with password='2222'
create user user2 for login employee

create login counterMeneger with password='3333'
create user user3 for login counterMeneger

create login maneger with password='4444'
create user user4 for login maneger

grant select on activities to user1
deny update,insert,delete on employee_pay to user2
grant select on empDate to user1
grant update,insert,delete on employee_pay to user3
deny update,insert,delete on employee to user3

select top 1 with ties EmpID,salary
from employee_pay
order by salary desc

select * from employee_pay