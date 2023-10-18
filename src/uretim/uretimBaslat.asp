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
	surecDepoID				=	Request.Form("surecDepoID")
	uretilenUrunGirisDepoID	=	Request.Form("uretilenUrunGirisDepoID")
	techizatID				=	Request.Form("techizatID")
	secilenReceteID			=	Request.Form("secilenReceteID")
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

			'If istur = "uretimPlan" Then
				turetilmisLot			=	lotOlusturFunc(teminDepoID)
				sorgu = "UPDATE portal.ajanda SET uretimLot = '" & turetilmisLot & "', receteID = " & secilenReceteID & ", teminDepoID = " & teminDepoID & ", surecDepoID = " & surecDepoID & ", techizatID = " & techizatID & " WHERE id = " & ajandaID & " AND silindi = 0"
				rs.open sorgu,sbsv5,3,3
			'Else
				' false
			'End if


	elseif islemDurum = "islemBitir" then

'########## stokHareket tablosundaki üretim veya kesim sürecindeki malzemeleri stoktan düş, üretilen yarı mamul veya mamulun stok girişini yap

	'##### üretilen ürüne ait bilgileri al
			sorgu = "SELECT t1.stokID, t1.isTur, t2.stokKodu, stok.FN_anaBirimIDBul(t2.stokID) as anaBirimID, stok.FN_anaBirimADBul(t2.stokID, 'kad') as anaBirimAD, t1.uretimLot,"
			sorgu = sorgu & " stok.FN_lotSktBul("&firmaID&",t1.stokID,t1.uretimLot) as mevcutSKT, t2.rafOmru"
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
				rafOmru				=	rs("rafOmru")
				mevcutSKT			=	rs("mevcutSKT")
				if isnull(mevcutSKT) then
					lotSKT			=	dateAdd("m",rafOmru,date())
				else
					lotSKT			=	mevcutSKT
				end if
			rs.close
	'##### /üretilen ürüne ait bilgileri al

			sorgu = "SELECT ISNULL(stok.FN_uretilmisMiktarBul("&ajandaID&", " & uretilenStokID & ", "&firmaID&"),0) as uretilmisMiktar,"
			sorgu = sorgu & " CASE"
			 	sorgu = sorgu & " WHEN ISNULL(stok.FN_uretilmisMiktarBul("&ajandaID&", " & uretilenStokID & ", "&firmaID&"),0) + " & uretilenMiktar & ""
				sorgu = sorgu & " = (stok.FN_siparisMiktarBul("&ajandaID&", "&firmaID&") * ISNULL(stok.FN_receteMiktarBul ( "&ajandaID&" ),1)) THEN 'tamam'"
				sorgu = sorgu & " WHEN"
				sorgu = sorgu & " ISNULL(stok.FN_uretilmisMiktarBul("&ajandaID&", " & uretilenStokID & ", "&firmaID&"),0) + " & uretilenMiktar & ""
				sorgu = sorgu & " > (stok.FN_siparisMiktarBul("&ajandaID&", "&firmaID&") * ISNULL(stok.FN_receteMiktarBul ( "&ajandaID&" ),1))"
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
				rs("lotSKT")			=	tarihsql(lotSKT)
				rs("ajandaID")			=	ajandaID
				rs("miktarBirim")		=	anaBirimAD
				rs("miktarBirimID")		=	anaBirimID
			rs.update
				yeniGirisID	=	rs("stokHareketID")
			rs.close


'$$$$$$$$$$$$ AŞAĞIDAKİ SORGU KESİM SÜRECİ BİTTİĞİNDE süreçteki ürünü çıkarmıyordu
			' sorgu = "SELECT t1.stokHareketID, t1.stokKodu, t1.stokID, t1.lot, t1.miktar as stokHareketMiktar, t1.miktarBirim, t1.miktarBirimID, t1.lotSKT,"
			' sorgu = sorgu & " t1.depoID, t1.siparisKalemID, t1.stokHareketTipi, t1.ajandaID, t3.miktar as receteAdimMiktar"
			' sorgu = sorgu & " FROM stok.stokHareket t1"
			' sorgu = sorgu & " LEFT JOIN portal.ajanda t2 ON t1.ajandaID = t2.bagliAjandaID AND t1.stokID = t2.stokID AND t2.silindi = 0"
			' sorgu = sorgu & " INNER JOIN recete.receteAdim t3 ON t2.receteAdimID = t3.receteAdimID"
			' sorgu = sorgu & " WHERE t1.siparisKalemID = " & siparisKalemID & " AND t1.ajandaID = " & ajandaID & ""
			' sorgu = sorgu & " AND t1.stokHareketTuru = 'G' AND t1.silindi = 0 AND t1.stokHareketID <> " & yeniGirisID & " ORDER BY t1.stokHareketID DESC"	
'$$$$$$$$$$$$ AŞAĞIDAKİ SORGU KESİM SÜRECİ BİTTİĞİNDE süreçteki ürünü çıkarmıyordu

			sorgu = "SELECT DISTINCT t1.stokKodu, t1.stokID, t1.miktarBirim, t1.miktarBirimID,"
			sorgu = sorgu & " t1.depoID, t1.siparisKalemID, t1.stokHareketTipi, t1.ajandaID, t3.miktar as receteAdimMiktar, t1.ajandaID"
			sorgu = sorgu & " FROM stok.stokHareket t1"
			sorgu = sorgu & " INNER JOIN recete.receteAdim t3 ON t1.receteAdimID = t3.receteAdimID"
			sorgu = sorgu & " WHERE t1.siparisKalemID = " & siparisKalemID & ""
			sorgu = sorgu & " AND t1.ajandaID = " & ajandaID & ""
			sorgu = sorgu & " AND t1.stokHareketTuru = 'G'"
			sorgu = sorgu & " AND t1.silindi = 0"
			sorgu = sorgu & " AND t1.stokHareketID <> " & yeniGirisID & ""
			rs.open sorgu,sbsv5,1,3


				do until rs.EOF
					ajandaID				=	rs("ajandaID")
					'stokHareketID 			=	rs("stokHareketID")
					stokKodu				=	rs("stokKodu")
					'miktar					=	rs("stokHareketMiktar")
					miktarBirim				=	rs("miktarBirim")
					miktarBirimID			=	rs("miktarBirimID")
					depoID					=	rs("depoID")
					stokID					=	rs("stokID")
					siparisKalemID			=	rs("siparisKalemID")
					stokHareketTipi			=	rs("stokHareketTipi")
					receteAdimMiktar		=	rs("receteAdimMiktar")
					yariMamulCikisMiktar	=	receteAdimMiktar * uretilenMiktar
					miktarBakiye			=	yariMamulCikisMiktar



					sorgu = " SELECT t1.lot, t1.lotSKT, [stok].[FN_uretimdekiMiktarLOT] (t1.ajandaID, t1.stokID, t1.firmaID, t1.lot) as uretimdekiLOTmiktar"
					sorgu = sorgu & "  FROM stok.stokHareket t1 WHERE t1.stokID = " & stokID & " AND t1.ajandaID = " & ajandaID & " AND silindi = 0 AND stokHareketTuru = 'G'"
					sorgu = sorgu & " AND [stok].[FN_uretimdekiMiktarLOT] (t1.ajandaID, t1.stokID, t1.firmaID, t1.lot) > 0"
					rs1.open sorgu,sbsv5,1,3

					for gi = 1 to rs1.recordcount
						lot						=	rs1("lot")
						lotSKT					=	rs1("lotSKT")
						uretimdekiLOTmiktar		=	rs1("uretimdekiLOTmiktar")


						if cdbl(uretimdekiLOTmiktar) < cdbl(yariMamulCikisMiktar) then
							dbKayitMiktar			=	uretimdekiLOTmiktar
							yariMamulCikisMiktar	=	cdbl(yariMamulCikisMiktar) - cdbl(uretimdekiLOTmiktar)
						else
							dbKayitMiktar			=	yariMamulCikisMiktar
							yariMamulCikisMiktar	=	cdbl(uretimdekiLOTmiktar) - cdbl(yariMamulCikisMiktar)
						end if
						miktarBakiye	=	cdbl(miktarBakiye) - cdbl(dbKayitMiktar)
				Response.Write gi&"////"&lot&" // "&yariMamulCikisMiktar & " //// "&uretimdekiLOTmiktar&" /// "&dbKayitMiktar&"///"&miktarBakiye&"<br>"
						

						sorgu = "SELECT * FROM stok.stokHareket"
						rs2.open sorgu,sbsv5,1,3
							rs2.addnew
							rs2("kid")				=	kid
							rs2("firmaID")			=	firmaID
							rs2("stokKodu")			=	stokKodu
							rs2("miktar")			=	dbKayitMiktar
							'rs2("miktar")			=	miktar
							rs2("miktarBirim")		=	miktarBirim
							rs2("miktarBirimID")	=	miktarBirimID
							rs2("girisTarih")		=	now()
							rs2("stokHareketTuru")	=	"C"
							rs2("depoID")			=	depoID
							rs2("aciklama")			=	"Üretim"
							rs2("stokID")			=	stokID
							rs2("siparisKalemID")	=	siparisKalemID
							rs2("lot")				=	lot
							rs2("stokHareketTipi")	=	stokHareketTipi
							rs2("prodHareketID")	=	yeniGirisID
							rs2("lotSKT")			=	tarihsql(lotSKT)
							rs2("ajandaID")			=	ajandaID
							rs2.update
							rs2.close
							if miktarBakiye <= 0 then
								exit for
							end if
					rs1.movenext
					next
					rs1.close

				rs.movenext
				loop
			rs.close

			if miktarTamamKontrol = "tamam" then
				sorgu = "UPDATE portal.ajanda SET bitisZaman = getdate(), tamamlandi = 1  WHERE id = " & ajandaID & " AND silindi = 0"
				rs.open sorgu,sbsv5,3,3

				'####### üretimdeki ana ürünün üretimi bitti ise tüm yan işlemleri bitti olarak işaretle
					if isTur = "uretimPlan" then
						sorgu = "UPDATE portal.ajanda SET tamamlandi = 1  WHERE bagliAjandaID = " & ajandaID & ""
						rs.open sorgu,sbsv5,3,3
					end if
				'####### üretimdeki ana ürünün üretimi bitti ise tüm yan işlemleri bitti olarak işaretle

			end if

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

