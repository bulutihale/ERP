<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
	isTur				=	Request.Form("isTur")
	stokKodu			=	Request.Form("stokKodu")
	stokHareketTuru		=	Request.Form("stokHareketTuru")
	kullanimMiktar		=	Request.Form("kullanimMiktar")
	miktarBirim			=	Request.Form("miktarBirim")
	surecDepoID			=	Request.Form("surecDepoID")
	stokID				=	Request.Form("stokID")
	siparisKalemID		=	Request.Form("siparisKalemID")
	lot					=	Request.Form("lot")
	stokHareketTipi		=	Request.Form("stokHareketTipi")
	secilenDepoID		=	Request.Form("secilenDepoID")
	lotSKT				=	Request.Form("lotSKT")
	ajandaID			=	Request.Form("ajandaID")
	ihtiyacMiktar		=	Request.Form("ihtiyacMiktar")


	sorgu = "SELECT stok.FN_birimIDBul('" & miktarBirim & "','K') as bid"
	rs.open sorgu,sbsv5,1,3
		birimID	=	rs("bid")
	rs.close
	

	modulAd =   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

if cdbl(ihtiyacMiktar) < cdbl(kullanimMiktar) then
	call toastrCagir("Kullanım miktarı, ihtiyaç miktarından fazla olamaz.","HATA","center","error","otomatik","")
	Response.End()
end if

Response.Flush()

call logla("Üretim için seçilen Lot kayıt")


yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then

	sorgu = "SELECT stok.FN_depoSinifBul("&surecDepoID&") as a, stok.FN_depoSinifBul("&secilenDepoID&") as b"
	rs.open sorgu, sbsv5, 1, 3
		if rs("a") <> rs("b")  then
			call toastrCagir("Temin depo ile seçilen süreç UYUMSUZ!","HATA","center","error","otomatik","")
			Response.End()
		end if
	rs.close
	

		sorgu = "SELECT * FROM stok.stokHareket"
		rs.open sorgu, sbsv5, 1, 3
			rs.addnew
				rs("kid")					=	kid
				rs("firmaID")				=	firmaID
				rs("stokKodu")				=	stokKodu
				rs("miktar")				=	kullanimMiktar
				rs("miktarBirim")			=	miktarBirim
				rs("miktarBirimID")			=	birimID
				rs("girisTarih")			=	date()
				rs("stokHareketTuru")		=	stokHareketTuru
				rs("depoID")				=	secilenDepoID
				rs("aciklama")				=	"Transfer"
				rs("stokID")				=	stokID
				rs("siparisKalemID")		=	siparisKalemID
				rs("lot")					=	lot
				rs("stokHareketTipi")		=	stokHareketTipi
				rs("lotSKT")				=	lotSKT
				rs("ajandaID")				=	ajandaID
			rs.update
			cikisHareketID	=	rs("stokHareketID")

			rs.addnew
				rs("kid")					=	kid
				rs("firmaID")				=	firmaID
				rs("stokKodu")				=	stokKodu
				rs("miktar")				=	kullanimMiktar
				rs("miktarBirim")			=	miktarBirim
				rs("miktarBirimID")			=	birimID
				rs("girisTarih")			=	date()
				rs("stokHareketTuru")		=	"G"
				rs("depoID")				=	surecDepoID
				rs("aciklama")				=	"Transfer"
				rs("stokID")				=	stokID
				rs("siparisKalemID")		=	siparisKalemID
				rs("lot")					=	lot
				rs("stokHareketTipi")		=	stokHareketTipi
				rs("refHareketID")			=	cikisHareketID
				rs("lotSKT")				=	lotSKT
				rs("ajandaID")				=	ajandaID
			rs.update
		rs.close
	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

