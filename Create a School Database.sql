create database School;
use School;
create table STUDENT (
    StdID int,
    StdName varchar(30) Not Null,
    Sex varchar(6),
    Percentage int,
    SClass int,
    Sec varchar(2),
    Str varchar(10),
    DOB Date,
    primary key (StdID)
    );
    Desc STUDENT;
	insert into STUDENT values(101,"Riya","F",80,6,"A","Science","1999-01-09");
	insert into STUDENT values(102,"Shreya","F",85,7,"B","Commerce","1999-10-09");
    insert into STUDENT values(103,"Sourya","M",75,6,"B","Science","1994-10-07");
    insert into STUDENT values(104,"Chandan","M",80,7,"A","Arts","1998-10-20");
    insert into STUDENT values(105,"Kumar","M",82,7,"B","Science","1998-02-25");
    select *from STUDENT;
    select StdName,DOB from STUDENT;
    select * from STUDENT where Percentage<80;
    select * from STUDENT where Percentage>=80;
    select * from STUDENT where Str="Science" and Percentage>75;
    select StdName,Percentage from STUDENT where percentage between 60 and 80;