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


    sorgu = "Select webmailUser,webmailPass,webmailIP from personel.personel where firmaID = " & firmaID & " and id = " & kid
    rs.Open sorgu, sbsv5, 1, 3
    if rs.recordcount > 0 then
        webmailUser =   rs("webmailUser")
        webmailPass =   rs("webmailPass")
        webmailIP =   rs("webmailIP")
    end if
    rs.close


MessageID  =   Request.QueryString("MessageID")

Set pop3 = Server.CreateObject("JMail.POP3")
pop3.Connect webmailUser, webmailPass, webmailIP
Set msg = pop3.Messages.item(MessageID)
baslik = msg.Subject
baslik = turkcele(baslik)
set msg = Nothing

hatamesaj = "Mail Silindi : " & baslik

pop3.DeleteSingleMessage MessageID

pop3.Disconnect

    call jsac("/webmail/mail.asp")
    call logla(hatamesaj)
    call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
%>