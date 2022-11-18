<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Mail"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


if kid <> "" then
    sorgu = "Select webmailUser,webmailPass,webmailIP from personel.personel where firmaID = " & firmaID & " and id = " & kid
    rs.Open sorgu, sbsv5, 1, 3
    if rs.recordcount > 0 then
        webmailUser =   rs("webmailUser")
        webmailPass =   rs("webmailPass")
        webmailIP   =   rs("webmailIP")
    end if
    rs.close
else
    hata = "Tanımsız Kullanıcı"
end if


if hata = "" then
    MessageID  =   Request.QueryString("MessageID")
    if MessageID = "" then
        hata = "Mail bilgisi alınamadı"
    end if
end if

if hata = "" then
    Set pop3 = Server.CreateObject("JMail.POP3")
    pop3.Connect webmailUser, webmailPass, webmailIP
    on error resume next
        Set msg = pop3.Messages.item(MessageID)
        if err.number = 0 then
            baslik = msg.Subject
            baslik = turkcele(baslik)
        else
            hata = "<center>İşlem iptal edildi!<br />Silmeye çalıştığınız mail daha önce silinmiş olabilir.</center>"
        end if
        set msg = Nothing
    on error goto 0
    if hata = "" then
        hatamesaj = "Mail Silindi : " & baslik
        pop3.DeleteSingleMessage MessageID
        call jsac("/webmail/mail.asp")
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
    else
        call logla(hata)
        call bootmodal(hata,"custom","","","","Tamam","","btn-danger","","","","","")
    end if
    pop3.Disconnect
else
    call logla(hata)
    call bootmodal(hata,"custom","","","","Tamam","","btn-danger","","","","","")
end if


%><!--#include virtual="/reg/rs.asp" -->