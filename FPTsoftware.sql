create database FPTsoftware;
use FPTsoftware;

create table dongxe(
dongxe varchar(50) primary key not null,
hangxe varchar(50),
songuoingoi int
);

create table nhacungcap(
MaNhaCC int not null primary key,
tennhacc varchar(50),
diachi varchar(50),
Sodt varchar (20),
masothue varchar(30),
dongxecc varchar(50), foreign key (dongxecc) references dongxe(dongxe)
);

create table loaidichvu(
maloaiDV int not null primary key,
tenloaidv varchar(50)
);

create table mucphi(
mamucphi int not null primary key,
dongia int,
mota varchar(50)
);



create table Dangkycungcap(
maDKCC int not null primary key,
manhacc int,foreign key (manhacc) references nhacungcap(manhacc),
maloaidv int, foreign key (maloaidv) references loaidichvu(maloaidv),
mamucphi int, foreign key (mamucphi) references mucphi(mamucphi),
dongxe varchar(50), foreign key (dongxe) references dongxe(dongxe),
BdCCdate datetime,
ktccdate datetime,
SLxeDK int
);

-- Câu 1: Hãy tự định nghĩa kiểu dữ liệu cho các cột, sau đó tạo đầy đủ lược đồ cơ sở dữ liệu
-- Câu 2: Nhập toàn bộ dữ liệu mẫu đã được minh họa ở trên vào cơ sở dữ liệu

-- Câu 3: Liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ
select * from dongxe where songuoingoi > 5;

-- Câu 4: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp những dòng xe
select N.manhacc, N.tennhacc,N.diachi,N.Sodt,N.masothue,N.dongxecc,D.hangxe
from nhacungcap N join dongxe D on N.dongxecc = D.dongxe
where D.hangxe = 'toyota';

-- Câu 5: Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên nhà cung cấp và giảm dần theo mã số thuế-- 
select * from nhacungcap
order by tennhacc ASC;

select * from nhacungcap
order by masothue DESC;

-- Câu 6: Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung cấp với
-- yêu cầu chỉ đếm cho những nhà cung cấp thực hiện đăng ký cung cấp có ngày bắt đầu
-- cung cấp là “20/11/2015”

select  N.manhacc,N.tennhacc,count(maDKcc) as 'so lan dang ky cung cap'
From dangkycungcap DKCC join nhacungcap N on DKCC.manhacc= N.manhacc
where DKCC.BdCCdate > '2019-12-15'
group by N.manhacc;

-- Câu 7: Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe
-- chỉ được liệt kê một lần

select dongxe.hangxe from dongxe group by dongxe.hangxe;

-- Câu 8: Liệt kê MaDKCC, MaNhaCC, TenNhaCC, DiaChi, MaSoThue, TenLoaiDV, DonGia,
-- HangXe, NgayBatDauCC, NgayKetThucCC của tất cả các lần đăng ký cung cấp phương
-- tiện với yêu cầu những nhà cung cấp nào chưa từng thực hiện đăng ký cung cấp phương
-- tiện thì cũng liệt kê thông tin những nhà cung cấp đó ra

select DKCC.MaDKCC, DKCC.MaNhaCC, NCC.TenNhaCC, NCC.DiaChi, NCC.MaSoThue, LDV.TenLoaiDV, MP.DonGia,DX.HangXe, DKCC.bdccdate, DKCC.ktccdate,count(maDKCC)
from dangkycungcap DKCC join Nhacungcap NCC on DKCC.manhacc = NCC.manhacc and DKCC.dongxe = NCC.dongxecc join dongxe DX on DKCC.dongxe = DX.dongxe join loaidichvu LDV on DKCC.maloaidv = LDV.maloaiDV join mucphi MP on DKCC.mamucphi = MP.mamucphi
group by NCC.manhacc;

-- Câu 9: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp phương tiện
-- thuộc dòng xe “xe 20 chỗ” hoặc từng đăng ký cung cấp phương tiện thuộc dòng xe “xe 30 chỗ”

select DKCC.MaDKCC, DKCC.MaNhaCC, NCC.TenNhaCC, NCC.DiaChi, NCC.MaSoThue, LDV.TenLoaiDV, MP.DonGia,DX.HangXe, DKCC.bdccdate, DKCC.ktccdate
from dangkycungcap DKCC join Nhacungcap NCC on DKCC.manhacc = NCC.manhacc and DKCC.dongxe = NCC.dongxecc join dongxe DX on DKCC.dongxe = DX.dongxe join loaidichvu LDV on DKCC.maloaidv = LDV.maloaiDV join mucphi MP on DKCC.mamucphi = MP.mamucphi
where DX.dongxe = 'xe 20 chỗ' or DKCC.dongxe  = 'xe 30 chỗ';

-- Câu 10: Liệt kê thông tin của các nhà cung cấp chưa từng thực hiện đăng ký cung cấp
-- phương tiện lần nào cả.

select * from nhacungcap
where not exists (select NCC.TenNhaCC, NCC.DiaChi, NCC.MaSoThue from dangkycungcap DKCC join Nhacungcap NCC on DKCC.manhacc = NCC.manhacc and DKCC.dongxe = NCC.dongxecc 
where NCC.manhacc = DKCC.manhacc );






