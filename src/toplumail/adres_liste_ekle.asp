<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    Response.Flush()
'###### ANA TANIMLAMALAR
' |Toplu Mail#Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6

'hata verirse
'maximum requesting Entity body limit 20000000


yetkiTM = yetkibul(modulAd)


Server.ScriptTimeout = 30000


adresListesi    =   Request.Form("maillistesi")
adresGrupID    =   Request.Form("adresGrupID")
altModul        =   Request.Form("altModul")
islem           =   Request.Form("islem")
tur             =   Request.Form("tur")



		if adresListesi <> "" then
            adresListesi        =   lcase(adresListesi)
			adresListesi        =	Replace(adresListesi,chr(13),chr(10))
			adresListesi        =	Replace(adresListesi,",",chr(10))
			adresListesi        =	Replace(adresListesi,";",chr(10))
			adresListesiArr     =	Split(adresListesi,chr(10))
            toplamKayit         =   ubound(adresListesiArr)
            toplamEklenen       =	0
			for si = 0 to ubound(adresListesiArr)
				if adresListesiArr(si) <> "" then
					adresListesiArr(si) = trim(adresListesiArr(si))
					adresListesiArr(si) = Replace(adresListesiArr(si)," ","")
                    if tur = "email" then
                        if len(adresListesiArr(si)) > 7 then
                            if instr(adresListesiArr(si),"@") > 0 and instr(adresListesiArr(si),".") > 0 then
                                if altModul = "Kara Liste" then
                                    sorgu = "Select * from toplumail.blacklist where adres = '" & adresListesiArr(si) & "'"
                                    rs.open sorgu,sbsv5,1,3
                                    if rs.recordcount = 0 then
                                        ' Response.Write adresListesiArr(si) & vbcrlf
                                        rs.addnew
                                        rs("adres") = adresListesiArr(si)
                                        rs("kaynak") = "Toplu Yükleme"
                                        rs("firmaID") = firmaID
                                        rs("kid") = kid
                                        rs.update
                                        toplamEklenen = toplamEklenen + 1
                                        Response.Flush()
                                    end if
                                    rs.close
                                end if
                                if altModul = "Adres Liste" then
                                    if adresGrupID = "" then
                                        hatamesaj = "Bir hata oluştu. Sayfayı yeniden yükleyip deneyin."
                                        call logla(hatamesaj)
                                        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-info","","","","","")
                                        Response.End
                                    else
                                        sorgu = "Select * from toplumail.adres where adres = '" & adresListesiArr(si) & "' and adresGrupID = " & adresGrupID
                                        rs.open sorgu,sbsv5,1,3
                                        if rs.recordcount = 0 then
                                            ' Response.Write adresListesiArr(si) & vbcrlf
                                            rs.addnew
                                            rs("adres") = adresListesiArr(si)
                                            rs("kaynak") = "Toplu Yükleme"
                                            rs("firmaID") = firmaID
                                            rs("kid") = kid
                                            rs("adresGrupID") = adresGrupID
                                            rs.update
                                            toplamEklenen = toplamEklenen + 1
                                            Response.Flush()
                                        end if
                                        rs.close
                                    end if
                                end if
                            end if
                        end if
                    end if
				end if
			next
            if tur = "email" then
                if toplamEklenen = 0 then
                    hatamesaj = "Eklenecek yeni adres bulunamadı. Girilen adreslerin tamamı daha önce eklenmişler."
                    call logla(hatamesaj)
                    call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-info","","","","","")
                else
                    hatamesaj = toplamEklenen & " adres eklendi"
                    call logla(hatamesaj)
                    call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-success","","","","","")
                end if
            end if
    	end if


adresGrupID64   =   adresGrupID
adresGrupID64   =   base64_encode_tr(adresGrupID64)
call jsac("/toplumail/adres_liste.asp?adresGrupID64=" & adresGrupID64)


%><!--#include virtual="/reg/rs.asp" -->