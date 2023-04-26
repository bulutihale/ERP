<!--#include virtual="/reg/rs.asp" --><%

bu dosya teklif2 klasörünün altına gitsin


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")

    bankaID 			=   Request.Form("bankaID")
	if bankaID = "" then
		bankaID = 0
	end if

			firmaID				=  	Request.Form("firmaID")
			firmaAd				=  	Request.Form("firmaAd")
			adres				=	Request.Form("adres")
			telefon				=	Request.Form("telefon")
			faksNo				=	Request.Form("faksNo")
			vergiNo				=	Request.Form("vergiNo")
			vergiDairesi		=	Request.Form("vergiDairesi")
			sehir				=	Request.Form("sehir")
			ilce				=	Request.Form("ilce")
			webSite				=	Request.Form("webSite")
			iletisimEposta		=	Request.Form("iletisimEposta")



	modulAd 		=   "Teklif"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


yetkiKontrol = yetkibul(modulAd) 

	call rqKontrol(firmaAd,"Lütfen Firma adını yazınız","")
	call rqKontrol(adres,"Lütfen firma için adres yazınız","")
	call rqKontrol(telefon,"Lütfen telefon numarası yazınız.","")
	call rqKontrol(vergiNo,"Lütfen vergi numarası bilgisini yazınız.","")
	call rqKontrol(vergiDairesi,"Lütfen vergi dairesi bilgisini yazınız.","")
	call rqKontrol(sehir,"Lütfen şehir yazınız.","")
	call rqKontrol(ilce,"Lütfen ilçe yazınız.","")
	call rqKontrol(iletisimEposta,"Lütfen e-posta  yazınız.","")



if yetkiKontrol > 2 then


            sorgu = "SELECT top 1 * FROM portal.firma WHERE id = " & firmaID
			rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount = 0 then
                rs.addnew
				call logla("Yeni Firma Ekleniyor: " & firmaAd & "")
			else
				call logla("Firma Bilgileri Güncelleniyor: " & firmaAd & "")
            end if
			'#####tanımlandıktan sonra depo kodu ve depo adı değişmesin
				rs("Ad")				=	firmaAd
				rs("adres")				=	adres
                rs("telefon")			=	telefon
                rs("faksNo")			=	faksNo
                rs("vergiNo")			=	vergiNo
				rs("vergiDairesi")		=	vergiDairesi
				rs("sehir")				=	sehir
				rs("ilce")				=	ilce
                rs("webSite")			=	webSite
                rs("iletisimEposta")	=	iletisimEposta
            rs.update
            rs.close

end if

call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")

call jsac("/firma/firma_liste.asp")
modalkapat()





%><!--#include virtual="/reg/rs.asp" -->