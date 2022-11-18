<!--#include virtual="/reg/rs.asp" --><%

'//FIXME - Mail Attachment Download


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
    Set msg = pop3.Messages.item(MessageID)
    baslik      =   msg.Subject
    baslik      =   turkcele(baslik)
    tarih       =   msg.date
    gonderen    =   msg.from
    gonderenAd  =   msg.fromName
    ' icerik      =   msg.Body
    ' icerik      =   turkcele(icerik)
    icerik      =   msg.htmlbody
    set msg = Nothing
    hatamesaj = "Mail Okundu : " & baslik
    Response.Write "<div class=""table-responsive"">"
        Response.Write "<table class=""table table-striped table-bordered table-sm"">"
        Response.Write "<tr>"
        Response.Write "<td colspan=""2"" align=""center"">"
        Response.Write baslik
        Response.Write "</td>"
        Response.Write "</tr>"
        Response.Write "<tr>"
        Response.Write "<td>"
        Response.Write gonderen
        Response.Write " "
        Response.Write gonderenAd
        Response.Write "</td>"
        Response.Write "<td align=""right"">"
        Response.Write tarih
        Response.Write "</td>"
        Response.Write "</tr>"
        Response.Write "<tr>"
        Response.Write "<td colspan=""2"">"
        Response.Write icerik
        Response.Write "</td>"
        Response.Write "</tr>"
        Response.Write "</table>"
    Response.Write "</div>"
    pop3.Disconnect
else
    call yetkisizGiris(hata,"","")
end if
%>