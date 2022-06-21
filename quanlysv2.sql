create database Quanlysinhvien2;
use Quanlysinhvien2;

-- khoa
create table Department (
DepartmentID int  primary key,
DepartmentName  varchar(50) not null
);

create table class(
classid int  primary key,
className  varchar(50) not null,
DepartmentID int,
foreign key(DepartmentID )references Department(DepartmentID)
);


create table students (
studentId int  primary key,
studentName varchar(50) not null,
birthday date,
gender varchar(50),
scholarship varchar(50),
classId int,
foreign key(classId) references class(classId)
);

create table subjects(
 subjectsID int  primary key,
 subjectsName  varchar(50) not null,
 number int
);


create table result(
resultID int primary key,
result float,
studentID int,
subjectsID int,
foreign key(studentID)references students(studentID),
foreign key(subjectsID)references subjects(subjectsID)
);

-- Câu 5: Lập danh sách sinh viên có họ ‘Trần’
select *from students where studentName like ('Trần%');


-- Câu 6: Lập danh sách sinh viên nữ có học bổng
select * from students
where gender = 'nữ' and scholarship=1;

-- Câu 7: Lập danh sách sinh viên nữ hoặc danh sách sinh viên có học bổng
select * from students
where gender = 'nữ' or scholarship=1;

-- 	Câu 8: Lập danh sách sinh viên có năm sinh từ 1978 đến 1985. Danh sách cần các thuộc tính của quan hệ SinhVien
select * from students where birthday  between '1998-12-31' and '2001-01-01';

-- Câu 9: Liệt kê danh sách sinh viên được sắp xếp tăng dần theo MaSV
 select * from students
 order by studentid ASC;
 
--  Câu 10: Liệt kê danh sách sinh viên được sắp xếp giảm dần theo HocBong
select * from students
 where scholarship = 1
 order by studentid DESC;
 
-- câu 12: Lập danh sách sinh viên có học bổng của khoa java.
select  S.studentid,S.Name,S.birthday,S.scholarship,S.gender,S.classid,D.Departmentname,R.result
From students S join result R on S.studentid = R.studentid join class C on S.classid = C.classId join department D on C.Departmenttid = D.Departmentid
 where scholarship = 1 and D.departmentid= 1;

-- câu 13: Lập danh sách sinh viên có học bổng của khoa Python. 


-- Câu 14: Cho biết số sinh viên của mỗi lớp
select class.classname, count(studentid) as 'số sinh viên'
from class join students on class.classid = students.classid
group by class.classname;

-- Câu 15: Cho biết số lượng sinh viên của mỗi khoa.
select  D.departmentname,count(studentid) as 'so sinh vien'
From students S join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
 group by D.departmentname

-- Câu 16: Cho biết số lượng sinh viên nữ của mỗi khoa 
select  D.departmentname,count(studentid) as 'so sinh vien nữ'
From students S join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
where gender = 'nữ'
 group by D.departmentname;
 
--  Câu 17: Cho biết tổng tiền học bổng của mỗi lớp
select  D.departmentname,count(studentid)*50000 as 'Tong tien hoc bong'
From students S join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
where scholarship = 1;

-- Câu 18: Cho biết tổng số tiền học bổng của mỗi khoa


-- Câu 19: Lập danh sánh những khoa có nhiều hơn 100 sinh viên. Danh sách cần: MaKhoa, TenKhoa, Soluong
select  C.departmentid,D.departmentname,count(studentid) as 'so sinh vien'
From students S join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
where (select  count(studentid) as 'so sinh vien'
From students S join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid) > 100
group by D.departmentname;

-- Câu 20: Lập danh sánh những khoa có nhiều hơn 50 sinh viên nữ. Danh sách cần: MaKhoa, TenKhoa, Soluong
select  C.departmentid,D.departmentname,count(studentid) as 'so sinh vien nu'
From students S join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
where gender = 'female' and (select  count(studentid) as 'so sinh vien'
From students S join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
where gender = 'female') > 50
group by D.departmentname;


-- Câu22: Lập danh sách sinh viên có học bổng cao nhất
-- Câu 23: Lập danh sách sinh viên có điểm thi môn toán cao nhất
