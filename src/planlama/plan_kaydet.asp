<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()


	
	'##### request 
	'##### request
		kid					=	kidbul()
		hangiYil			=	Request.Form("hangiYil")
		hangiAy				=	Request.Form("hangiAy")
		hangiGun			=	Request.Form("hangiGun")
		siparisKalemID		=	Request.Form("siparisKalemID")
		yer					=	Request.Form("yer")
		silAjandaID			=	Request.Form("silAjandaID")
		isTur				=	Request.Form("isTur")
		fasonAnaID			=	Request.Form("fasonAnaID")
		planTarih			=	DateSerial(hangiYil, hangiAy, hangiGun)
		receteID			=	Request("receteID")
	'##### request
	'##### request

    modulAd 		=   "Planlama"


	'##### YETKİ BUL
	'##### YETKİ BUL
		yetkiKontrol	 = yetkibul(modulAd)
	'##### YETKİ BUL
	'##### YETKİ BUL


	If planTarih < date() Then
		call jsrun("swal('Geçmiş tarihe plan girilemez.','')")
	else
		if yetkiKontrol > 5 then
			sorgu = "SELECT t3.cariAd, t4.stokKodu, t4.stokAd, t1.miktar, t1.mikBirim, t1.stokID, t2.cariID"
			sorgu = sorgu & " FROM teklif.siparisKalem t1"
			sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
			sorgu = sorgu & " INNER JOIN cari.cari t3 ON t3.cariID = t2.cariID"
			sorgu = sorgu & " INNER JOIN stok.stok t4 ON t1.stokID = t4.stokID"
			sorgu = sorgu & " WHERE t1.id = " & siparisKalemID
			rs.open sorgu, sbsv5,1,3
				cariID			=	rs("cariID")
				cariAd			=	rs("cariAd")
				stokID 			= 	rs("stokID")
				stokKodu		=	rs("stokKodu")
				stokAd			=	rs("stokAd")
				sipMiktar		=	rs("miktar")
				sipMikBirim		=	rs("mikBirim")

				if fasonAnaID <> "" then
					sorgu = ""
					sorgu = sorgu & " SELECT t2.cariAd as fasonCariAd, t1.miktar as fasonMiktar, t1.fasonCariID, t2.fasonDepoID, t3.depoAd as fasonDepoAd"
					sorgu = sorgu & " FROM fason.fasonAna t1"
					sorgu = sorgu & " INNER JOIN cari.cari t2 ON t1.fasonCariID = t2.cariID"
					sorgu = sorgu & " INNER JOIN stok.depo t3 ON t2.fasonDepoID = t3.id"
					sorgu = sorgu & " WHERE t1.id = " & fasonAnaID & " AND t1.silindi = 0"
					rs1.open sorgu, sbsv5,1,3
						fasonCariAd		=	rs1("fasonCariAd")
						fasonCariID		=	rs1("fasonCariID")
						fasonDepoID		=	rs1("fasonDepoID")
						fasonMiktar		=	rs1("fasonMiktar")
						fasonDepoAd		=	rs1("fasonDepoAd")
						ajandaMiktar	=	rs1("fasonMiktar")
						inpicerik		=	"FASON FİRMA:" & fasonCariAd & "tarafından fason olarak üretilecek <b>Ürün</b>: " & stokAd & " | <b>Miktar</b>: " & fasonMiktar & " " & sipMikBirim & " | <b>Sipariş Cari</b>: " & cariAd
					rs1.close
				else
					inpicerik		=	"<b>Ürün</b>: " & stokAd & " | <b>Miktar</b>: " & sipMiktar & " " & sipMikBirim & " | <b>Cari</b>: " & cariAd
					ajandaMiktar	=	sipMiktar
				end if
			rs.close



			'###### plan tarihi değişiyorsa eski tarihe ait kayıt silindi=1
				if silAjandaID <> "" then
					sorgu = "UPDATE portal.ajanda SET silindi = 1 WHERE id = " & silAjandaID
					rs.open sorgu, sbsv5,1,3
					sorgu = "UPDATE portal.ajanda SET silindi = 1 WHERE bagliAjandaID = " & silAjandaID
					rs.open sorgu, sbsv5,1,3
				call logla("ajanda plan kaydı değiştirildi ID:" & silAjandaID)
				end if
			'###### plan tarihi değişiyorsa eski tarihe ait kayıt silindi=1

			sorgu = "SELECT * FROM portal.ajanda"
			rs.open sorgu, sbsv5,1,3
			
			rs.addnew
				rs("firmaID")			=	firmaID
				rs("kid")				=	kid
				rs("hangiGun")			=	hangiGun
				rs("hangiAy")			=	hangiAy
				rs("hangiYil")			=	hangiYil
				planTarih				=	DateSerial(hangiYil,hangiAy,hangiGun)
				rs("icerik")			=	inpicerik
				rs("siparisKalemID")	=	siparisKalemID
				rs("isTur")				=	isTur
				rs("stokID")			=	stokID
				rs("fasonAnaID")		=	fasonAnaID
				rs("miktar")			=	ajandaMiktar
			rs.update
				ajandaID	=	rs("id")
			rs.close


			'################ sipariş kaleminin reçetesini bul EĞER FASON DEĞİL İSE yarı mamullerin depo transferini ajandaya kaydet 
				'if siparisKalemID <> "" AND isTur <> "fason" then
				if siparisKalemID <> "" then


				if isTur = "fason" then
				'#### eğer fason üretilecekse temin depo mal kabul olarak kayıt edilmesi için
					sorgu = "UPDATE portal.ajanda SET depoKategori = 'fason' WHERE id = " & ajandaID
					rs1.open sorgu, sbsv5,3,3
				'#### /eğer fason üretilecekse temin depo mal kabul olarak kayıt edilmesi için
				else
				'####### üretilecek mamulun, reçeteye göre temin deposunu kayıt et
					sorgu = "UPDATE portal.ajanda SET depoKategori = stok.FN_depoKategoriBul(" & receteID & ") WHERE id = " & ajandaID
					rs1.open sorgu, sbsv5,3,3
				'####### /üretilecek mamulun, reçeteye göre temin deposunu kayıt et
				end if


					sorgu = "SELECT "
					sorgu = sorgu & " t1.onHazirlikDeger, t1.onHazirlikTur, t1.stokID as receteStokID, t1.miktar as receteMiktar, t1.miktarBirim as receteBirim,"
					sorgu = sorgu & " t2.stokAd as receteStokAd, t2.stokKodu as receteStokKodu, t1.receteAdimID, t1.altReceteID"
					sorgu = sorgu & " FROM recete.receteAdim t1"
					sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
					sorgu = sorgu & " WHERE t1.receteID = " & receteID & " AND t1.stokID is not null AND t1.silindi = 0"
					rs.open sorgu, sbsv5,1,3

					if rs.recordcount > 0 then
						for ti = 1 to rs.recordcount
							altReceteID			=	rs("altReceteID")
							receteStokKodu		=	rs("receteStokKodu")
							receteStokAd		=	rs("receteStokAd")
							receteMiktar		=	rs("receteMiktar")
							receteBirim			=	rs("receteBirim")
							topReceteMiktar		=	sipMiktar * receteMiktar
							fasonReceteMiktar	=	fasonMiktar * receteMiktar
							receteAdimID		=	rs("receteAdimID")
							receteStokID		=	rs("receteStokID")
							onHazirlikTur		=	rs("onHazirlikTur")
							onHazirlikDeger		=	rs("onHazirlikDeger") * -1

				if isTur = "fason" then
					ymTransferIcerikYaz	=	"<span class=""text-danger bold"">FASON !!!!</span> " & fasonReceteMiktar & " " & receteBirim & " " & receteStokKodu & " " & receteStokAd & " ürünü " & fasonDepoAd & " gönder.<br>(" & planTarih & " planlanmış " & stokKodu & " - " & stokAd & " üretimi için.)"  
					kayitMiktar			=	fasonReceteMiktar
				else
					ymTransferIcerikYaz	=	topReceteMiktar & " " & receteBirim & " " & receteStokKodu & " " & receteStokAd & " ürünü üretim depoya gönder.<br>(" & planTarih & " planlanmış " & stokKodu & " - " & stokAd & " üretimi için.)"  
					kayitMiktar			=	topReceteMiktar
				end if

				'####### receteAdımına ait yarı mamullerin üretim depoya transferinin ajanda kaydı yapılsın
							kayitTarih		=	tarihHesapla(planTarih, onHazirlikTur, onHazirlikDeger)

							hangiYil		=	datepart("yyyy",kayitTarih)
							hangiAy			=	datepart("m",kayitTarih)
							hangiGun		=	datepart("d",kayitTarih)

							sorgu = "SELECT * FROM portal.ajanda"
							rs2.open sorgu, sbsv5,1,3
								rs2.addnew
									rs2("kid")				=	kid
									rs2("firmaID")			=	firmaID
									rs2("hangiGun")			=	hangiGun
									rs2("hangiAy")			=	hangiAy
									rs2("hangiYil")			=	hangiYil
									rs2("icerik")			=	ymTransferIcerikYaz
									rs2("stokID")			=	receteStokID
									rs2("receteAdimID")		=	receteAdimID
									rs2("bagliAjandaID")	=	ajandaID
									rs2("isTur")			=	"transfer"
									rs2("miktar")			=	kayitMiktar
								rs2.update
							rs2.close
				'####### /receteAdımına ait yarı mamullerin üretim depoya transferinin ajanda kaydı yapılsın
							
					sorgu = "SELECT t1.stokID as altReceteStokID, t2.stokAd as altReceteStokAd, stok.FN_depoKategoriBul(t1.receteID) as depoKategori,"
					sorgu = sorgu & " t1.onHazirlikDeger as altReceteOHD, t1.onHazirlikTur altReceteOHT, t2.stokKodu as altReceteStokKodu, t1.receteAdimID as altAdimID,"
					sorgu = sorgu & " t4.planAd"
					sorgu = sorgu & " FROM recete.receteAdim t1"
					sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
					sorgu = sorgu & " INNER JOIN recete.recete t3 ON t1.receteID = t3.receteID"
					sorgu = sorgu & " INNER JOIN isletme.istasyon t4 ON t3.istasyonID = t4.istasyonID"
					sorgu = sorgu & " WHERE t1.receteID = " & altReceteID & " AND t1.stokID is not null "
					rs1.open sorgu, sbsv5,1,3
					
					if rs1.recordcount > 0 then
						depoKategori		=	rs1("depoKategori")
						altAdimID			=	rs1("altAdimID")
						altReceteStokID		=	rs1("altReceteStokID")
						altReceteStokAd		=	rs1("altReceteStokAd")
						altReceteStokKodu	=	rs1("altReceteStokKodu")
						altReceteOHD		=	rs1("altReceteOHD") * -1
						altReceteOHDhes		=	onHazirlikDeger + altReceteOHD
						altReceteOHT		=	rs1("altReceteOHT")
						planAd				=	rs1("planAd")

					'####### receteAdımına ait alt recete var ise yarı mamul üretimi vb. işlemin ajanda kaydı yapılsın
							altRecKayitTar	=	tarihHesapla(planTarih, altReceteOHT, altReceteOHDhes)
							
							hangiYil		=	datepart("yyyy",altRecKayitTar)
							hangiAy			=	datepart("m",altRecKayitTar)
							hangiGun		=	datepart("d",altRecKayitTar)

							sorgu = "SELECT * FROM portal.ajanda"
							rs2.open sorgu, sbsv5,1,3
								rs2.addnew
									rs2("kid")					=	kid
									rs2("firmaID")				=	firmaID
									rs2("hangiGun")				=	hangiGun
									rs2("hangiAy")				=	hangiAy
									rs2("hangiYil")				=	hangiYil
									if isTur = "fason" then
										fasonIcerikYaz	=	"<span class=""text-danger bold"">FASON !!!!</span> "
									else
										fasonIcerikYaz	=	""
									end if
									rs2("icerik")				=	fasonIcerikYaz & altReceteStokKodu & " " & altReceteStokAd & " kullanarak " & kayitMiktar & " " & receteBirim & " " & receteStokKodu & " - " & receteStokAd &" Yarı mamul üret.<br>(" & planTarih & " planlanmış " & stokKodu & " - " & stokAd & " üretimi için.)"  
									'rs2("stokID")				=	altReceteStokID
									rs2("stokID")				=	receteStokID
									'rs2("receteAdimID")		=	altAdimID
									rs2("receteAdimID")			=	receteAdimID
									rs2("bagliAjandaID")		=	ajandaID
									rs2("isTur")				=	planAd
									rs2("depoKategori")			=	depoKategori
									rs2("miktar")				=	kayitMiktar
								rs2.update
							rs2.close
				'####### /receteAdımına ait alt recete var ise yarı mamul üretimi vb. işlemin ajanda kaydı yapılsın

					end if
					rs1.close	
					rs.movenext
					next
				end if
				rs.close

			end if
			'################ /sipariş kaleminin reçetesini bul EĞER FASON DEĞİL İSE yarı mamullerin depo transferini ajandaya kaydet 

			'########### seçilen reçeteID değerini AJANDA mamul satırına kaydet
					sorgu = "UPDATE portal.ajanda SET receteID = " & receteID & " WHERE id = " & ajandaID
					rs1.open sorgu, sbsv5,3,3
			'########### /seçilen reçeteID değerini AJANDA mamul satırına kaydet


				call logla("Ajandaya etkinlik kaydı yapıldı")

				call toastrCagir("Kayıt başarılı", "OK", "right", "success", "otomatik", "")
				
				call jsrun("$('#ajandaAnaDIV').load('/ajanda/ajanda.asp?yer=" & yer & "&isTur=" & istur & "&ayHareket=0&sorgulananTarih=" & planTarih & "&fasonAnaID=" & fasonAnaID & " #ajandaAnaDIV > *')")
				if yer = "modal" then
					call jsrun("$('#ortaalan').load('/satis/siparis_liste.asp')")
				end if
		else
			call yetkisizGiris("","","")
			call jsrun("swal('Yetkisiz İşlem','')")
		end if

	end if



					function tarihHesapla(planTarih, onHazirlikTur, onHazirlikDeger)
							if onHazirlikTur = "Saat" then
								kayitTarihF = planTarih
							elseif onHazirlikTur = "Gün" then
								kayitTarihF = dateadd("d",onHazirlikDeger,planTarih)
							end if
						'####### kayıt tarihi bugünden önceye gitmesin	
							if kayitTarihF < date() then
								kayitTarihF = date()
							end if
						'####### /kayıt tarihi bugünden önceye gitmesin

						'#### resmi tatil kontrol
							bazTarih	=	kayitTarihF
							for zi = 0 to -31 step -1
								kayitTarihF	=	DateAdd("d",zi,bazTarih)
								gunAd		=	WeekdayName(weekday(kayitTarihF))
								
								sorgu = "SELECT aciklama, tatilGunu FROM portal.isGunu WHERE tatilGunu = '" & tarihsql2(kayitTarihF) & "'"
								fn1.open sorgu,sbsv5,1,3
									kayitSayi	=	fn1.recordcount
								fn1.close
									if kayitSayi > 0 OR gunAd = "Pazar" then
										resmiTatil 	=	"evet"
									else
										resmiTatil	=	"hayir"
										exit for
									end if
							next
							tarihHesapla = kayitTarihF
						'#### /resmi tatil kontrol
					end function















	


%>



