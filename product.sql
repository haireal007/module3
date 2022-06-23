create database product;
use product;

Create table product(
    codeP int primary key,
    nameP varchar(255),
    priceP double
);
create table orders(
    codeO int primary key,
    dateO date,
    totalMoney double
);
create table OrderDetail(
	orderid int,
	codeP int ,
	codeO int,
	soluong int ,
    primary key(codeP,codeO),
    foreign key (codeP) references product(codeP),
	foreign key (codeO) references orders(codeO)
);

INSERT INTO `product` (`codeP`, `nameP`, `priceP`) VALUES ('1', 'banh mi', '8.2');
INSERT INTO `product` (`codeP`, `nameP`, `priceP`) VALUES ('2', 'bim bim', '5.2');
INSERT INTO `product` (`codeP`, `nameP`, `priceP`) VALUES ('3', 'mi tom', '9.2');
INSERT INTO `product` (`codeP`, `nameP`, `priceP`) VALUES ('4', 'nuoc hoa', '7.2');
orderdetail

-- viết trigger để tự động cập nhật tổng giá tiền của bảng hoá đơn.
DELIMITER $$
create trigger tgSetStatus
after insert on  OrderDetail
for each row
begin
update orders
set   totalMoney =   totalMoney+ (new.soluong * (select priceP from product where codeP = new.codeP)) where codeO = new.codeO;
end
$$

-- viết trigger để tự động cập nhật tổng giá tiền của bảng hoá đơn khi xoá hoá đơn chi tiết.

DELIMITER $$
create trigger deleteSetStatus
after delete on  OrderDetail
for each row
begin
update orders
set   totalMoney =   totalMoney - (old.soluong * (select priceP from product where codeP = old.codeP)) where codeO = old.codeO;
end
$$

-- drop trigger deleteSetStatus