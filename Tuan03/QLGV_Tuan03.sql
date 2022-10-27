use QLGV

--Bai tap 2, phan II, cau 1, trang 12
update GIAOVIEN
set HESO += 0.2
where MAGV in (
	select TRGKHOA from KHOA
)


--Bai tap 2, phan II, cau 2, trang 12
update HOCVIEN set DIEMTB = DTBHV.DTB
from HOCVIEN left join (
	select KQ.MAHV, AVG(KQ.DIEM) as DTB
	from KETQUATHI KQ inner join (
		select MAHV, MAMH, max(LANTHI) LANTHIMAX
		from KETQUATHI
		group by MAHV, MAMH
	) A
	on KQ.MAHV = A.MAHV and KQ.MAMH = A.MAMH and KQ.LANTHI = A.LANTHIMAX
	group by KQ.MAHV
) DTBHV
on HOCVIEN.MAHV = DTBHV.MAHV

--Bai tap 2, phan II, cau 3, trang 12
update HOCVIEN set GHICHU = 'Cam thi'
where MAHV in (
	select MAHV
	from KETQUATHI
	where LANTHI = 3 and DIEM < 5
)

--Bai tap 2, phan II, cau 4, trang 12
update HOCVIEN set XEPLOAI = 
case 
	when DIEMTB >= 9 then 'XS'
	when DIEMTB < 9 and DIEMTB >= 8 then 'G'
	when DIEMTB < 8 and DIEMTB >= 6.5 then 'K'
	when DIEMTB < 6.5 and DIEMTB >= 5 then 'TB'
	when DIEMTB < 5 then 'Y'
end;

--Bai tap 2, phan III, cau 6, trang 12
select distinct TENMH 
from ((MONHOC MH inner join GIANGDAY GD
on MH.MAMH = GD.MAMH) inner join GIAOVIEN GV
on GD.MAGV = GV.MAGV)
where HOTEN = 'Tran Tam Thanh' and HOCKY = 1 and NAM = 2006

--Bai tap 2, phan III, cau 7, trang 12
select distinct MH.MAMH, TENMH
from MONHOC MH, GIANGDAY GD, GIAOVIEN GV, LOP
where
(
	LOP.MAGVCN = GV.MAGV
	and GD.MAGV = GV.MAGV
	and GD.MAMH = MH.MAMH
	and LOP.MALOP = 'K11'
	and HOCKY = 1
	and NAM = 2006
)

--Bai tap 2, phan III, cau 8, trang 12
select HO + ' ' + TEN as HOTEN from HOCVIEN
where MAHV in (
	select TRGLOP from LOP inner join GIANGDAY GD
	on LOP.MALOP = GD.MALOP
	where GD.MAGV in (
			select MAGV from GIAOVIEN
			where HOTEN = 'Nguyen To Lan' )
		and GD.MAMH in (
			select MAMH from MONHOC
			where TENMH = 'Co So Du Lieu')
)

--Bai tap 2, phan III, cau 9, trang 12
select MH.MAMH, MH.TENMH
from MONHOC MH inner join DIEUKIEN DK
on DK.MAMH_TRUOC = MH.MAMH
where DK.MAMH in (
	select MAMH from MONHOC
	where TENMH = 'Co So Du Lieu'
)

--Bai tap 2, phan III, cau 10, trang 12
select MH.MAMH, TENMH
from MONHOC MH inner join DIEUKIEN DK
on DK.MAMH = MH.MAMH
where MAMH_TRUOC in (
	select MAMH from MONHOC
	where TENMH = 'Cau Truc Roi Rac'
)

--Bai tap 2, phan III, cau 11, trang 12
select HOTEN
from GIAOVIEN
where MAGV in (
	select MAGV from GIANGDAY
	where MAMH = 'CTRR' and MALOP in ('K11', 'K12') and HOCKY = 1 and NAM = 2006
	group by MAGV
	having count(distinct MALOP) = 2
)

--Bai tap 2, phan III, cau 12, trang 13
select HV.MAHV, HO + ' ' + TEN as HOTEN
from HOCVIEN HV inner join KETQUATHI KQ
on KQ.MAHV = HV.MAHV
where LANTHI = 1 and KQUA = 'Khong dat' and MAMH = 'CSDL' and KQ.MAHV not in (
	select MAHV
	from KETQUATHI
	where LANTHI > 1 and MAMH = 'CSDL'
)

--Bai tap 2, phan III, cau 13, trang 13
select MAGV, HOTEN
from GIAOVIEN
where MAGV not in (
	select MAGV
	from GIANGDAY
)

--Bai tap 2, phan III, cau 14, trang 13
select MAGV, HOTEN
from GIAOVIEN
where MAGV not in (
	select GV.MAGV
	from GIAOVIEN GV, GIANGDAY GD, MONHOC MH
	where (
		GV.MAGV = GD.MAGV
		and GD.MAMH = MH.MAMH
		and MH.MAKHOA = GV.MAKHOA
	)
)

--Bai tap 2, phan III, cau 15, trang 13
select HO + ' ' + TEN as HOTEN
from HOCVIEN HV inner join KETQUATHI KQ
on HV.MAHV = KQ.MAHV
where MALOP = 'K11' and ((LANTHI = 3 and KQUA = 'Khong dat') or (LANTHI = 2 and MAMH = 'CTRR' and DIEM = 5))

--Bai tap 2, phan III, cau 16, trang 13
select HOTEN
from GIAOVIEN
where MAGV in (
	select MAGV from GIANGDAY
	where MAMH = 'CTRR'
	group by MAGV, HOCKY, NAM
	having count(distinct MALOP) >=2
)

--Bai tap 2, phan III, cau 17, trang 13
select HV.MAHV, HO + ' ' + TEN as HOTEN, DIEM
from ((KETQUATHI KQ inner join HOCVIEN HV
on KQ.MAHV = HV.MAHV) inner join (
	select MAHV, MAX(LANTHI) LANTHIMAX
	from KETQUATHI
	where MAMH = 'CSDL'
	group by MAHV, MAMH
	) A
on A.MAHV = HV.MAHV
)
where KQ.LANTHI = A.LANTHIMAX and MAMH = 'CSDL'
order by HV.MAHV

--Bai tap 2, phan III, cau 18, trang 13
select HV.MAHV, HO + ' ' + TEN as HOTEN, DIEMMAX
from HOCVIEN HV inner join (
	select MAHV, max(DIEM) as DIEMMAX from KETQUATHI
	where MAMH in (
		select MAMH from MONHOC
		where TENMH = 'Co So Du Lieu'
	)
	group by MAHV, MAMH
) DIEM_CSDL_MAX
on HV.MAHV = DIEM_CSDL_MAX.MAHV


