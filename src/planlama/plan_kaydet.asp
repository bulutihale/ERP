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
	planTarih			=	DateSerial(hangiYil, hangiAy, hangiGun)
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
				cariID		=	rs("cariID")
				cariAd		=	rs("cariAd")
				stokID 		= 	rs("stokID")
				stokKodu	=	rs("stokKodu")
				stokAd		=	rs("stokAd")
				sipMiktar	=	rs("miktar")
				sipMikBirim	=	rs("mikBirim")
				inpicerik	=	"<b>Ürün</b>: " & stokAd & " | <b>Miktar</b>: " & sipMiktar & " " & sipMikBirim & " | <b>Cari</b>: " & cariAd
			rs.close


		'##### DOSYA KAYDET
		'##### DOSYA KAYDET

			'## veritabanı

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
			rs.update
				ajandaID	=	rs("id")
			rs.close


			'################ sipariş kaleminin reçetesini bul yarı mamullerin depo transferini ajandaya kaydet
				if siparisKalemID <> "" then
				
				'### cari için  özel reçete var mı? yoksa normal reçeteyi al
						ekSorgu		=	" AND t1.cariID = " & cariID
						ekSorgu2	=	" AND t1.cariID = 0"

					sorgu = "SELECT t1.receteID FROM recete.recete t1 WHERE t1.stokID = " & stokID & " AND t1.silindi = 0 AND t1.firmaID = " & firmaID
					ilkSorgu 	=	sorgu & ekSorgu
					ikinciSorgu	=	sorgu & ekSorgu2
					rs.open ilkSorgu, sbsv5,1,3
						if rs.recordcount  = 0 then
							rs.close
							rs.open ikinciSorgu, sbsv5,1,3
						end if
						if rs.recordcount > 0 then
							receteID	=	rs("receteID")
						else
							receteID = 0
							call jsrun("swal('','Ürün takvim kaydı yapıldı ancak ürüne ait reçete bulunamadı.')")
						end if
					rs.close
				'### /cari için  özel reçete var mı? yoksa normal reçeteyi al

					sorgu = "SELECT t1.onHazirlikDeger, t1.onHazirlikTur, t1.stokID as receteStokID, t1.miktar as receteMiktar, t1.miktarBirim as receteBirim,"
					sorgu = sorgu & " t2.stokAd as receteStokAd, t2.stokKodu as receteStokKodu, t1.receteAdimID,t1.altReceteID"
					sorgu = sorgu & " FROM recete.receteAdim t1"
					sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
					sorgu = sorgu & " WHERE t1.receteID = " & receteID & " AND t1.stokID is not null AND t1.silindi = 0"
					rs.open sorgu, sbsv5,1,3

					'Response.Write sorgu &"<br>"

					if rs.recordcount > 0 then
						for ti = 1 to rs.recordcount
							altReceteID		=	rs("altReceteID")
							receteStokKodu	=	rs("receteStokKodu")
							receteStokAd	=	rs("receteStokAd")
							receteMiktar	=	rs("receteMiktar")
							receteBirim		=	rs("receteBirim")
							topReceteMiktar	=	sipMiktar * receteMiktar
							receteAdimID	=	rs("receteAdimID")
							receteStokID	=	rs("receteStokID")
							onHazirlikTur	=	rs("onHazirlikTur")
							onHazirlikDeger	=	rs("onHazirlikDeger") * -1


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
									rs2("icerik")			=	topReceteMiktar & " " & receteBirim & " " & receteStokKodu & " " & receteStokAd & " ürünü üretim depoya gönder.<br>(" & planTarih & " planlanmış " & stokKodu & " - " & stokAd & " üretimi için.)"  
									rs2("stokID")			=	receteStokID
									rs2("receteAdimID")		=	receteAdimID
									rs2("bagliAjandaID")	=	ajandaID
									rs2("isTur")			=	"transfer"
								rs2.update
							rs2.close
				'####### /receteAdımına ait yarı mamullerin üretim depoya transferinin ajanda kaydı yapılsın
							



					sorgu = "SELECT t1.stokID as altReceteStokID, t2.stokAd as altReceteStokAd,"
					sorgu = sorgu & " t1.onHazirlikDeger as altReceteOHD, t1.onHazirlikTur altReceteOHT, t2.stokKodu as altReceteStokKodu, t1.receteAdimID as altAdimID"
					sorgu = sorgu & " FROM recete.receteAdim t1"
					sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
					sorgu = sorgu & " WHERE t1.receteID = " & altReceteID & " AND t1.stokID is not null "
					rs1.open sorgu, sbsv5,1,3
					'Response.Write sorgu &"<br>"
					'response.end
					
						if rs1.recordcount > 0 then
							altAdimID			=	rs1("altAdimID")
							altReceteStokID		=	rs1("altReceteStokID")
							altReceteStokAd		=	rs1("altReceteStokAd")
							altReceteStokKodu	=	rs1("altReceteStokKodu")
							altReceteOHD		=	rs1("altReceteOHD") * -1
							altReceteOHDhes		=	onHazirlikDeger + altReceteOHD
							altReceteOHT		=	rs1("altReceteOHT")

				'####### receteAdeımına ait alt recete var ise yarı mamul üretimi vb. işlemin ajanda kaydı yapılsın
							altRecKayitTar	=	tarihHesapla(planTarih, altReceteOHT, altReceteOHDhes)

							hangiYil		=	datepart("yyyy",altRecKayitTar)
							hangiAy			=	datepart("m",altRecKayitTar)
							hangiGun		=	datepart("d",altRecKayitTar)

							sorgu = "SELECT * FROM portal.ajanda"
							rs2.open sorgu, sbsv5,1,3
								rs2.addnew
									rs2("kid")				=	kid
									rs2("firmaID")			=	firmaID
									rs2("hangiGun")			=	hangiGun
									rs2("hangiAy")			=	hangiAy
									rs2("hangiYil")			=	hangiYil
									rs2("icerik")			=	altReceteStokKodu & " " & altReceteStokAd & " kullarak " & topReceteMiktar & " " & receteBirim & " " & receteStokKodu & " - " & receteStokAd &" Yarı mamul üret.<br>(" & planTarih & " planlanmış " & stokKodu & " - " & stokAd & " üretimi için.)"  
									'rs2("stokID")			=	altReceteStokID
									rs2("stokID")			=	receteStokID
									'rs2("receteAdimID")		=	altAdimID
									rs2("receteAdimID")		=	receteAdimID
									rs2("bagliAjandaID")	=	ajandaID
									rs2("isTur")			=	"kesimPlan"
								rs2.update
							rs2.close
				'####### /receteAdeımına ait alt recete var ise yarı mamul üretimi vb. işlemin ajanda kaydı yapılsın


						end if
					rs1.close	
				rs.movenext
				next
			end if
			rs.close


				end if
			'################ /sipariş kaleminin reçetesini bul yarı mamullerin depo transferini ajandaya kaydet
				call logla("Ajandaya etkinlik kaydı yapıldı")

					call toastrCagir("Kayıt başarılı", "OK", "right", "success", "otomatik", "")
					
					call jsrun("$('#ajandaAnaDIV').load('/ajanda/ajanda.asp?yer=" & yer & "&ayHareket:=0&sorgulananTarih=" & planTarih & " #ajandaAnaDIV > *')")
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



