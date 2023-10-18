<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
	isTur				=	Request.Form("isTur")
	stokKodu			=	Request.Form("stokKodu")
	stokHareketTuru		=	Request.Form("stokHareketTuru")
	kullanimMiktar		=	Request.Form("kullanimMiktar")
	kullanimMiktar 		=	replace(kullanimMiktar,".",",")
	kullanimMiktar		=	cdbl(kullanimMiktar)
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
	receteAdimID		=	Request.Form("receteAdimID")

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
		sorgu = sorgu & " WHERE ajandaID = " & ajandaID & ""
		sorgu = sorgu & " AND siparisKalemID = " & siparisKalemID & ""
		sorgu = sorgu & " AND stokID = " & stokID & ""
		sorgu = sorgu & " AND lot = '" & lot & "'"
		sorgu = sorgu & " AND silindi = 0"
		sorgu = sorgu & " AND stokHareketTuru = 'G'"
		rs.open sorgu, sbsv5, 1, 3

		if rs.recordcount > 0 then
			'########## gelen LOT daha önce üretim sürecine kayıt edilmiş ise miktarını arttır
				lotEskiMiktar	=	rs("miktar")
				lotYeniMiktar	=	cdbl(lotEskiMiktar) + cdbl(kullanimMiktar)
				rs("miktar")	=	lotYeniMiktar
				rs.update
			'########## /gelen LOT daha önce üretim sürecine kayıt edilmiş ise miktarını arttır

			'########## gelen LOT daha önce üretim sürecine kayıt edilmiş ise ÇIKIŞ miktarını arttır
				sorgu = "UPDATE stok.stokHareket SET miktar = " & lotYeniMiktar & ""
				sorgu = sorgu & " WHERE ajandaID = " & ajandaID & ""
				sorgu = sorgu & " AND siparisKalemID = " & siparisKalemID & ""
				sorgu = sorgu & " AND stokID = " & stokID & ""
				sorgu = sorgu & " AND lot = '" & lot & "'"
				sorgu = sorgu & " AND silindi = 0"
				sorgu = sorgu & " AND stokHareketTuru = 'C'"
				rs1.open sorgu, sbsv5, 3, 3
			'########## /gelen LOT daha önce üretim sürecine kayıt edilmiş ise ÇIKIŞ miktarını arttır
		else
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
				rs("lotSKT")				=	tarihsql(lotSKT)
				rs("ajandaID")				=	ajandaID
				rs("receteAdimID")			=	receteAdimID
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
				rs("lotSKT")				=	tarihsql(lotSKT)
				rs("ajandaID")				=	ajandaID
				rs("receteAdimID")			=	receteAdimID
			rs.update
		end if
		rs.close
	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

