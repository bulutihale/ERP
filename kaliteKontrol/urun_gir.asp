<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")

    stokHareketID	=   Request.Form("stokHareketID")
    onayMiktar 		=   Request.Form("onayMiktar")
	girisDepoID		=	Request.Form("girisDepoID")
	atananLot		=   Request.Form("atananLot")
	atananLot		=	trim(atananLot)
	redMiktar		=   Request.Form("redMiktar")
	redDepoID		=   Request.Form("redDepoID")
	
	if isnull(redMiktar) OR redMiktar = "" then redmiktar = 0
	
	modulAd 	=   "Kalite Kontrol"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Kalite Kontrol ürün kabul: " & stokHareketID & "")

yetkiKontrol = yetkibul(modulAd)

	sorgu = "SELECT t1.miktar, t1.miktarBirim, t1.stokKodu, t1.stokID, t1.lot, t1.lotSKT, t1.depoID, stok.FN_birimIDBul(t1.miktarBirim,'K') as miktarBirimID"
	sorgu = sorgu & " FROM stok.stokHareket t1 WHERE t1.firmaID = " & firmaID & " AND t1.stokHareketID = " & stokHareketID
	rs.open sorgu, sbsv5, 1, 3

		
		girisMiktar		=	rs("miktar")
		miktarBirim		=	rs("miktarBirim")
		miktarBirimID	=	rs("miktarBirimID")
		stokKodu		=	rs("stokKodu")
		stokID			=	rs("stokID")
		cikanLot		=	rs("lot")
		lotSKT			=	rs("lotSKT")
		cikisDepoID		=	rs("depoID")
	rs.close
	

if cdbl(onayMiktar) > 0 AND atananLot = "" then
	hatamesaj = "LOT ataması yapılmamış."
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if cdbl(redMiktar) > 0 AND redDepoID = "" then
	hatamesaj = "Red edilen miktar için Depo seçilmemiş."
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if cdbl(onayMiktar) + cdbl(redMiktar) > cdbl(girisMiktar) then
	hatamesaj = "Onaylanan ve Red edilen miktarlar toplamı giriş miktarından fazla olamaz."
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if cdbl(onayMiktar) + cdbl(redMiktar) <> cdbl(girisMiktar) then
	hatamesaj = "Toplam bekleyen miktar ile kabul - red miktar toplamları eşit olmalı."
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

	'######## tedarikçi değerlendime hesapla
	
	'girisMiktar	=	cdbl(girisMiktar)
	'redMiktar	=	cdbl(redMiktar)
	'onayMiktar	=	cdbl(onayMiktar)
	
		
		teslimBasariYuzde				=	(onayMiktar / girisMiktar) * 100
		
	'######## tedarikçi değerlendime hesapla


if yetkiKontrol > 2 then

	if gorevID = "" then
		gorevID = 0
	end if
	
				sorgu = "SELECT * FROM stok.stokHareket"
				rs.open sorgu, sbsv5, 1, 3
	'###### ONAYLANAN miktar işlemleri
	'###### ONAYLANAN miktar işlemleri
			'##### ÇIKIŞ stok hareketi kayıtları
			'##### ÇIKIŞ stok hareketi kayıtları
				rs.addnew
					rs("firmaID")			=	firmaID
					rs("stokKodu")			=	stokKodu
					rs("miktar")			=	onayMiktar
					rs("miktarBirim")		=	miktarBirim
					rs("miktarBirimID")		=	miktarBirimID
					rs("stokHareketTuru")	=	"C"
					rs("depoID")			=	cikisDepoID
					rs("stokID")			=	stokID
					rs("lot")				=	cikanLot
					rs("lotSKT")			=	lotSKT
					rs("kid")				=	kid
					rs("stokHareketTipi")	=	"T"
					rs("refHareketID")		=	stokHareketID
					rs("girisTarih")		=	date()
				rs.update
				onayliCikisStokHareketID	=	rs("stokHareketID")
			'##### //ÇIKIŞ stok hareketi kayıtları
			'##### //ÇIKIŞ stok hareketi kayıtları
			
			
			'##### GİRİŞ stok hareketi kayıtları
			'##### GİRİŞ stok hareketi kayıtları
				rs.addnew
					rs("firmaID")			=	firmaID
					rs("stokKodu")			=	stokKodu
					rs("miktar")			=	onayMiktar
					rs("miktarBirim")		=	miktarBirim
					rs("miktarBirimID")		=	miktarBirimID
					rs("stokHareketTuru")	=	"G"
					rs("depoID")			=	girisDepoID
					rs("stokID")			=	stokID
					rs("lot")				=	atananLot
					rs("lotSKT")			=	lotSKT
					rs("kid")				=	kid
					rs("stokHareketTipi")	=	"T"
					rs("girisTarih")		=	date()
					rs("teslimBasariYuzde")	=	teslimBasariYuzde
					rs("refHareketID")		=	onayliCikisStokHareketID
				rs.update
			'##### //GİRİŞ stok hareketi kayıtları
			'##### //GİRİŞ stok hareketi kayıtları
	'###### //ONAYLANAN miktar işlemleri
	'###### //ONAYLANAN miktar işlemleri

	'###### RED edilen miktar işlemleri
	'###### RED edilen miktar işlemleri
		if redMiktar > 0 then
				'##### ÇIKIŞ stok hareketi kayıtları
				'##### ÇIKIŞ stok hareketi kayıtları
					rs.addnew
						rs("firmaID")			=	firmaID
						rs("stokKodu")			=	stokKodu
						rs("miktar")			=	redMiktar
						rs("miktarBirim")		=	miktarBirim
						rs("miktarBirimID")		=	miktarBirimID
						rs("stokHareketTuru")	=	"C"
						rs("depoID")			=	cikisDepoID
						rs("stokID")			=	stokID
						rs("lot")				=	cikanLot
						rs("lotSKT")			=	lotSKT
						rs("kid")				=	kid
						rs("stokHareketTipi")	=	"T"
						rs("refHareketID")		=	stokHareketID
						rs("girisTarih")		=	date()
					rs.update
				redCikisStokHareketID	=	rs("stokHareketID")
				'##### //ÇIKIŞ stok hareketi kayıtları
				'##### //ÇIKIŞ stok hareketi kayıtları
				
				'##### RED DEPO GİRİŞ stok hareketi kayıtları
				'##### RED DEPO GİRİŞ stok hareketi kayıtları
					rs.addnew
						rs("firmaID")			=	firmaID
						rs("stokKodu")			=	stokKodu
						rs("miktar")			=	redMiktar
						rs("miktarBirim")		=	miktarBirim
						rs("miktarBirimID")		=	miktarBirimID
						rs("stokHareketTuru")	=	"G"
						rs("depoID")			=	redDepoID
						rs("stokID")			=	stokID
						rs("lot")				=	cikanLot
						rs("lotSKT")			=	lotSKT
						rs("kid")				=	kid
						rs("stokHareketTipi")	=	"T"
						rs("girisTarih")		=	date()
						rs("refHareketID")		=	redCikisStokHareketID
					rs.update
				'##### //RED DEPO GİRİŞ stok hareketi kayıtları
				'##### //RED DEPO GİRİŞ stok hareketi kayıtları
		end if
	'###### //RED edilen miktar işlemleri
	'###### //RED edilen miktar işlemleri
				rs.close
end if

call bildirim(2,"Ürün Bildirimi",stokKodu & " Ürün Kalite Kontrol girişi yapıldı",1,kid,"","","","","")

call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")

call jsac("/kaliteKontrol/bekleyen_liste.asp")
modalkapat()





%><!--#include virtual="/reg/rs.asp" -->






















