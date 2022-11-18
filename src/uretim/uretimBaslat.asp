<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
	siparisKalemID		=	Request.Form("siparisKalemID")
	ajandaID			=	Request.Form("ajandaID")
	islemDurum			=	Request.Form("islemDurum")
	uretilenMiktar		=	Request.Form("uretilenMiktar")

	modulAd =   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


if ajandaID = "" then
	hata = 1
end if
yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 6 then



	if islemDurum = "islemBasla" then

		sorgu = "SELECT icerik FROM protal.ajanda WHERE id = " & ajandaID
		rs.open sorgu,sbsv5,1,3
			call logla("Üretim başlat: " & rs("icerik"))
		rs.close

			sorgu = "UPDATE stok.stokHareket SET stokHareketTipi = 'U' WHERE siparisKalemID = " & siparisKalemID & " AND ajandaID = " & ajandaID & " AND stokHareketTuru = 'G' AND silindi = 0"
			rs.open sorgu,sbsv5,3,3

			sorgu = "UPDATE portal.ajanda SET baslangicZaman = getdate() WHERE id = " & ajandaID & " AND silindi = 0"
			rs.open sorgu,sbsv5,3,3

	elseif islemDurum = "islemBitir" then
'########## stokHareket tablosundaki üretim veya kesim sürecindeki malzemeleri stoktan düş, üretilen yarı mamul veya mamulun stok girişini yap

	'##### üretilen ürüne ait bilgileri al
			sorgu = "SELECT t1.stokID, t1.isTur, t2.stokKodu FROM portal.ajanda t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " WHERE t1.id = " & ajandaID
			rs.open sorgu,sbsv5,1,3
				uretilenStokID		=	rs("stokID")
				stokKodu			=	rs("stokKodu")
				isTur				=	rs("isTur")
			rs.close
	'##### üretilen ürüne ait bilgileri al

	'#### üretilen ürünü süreç çıkışında belirtilen (depo tablosunda) depoya giriş yap 

	sorgu = "SELECT TOP(1) t1.stokHareketID, t1.lot, t1.lotSKT, t2.surecSonuDepoID, t1.stokID"
	sorgu = sorgu & " FROM stok.stokHareket t1"
	sorgu = sorgu & " INNER JOIN stok.depo t2 ON t1.depoID = t2.id"
	sorgu = sorgu & " WHERE t1.siparisKalemID = " & siparisKalemID & " AND t1.ajandaID = " & ajandaID & ""
	sorgu = sorgu & " AND t1.stokHareketTuru = 'G' AND t1.silindi = 0"
	sorgu = sorgu & " ORDER BY t1.stokHareketID DESC"			
	rs.open sorgu,sbsv5,1,3
		lot				=	rs("lot")
		lotSKT			=	rs("lotSKT")
		refHareketID	=	rs("stokHareketID")
		surecSonuDepoID	=	rs("surecSonuDepoID")
		stokID			=	rs("stokID")
	rs.close

			sorgu = "SELECT * FROM stok.stokHareket"
			rs.open sorgu,sbsv5,1,3
			rs.addnew
				rs("kid")				=	kid
				rs("firmaID")			=	firmaID
				rs("stokKodu")			=	stokKodu
				rs("stokID")			=	uretilenStokID
				rs("miktar")			=	uretilenMiktar
				rs("miktarBirim")		=	"birimBUL"
				rs("girisTarih")		=	now()
				rs("stokHareketTuru")	=	"G"
				rs("fisNo")			=	""
				rs("aciklama")			=	"Üretim"
				rs("belgeNo")			=	null
				rs("depoID")			=	surecSonuDepoID
				' rs("belgeTarih")		=	null
				rs("cevrim")			=	0
				' rs("cariID")			=	cariID
				rs("siparisKalemID")	=	siparisKalemID
				rs("lot")				=	lot
				rs("stokHareketTipi")	=	"T"
				rs("refHareketID")		=	refHareketID
				rs("lotSKT")			=	lotSKT
				rs("ajandaID")			=	ajandaID
			rs.update
				yeniGirisID	=	rs("stokHareketID")
			rs.close

			sorgu = "SELECT stokHareketID, stokKodu, stokID, lot, miktar, miktarBirim, lotSKT, depoID, siparisKalemID, stokHareketTipi, ajandaID"
			sorgu = sorgu & " FROM stok.stokHareket WHERE siparisKalemID = " & siparisKalemID & " AND ajandaID = " & ajandaID & ""
			sorgu = sorgu & " AND stokHareketTuru = 'G' AND silindi = 0 AND stokHareketID <> " & yeniGirisID & " ORDER BY stokHareketID DESC"	
			rs.open sorgu,sbsv5,1,3


				for fi = 1 to rs.recordcount
				stokHareketID 	=	rs("stokHareketID")
				stokKodu		=	rs("stokKodu")
				miktar			=	rs("miktar")
				miktarBirim		=	rs("miktarBirim")
				depoID			=	rs("depoID")
				stokID			=	rs("stokID")
				siparisKalemID	=	rs("siparisKalemID")
				lot				=	rs("lot")
				stokHareketTipi	=	rs("stokHareketTipi")
				lotSKT			=	rs("lotSKT")
				ajandaID		=	rs("ajandaID")
				
					sorgu = "INSERT INTO stok.stokHareket"
					sorgu = sorgu & " (kid, firmaID, stokKodu, miktar, miktarBirim, girisTarih, stokHareketTuru, depoID, aciklama, stokID, siparisKalemID, lot, stokHareketTipi, prodHareketID, lotSKT, ajandaID)"
					sorgu = sorgu & " VALUES("
					sorgu = sorgu & kid & "," & firmaID & ",'" & stokKodu & "'," & miktar & ",'" & miktarBirim & "', getdate(), 'C'," & depoID & ", 'Üretim'," & stokID & "," & siparisKalemID & ",'" & lot & "','" & stokHareketTipi& "'," & yeniGirisID & ",'" & tarihsql(lotSKT) & "'," & ajandaID
					sorgu = sorgu & ")"
					rs1.open sorgu,sbsv5,3,3
				rs.movenext
				next
			rs.close

			sorgu = "UPDATE portal.ajanda SET bitisZaman = getdate(), tamamlandi = 1  WHERE id = " & ajandaID & " AND silindi = 0"
			rs.open sorgu,sbsv5,3,3

			'####### üretimdeki ana ürünün üretimi bitti ise tüm yan işlermleri bitti olarak işaretle
				if isTur = "uretimPlan" then
					sorgu = "UPDATE portal.ajanda SET tamamlandi = 1  WHERE bagliAjandaID = " & ajandaID & ""
					rs.open sorgu,sbsv5,3,3
				end if
			'####### üretimdeki ana ürünün üretimi bitti ise tüm yan işlermleri bitti olarak işaretle

			sorgu = "SELECT icerik FROM protal.ajanda WHERE id = " & ajandaID
			rs.open sorgu,sbsv5,1,3
				call logla("Üretim bitti: " & rs("icerik"))
			rs.close

		end if
	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

