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
	depoKategori		=	Request.Form("depoKategori")
	stokID				=	Request.Form("stokID")
	siparisKalemID		=	Request.Form("siparisKalemID")
	lot					=	Request.Form("lot")
	stokHareketTipi		=	Request.Form("stokHareketTipi")
	cikisDepoID			=	Request.Form("secilenDepoID")
	lotSKT				=	Request.Form("lotSKT")

	modulAd =   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Üretim için seçilen Lot kayıt")


yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then

	sorgu = "SELECT id FROM stok.depo WHERE"
		if isTur = "uretimPlan" then
			sorgu = sorgu & " depoKategori = 'surecUretim'"
		elseif isTur = "kesimPlan" then
			sorgu = sorgu & " depoKategori = 'surecKesim'"
		end if
	rs.open sorgu, sbsv5, 1, 3
		surecDepoID	=	rs("id")
	rs.close
	

		sorgu = "SELECT * FROM stok.stokHareket"
		rs.open sorgu, sbsv5, 1, 3
			rs.addnew
				rs("kid")					=	kid
				rs("firmaID")				=	firmaID
				rs("stokKodu")				=	stokKodu
				rs("miktar")				=	kullanimMiktar
				rs("miktarBirim")			=	miktarBirim
				rs("girisTarih")			=	date()
				rs("stokHareketTuru")		=	stokHareketTuru
				rs("depoID")				=	cikisDepoID
				rs("aciklama")				=	"Transfer"
				rs("stokID")				=	stokID
				rs("siparisKalemID")		=	siparisKalemID
				rs("lot")					=	lot
				rs("stokHareketTipi")		=	stokHareketTipi
				rs("lotSKT")				=	lotSKT
			rs.update
			cikisHareketID	=	rs("stokHareketID")

			rs.addnew
				rs("kid")					=	kid
				rs("firmaID")				=	firmaID
				rs("stokKodu")				=	stokKodu
				rs("miktar")				=	kullanimMiktar
				rs("miktarBirim")			=	miktarBirim
				rs("girisTarih")			=	date()
				rs("stokHareketTuru")		=	"G"
				rs("depoID")				=	surecDepoID
				rs("aciklama")				=	"Transfer"
				rs("stokID")				=	stokID
				rs("siparisKalemID")		=	siparisKalemID
				rs("lot")					=	lot
				rs("stokHareketTipi")		=	stokHareketTipi
				rs("refHareketID")			=	cikisHareketID
				rs("refHareketID")			=	cikisHareketID
				rs("lotSKT")				=	lotSKT
			rs.update
		rs.close
	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

