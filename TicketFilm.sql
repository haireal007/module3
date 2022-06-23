create database TicketFilm;
use TicketFilm;
-- foreign key () references tb(),
-- PHIM genrefilm(thể loại phim)
create table film(
IDfilm int primary key,
namefilm varchar(225),
genrefilm varchar(50),
datefilm date
);

-- Phòng
create table room(
IDroom int primary key,
nameroom varchar(50),
statusroom bit
);

-- GHẾ
create table chair(
IDchair int primary key,
IDroom int,
 foreign key (IDroom) references room(IDroom),
 numberchair int
);

-- VÉ
create table TicketFilm(
idfilm int,
 foreign key (idfilm) references film(idfilm),
idchair int ,
foreign key (idchair) references chair(idchair),
 datefilm date,
 statusfilm bit
);

-- 1.Chèn giá trị table TicketFilm
INSERT INTO TicketFilm  VALUES ('1', '1', '2008-10-20','Đã bán'),
('1', '3', '2008-11-20','Đã bán'),
('1', '4', '2008-12-20','Đã bán'),
('2', '1', '2009-02-14','Đã bán'),
('3', '1', '2009-02-14','Đã bán'),
('2', '5', '2009-03-08','Chưa bán'),
('2', '3', '2009-03-08','Chưa bán');

-- 2.Hiển thị danh sách các phim (chú ý: danh sách phải được sắp xếp theo trường Thoi_gian)
select*from film
order by datefilm; 

-- 3.Hiển thị Ten_phim có thời gian chiếu dài nhất
select * from film where datefilm = (select max(datefilm) from film);

-- 4.Hiển thị Ten_Phim có thời gian chiếu ngắn nhất
select*from filmwhere datefilm = (select min(datefilm) from film);


-- 5.Hiển thị danh sách So_Ghe mà bắt đầu bằng chữ ‘A’
select*from chair  where numberchair like ('A%');

-- 6.Sửa cột Trang_thai của bảng tblPhong sang kiểu nvarchar(25)
alter table room modify column statusroom nvarchar(25);

-- 7.Cập nhật giá trị cột Trang_thai của bảng tblPhong theo các luật sau:			
-- Nếu Trang_thai=0 thì gán Trang_thai=’Đang sửa’
-- Nếu Trang_thai=1 thì gán Trang_thai=’Đang sử dụng’
-- Nếu Trang_thai=null thì gán Trang_thai=’Unknow’
-- Sau đó hiển thị bảng tblPhong 

-- update room set  statusroom = 'Đang sửa'
-- where statusroom = 0 and idroom > 0;

-- update room set  statusroom = 'Đang sử dụng'
-- where statusroom = 1 and idroom > 0;

-- update room set  statusroom = 'Unknow'
-- where statusroom is null and idroom > 0;


-- 8.Hiển thị danh sách tên phim mà  có độ dài >15 và < 25 ký tự 
select* from film 
where length(namefilm) between 15 and 25;


-- 9.Hiển thị Ten_Phong và Trang_Thai trong bảng tblPhong  trong 1 cột với tiêu đề ‘Trạng thái phòng chiếu’
select nameroom, statusroom 'Trạng thái phòng chiếu' from room;

-- 10.Tạo bảng mới có tên tblRank với các cột sau: STT(thứ hạng sắp xếp theo Ten_Phim), TenPhim, Thoi_gian

create view tnRank as 
select ROW_NUMBER() OVER (ORDER BY  namefilm) STT, namefilm, datefilm from film;
select*from tnRank ;

-- 11.Trong bảng tblPhim :
-- Thêm trường Mo_ta(describe) kiểu nvarchar(max)		
ALTER TABLE film
ADD COLUMN `describe` nvarchar(255) NULL AFTER `datefilm`;

-- Cập nhật trường Mo_ta: thêm chuỗi “Đây là bộ phim thể loại  ” + nội dung trường LoaiPhim		
UPDATE film SET `describe` = concat( 'Đây là bộ phim thể loại',' ', genrefilm ) WHERE IDfilm >0 ;
-- Hiển thị bảng tblPhim sau khi cập nhật		
SELECT * FROM film;		
-- Cập nhật trường Mo_ta: thay chuỗi “bộ phim” thành chuỗi “film”
UPDATE film SET `describe` = concat( 'Đây là film thể loại',' ', genrefilm ) WHERE IDfilm >0 ;
-- Hiển thị bảng tblPhim sau khi cập nhật	
SELECT * FROM film;	

-- 12.Xóa tất cả các khóa ngoại trong các bảng trên.		
ALTER TABLE chair
DROP CONSTRAINT IDroom;

-- 13.Xóa dữ liệu ở bảng tblGhe


-- 14.Hiển thị ngày giờ hiện tại và ngày giờ hiện tại cộng thêm 5000 phút


