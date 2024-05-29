<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

    call sessiontest()
    kid		=	kidbul()

	modulAd 		=   "Fason" 

	'##### YETKİ BUL
	'##### YETKİ BUL
	yetkiKontrol	 = yetkibul(modulAd)
	'##### YETKİ BUL
	'##### YETKİ BUL

	listeStokHareketID			=	Request.Form("listeStokHareketID[]")
	fasonAnaID					=	Request.Form("fasonAnaID")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	'########### liste halinde gelen stokHareketID yi kullanarak ürün girişlerini yap

	sorgu = "UPDATE stok.stokHareket SET stokHareketTuru = 'G' WHERE stokHareketID IN (" & listeStokHareketID & ")"
	rs.open sorgu, sbsv5, 3, 3

	'########### /liste halinde gelen stokHareketID yi kullanarak ürün girişlerini yap

	'############# fasona gönderilen ürünler belge numarası belirle
		sorgu = "SELECT TOP(1) belgeNo FROM fason.fasonDetay ORDER BY id DESC"
		fn1.open sorgu, sbsv5,1,3
			'##### DOSYA NO OLUŞTUR
			'##### DOSYA NO OLUŞTUR
				if fn1.recordcount = 0 then
					belgeNo_p2	=	"00001"
					belgeNo 	=	"FSN" & year(date()) & "_" & belgeNo_p2
				else
					belgeNo		=	replace(fn1("belgeNo"),"FSN","")
					belgeNo_p2	=	right(belgeNo,5)
					if int(left(belgeNo,4)) <> int(year(date())) then
						belgeNo_p2 = "00000"
					end if
					belgeNo_p2	=	int(belgeNo_p2)
					belgeNo_p2	=	belgeNo_p2+1
					belgeNo_p2	=	1000000 + belgeNo_p2
					belgeNo_p2	=	right(belgeNo_p2,5)
					belgeNo		=	"FSN" & year(date()) & "_" & belgeNo_p2
				end if
			'##### /DOSYA NO OLUŞTUR
			'##### /DOSYA NO OLUŞTUR
		fn1.close
	'############# /fasona gönderilen ürünler belge numarası belirle



	sorgu = "SELECT t1.stokHareketID, t1.stokID"
	sorgu = sorgu & " FROM stok.stokHareket t1"
	sorgu = sorgu & " WHERE t1.stokHareketID IN (" & listeStokHareketID & ")"
	rs.open sorgu, sbsv5, 1, 3
		for li = 1 to rs.recordcount
			stokHareketID		=	rs("stokHareketID")
			stokID				=	rs("stokID")
			
			sorgu = "INSERT INTO fason.fasonDetay(fasonAnaID, stokID, gonderimZamani, gidisStokhareketID, belgeNo) VALUES(" & fasonAnaID & ", " & stokID & ", getdate(), " & stokHareketID & ", '" & belgeNo &"')"
			rs1.open sorgu, sbsv5, 3, 3
		rs.movenext
		next
	rs.close



%><!--#include virtual="/reg/rs.asp" -->






