<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
    urunTip				=	Request.Form("urunTip")
	mamulLot			=	Request.Form("lot")
	mamulMiktar			=	Request.Form("mamulMiktar")
	koliIndexID			=	Request.Form("koliIndexID")
	sarfDepoID			=	Request.Form("sarfDepoID")
	ihtiyacKoliSayi		=	Request.Form("ihtiyacKoliSayi")
	ihtiyacBantMt		=	Request.Form("ihtiyacBantMt")
	ajandaID			=	Request.Form("ajandaID")
	mamulCikisDepoID	=	Request.Form("mamulCikisDepoID")
	modulAd 			=   "Sterilizasyon"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

Response.Flush()


call logla("Sterilizasyon süreci, koli seçimi")

yetkiKontrol = yetkibul(modulAd)

'################ kolilenecek ürünlerin giriş yapacağı depoyu belirle
'################ kolilenecek ürünlerin giriş yapacağı depoyu belirle
	if urunTip = "nonSteril" then
		hazirUrunDepoKategori	=	"satis"
	elseif urunTip = "steril" then
		hazirUrunDepoKategori	=	"surecSterilizasyon"
	end if

	sorgu = "SELECT id FROM stok.depo WHERE depoKategori = '" & hazirUrunDepoKategori & "'"
	rs.open sorgu,sbsv5,1,3
		hazirUrunGirisDepoID	=	rs("id")
	rs.close
'################ /kolilenecek ürünlerin giriş yapacağı depoyu belirle
'################ /kolilenecek ürünlerin giriş yapacağı depoyu belirle



'###### ARAMA FORMU
'###### ARAMA FORMU
	if yetkiKontrol > 6 then


	'####### ürünleri kolile, kullanılan bant, koli gibi malzemeleri stoktan düş
	'####### ürünleri kolile, kullanılan bant, koli gibi malzemeleri stoktan düş
		sorgu = "SELECT t2.bantStokID, t2.hamKoliStokID, t2.bantMt, t3.stokKodu as bantStokKodu, t4.stokKodu as hamKoliStokKodu,"
		sorgu = sorgu & " t1.stokID as mamulStokID, t5.stokKodu as mamulStokKodu, t5.anaBirimID as mamulAnaBirimID,"
		sorgu = sorgu & " portal.siparisKalemIDbul(" & firmaID & ", " & ajandaID & ") as siparisKalemID,"
		sorgu = sorgu & " t3.anaBirimID as bantAnaBirimID, t4.anaBirimID as koliAnaBirimID, stok.FN_anaBirimAdBul(t1.stokID, 'kAD') as mamulAnaBirimAd,"
		sorgu = sorgu & " stok.FN_anaBirimAdBul(t2.bantStokID, 'kAD') as bantAnaBirimAd, stok.FN_anaBirimADBul(t2.hamKoliStokID, 'kAD') as koliAnaBirimAd"
		sorgu = sorgu & " FROM stok.koliIndex t1"
		sorgu = sorgu & " INNER JOIN stok.koli t2 ON t1.koliID = t2.koliID"
		sorgu = sorgu & " INNER JOIN stok.stok t3 ON t2.bantStokID = t3.stokID"
		sorgu = sorgu & " INNER JOIN stok.stok t4 ON t2.hamKoliStokID = t4.stokID"
		sorgu = sorgu & " INNER JOIN stok.stok t5 ON t1.stokID = t5.stokID"
		sorgu = sorgu & " WHERE koliIndexID = " & koliIndexID
		rs.open sorgu,sbsv5,1,3
			
			mamulStokID			=	rs("mamulStokID")
			mamulStokKodu		=	rs("mamulStokKodu")
			mamulAnaBirimID		=	rs("mamulAnaBirimID")
			mamulAnaBirimAd		=	rs("mamulAnaBirimAd")
			siparisKalemID		=	rs("siparisKalemID")

			bantStokID			=	rs("bantStokID")
			bantStokKodu		=	rs("bantStokKodu")
			bantAnaBirimID		=	rs("bantAnaBirimID")
			bantAnaBirimAd		=	rs("bantAnaBirimAd")
			lot					=	"lotTakibiYok"
			bilgiBant			=	bantStokID & "|" & bantStokKodu & "|" & ihtiyacBantMt & "|" & bantAnaBirimID & "|" & bantAnaBirimAd & "|" & lot

			hamKoliStokID		=	rs("hamKoliStokID")
			hamKoliStokKodu		=	rs("hamKoliStokKodu")
			koliAnaBirimID		=	rs("koliAnaBirimID")
			koliAnaBirimAd		=	rs("koliAnaBirimAd")
			lot					=	"lotTakibiYok"
			bilgiKoli			=	hamKoliStokID & "|" & hamKoliStokKodu & "|" & ihtiyacKoliSayi & "|" & koliAnaBirimID & "|" & koliAnaBirimAd & "|" & lot
		rs.close

		bilgiArr	=	Array(bilgiBant, bilgiKoli)


	for each a in bilgiArr
		altBilgiArr		=	split(a,"|")
		
		for zi = 0 to ubound(altBilgiArr)
			stokID			=	altBilgiArr(0)
			stokKodu		=	altBilgiArr(1)
			miktar			=	altBilgiArr(2)
			miktarBirimID	=	altBilgiArr(3)
			miktarBirim		=	altBilgiArr(4)
			lot				=	altBilgiArr(5)
		next

		sorgu = "SELECT * FROM stok.stokHareket"
		rs.open sorgu,sbsv5,1,3
			rs.addnew
			rs("kid")				=	kid
			rs("firmaID")			=	firmaID
			rs("stokID")			=	stokID
			rs("stokKodu")			=	stokKodu
			rs("miktar")			=	miktar
			rs("miktarBirimID")		=	miktarBirimID
			rs("miktarBirim")		=	miktarBirim
			rs("girisTarih")		=	now()
			rs("stokHareketTuru")	=	"C"
			rs("lot")				=	lot
			rs("depoID")			=	sarfDepoID
			rs("aciklama")			=	"Kullanım"
			rs("siparisKalemID")	=	siparisKalemID
			rs("stokHareketTipi")	=	"T"
			rs("prodHareketID")		=	null
			rs("lotSKT")			=	null
			rs("ajandaID")			=	0
		rs.update
		rs.close
	next
	'####### /ürünleri kolile, kullanılan bant, koli gibi malzemeleri stoktan düş
	'####### /ürünleri kolile, kullanılan bant, koli gibi malzemeleri stoktan düş

		'if urunTip = "nonSteril" then

		'#### kolilere konan mamülün beklediği depodan çıkışını yap
			sorgu = "SELECT * FROM stok.stokHareket"
			rs.open sorgu,sbsv5,1,3
				rs.addnew
				rs("kid")				=	kid
				rs("firmaID")			=	firmaID
				rs("stokID")			=	mamulStokID
				rs("stokKodu")			=	mamulStokKodu
				rs("miktar")			=	mamulMiktar
				rs("miktarBirimID")		=	mamulAnaBirimID
				rs("miktarBirim")		=	mamulAnaBirimAd
				rs("girisTarih")		=	now()
				rs("stokHareketTuru")	=	"C"
				rs("lot")				=	mamulLot
				rs("depoID")			=	mamulCikisDepoID
				rs("aciklama")			=	"Transfer"
				rs("siparisKalemID")	=	siparisKalemID
				rs("stokHareketTipi")	=	"T"
				rs("prodHareketID")		=	null
				rs("lotSKT")			=	null
				rs("ajandaID")			=	ajandaID
			rs.update
		rs.close
		'#### /kolilere konan mamülün beklediği depodan çıkışını yap

		'#### NON steril ürünleri mamul depoya giriş yap
			sorgu = "SELECT * FROM stok.stokHareket"
			rs.open sorgu,sbsv5,1,3
				rs.addnew
				rs("kid")				=	kid
				rs("firmaID")			=	firmaID
				rs("stokID")			=	mamulStokID
				rs("stokKodu")			=	mamulStokKodu
				rs("miktar")			=	mamulMiktar
				rs("miktarBirimID")		=	mamulAnaBirimID
				rs("miktarBirim")		=	mamulAnaBirimAd
				rs("girisTarih")		=	now()
				rs("stokHareketTuru")	=	"G"
				rs("lot")				=	mamulLot
				rs("depoID")			=	hazirUrunGirisDepoID
				rs("aciklama")			=	"Transfer"
				rs("siparisKalemID")	=	siparisKalemID
				rs("stokHareketTipi")	=	"T"
				rs("prodHareketID")		=	null
				rs("lotSKT")			=	null
				rs("ajandaID")			=	ajandaID
				rs("koliIndexID")		=	koliIndexID
				rs("koliSayi")		=	ihtiyacKoliSayi
			rs.update
		rs.close
'#### /NON steril ürünleri mamul depoya giriş yap

		'end if


	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%><!--#include virtual="/reg/rs.asp" -->



