<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid						=	kidbul()
	siparisKalemID			=	Request.Form("siparisKalemID")
	ajandaID				=	Request.Form("ajandaID")
	islemDurum				=	Request.Form("islemDurum")
	uretilenMiktar			=	Request.Form("uretilenMiktar")
	teminDepoID				=	Request.Form("teminDepoID")
	uretilenUrunGirisDepoID	=	Request.Form("uretilenUrunGirisDepoID")
	techizatID				=	Request.Form("techizatID")
	modulAd =   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


if ajandaID = "" then
	hata = 1
end if

if techizatID = "" then
	techizatID = 0
end if

yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 6 then



	if islemDurum = "islemBasla" then


		sorgu = "SELECT icerik, isTur FROM portal.ajanda WHERE id = " & ajandaID
		rs.open sorgu,sbsv5,1,3
			call logla("Üretim başlat: " & rs("icerik"))
			isTur	=	rs("isTur")
		rs.close


			sorgu = "UPDATE stok.stokHareket SET stokHareketTipi = 'U', techizatID = " & techizatID & " WHERE siparisKalemID = " & siparisKalemID & " AND ajandaID = " & ajandaID & " AND stokHareketTuru = 'G' AND silindi = 0"
			rs.open sorgu,sbsv5,3,3

			sorgu = "UPDATE portal.ajanda SET baslangicZaman = getdate() WHERE id = " & ajandaID & " AND silindi = 0"
			rs.open sorgu,sbsv5,3,3

			If istur = "uretimPlan" Then
				turetilmisLot			=	lotOlusturFunc(teminDepoID)
				sorgu = "UPDATE portal.ajanda SET uretimLot = '" & turetilmisLot & "' WHERE id = " & ajandaID & " AND silindi = 0"
				rs.open sorgu,sbsv5,3,3
			Else
				' false
			End if


	elseif islemDurum = "islemBitir" then

'########## stokHareket tablosundaki üretim veya kesim sürecindeki malzemeleri stoktan düş, üretilen yarı mamul veya mamulun stok girişini yap

	'##### üretilen ürüne ait bilgileri al
			sorgu = "SELECT t1.stokID, t1.isTur, t2.stokKodu, stok.FN_anaBirimIDBul(t2.stokID) as anaBirimID, stok.FN_anaBirimADBul(t2.stokID, 'kad') as anaBirimAD, t1.uretimLot"
			sorgu = sorgu & " FROM portal.ajanda t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " WHERE t1.id = " & ajandaID
			rs.open sorgu,sbsv5,1,3
				uretilenStokID		=	rs("stokID")
				stokKodu			=	rs("stokKodu")
				isTur				=	rs("isTur")
				anaBirimID			=	rs("anaBirimID")
				anaBirimAD			=	rs("anaBirimAD")
				uretimLot			=	rs("uretimLot")
			rs.close
	'##### /üretilen ürüne ait bilgileri al

			sorgu = "SELECT ISNULL(stok.FN_uretilmisMiktarBul("&ajandaID&", " & uretilenStokID & ", "&firmaID&"),0) as uretilmisMiktar,"
			sorgu = sorgu & " CASE"
			 	sorgu = sorgu & " WHEN ISNULL(stok.FN_uretilmisMiktarBul("&ajandaID&", " & uretilenStokID & ", "&firmaID&"),0) + " & uretilenMiktar & ""
				sorgu = sorgu & " = (stok.FN_siparisMiktarBul("&ajandaID&", "&firmaID&") * stok.FN_receteMiktarBul ("&ajandaID&")) THEN 'tamam'"
				sorgu = sorgu & " WHEN"
				sorgu = sorgu & " ISNULL(stok.FN_uretilmisMiktarBul("&ajandaID&", " & uretilenStokID & ", "&firmaID&"),0) + " & uretilenMiktar & ""
				sorgu = sorgu & " > (stok.FN_siparisMiktarBul("&ajandaID&", "&firmaID&") * stok.FN_receteMiktarBul ("&ajandaID&"))"
			sorgu = sorgu & " THEN 'fazla' ELSE 'eksik' END as miktarTamamKontrol"
			rs.open sorgu,sbsv5,1,3
				uretilmisMiktar		=	rs("uretilmisMiktar")
				miktarTamamKontrol	=	rs("miktarTamamKontrol")
			rs.close

			if miktarTamamKontrol = "fazla" then
				mesaj = "Üretilen toplam miktar sipariş miktarını geçiyor. Daha önce üretilen:"&uretilmisMiktar&""
				call toastrCagir(mesaj, "HATA", "right", "error", "otomatik", "")
				call logla(mesaj)
				Response.End()
			end if

	'#### üretilen ürünü süreç çıkışında belirtilen (depo tablosunda) depoya giriş yap 

	sorgu = "SELECT TOP(1) t1.stokHareketID, t1.lot, t1.lotSKT,"
	sorgu = sorgu & " CASE WHEN t2.surecSonuDepoID = 0 THEN t1.depoID ELSE t2.surecSonuDepoID END as surecSonuDepoID,"
	sorgu = sorgu & " t1.stokID"
	sorgu = sorgu & " FROM stok.stokHareket t1"
	sorgu = sorgu & " INNER JOIN stok.depo t2 ON t1.depoID = t2.id"
	sorgu = sorgu & " WHERE t1.siparisKalemID = " & siparisKalemID & " AND t1.ajandaID = " & ajandaID & ""
	sorgu = sorgu & " AND t1.stokHareketTuru = 'G' AND t1.silindi = 0"
	sorgu = sorgu & " ORDER BY t1.stokHareketID DESC"		
	rs.open sorgu,sbsv5,1,3

	a = 0
	
		if rs.recordcount > 0 then
			a				=	1
			lot				=	rs("lot")
			lotSKT			=	rs("lotSKT")
			refHareketID	=	rs("stokHareketID")
			if uretilenUrunGirisDepoID = "" then
				surecSonuDepoID	=	rs("surecSonuDepoID")
			else
				surecSonuDepoID	=	uretilenUrunGirisDepoID
			end if
			stokID			=	rs("stokID")
		end if
	rs.close
		if a = 1 then
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
				rs("fisNo")				=	""
				rs("aciklama")			=	"Üretim"
				rs("belgeNo")			=	null
				rs("depoID")			=	surecSonuDepoID
				' rs("belgeTarih")		=	null
				rs("cevrim")			=	0
				' rs("cariID")			=	cariID
				rs("siparisKalemID")	=	siparisKalemID
				if uretimLot <> "" then
					lot	=	uretimLot
				end if
				rs("lot")				=	lot
				rs("stokHareketTipi")	=	"U"
				rs("refHareketID")		=	refHareketID
				rs("lotSKT")			=	lotSKT
				rs("ajandaID")			=	ajandaID
				rs("miktarBirim")		=	anaBirimAD
				rs("miktarBirimID")		=	anaBirimID
			rs.update
				yeniGirisID	=	rs("stokHareketID")
			rs.close

			sorgu = "SELECT t1.stokHareketID, t1.stokKodu, t1.stokID, t1.lot, t1.miktar as stokHareketMiktar, t1.miktarBirim, t1.miktarBirimID, t1.lotSKT,"
			sorgu = sorgu & " t1.depoID, t1.siparisKalemID, t1.stokHareketTipi, t1.ajandaID, t3.miktar as receteAdimMiktar"
			sorgu = sorgu & " FROM stok.stokHareket t1"
			sorgu = sorgu & " LEFT JOIN portal.ajanda t2 ON t1.ajandaID = t2.bagliAjandaID AND t1.stokID = t2.stokID AND t2.silindi = 0"
			sorgu = sorgu & " INNER JOIN recete.receteAdim t3 ON t2.receteAdimID = t3.receteAdimID"
			sorgu = sorgu & " WHERE t1.siparisKalemID = " & siparisKalemID & " AND t1.ajandaID = " & ajandaID & ""
			sorgu = sorgu & " AND t1.stokHareketTuru = 'G' AND t1.silindi = 0 AND t1.stokHareketID <> " & yeniGirisID & " ORDER BY t1.stokHareketID DESC"	
			rs.open sorgu,sbsv5,1,3


				for fi = 1 to rs.recordcount
					stokHareketID 			=	rs("stokHareketID")
					stokKodu				=	rs("stokKodu")
					miktar					=	rs("stokHareketMiktar")
					miktarBirim				=	rs("miktarBirim")
					miktarBirimID			=	rs("miktarBirimID")
					depoID					=	rs("depoID")
					stokID					=	rs("stokID")
					siparisKalemID			=	rs("siparisKalemID")
					lot						=	rs("lot")
					stokHareketTipi			=	rs("stokHareketTipi")
					lotSKT					=	rs("lotSKT")
					ajandaID				=	rs("ajandaID")
					receteAdimMiktar		=	rs("receteAdimMiktar")	
					yariMamulCikisMiktar	=	receteAdimMiktar * uretilenMiktar

					sorgu = "SELECT * FROM stok.stokHareket"
					rs1.open sorgu,sbsv5,1,3
						rs1.addnew
						rs1("kid")				=	kid
						rs1("firmaID")			=	firmaID
						rs1("stokKodu")			=	stokKodu
						rs1("miktar")			=	yariMamulCikisMiktar
						'rs1("miktar")			=	miktar
						rs1("miktarBirim")		=	miktarBirim
						rs1("miktarBirimID")	=	miktarBirimID
						rs1("girisTarih")		=	now()
						rs1("stokHareketTuru")	=	"C"
						rs1("depoID")			=	depoID
						rs1("aciklama")			=	"Üretim"
						rs1("stokID")			=	stokID
						rs1("siparisKalemID")	=	siparisKalemID
						rs1("lot")				=	lot
						rs1("stokHareketTipi")	=	stokHareketTipi
						rs1("prodHareketID")	=	yeniGirisID
						rs1("lotSKT")			=	tarihsql(lotSKT)
						rs1("ajandaID")			=	ajandaID
						rs1.update
						rs1.close
					rs.movenext
				next
			rs.close

			if miktarTamamKontrol = "tamam" then
				sorgu = "UPDATE portal.ajanda SET bitisZaman = getdate(), tamamlandi = 1  WHERE id = " & ajandaID & " AND silindi = 0"
				rs.open sorgu,sbsv5,3,3
			end if

			'####### üretimdeki ana ürünün üretimi bitti ise tüm yan işlemleri bitti olarak işaretle
				if isTur = "uretimPlan" then
					sorgu = "UPDATE portal.ajanda SET tamamlandi = 1  WHERE bagliAjandaID = " & ajandaID & ""
					rs.open sorgu,sbsv5,3,3
				end if
			'####### üretimdeki ana ürünün üretimi bitti ise tüm yan işlemleri bitti olarak işaretle

			sorgu = "SELECT icerik FROM portal.ajanda WHERE id = " & ajandaID
			rs.open sorgu,sbsv5,1,3
				call logla("Üretim bitti: " & rs("icerik") & "<b>Üretimi biten miktar:</b> " & uretilenMiktar & "")
			rs.close
			call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")
		end if
		end if
	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

