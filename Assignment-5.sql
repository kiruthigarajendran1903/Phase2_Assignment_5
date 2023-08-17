

if exists (select * from sys.databases where name = 'Assessment05Db')

 drop database  Assessment05Db

 create database Assessment05Db

 use Assessment05Db


 create schema bank
 create table bank.Customer
 (CId int primary key identity(1000,1),
 CName nvarchar(50) not null,
 CEmail nvarchar(50) not null unique,
 Contact nvarchar(50) not null unique,
CPwd AS (RIGHT(CName, 2) + CAST(CId AS NVARCHAR(10)) + LEFT(Contact, 2)) PERSISTED,
)


insert into bank.Customer values ('Raj','rk@gmail.com','983567290')
insert into bank.Customer values ('Suraj','suraj@gmail.com','683567290')
insert into bank.Customer values ('vinith','vinith@gmail.com','723567290')
insert into bank.Customer values ('kevin','Kk@gmail.com','903567290')

select * from bank.Customer

create table bank.MailInfo
(MailTo nvarchar(50) primary key,
CEmail nvarchar(50),
MailDate date,
MailMessage nvarchar(max),
)

create trigger bank.trgMailToCust
on bank.Customer
after insert
as
begin
    declare @cid int
	declare @cname nvarchar(50)
    declare @cmail nvarchar(50)
    declare @ccontact nvarchar(50)
    declare @cpwd nvarchar(50)
    declare @cmsg nvarchar(500)

    select @cid = Cid, @cname = CName, @cmail = CEmail, @ccontact = Contact from inserted
    set @cpwd = (RIGHT(@cname, 2) + cast(@cid AS nvarchar(10)) + LEFT(@ccontact, 2))
    set @cmsg = 'Your NetBanking password is: ' + @cpwd + '. It is valid up to 2 days only. Update it!'

    insert into bank.MailInfo (MailTo, CEmail, MailDate, MailMessage)
    values (@cmail, @cmail, getDate(), @cmsg)

    if (@@ROWCOUNT >= 1)
    begin
        print 'After trigger value inserted';
    end
	end



insert into bank.Customer (CName, CEmail, Contact)
values ('Devid', 'devid@gmail.com', '9856230874')


select * from bank.Customer

select * from bank.MailInfo

