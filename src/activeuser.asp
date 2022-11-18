<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Personel"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


'#### ZAMANLANMIŞ GÖREVLER
'#### ZAMANLANMIŞ GÖREVLER
	Response.Write "<scr" & "ipt type=""text/javascript"">"
	Response.Write "$().ready(function(){"
       Response.Write "setTimeout(function(){"
           Response.Write "$('#activeuserUrl').load('" & sb_activeuserUrl & "')"
       Response.Write ";}, " & sb_activeuserTime & "000 );"
    Response.Write "});"
	Response.Write "</scr" & "ipt>"
'#### ZAMANLANMIŞ GÖREVLER
'#### ZAMANLANMIŞ GÖREVLER


'#### BİLDİRİM YÖNETİMİ
'#### BİLDİRİM YÖNETİMİ
if kid <> "" then
    sorgu = "Select top 10 icerik,notificationID from portal.notification where okundu = 0 and firmaID = " & firmaID & " and kid = " & kid & " order by notificationID DESC"
    rs.Open sorgu, sbsv5, 1, 3
        bildirimsayi = rs.recordcount
        'sayıyı güncelle
        if bildirimsayi = 0 then
            'd-none varsa bişey yapma, yoksa d-none ekle
                komut = "$('.bildirimcontainer').addClass('d-none');"
                call jsrun(komut)
            'd-none varsa bişey yapma, yoksa d-none ekle
        else
            '## d-none varsa sil
                komut = "if($('.bildirimcontainer').hasClass('d-none')){$('.bildirimcontainer').removeClass('d-none');}"
                call jsrun(komut)
            '## d-none varsa sil
            '## sayıyı güncelle
                komut = "$('.bildirimsayi').text('" & bildirimsayi & "');"
                call jsrun(komut)
            '## sayıyı güncelle
            '## eksik bildirim varsa ekle
            for i = 1 to rs.recordcount
                ' komut = "if($('.bildirimitem" & rs("notificationID") & "').length > 0){alert('var');}"
                komut = "if($('.bildirimitem" & rs("notificationID") & "').length == 1){}else{"
                ' komut = komut & "$('<a>XXX" & rs("notificationID") & "</a>').insertBefore('.bildirimitemTum')"
                komut = komut & "$('<a class=""dropdown-item bildirimitem bildirimitem" & rs("notificationID") & """><div class=""item-content flex-grow"">"
                komut = komut & "<h6 class=""ellipsis font-weight-normal"" "
                komut = komut & "onClick=""modalajax(\'/portal/notificationModal.asp?gorevID=" & rs("notificationID") & "\')"" "
                komut = komut & ">"
                komut = komut & rs("icerik")
                komut = komut & "</h6></div></a>').insertBefore('.bildirimitemTum')"
                komut = komut & "}"
                call jsrun(komut)
            rs.movenext
            next
            '## eksik bildirim varsa ekle
        end if
    rs.close
end if
'#### BİLDİRİM YÖNETİMİ
'#### BİLDİRİM YÖNETİMİ


'#### MAİL
'#### MAİL
if kid <> "" then
    sorgu = "Select webmailUser,webmailPass,webmailIP from personel.personel where firmaID = " & firmaID & " and id = " & kid
    rs.Open sorgu, sbsv5, 1, 3
    if rs.recordcount > 0 then
        webmailUser =   rs("webmailUser")
        webmailPass =   rs("webmailPass")
        webmailIP =   rs("webmailIP")
    end if
    rs.close
    if webmailUser <> "" and webmailPass <> "" and webmailIP <> "" then
        Set pop3 = Server.CreateObject("JMail.POP3")
        pop3.Connect webmailUser, webmailPass, webmailIP
        mailSayisi = pop3.count
        pop3.Disconnect
            '## sayıyı güncelle
                komut = "$('.mailSayi').text('" & mailSayisi & "');"
                call jsrun(komut)
            '## sayıyı güncelle
            '## EĞER AÇIK OLAN SAYFA MAİL İSE SAYFAYI GÜNCELLE
            '## EĞER AÇIK OLAN SAYFA MAİL İSE SAYFAYI GÜNCELLE
            
            '## EĞER AÇIK OLAN SAYFA MAİL İSE SAYFAYI GÜNCELLE
            '## EĞER AÇIK OLAN SAYFA MAİL İSE SAYFAYI GÜNCELLE
    end if
end if
'#### MAİL
'#### MAİL

%>