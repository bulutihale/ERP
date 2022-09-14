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

			if silAjandaID <> "" then
				sorgu = "UPDATE portal.ajanda SET  silindi = 1 WHERE id = " & silAjandaID
				rs.open sorgu, sbsv5,1,3
			call logla("ajanda plan kaydı değiştirildi ID:" & silAjandaID)
			end if
				

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
			rs.update
			rs.close




				
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



