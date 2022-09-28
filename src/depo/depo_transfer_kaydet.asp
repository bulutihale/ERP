<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()

    girisDepoID		=   Request.Form("girisDepoID")
    depoID 			=   Request.Form("depoID")
    lot		 		=   Request.Form("lot")
	lotSKT			=   Request.Form("lotSKT")
    aktarMiktar		=   Request.Form("aktarMiktar")
	miktarBirim		=   Request.Form("miktarBirim")
	stokID			=   Request.Form("stokID")
	stokKodu		=   Request.Form("stokKodu")
	modulAd 		=   "Depo"

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call rqKontrol(girisDepoID,"Lütfen giriş yapılacak depo seçimi yapın.","")
call rqKontrol(aktarMiktar,"Lütfen aktarım miktarını yazın.","")

Response.Flush()

call logla("Depo transferi oluştur")

yetkiKontrol = yetkibul(modulAd)


		'#### yarı mamullerin hareketini stokHareket tablosuna C (çıkış) olarak kaydet
			sorgu = "SELECT * FROM stok.stokHareket"
			rs1.open sorgu, sbsv5,1,3
				rs1.addnew
					rs1("kid")				=	kid
					rs1("firmaID")			=	firmaID
					rs1("stokKodu")			=	stokKodu
					rs1("miktar")			=	aktarMiktar
					rs1("miktarBirim")		=	miktarBirim
					rs1("girisTarih")		=	date()
					rs1("stokHareketTuru")	=	"C"
					rs1("depoID")			=	depoID
					rs1("aciklama")			=	"Transfer"
					rs1("stokID")			=	stokID
					rs1("stokHareketTipi")	=	"T"
					rs1("lot")				=	lot
					rs1("lotSKT")			=	lotSKT
				rs1.update
				stokHareketID	=	rs1("stokHareketID")
			rs1.close
		'#### /yarı mamullerin hareketini stokHareket tablosuna C (çıkış) olarak kaydet

		'#### yarı mamullerin hareketini stokHareket tablosuna üretim depoya G (giriş) olarak kaydet
			sorgu = "SELECT * FROM stok.stokHareket"
			rs1.open sorgu, sbsv5,1,3
				rs1.addnew
					rs1("kid")				=	kid
					rs1("firmaID")			=	firmaID
					rs1("stokKodu")			=	stokKodu
					rs1("miktar")			=	aktarMiktar
					rs1("miktarBirim")		=	miktarBirim
					rs1("girisTarih")		=	date()
					rs1("stokHareketTuru")	=	"GB"
					rs1("depoID")			=	girisDepoID
					rs1("aciklama")			=	"Transfer"
					rs1("stokID")			=	stokID
					rs1("stokHareketTipi")	=	"T"
					rs1("refHareketID")		=	stokHareketID
					rs1("lot")				=	lot
					rs1("lotSKT")			=	lotSKT
				rs1.update
			rs1.close
		'#### /yarı mamullerin hareketini stokHareket tablosuna üretim depoya G (giriş) olarak kaydet





%><!--#include virtual="/reg/rs.asp" -->