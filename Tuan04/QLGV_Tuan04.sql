use QLGV

--Bai tap 2, phan III, cau 19, trang 13
select MAKHOA, TENKHOA from (
	select MAKHOA, TENKHOA, rank() over (order by NGTLAP) RANK_NGTLAP
	from KHOA
) A
where RANK_NGTLAP = 1

--Bai tap 2, phan III, cau 20, trang 13
select HOCHAM, count(MAGV) as SOLUONG
from GIAOVIEN
where HOCHAM = 'GS' or HOCHAM = 'PGS'
group by HOCHAM

--Bai tap 2, phan III, cau 21, trang 13
select MAKHOA, HOCVI, count(MAGV) as SOLUONG
from GIAOVIEN
where HOCVI in ('CN', 'KS', 'Ths', 'TS', 'PTS')
group by MAKHOA, HOCVI
order by MAKHOA

--Bai tap 2, phan III, cau 22, trang 13
select A.MAMH, KQUA, count(*) SOHOCVIEN
from KETQUATHI A inner join (
	select MAMH, MAHV, max(LANTHI) MAXLANTHI
	from KETQUATHI
	group by MAMH, MAHV
) B 
on A.MAMH = B.MAMH
where LANTHI = MAXLANTHI and A.MAHV = B.MAHV
group by A.MAMH, KQUA

--Bai tap 2, phan III, cau 23, trang 13
select distinct A.MAGV, HOTEN
from GIAOVIEN A, LOP B, GIANGDAY C
where (
	A.MAGV = C.MAGV
	and B.MALOP = C.MALOP
	and A.MAGV = B.MAGVCN
)

--Bai tap 2, phan III, cau 24, trang 13
select HO + ' ' + TEN as HOTEN
from HOCVIEN HV inner join LOP 
on HV.MAHV = LOP.TRGLOP
where LOP.SISO = (
	select max(SISO) from LOP
)

--Bai tap 2, phan III, cau 25, trang 13
select HV.MAHV,  HO + ' ' + TEN as HOTEN
from ((HOCVIEN HV inner join LOP
on HV.MAHV = LOP.TRGLOP) inner join KETQUATHI KQ
on HV.MAHV = KQ.MAHV)
where HV.MAHV not in (
	select distinct MAHV from KETQUATHI
	where KQUA = 'Dat'
)

--Bai tap 2, phan III, cau 26, trang 13
select A.MAHV, HO + ' ' + TEN as HOTEN from (
	select MAHV, rank() over (order by count(MAMH) desc) rank_MH from KETQUATHI KQ
	where DIEM between 9 and 10
	group by KQ.MAHV
) A inner join HOCVIEN HV
on A.MAHV = HV.MAHV
where rank_MH = 1

--Bai tap 2, phan III, cau 27, trang 13
select left(A.MAHV, 3) as MALOP, A.MAHV, HO + ' ' + TEN as HOTEN from (
	select MAHV, rank() over (partition by left(MAHV, 3) order by count(MAMH) desc) RANK_MH from KETQUATHI KQ
	where DIEM between 9 and 10
	group by KQ.MAHV
) A inner join HOCVIEN HV
on A.MAHV = HV.MAHV
where RANK_MH = 1
group by left(A.MAHV, 3), A.MAHV, TEN, HO

--Bai tap 2, phan III, cau 28, trang 13
select NAM, HOCKY, MAGV, count(MAMH) as SOMONHOC, count(MALOP) as SOLOP
from GIANGDAY
group by NAM, HOCKY, MAGV

--Bai tap 2, phan III, cau 29, trang 13
select NAM, HOCKY, A.MAGV, HOTEN from (
	select NAM, HOCKY, MAGV, rank() over (partition by NAM, HOCKY order by count(*) desc) as RANK_DAY
	from GIANGDAY
	group by NAM, HOCKY, MAGV
) A inner join GIAOVIEN GV
on A.MAGV = GV.MAGV
where RANK_DAY = 1

--Bai tap 2, phan III, cau 30, trang 13
select A.MAMH, TENMH from (
	select MAMH, KQUA, LANTHI, rank() over (partition by LANTHI, KQUA order by count(*) desc) as RANK_HV
	from KETQUATHI
	group by LANTHI, KQUA, MAMH
) A inner join MONHOC MH
on A.MAMH = MH.MAMH
where A.KQUA = 'Khong Dat' and A.LANTHI = 1 and RANK_HV = 1

--Bai tap 2, phan III, cau 31, trang 13
select distinct HV.MAHV, HO + ' ' + TEN as HOTEN
from HOCVIEN HV inner join KETQUATHI KQ
on HV.MAHV = KQ.MAHV
where HV.MAHV not in (
	select MAHV from KETQUATHI
	where LANTHI = 1 and KQUA = 'Khong Dat'
)

--Bai tap 2, phan III, cau 32, trang 13
select distinct HV.MAHV, HO + ' ' + TEN as HOTEN
from HOCVIEN HV inner join KETQUATHI KQ
on HV.MAHV = KQ.MAHV
where HV.MAHV not in (
	select KQ.MAHV from KETQUATHI KQ inner join (
		select MAHV, MAMH, max(LANTHI) as MAXLANTHI from KETQUATHI
		group by MAHV, MAMH
	) A
	on A.MAHV = KQ.MAHV
	where KQ.MAMH = A.MAMH and LANTHI = MAXLANTHI and KQUA = 'Khong Dat'
)

--Bai tap 2, phan III, cau 33, trang 13
select distinct HV.MAHV, HO + ' ' + TEN as HOTEN
from HOCVIEN HV inner join (
	select MAHV, count(distinct MAMH) as SOMONTHI from KETQUATHI
	group by MAHV
) KQ
on HV.MAHV = KQ.MAHV
where SOMONTHI = 4 and HV.MAHV not in (
	select MAHV from KETQUATHI
	where LANTHI = 1 and KQUA = 'Khong Dat'
)

--Bai tap 2, phan III, cau 34, trang 13
select distinct HV.MAHV, HO + ' ' + TEN as HOTEN
from HOCVIEN HV inner join (
	select MAHV, count(distinct MAMH) as SOMONTHI from KETQUATHI
	group by MAHV
) KQ
on HV.MAHV = KQ.MAHV
where SOMONTHI = 4 and HV.MAHV not in (
	select KQ.MAHV from KETQUATHI KQ inner join (
		select MAHV, MAMH, max(LANTHI) as MAXLANTHI from KETQUATHI
		group by MAHV, MAMH
	) A
	on A.MAHV = KQ.MAHV
	where KQ.MAMH = A.MAMH and LANTHI = MAXLANTHI and KQUA = 'Khong Dat'
)

--Bai tap 2, phan III, cau 35, trang 13
select KQ.MAMH, KQ.MAHV, HO + ' ' + TEN as HOTEN
from ((HOCVIEN HV inner join KETQUATHI KQ
on HV.MAHV = KQ.MAHV) inner join (
	select MAMH, max(DIEMCUOI) as MAXDIEMCUOI
	from (
		select KQ.MAMH, KQ.MAHV, DIEM as DIEMCUOI
		from KETQUATHI KQ inner join (
			select MAMH, MAHV, max(LANTHI) as MAXLANTHI
			from KETQUATHI
			group by MAMH, MAHV
		) A
		on KQ.MAHV = A.MAHV
		where KQ.MAMH = A.MAMH and LANTHI = MAXLANTHI
	) B
	group by MAMH
) C
on KQ.MAMH = C.MAMH)
where KQ.DIEM = C.MAXDIEMCUOI
