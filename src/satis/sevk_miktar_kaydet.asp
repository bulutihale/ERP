<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()




	'##### request
	'##### request
		kid						=	kidbul()

		cikisdepoID				=	request("depoID")
		sevkMiktar				=	request("sevkMiktar")
		siparisKalemID			=	request("siparisKalemID")
		lot						=	request("lot")
		ajandaID				=	request("ajandaID")
		sevkTip					=	request("sevkTip")
		stokHareketID			=	request("stokHareketID")
		sevkcariID				=	request("sevkcariID")
	'##### request
	'##### request

	if sevkTip = "siparisSevk" then
		call logla("İrsaliye için sevk miktarı TEMP tablosuna yazılıyor siparisKalemID:"&siparisKalemID)

		sorgu = "SELECT t2.cariID, t1.stokID, t3.stokKodu, t1.mikBirimID, t1.mikBirim, t1.birimFiyat, t1.paraBirim,"
		sorgu = sorgu & " stok.FN_lotSktBul("&firmaID&",t1.stokID,'"&lot&"') as lotSKT"
		sorgu = sorgu & " FROM teklif.siparisKalem t1"
		sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
		sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
		sorgu = sorgu & " WHERE t1.id = " & siparisKalemID
		rs.open sorgu, sbsv5,1,3
			if rs.recordcount > 0 then
				cariID			=	rs("cariID")
				stokID			=	rs("stokID")
				stokKodu		=	rs("stokKodu")
				mikBirimID		=	rs("mikBirimID")
				mikBirim		=	rs("mikBirim")
				birimFiyat		=	rs("birimFiyat")
				paraBirim		=	rs("paraBirim")
				lotSKT			=	rs("lotSKT")
			end if
		rs.close
	elseif sevkTip = "stoktanSevk" then
		sorgu = "SELECT t1.stokID, t1.stokKodu, t1.miktarBirimID, t1.miktarBirim, t1.lotSKT"
		sorgu = sorgu & " FROM stok.stokhareket t1"
		sorgu = sorgu & " WHERE t1.stokHareketID = " & stokHareketID
		rs.open sorgu, sbsv5,1,3
			if rs.recordcount > 0 then
				cariID			=	sevkcariID
				stokID			=	rs("stokID")
				stokKodu		=	rs("stokKodu")
				mikBirimID		=	rs("miktarBirimID")
				mikBirim		=	rs("miktarBirim")
				birimFiyat		=	0
				paraBirim		=	""
				lotSKT			=	rs("lotSKT")
			end if
		rs.close
	end if
'###### geçici tabloya irsaliye için gerekli bilgileri yaz

'###### stokHareket Tablosuna satış deposundan çıkış kaydını yaz
			sorgu = "SELECT * FROM stok.stokHareket"
			rs1.open sorgu, sbsv5,1,3
				rs1.addnew
					rs1("kid")				=	kid
					rs1("firmaID")			=	firmaID
					rs1("stokKodu")			=	stokKodu
					rs1("miktar")			=	sevkMiktar
					rs1("miktarBirim")		=	mikBirim
					rs1("miktarBirimID")	=	mikBirimID
					rs1("girisTarih")		=	date()
					rs1("stokHareketTuru")	=	"C"
					rs1("depoID")			=	cikisdepoID
					rs1("aciklama")			=	"Satış"
					rs1("stokID")			=	stokID
					rs1("stokHareketTipi")	=	"S"
					rs1("lot")				=	lot
					rs1("lotSKT")			=	tarihsql(lotSKT)
					rs1("ajandaID")			=	ajandaID
					rs1("siparisKalemID")	=	siparisKalemID
				rs1.update
				stokHareketID	=	rs1("stokHareketID")
			rs1.close
'###### stokHareket Tablosuna satış deposundan çıkış kaydını yaz



	sorgu = "SELECT * FROM teklif.siparisKalemTemp"
	rs.open sorgu, sbsv5,1,3
			rs.addnew
				rs("kid")				=	kid
				rs("firmaID")			=	firmaID
				rs("cariID")			=	cariID
				rs("stokID")			=	stokID
				rs("miktar")			=	sevkMiktar
				rs("birimFiyat")		=	birimFiyat
				rs("paraBirim")			=	paraBirim
				rs("siparisTur")		=	"IRS"
				rs("mikBirim")			=	mikBirim
				rs("mikBirimID")		=	mikBirimID
				rs("siparisTarih")		=	date()
				rs("lot")				=	lot
				rs("stokHareketID")		=	stokHareketID
				rs("talepSipKalemID")	=	siparisKalemID
			rs.update
			call logla("Kayıt Başarılı.")
	rs.close
'###### geçici tabloya irsaliye için gerekli bilgileri yaz



%>

