create database QuanlysinhvienHam;
use QuanlysinhvienHam;

create table students(
studentid int primary key,
studentname varchar(50) not null,
studentage int,
studentstatus varchar(50)
);

create table test(
testid int primary key,
testname varchar(50)
);

create table studenttest (
studentid int,
foreign key (studentid) references students(studentid),
testid int, 
foreign key (testid) references test(testid),
datetest date,
mark float
);

-- 1.Tạo 3 bảng và chèn dữ liệu như hình dưới đây: -- 

insert into test values(1,'EPC'),(2,'DWMX'),(3,'SQL1'),(4,'SQL2');

insert into studenttest values(1,1,'2006-07-17',8),(1,2,'2006-07-18',5),(1,3,'2006-07-19',7),
(2,1,'2006-07-17',7),(2,2,'2006-07-18',8),(2,3,'2006-07-19',4),(3,1,'2006-07-17',10),(3,3,'2006-07-18',1);

-- 2.Hiển thị danh sách các học viên đã tham gia thi, các môn thi được thi bởi các học viên đó, 
-- điểm thi và ngày thi giống như hình sau:

create view danhsachdiemthi as 
select ROW_NUMBER() OVER (ORDER BY  S.studentName)  STT,  S.studentName,T.testname,
ST.mark, ST.datetest 
from studenttest ST join test T on ST.testid =T.testid join students S 	on ST.studentid = S.studentid;
select*from danhsachdiemthi;

-- 3.Hiển thị danh sách các bạn học viên chưa thi môn nào như hình sau:
create view danhsachchuathi as 
select*from students
where not exists (select*from studenttest where students.studentId =studenttest.studentid);

-- 4.Hiển thị danh sách học viên phải thi lại, tên môn học phải thi lại 
-- và điểm thi(điểm phải thi lại là điểm nhỏ hơn 5) như sau:
create view danhsachthilai as
select ROW_NUMBER() OVER (ORDER BY  S.studentName)  STT,  S.studentName 'student name',T.testname 'Test name',
ST.mark, ST.datetest 'date' 
from studenttest ST join test T on ST.testid =T.testid join students S 	on ST.studentid = S.studentid
where ST.mark < 5;
select*from danhsachthilai;

-- 5.Hiển thị danh sách học viên và điểm trung bình(Average) của các môn đã thi.
--  Danh sách phải sắp xếp theo thứ tự điểm trung bình giảm dần(nếu không sắp xếp thì chỉ được ½ số điểm) như sau:

create view danhsachdiemtrungbinh  as 
select ROW_NUMBER() OVER (ORDER BY  S.studentName)  STT,  S.studentName , avg(mark) 'Average'
from studenttest ST join students S on ST.studentid = S.studentid group by S.studentname;
select*from danhsachdiemtrungbinh;

-- 6.Hiển thị tên và điểm trung bình của học viên có điểm trung bình lớn nhất như sau:
create view diemtrungbinhmax  as 
select  danhsachdiemtrungbinh.studentName, max(Average) 'AverageMax'
from danhsachdiemtrungbinh;
select*from diemtrungbinhmax ;

-- 7.Hiển thị điểm thi cao nhất của từng môn học. Danh sách phải được sắp xếp theo tên môn học như sau:
create view danhsachdiemthiMax as 
select ROW_NUMBER() OVER (ORDER BY  danhsachdiemthi.testname) STT,  danhsachdiemthi.testname, max(mark) 'maxmark'
from danhsachdiemthi
group by danhsachdiemthi.testname
order by  danhsachdiemthi.testname ASC;

-- 8.Hiển thị danh sách tất cả các học viên
--  và môn học mà các học viên đó đã thi nếu học viên chưa thi môn nào thì phần tên môn học để Null như sau:
select ROW_NUMBER() OVER (ORDER BY  danhsachdiemthi.testname) STT, danhsachdiemthi.studentname,danhsachdiemthi.testname
from danhsachdiemthi
order by  danhsachdiemthi.studentname ASC;

-- 9.Sửa (Update) tuổi của tất cả các học viên mỗi người lên một tuổi.
update students set studentage = studentage + 1
where studentid = 1 or studentid = 2 or studentid = 3 or studentid = 4;

-- 10.Thêm trường tên là Status có kiểu Varchar(10) vào bảng Student.

alter table student add statuss varchar(10);

-- 11.Cập nhật(Update) trường Status sao cho những học viên nhỏ hơn 30 tuổi sẽ nhận giá trị ‘Young’,
--  trường hợp còn lại nhận giá trị ‘Old’
--  sau đó hiển thị toàn bộ nội dung bảng Student lên như sau:	


