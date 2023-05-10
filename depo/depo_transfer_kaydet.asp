<!--#include virtual="/reg/rs.asp" --><%

 
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()

    girisDepoID		=   Request.Form("girisDepoID") 
    depoID 			=   Request.Form("depoID")
    lot		 		=   Request.Form("lot")
	lotSKT			=   Request.Form("lotSKT")
    aktarMiktar		=   cdbl(Request.Form("aktarMiktar"))
	lotMiktar		=	cdbl(Request.Form("lotMiktar"))
	miktarBirim		=   Request.Form("miktarBirim")
	stokID			=   Request.Form("stokID")
	stokKodu		=   Request.Form("stokKodu")
	ajandaID64		=   Request.Form("ajandaID64")
	ajandaID		=	ajandaID64
	ajandaID		=	base64_decode_tr(ajandaID)
	modulAd 		=   "Depo"

sorgu = "SELECT stok.FN_birimIDBul('" & miktarBirim & "','K') as bid"
rs.open sorgu,sbsv5,1,3
	birimID	=	rs("bid")
rs.close

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call rqKontrol(girisDepoID,"Lütfen giriş yapılacak depo seçimi yapın.","")
call rqKontrol(aktarMiktar,"Lütfen aktarım miktarını yazın.","")


if lotMiktar < aktarMiktar then
	call rqKontrol("","Aktarım miktarı toplam LOT miktarından fazla olamaz.","")
end if

Response.Flush()


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
					rs1("miktarBirimID")	=	birimID
					rs1("girisTarih")		=	date()
					rs1("stokHareketTuru")	=	"C"
					rs1("depoID")			=	depoID
					rs1("aciklama")			=	"Transfer"
					rs1("stokID")			=	stokID
					rs1("stokHareketTipi")	=	"T"
					rs1("lot")				=	lot
					rs1("lotSKT")			=	tarihsql(lotSKT)
					rs1("ajandaID")			=	ajandaID
				rs1.update
				stokHareketID	=	rs1("stokHareketID")
			rs1.close

	call logla("Depo transferi oluşturuldu <b>stokHareketID:</b> " &stokHareketID)
	
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
					rs1("miktarBirimID")	=	birimID
					rs1("girisTarih")		=	date()
					rs1("stokHareketTuru")	=	"GB"
					rs1("depoID")			=	girisDepoID
					rs1("aciklama")			=	"Transfer"
					rs1("stokID")			=	stokID
					rs1("stokHareketTipi")	=	"T"
					rs1("refHareketID")		=	stokHareketID
					rs1("lot")				=	lot
					rs1("lotSKT")			=	tarihsql(lotSKT)
					rs1("ajandaID")			=	ajandaID
				rs1.update
			rs1.close
		'#### /yarı mamullerin hareketini stokHareket tablosuna üretim depoya G (giriş) olarak kaydet


		'### Eğer ajanda üzerinden gelen bir hareket kaydı ise ajanda üzerinde tamamlandı işaretle.
			if not isnull(ajandaID) then
			sorgu = "SELECT (stok.FN_receteMiktarBul("&ajandaID&") * stok.FN_siparisMiktarBul("&ajandaID&","&firmaID&")) as toplamMiktar, stok.FN_transferMiktarBul("&ajandaID&","&firmaID&") as transferMiktar"
			rs.open sorgu, sbsv5,1,3
				toplamMiktar	=	rs("toplamMiktar")
				transferMiktar	=	rs("transferMiktar")
			rs.close
				if not ISNULL(toplamMiktar) then
					if cdbl(transferMiktar) >= cdbl(toplamMiktar) then
						sorgu = "UPDATE portal.ajanda SET tamamlandi = 1 WHERE id = " & ajandaID
						rs.open sorgu, sbsv5,3,3
					end if
				end if
			end if
		'### /Eğer ajanda üzerinden gelen bir hareket kaydı ise ajanda üzerinde tamamlandı işaretle.


%><!--#include virtual="/reg/rs.asp" -->