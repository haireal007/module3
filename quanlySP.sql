create database QLSP;
use QLSP;
create table KhachHang (
MAKH INT PRIMARY KEY auto_increment,
HOTEN VARCHAR (50),
DCHI VARCHAR (50),
SODT VARCHAR (20),
NGSINH DATETIME,
DOANHSO FLOAT,
NGDK DATETIME
);

create table NHANVIEN (
MANV INT PRIMARY KEY auto_increment,
HOTEN VARCHAR (50),
NGVL DATETIME,
SODT VARCHAR (20)
);

create table SANPHAM (
MASP INT primary KEY auto_increment,
TENSP VARCHAR (50),
DVTINH VARCHAR (20),
NUOCSX VARCHAR (30),
GIA FLOAT
);

create table HOADON (
SOHD INT primary KEY auto_increment,
NGHD DATETIME,
MAKH INT,
MANV INT,
TRIGIA FLOAT,
foreign key (MAKH) references KHACHHANG(MAKH),
foreign key (MANV) references NHANVIEN(MANV)
);

CREATE TABLE CTHD (
SOHD int,
MASP INT,
SL INT,
foreign key (SOHD) references HOADON(SOHD),
foreign key (MASP) references SANPHAM(MASP),
primary key (SOHD,MASP)
);
insert into khachhang values  (1,'Nguyen ngoc tuan', 'HN', 0913032924, '1992-04-4', 0,'2021-03-01'),
(2,'Tran Trung Dung', 'HN', 01268324609, '1990-05-23',0, '2021-03-02'),
(3,'NGuyen Thi Hoa', 'ND', 0123456789, '1988-02-09',0, '2021-03-05'),
(4,'Le Manh Hung', 'BG', 0123456777, '1985-11-09',0, '2021-04-21'),
(5,'Tran Ngoc Anh', 'QN', 0123456666, '1993-10-08',0, '2021-06-18');
                             
insert into nhanvien values (1,'Nguyen van toan','2020/04/28','0564854532'),
							(2,'do duy nam','2019/03/27','0775697865'),
                            (3,'hoang cong hau','2022/5/28','055345598');
                            
insert into sanpham values (1,'Bún bò','bát','việt nam','40'),
						   (2,'Cơm rang dua bo','đĩa','việt nam','35'),
                           (3,'Bánh cuốn','đĩa','việt nam','30'),
                           (4,'Phở bò','bát','việt nam','40'),
                            (5,'Bún gà','bát','việt nam','35'),
                             (6,'Miến Ngan','bát','việt nam','35'),
                              (7,'Bún chả','bát','việt nam','35');
insert into hoadon values (1,'2006/05/25',1,2,0),
						  (2,'2022/05/25',2,3,0),
                          (3,'2022/10/25',1,2,0);
                          
insert into hoadon values (4,'2022/06/07',1,2,0),
						  (5,'2022/06/08',2,1,0),
                          (6,'2022/06/09',1,1,0);
                          
insert into hoadon values (7,'2022/07/21',1,2,0),
						  (8,'2022/07/22',2,3,0),
                          (9,'2022/07/23',2,1,0);
                          
insert into hoadon values (10,'2006/08/01',1,2,0),
						  (11,'2006/08/02',2,3,0),
                          (12,'2022/08/03',1,3,0);
                          
insert into cthd values (4,2,10),
						(5,1,5),
						(6,3,1);
insert into cthd values (7,4,1),
						(8,3,3),
						(9,2,2),
                        (10,1,2);
-- câu 1:
select count(distinct ct.masp) as 'Số sp khác nhau'
from hoadon HD join cthd CT on HD.sohd = CT.sohd 
where year(HD.nghd) = 2006  ;

-- câu 2:
select max(hoadon.trigia) as 'Bill Max', min(hoadon.trigia) as 'Bill Min'
from hoadon; 

-- câu 3:
select avg(hoadon.trigia) as 'avg bill in 2006'
from hoadon
where year(hoadon.nghd) = 2006 ;

-- câu 4:
select sum(hoadon.trigia) as 'Sum bill in 2006'
from hoadon
where year(hoadon.nghd) = 2006 ;

-- câu 5:
select max(hoadon.trigia) as 'Bill Max in 2006'
from hoadon
where year(nghd) = 2006; 

-- câu 6:
select KH.hoten, max(HD.trigia)
from khachhang KH join hoadon HD on KH.makh = hd.makh
where year(nghd) = 2006;

-- câu 7:
select KH.makh,KH.hoten
from khachhang kh
order by kh.doanhso desc
limit 3;

-- câu 8:
select masp, tensp, gia
from sanpham
where gia >= (
select distinct gia from sanpham
order by gia desc
limit 2,1
);

-- câu 9:
select masp, tensp, gia
from sanpham
where nuocsx like 'ý' and gia >= (
select distinct gia from sanpham
order by gia desc
limit 2,1
);

-- câu 10:
select masp, tensp, gia
from sanpham
where nuocsx like 'trung quốc' and gia >= (
select distinct gia from sanpham
order by gia desc
limit 2,1
);

-- câu 11:
Select *, rank() over(order by doanhso DESC) as ranking from khachhang;

-- câu 12:
select count(masp) 'số sp do ý sx' 
from sanpham
where nuocsx like 'ý';

-- câu 13:
select nuocsx, count(masp) "số sp sx" 
from sanpham
group by nuocsx;

-- câu 14:
select nuocsx , min(gia) as 'gia sp min', max(gia) as 'gia sp max', avg(gia) as 'gia sp avg' 
from sanpham
group by nuocsx;

-- câu 15:
select nghd as 'Ngày', sum(trigia) as 'Doanh thu'
from hoadon
group by nghd
order by nghd;

-- câu 16:
select count(cthd.sl) ' Số lượng bán ra'
from cthd join hoadon on hoadon.sohd = cthd.sohd
where month(nghd) = 10 and year(nghd) = 2006;

-- câu 17:
select month(nghd) as 'tháng', sum(trigia) as 'doanh thu'
from hoadon
where year(nghd) = 2006
group by month(nghd)
order by month(nghd);

-- câu 18:
select hoadon.sohd , count(cthd.masp) as 'so sp'
from hoadon join cthd on cthd.sohd = hoadon.sohd
group by hoadon.sohd
having count(cthd.masp) = 3 ;

-- câu 19:
select hoadon.sohd , count(cthd.masp) as 'so sp'
from hoadon join cthd on cthd.sohd = hoadon.sohd join sanpham on sanpham.masp = cthd.masp
where sanpham.nuocsx = 'việt nam'
group by hoadon.sohd
having count(cthd.masp) = 3 ;

-- câu 20:
select khachhang.makh, khachhang.hoten,count(hoadon.sohd)
from khachhang join hoadon on hoadon.makh = khachhang.makh
group by khachhang.makh
having count(hoadon.sohd) = (
select count(sohd)
from hoadon
group by makh
order by count(sohd) desc
limit 1
);

-- câu 21:
select month(nghd) as 'tháng', sum(trigia) as 'doanh thu'
from hoadon
where year(nghd) = 2006
group by month(nghd)
having sum(trigia) = (
select sum(trigia)
from hoadon
where year(nghd) = 2006
group by month(nghd)
order by sum(trigia) desc
limit 1);

-- câu 22: 
select sanpham.masp, sanpham.tensp, count(cthd.sl) as 'số lượng bán ra'
from sanpham join cthd on cthd.masp = sanpham.masp join hoadon on hoadon.sohd = cthd.sohd 
where year(hoadon.nghd) = 2006
group by sanpham.masp
having count(cthd.sl) = (
select count(cthd.sl)
from cthd
group by masp
order by count(cthd.sl)
limit 1
);

-- câu 23:
select sanpham.masp, sanpham.tensp 