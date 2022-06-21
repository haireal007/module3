create database Quanlysinhvien1;
use Quanlysinhvien1;

create table students (
studentId int  primary key,
studentName varchar(50) not null,
age int not null,
email varchar(50));

create table subjects(
subjectId int primary key,
subjectName varchar(50));

create table classes(
classId int auto_increment primary key,
className varchar(50));

create table classStudent(
studentId int ,
classId int,
foreign key(studentId)references students(studentId),
foreign key(classId)references classes(classId));

create table marks(
markId int,
subjectId int,
studentId int,
 foreign key (subjectId)references subjects(subjectId),
foreign key (studentId)references students(studentId));

insert into classstudent values
(1,1),
(2,1),
(3,2),
(4,2),
(5,2);

-- Cau 1: Hien thi danh sach tat ca cac hoc vien:
select *from students;

-- cau2: Hien thi danh sach tat ca cac mon hoc:
select *from classes;

-- cau3: Tinh diem trung binh :
select avg(markID) as DiemTB from marks;

-- cau4: Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat:
select SubjectName from subjects where SubjectID =(select SubjectID from marks where MarkID = (select max(markID) from marks));

-- cau5: Danh so thu tu cua diem theo chieu giam:
select stt, markID from marks order by marks desc;

-- cau6: Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max):
alter table subjects modify column SubjectName nvarchar(255) not null;

-- cau7: Cap nhat them dong chu « Day la mon hoc «  vao truoc cac ban ghi tren cot SubjectName trong bang Subjects:
update subjects set `subjectName` = (select subjectName subjects where subjectId = 1);

-- cau8: Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50:
alter table Students 
add constraint check(Age>15 and Age <50); 

-- cau9: Loai bo tat ca quan he giua cac bang:
alter table students
add status int not null ;

-- cau10: Xoa hoc vien co StudentID la 1:
ALTER TABLE classstudent DROP FOREIGN KEY studentId;
ALTER TABLE marks DROP FOREIGN KEY studentId;
alter table students drop constraint studentId;
DELETE FROM students WHERE studentId = 1;

-- cau11:Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1:
alter table Students 
add column Status bit default 1;

-- cau12: Cap nhap gia tri Status trong bang Student thanh 0:
update Students
set Status=0
where StudentID>0;