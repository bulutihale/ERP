<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    aramaad	=	Request.Form("aramaad")
    Response.Flush()
'###### ANA TANIMLAMALAR



yetkiTM = yetkibul(modulAd)


call logla("Toplu mail gönderim listesi ekranı")


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
					Response.Write "<form action=""/toplumail/gonderim_liste.asp"" method=""post"" class=""ortaform"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""Şablon adı"" name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
						Response.Write "</div>"
					Response.Write "</form>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU




	if yetkiTM > 0 then
		Response.Write "<div class=""container-fluid scroll-ekle3"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
		sorgu = "Select top 100" & vbcrlf
		sorgu = sorgu & "durum" & vbcrlf
		sorgu = sorgu & ",gonderimID" & vbcrlf
		sorgu = sorgu & ",toplumail.gonderim.tarih" & vbcrlf
		sorgu = sorgu & ",toplumail.sablon.sablonBaslik" & vbcrlf
		' sorgu = sorgu & ",toplumail.sablon.sablonIcerik" & vbcrlf
		sorgu = sorgu & ",toplumail.adres.adres" & vbcrlf
		' sorgu = sorgu & ",toplumail.mailAccount.gonderenAd" & vbcrlf
		' sorgu = sorgu & ",toplumail.mailAccount.gonderenAdres" & vbcrlf
		' sorgu = sorgu & ",toplumail.mailAccount.gonderenAdresSifre" & vbcrlf
		' sorgu = sorgu & ",toplumail.mailAccount.smtpAdres" & vbcrlf
		' sorgu = sorgu & ",toplumail.mailAccount.smtpPort" & vbcrlf
		' sorgu = sorgu & ",toplumail.mailAccount.smtpSSL" & vbcrlf
		' sorgu = sorgu & ",(Select count(blacklistID) from toplumail.blacklist where adres = toplumail.adres.adres and firmaID = " & firmaID & ") as blacklist" & vbcrlf
		sorgu = sorgu & "from toplumail.gonderim" & vbcrlf
		sorgu = sorgu & "LEFT JOIN toplumail.sablon on toplumail.sablon.sablonID = toplumail.gonderim.sablonID" & vbcrlf
		sorgu = sorgu & "LEFT JOIN toplumail.adres on toplumail.adres.adresID = toplumail.gonderim.adresID" & vbcrlf
		sorgu = sorgu & "LEFT JOIN toplumail.mailAccount on toplumail.mailAccount.mailAccountID = toplumail.gonderim.mailAccountID" & vbcrlf
		sorgu = sorgu & "where toplumail.gonderim.firmaID = " & firmaID & vbcrlf
        if aramaad = "" then
        else
            sorgu = sorgu & " and (toplumail.sablon.sablonBaslik like N'%" & aramaad & "%' or toplumail.adres.adres like N'%" & aramaad & "%')" & vbcrlf
        end if
        ' sorgu = sorgu & "order by newid()"
        sorgu = sorgu & "order by toplumail.gonderim.tarih desc"
					rs.Open sorgu, sbsv5, 1, 3
						if rs.recordcount > 0 then
							bekleyen = 0
							Response.Write "<div class=""table-responsive"">"
							Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
							Response.Write "<th scope=""col"">Tarih</th>"
							Response.Write "<th scope=""col"">Başlık</th>"
							Response.Write "<th scope=""col"">Adres</th>"
							Response.Write "<th scope=""col"">Durum</th>"
							Response.Write "<th scope=""col"">İşlem</th>"
							Response.Write "</tr></thead><tbody>" 
								for i = 1 to rs.recordcount
                                    tarih = rs("tarih")
                                    sablonBaslik = rs("sablonBaslik")
                                    adres = rs("adres")
                                    durum = rs("durum")
                                    gonderimID  =rs("gonderimID")
									Response.Write "<tr>"
										Response.Write "<td>" & tarih & "</td>"
										Response.Write "<td>" & sablonBaslik & "</td>"
										Response.Write "<td>" & kvkkMaske(adres,3,yetkiTM) &  "</td>"
										Response.Write "<td"
                                        if durum = "Beklemede" then
                                            Response.Write " class=""bg-warning"""
                                        elseif durum = "Gönderildi" then
                                            Response.Write " class=""bg-success"""
                                        elseif durum = "Blacklist" then
                                            Response.Write " class=""bg-danger"""
                                        end if
                                        Response.Write ">" & durum &  "</td>"
										if durum = "Beklemede" then
                                            Response.Write "<td class=""text-right"">"
											'# Mail Gönder
												Response.Write "<a onClick=""$('#ajax').load('/toplumail/gonder3.asp?gonderimID=" & gonderimID & "');"" title=""" & translate("Mail Gönder","","") & """ class=""ml-2"" >"
												Response.Write "<i class=""icon email-go"
												Response.Write """></i>"
												Response.Write "</a>"
											'# Mail Gönder
                                            Response.Write "</td>"
											bekleyen = 1
                                        else
                                            Response.Write "<td>"
                                            Response.Write "&nbsp;"
                                            Response.Write "</td>"
										end if

									Response.Write "</tr>"
									Response.Flush()
								rs.movenext
								next
							Response.Write "</tbody>"
							Response.Write "</table>"
							Response.Write "</div>"
						else
							call yetkisizGiris("Şablon Bulunamadı","","")
						end if
					rs.close
				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"


if bekleyen > 0 then
	call jsacdelay("/toplumail/gonderim_liste.asp",10000)
else
	call jsacdelay("/toplumail/gonderim_liste.asp",60000)
end if






	else
		call yetkisizGiris("Gönderim listesini görmek için yeterli yetkiniz bulunmamaktadır","","")
	end if



















%><!--#include virtual="/reg/rs.asp" -->