<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
	
	
	stokKodu		=	Request.Form("stokKodu")
    miktar			=   Request.Form("gelenMiktar")
	miktarBirim		=	Request.Form("miktarBirim")
	sipMiktar		=   Request.Form("sipMiktar")
	teslimEdilen	=   Request.Form("teslimEdilen")
    depoID			=   Request.Form("depoSec")
	aciklama		=   Request.Form("aciklama")
    belgeNo			=   Request.Form("belgeNo")
	belgeTarih		=   Request.Form("belgeTarih")
	stokID			=   Request.Form("stokID")
    cariID	 		=   Request.Form("cariSec")
    girisTarih		=   Request.Form("girisTarih")
	siparisKalemID	=	Request.Form("siparisKalemID")
	lot				=	Request.Form("lot")
	lotSKT			=	Request.Form("lotSKT")
	
    modulAd =   "depo"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Mal Kabul Belge Kayıt:" & belgeNo & "")

yetkiKontrol = yetkibul(modulAd)


	call rqKontrol(cariID,"Cari seçimi yapılmalı.","")
	call rqKontrol(stokKodu,"Ürün seçimi yapılmalı.","")
	call rqKontrol(belgeTarih,"Gelen Belgenin tarih bilgisi girilmeli.","")
	call rqKontrol(belgeNo,"Gelen Belgenin numarası girilmeli.","")
	call rqKontrol(girisTarih,"Giriş tarihi belirtilmeli.","")
	call rqKontrol(miktar,"Miktar belirtilmeli.","")
	call rqKontrol(miktarBirim,"Birim seçimi yapılmalı.","")

if cdbl(miktar) + cdbl(teslimEdilen) > cdbl(sipMiktar) then 
	hatamesaj = "Toplam teslim alınan miktar sipariş miktarından fazla olamaz."
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

	call rqKontrol(depoID,"Giriş deposu seçilmeli.","")
	call rqKontrol(lotSKT,"LOT a ait son kullanma tarihi girilmedi.","")


'################### stok hareket tablosuna mal kabul kaydı yaz
	
	sorgu = "SELECT top(1) * FROM stok.stokHareket"
	rs.open sorgu, sbsv5, 1, 3
		rs.addnew
			rs("firmaID")			=	firmaID
			rs("kid")				=	kid
			rs("stokKodu")			=	stokKodu
			rs("miktar")			=	miktar
			rs("miktarBirim")		=	miktarBirim
			rs("stokHareketTuru")	=	"G"
			rs("stokHareketTipi")	=	"A"
			rs("depoID")			=	depoID
			rs("girisTarih")		=	girisTarih
			rs("fisNo")				=	""'mal kabul fiş numarasını yaz
			rs("aciklama")			=	aciklama
			rs("belgeNo")			=	belgeNo
			rs("belgeTarih")		=	belgeTarih
			rs("stokID")			=	stokID
			rs("cariID")			=	cariID
			rs("siparisKalemID")	=	siparisKalemID
			rs("lot")				=	lot
			rs("lotSKT")			=	lotSKT
		rs.update
		rs.close

'################### stok hareket tablosuna mal kabul kaydı yaz

call bildirim(2,"Ürün Bildirimi",stokKodu & " Ürün girişi yapıldı",1,kid,"","","","","")

call toastrCagir("Mal kabul ürün kaydı yapıldı.", "OK", "right", "success", "otomatik", "")

call jsrun("$('#divsipListe').load('/malKabul/mal_kabul_siparis_liste.asp',{cariID:"&cariID&"})")

call jsrun("$('.inpReset').val('')")





%><!--#include virtual="/reg/rs.asp" -->















