use QLBH

--Bai tap 1, phan III, cau 20, trang 5
select count(SOHD) as SOHOADON from HOADON
where MAKH not in (
	select MAKH from KHACHHANG
	where HOADON.MAKH = KHACHHANG.MAKH
)

--Bai tap 1, phan III, cau 21, trang 5
select count(distinct MASP) as SOSANPHAM
from CTHD CT inner join HOADON HD
on CT.SOHD = HD.SOHD
where year(NGHD) = 2006

--Bai tap 1, phan III, cau 22, trang 5
select min(TRIGIA) as TRIGIA_NHONHAT, max(TRIGIA) as TRIGIA_LONNHAT from HOADON

--Bai tap 1, phan III, cau 23, trang 5
select avg(TRIGIA) as TRIGIA_TRUNGBINH from HOADON where year(NGHD) = 2006

--Bai tap 1, phan III, cau 24, trang 5
select sum(TRIGIA) as DOANHTHU from HOADON where year(NGHD) = 2006

--Bai tap 1, phan III, cau 25, trang 5
select SOHD from HOADON
where year(NGHD) = 2006 and TRIGIA in (
	select MAX(TRIGIA) from HOADON where YEAR(NGHD) = 2006
)

--Bai tap 1, phan III, cau 26, trang 5
select HOTEN
from KHACHHANG KH inner join HOADON HD
on KH.MAKH = HD.MAKH
where year(NGHD) = 2006 and TRIGIA in (
	select max(TRIGIA) from HOADON where year(NGHD) = 2006
)

--Bai tap 1, phan III, cau 27, trang 5
select top 3 MAKH, HOTEN
from KHACHHANG
order by DOANHSO desc

--Bai tap 1, phan III, cau 28, trang 5
select MASP, TENSP
from SANPHAM
where GIA in (
	select distinct top 3 GIA
	from SANPHAM
	order  by GIA desc
)

--Bai tap 1, phan III, cau 29, trang 5
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Thai Lan' and GIA in (
	select distinct top 3 GIA
	from SANPHAM
	order  by GIA desc
)

--Bai tap 1, phan III, cau 30, trang 5
select MASP, TENSP
from SANPHAM
where NUOCSX = 'Trung Quoc' and GIA in (
	select distinct top 3 GIA
	from SANPHAM
	where NUOCSX = 'Trung Quoc'
	order  by GIA desc
)

--Bai tap 1, phan III, cau 31, trang 5
select top 3 MAKH, HOTEN, rank() over (order by DOANHSO desc) RANK_KH from KHACHHANG

--Bai tap 1, phan III, cau 32, trang 5
select count(MASP) as SOSANPHAMTQ
from SANPHAM
where NUOCSX = 'Trung Quoc'

--Bai tap 1, phan III, cau 33, trang 5
select NUOCSX, count(MASP) as SOSANPHAM
from SANPHAM
group by NUOCSX

--Bai tap 1, phan III, cau 34, trang 5
select NUOCSX, max(GIA) as GIALONNHAT, min(GIA) as GIANHONHAT, avg(GIA) GIATRUNGBINH
from SANPHAM
group by NUOCSX

--Bai tap 1, phan III, cau 35, trang 5
select NGHD as NGAYBAN, sum(TRIGIA) DOANHTHU
from HOADON
group by NGHD

--Bai tap 1, phan III, cau 36, trang 5
select MASP, sum(SL) as TONGSOLUONG
from CTHD CT inner join HOADON HD
on CT.SOHD = HD.SOHD
where month(NGHD) = 10 and year(NGHD) = 2006
group by MASP

--Bai tap 1, phan III, cau 37, trang 5
select month(NGHD) as THANG, sum(TRIGIA) as DOANHTHU
from HOADON
where year(NGHD) = 2006
group by month(NGHD)

--Bai tap 1, phan III, cau 38, trang 5
select SOHD from CTHD
group by SOHD
having count(distinct MASP) >= 4

--Bai tap 1, phan III, cau 39, trang 5
select SOHD
from CTHD CT inner join SANPHAM SP
on CT.MASP = SP.MASP
where NUOCSX = 'Viet Nam'
group by SOHD
having count(distinct CT.MASP) = 3

--Bai tap 1, phan III, cau 40, trang 5
select MAKH, HOTEN from (
	select HD.MAKH, HOTEN, rank() over (order by count(SOHD) desc) RANK_SOLAN
	from HOADON HD inner join KHACHHANG KH
	on HD.MAKH = KH.MAKH
	group by HD.MAKH, HOTEN
) A
where RANK_SOLAN = 1

--Bai tap 1, phan III, cau 41, trang 5
select THANG from (
	select month(NGHD) as THANG, rank() over (order by sum(TRIGIA) desc) RANK_TRIGIA
	from HOADON
	where year(NGHD) = 2006
	group by month(NGHD)
) A
where RANK_TRIGIA = 1

--Bai tap 1, phan III, cau 42, trang 5
select SP.MASP, TENSP from (
	select CT.MASP, rank() over (order by sum(SL) asc) RANK_SOLUONG
	from CTHD CT inner join HOADON HD
	on	CT.SOHD = HD.SOHD
	where year(NGHD) = 2006
	group by CT.MASP
) A inner join SANPHAM SP
on A.MASP = SP.MASP
where RANK_SOLUONG = 1

--Bai tap 1, phan III, cau 43, trang 5
select SP.NUOCSX, MASP, TENSP from (
	select NUOCSX, max(GIA) as MAXGIA
	from SANPHAM
	group by NUOCSX
) A inner join SANPHAM SP
on A.NUOCSX = SP.NUOCSX
where SP.GIA = MAXGIA

--Bai tap 1, phan III, cau 44, trang 5
select NUOCSX from SANPHAM
group by NUOCSX
having count(distinct GIA) >= 3

--Bai tap 1, phan III, cau 45, trang 5
select KH.MAKH, HOTEN from (
	select top 10 HD.MAKH, DOANHSO, rank() over (order by count(SOHD) desc) RANK_SOLAN
	from KHACHHANG KH inner join HOADON HD
	on KH.MAKH = HD.MAKH
	group by HD.MAKH, DOANHSO
	order by DOANHSO desc
) A inner join KHACHHANG KH
on A.MAKH = KH.MAKH
where RANK_SOLAN = 1