use QLBH

--Bai tap 1, phan III, cau 12, trang 4
select distinct SOHD from CTHD
where MASP in ('BB01', 'BB02') and SL between 10 and 20

--Bai tap 1, phan III, cau 13, trang 4
select distinct SOHD from CTHD
where MASP in ('BB01', 'BB02') and SL between 10 and 20
group by SOHD
having count(distinct MASP) = 2

--Bai tap 1, phan III, cau 14, trang 5
set dateformat DMY
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Trung Quoc' or MASP in
(
	select distinct MASP
	from CTHD CT inner join HOADON HD
	on CT.SOHD = HD.SOHD
	where HD.NGHD = '1/1/2007'
)

--Bai tap 1, phan III, cau 15, trang 5
select MASP, TENSP from SANPHAM
where MASP not in 
(
	select distinct MASP from CTHD
)

--Bai tap 1, phan III, cau 16, trang 5
select MASP, TENSP from SANPHAM
where MASP not in
(
	select distinct CT.MASP 
	from CTHD CT inner join HOADON HD
	on CT.SOHD = HD.SOHD
	where YEAR(HD.NGHD) = '2006'
)

--Bai tap 1, phan III, cau 17, trang 5
select MASP, TENSP from SANPHAM
where NUOCSX = 'Trung Quoc' and MASP not in
(
	select distinct CT.MASP 
	from CTHD CT inner join HOADON HD
	on CT.SOHD = HD.SOHD
	where YEAR(HD.NGHD) = 2006
)

--Bai tap 1, phan III, cau 18, trang 5
select distinct CT.SOHD
from CTHD CT inner join SANPHAM SP
on CT.MASP = SP.MASP
where NUOCSX = 'Singapore'
group by CT.SOHD
having count(distinct CT.MASP) = (
	select count(MASP)
	from SANPHAM
	where NUOCSX = 'Singapore'
)

--Bai tap 1, phan III, cau 19, trang 5
select distinct CT.SOHD
from ((CTHD CT
inner join SANPHAM SP on CT.MASP = SP.MASP)
inner join HOADON HD on CT.SOHD = HD.SOHD)
where YEAR(HD.NGHD) = 2006 and NUOCSX = 'Singapore'
group by CT.SOHD
having count(distinct CT.MASP) = (
	select count(MASP)
	from SANPHAM
	where NUOCSX = 'Singapore'
)
