<!--#include virtual="/reg/rs.asp" --><%

'//FIXME - 1- MAIL READ - UNREAD
'//FIXME - 2- MAIL GÖNDERME
'//FIXME - 3- MAIL REPLY
'//FIXME - 4- MAIL ADRES DEFTERİ
'//FIXME - 5- MAIL gelince listeyi yenileme


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



call logla("Mail : Gelen Kutusu")
Set pop3 = Server.CreateObject("JMail.POP3")
pop3.Connect webmailUser, webmailPass, webmailIP

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
                if pop3.count = 0 then
                    hata = "Mail Bulunamadı"
                    Response.Write hata
                else
                    Response.Write "<div class=""table-responsive"">"
                    Response.Write "<table class=""table table-striped table-bordered table-hover table-sm"">"
                    Response.Write "<thead class=""thead-dark"">"
                    Response.Write "<tr>"
                    Response.Write "<th scope=""col"" nowrap>Tarih</th>"
                    Response.Write "<th scope=""col"">Gönderen</th>"
                    Response.Write "<th scope=""col"">Alıcı</th>"
                    Response.Write "<th scope=""col"">Başlık</th>"
                    Response.Write "<th scope=""col"">İşlem</th>"
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
                        Subject     =   left(Subject,70)
                        Response.Write "<tr>"
                            Response.Write "<td nowrap>" & tarih & "</td>"
                            Response.Write "<td title=""" & FromName & """>" & fromMail & "</td>"
                                Set Recipients = msg.Recipients
                                Set re = Recipients.item(0)
                                    If re.ReType = 0 Then
                                        if re.Name = "" then
                                            Response.Write "<td>" & re.EMail & "</td>"
                                        else
                                            Response.Write "<td title=""" & re.EMail & """>" & re.Name & "</td>"
                                        end if
                                    End If
                            Response.Write "<td>" & Subject &  "</td>"
                            Response.Write "<td align=""right"">"
                            Response.Write "<i class=""mdi mdi-message-text-outline ml-3"" title=""Mail Oku"" onClick=""modalajaxfit('/webmail/mailBody.asp?MessageID=" & maili & "');""></i>"
                            Response.Write "<i class=""mdi mdi-delete ml-3"" title=""Mail Sil"" onClick=""$('#ajax').load('/webmail/mailDelete.asp?MessageID=" & maili & "');""></i>"
                            
                            Response.Write "</td>"
                        Response.Write "</tr>"
                    next
                    Response.Write "</tbody>"
                    Response.Write "</table>"
                    Response.Write "</div>"
                end if
				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
%>