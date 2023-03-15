<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    Response.Flush()
'###### ANA TANIMLAMALAR

'###### verileri çek
    sablonID        =   Request.Form("sablonID")
    adresGrupID     =   Request.Form("adresGrupID")
    mailAccountID   =   Request.Form("mailAccountID")
    tekrarGonderim  =   Request.Form("tekrarGonderim")
'###### verileri çek

'###### VERİ KONTROLÜ
    if sablonID = "" then
        hatamesaj = "Lütfen şablon seçin"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    if adresGrupID = "" then
        hatamesaj = "Lütfen hedef kitleyi seçin"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    if mailAccountID = "" then
        hatamesaj = "Lütfen maili gönderecek hesabı seçin"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
'###### VERİ KONTROLÜ

call logla("Gönderim yapılacak mailler hazırlanıyor")

'###### İŞLEM
    sorgu = "INSERT into toplumail.gonderim" & vbcrlf
    sorgu = sorgu & "select getdate() as tarih," & kid & " as kid," & firmaID & " as firmaID,'Beklemede' as durum," & sablonID & " as sablonID,adresID," & mailAccountID & " as mailAccountID from toplumail.adres" & vbcrlf
    sorgu = sorgu & "where silindi = 0 and adresGrupID = " & adresGrupID & vbcrlf
    if tekrarGonderim = "" then
        sorgu = sorgu & "and adresID not in (select adresID from toplumail.gonderim where durum in ('Beklemede','Gönderildi','Blacklist') and sablonID = " & sablonID & ")" & vbcrlf
    end if
    ' buraya blacklist gelicek
    ' Response.Write sorgu
    ' Response.End()
    rs.open sorgu,sbsv5,3,3
'###### İŞLEM







        '### ŞABLONLAR
            sorgu = "Select * from toplumail.sablon where firmaID = " & firmaID & " and silindi = 0 and sablonID = " & sablonID
            sorgu = sorgu & " order by sablonBaslik ASC"
            rs.open sorgu,sbsv5,1,3
            if rs.recordcount > 0 then
                sablonBaslik    =   rs("sablonBaslik")
                sablonIcerik    =   rs("sablonIcerik")
                sablonIcerik    =   replace(sablonIcerik,"[title]",sablonBaslik)
            end if
            rs.close
        '### ŞABLONLAR



	Set objStream = server.CreateObject("ADODB.Stream")
	objStream.Open
	objStream.CharSet = "UTF-8"
    objStream.WriteText sablonIcerik
	objStream.SaveToFile Server.Mappath("/temp/mail/" & sablonID & ".html"),2
	objStream.Close
	set objStream = Nothing



        hatamesaj = "Gönderim listesi oluşturuldu. Gönderim başlıyor"
        call logla(hatamesaj)
        hatamesaj = "<center>Gönderim listesi oluşturuldu. Gönderim başlıyor."
        hatamesaj = hatamesaj & "<br />&nbsp;<br />Gönderim listesine <a href=""/toplumail/gonderim_liste"" style=""color:red"">buradan</a> ulaşabilirsiniz"
        hatamesaj = hatamesaj & "<br />&nbsp;<br />Gönderilen içeriğe <a href=""/temp/mail/" & sablonID & ".html"" style=""color:red"" target=""_blank"">buradan</a> ulaşabilirsiniz</center>"
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-success","","","","","")


%><!--#include virtual="/reg/rs.asp" -->