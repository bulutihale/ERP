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
			sorgu = "SELECT t3.cariAd, t4.stokAd, t1.miktar, t1.mikBirim"
			sorgu = sorgu & " FROM teklif.siparisKalem t1"
			sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
			sorgu = sorgu & " INNER JOIN cari.cari t3 ON t3.cariID = t2.cariID"
			sorgu = sorgu & " INNER JOIN stok.stok t4 ON t1.stokID = t4.stokID"
			sorgu = sorgu & " WHERE t1.id = " & siparisKalemID
			rs.open sorgu, sbsv5,1,3
				cariAd		=	rs("cariAd")
				stokAd		=	rs("stokAd")
				miktar		=	rs("miktar")
				mikBirim	=	rs("mikBirim")
				inpicerik	=	"<b>Ürün</b>: " & stokAd & " | <b>Miktar</b>: " & miktar & " " & mikBirim & " | <b>Cari</b>: " & cariAd
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
				'###### siparişteki stok ve cari vilgilerini al
					sorgu = "SELECT t1.stokID, t2.cariID, t1.miktar, t1.mikBirim"
					sorgu = sorgu & " FROM teklif.siparisKalem t1"
					sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
					sorgu = sorgu & " WHERE t1.id = " & siparisKalemID
					rs.open sorgu, sbsv5,1,3
						sipMiktar	=	rs("miktar")
						sipMikBirim	=	rs("mikBirim")
						stokID 		= 	rs("stokID")
						cariID		=	rs("cariID")
					rs.close
				'###### siparişteki stok ve cari vilgilerini al

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
				'### cari için  özel reçete var mı? yoksa normal reçeteyi al

					sorgu = "SELECT t1.onHazirlikDeger, t1.onHazirlikTur, t1.stokID as receteStokID, t2.stokKodu as receteStokKodu, t1.receteAdimID"
					sorgu = sorgu & " FROM recete.receteAdim t1"
					sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
					sorgu = sorgu & " WHERE t1.receteID = " & receteID & " AND t1.stokID is not null "
					rs.open sorgu, sbsv5,1,3

					if rs.recordcount > 0 then
						for ti = 1 to rs.recordcount
							receteStokKodu	=	rs("receteStokKodu")
							receteAdimID	=	rs("receteAdimID")
							receteStokID	=	rs("receteStokID")
							onHazirlikTur	=	rs("onHazirlikTur")
							onHazirlikDeger	=	rs("onHazirlikDeger") * -1

							if onHazirlikTur = "Saat" then
								kayitTarih = planTarih
							elseif onHazirlikTur = "Gün" then
								kayitTarih = dateadd("d",onHazirlikDeger,planTarih)
							end if
						'####### kayıt tarihi bugünden önceye gitmesin	
							if kayitTarih < date() then
								kayitTarih = date()
							end if
						'####### /kayıt tarihi bugünden önceye gitmesin

						'#### resmi tatil kontrol
							bazTarih	=	kayitTarih
							for zi = 0 to -31 step -1
								kayitTarih	=	DateAdd("d",zi,bazTarih)
								gunAd		=	WeekdayName(weekday(kayitTarih))
								
								sorgu = "SELECT aciklama, tatilGunu FROM portal.isGunu WHERE tatilGunu = '" & tarihsql2(kayitTarih) & "'"
								rs1.open sorgu,sbsv5,1,3
									kayitSayi	=	rs1.recordcount
								rs1.close
									if kayitSayi > 0 OR gunAd = "Pazar" then
										resmiTatil 	=	"evet"
									else
										resmiTatil	=	"hayir"
										exit for
									end if
							next
						'#### /resmi tatil kontrol


							hangiYil		=	datepart("yyyy",kayitTarih)
							hangiAy			=	datepart("m",kayitTarih)
							hangiGun		=	datepart("d",kayitTarih)

							sorgu = "SELECT * FROM portal.ajanda"
							rs1.open sorgu, sbsv5,1,3
								rs1.addnew
									rs1("kid")				=	kid
									rs1("firmaID")			=	firmaID
									rs1("hangiGun")			=	hangiGun
									rs1("hangiAy")			=	hangiAy
									rs1("hangiYil")			=	hangiYil
									rs1("icerik")			=	receteStokID & " stokID üretim depoya gönder."
									rs1("stokID")			=	receteStokID
									rs1("receteAdimID")		=	receteAdimID
									rs1("bagliAjandaID")	=	ajandaID
									rs1("isTur")			=	"transfer"
								rs1.update
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



















	


%>



