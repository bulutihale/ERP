<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
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
    Response.Write "<div class=""row"">"
        Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
            Response.Write "<div class=""card"">"
            Response.Write "<div class=""card-header text-white bg-dark""><a href=""/webmail/mail"" style=""color:white"">Webmail</a></div>"
            Response.Write "<div class=""card-body"" style=""max-height:300px;overflow:auto;padding:0 !important"">"
                Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 border-primary border card pricing-card-body "
                Response.Write """>"
                    Response.Write "<div class=""row"">"
                    if webmailUser <> "" then
                        Set pop3 = Server.CreateObject("JMail.POP3")
                        pop3.Connect webmailUser, webmailPass, webmailIP
                            if pop3.count = 0 then
                                hata = "Mail Bulunamadı"
                                Response.Write hata
                            else
                                Response.Write "<div class=""table-responsive"">"
                                Response.Write "<table class=""table table-striped table-bordered table-hover table-sm"">"
                                Response.Write "<thead class=""thead-dark"">"
                                Response.Write "<tr>"
                                Response.Write "<th scope=""col"" nowrap>Tarih</th>"
                                ' Response.Write "<th scope=""col"">Gönderen</th>"
                                Response.Write "<th scope=""col"">Başlık</th>"
                                Response.Write "</tr>"
                                Response.Write "</thead>"
                                Response.Write "<tbody>" 
                                for maili = 1 to pop3.count
                                    Set msg = pop3.Messages.item(maili)
                                    FromName = msg.FromName
                                    FromName = turkcele(FromName)
                                    fromMail    =   msg.from
                                    ReTo        =   turkcele(ReTo)
                                    tarih       =   msg.Date
                                    Subject     =   msg.Subject
                                    Subject     =   turkcele(Subject)
                                    Subject     =   left(Subject,50)
                                    Response.Write "<tr>"
                                        Response.Write "<td nowrap>" & tarihtr(tarih) & "</td>"
                                        ' Response.Write "<td title=""" & FromName & """>" & fromMail & "</td>"
                                        Response.Write "<td>" & Subject &  "...</td>"
                                    Response.Write "</tr>"
                                    if maili = 6 then
                                        exit for
                                    end if
                                next
                                Response.Write "</tbody>"
                                Response.Write "</table>"
                                Response.Write "</div>"
                            end if
                        pop3.disconnect
                    else
                        call yetkisizGiris("Mail Bilgileri Tanımlanmamış","","")
                    end if
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"
        Response.Write "</div>"
    Response.Write "</div>"
else
    call yetkisizGiris(hata,"","")
end if
%><!--#include virtual="/reg/rs.asp" -->