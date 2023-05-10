<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	Response.Charset	=	"utf-8"
	Response.Flush()
	Session("lngTimer")	=	Timer
	site				=	Request.ServerVariables("HTTP_HOST")
	kid					=	kidbul()
	personelID			=	kid
	mobil				=	mobilkontrol()
	hata				=	""
    modul =   "portal.duyuru"
    modulAd = modul
    sayfaTur            =   "duyuru"
    tur                 =   Request.QueryString("tur")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

    if tur = "" then
        sayfaTur     ="Duyuru"
    elseif tur = "duyuru" then
        sayfaTur     ="Duyuru"
    elseif tur = "kitap" then
        sayfaTur     ="Kitap Özetleri"
    elseif tur = "ingilizce" then
        sayfaTur     ="İngilizce Makaleler"
    end if





		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-dark""><a href=""/duyuru/duyuru/" & tur & """ style=""color:white"">" & sayfaTur & "</a></div>"
				Response.Write "<div class=""card-body"" style=""max-height:300px;overflow:auto;padding:0 !important"">"


if tur = "duyuru" then
    sorgu = "Select top 1 * from portal.duyuru where firmaID = " & firmaID & " and durum = N'Yayında' and tur = '" & sayfaTur & "' and t1 <= '" & tarihsql(date()) & "' and (t2 >= '" & tarihsql(date()) & "' or t2 is null) order by t1 desc"
else
    sorgu = "Select top 10 * from portal.duyuru where firmaID = " & firmaID & " and durum = N'Yayında' and tur = '" & sayfaTur & "' and t1 <= '" & tarihsql(date()) & "' and (t2 >= '" & tarihsql(date()) & "' or t2 is null) order by t1 desc"
end if
	rs.Open sorgu, sbsv5, 1, 3
		if rs.recordcount > 0 then
            for i = 1 to rs.recordcount
                if tur = "duyuru" then
                    Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-body"">"
                    Response.Write "<h4 class=""card-title"">"
                    Response.Write "<div class=""row"">"
                    Response.Write "<div class=""col-md-8"">" & rs("baslik") & "</div>"
                    if yetkiPersonel > 0 or yetkiIT > 0 then
                        Response.Write "<div class=""col-md-4 text-right"" onClick=""modalajax('/duyuru/duyuru_yeni.asp?gorevID=" & rs("duyuruID") & "')"">" & tarihtr(rs("t1")) & "</div>"
                    else
                        Response.Write "<div class=""col-md-4 text-right"">" & tarihtr(rs("t1")) & "</div>"
                    end if
                    Response.Write "</div>"
                    Response.Write "</h4>"
                    Response.Write "<p class=""card-description"">" & rs("icerik") & "</p>"
                        sorgu = "Select * from portal.dosya where modul = '" & modul & "' and modulID = " & rs("duyuruID") 
                        rs2.Open sorgu, sbsv5, 1, 3
                        if rs2.recordcount > 1 then
                            Response.Write "<div class=""row"">"
                        end if
                        for ri = 1 to rs2.recordcount
                            dosyaID = rs2("dosyaID")
                            dosyaUzanti = rs2("dosyaUzanti")
                            dosyaAciklama = rs2("dosyaAciklama")
                            dosyaAdi = rs2("dosyaID") & "." & rs2("dosyaUzanti")
                            dosyaAdiOrjinal = rs2("dosyaAd")
                            if dosyaUzanti = "jpg" or dosyaUzanti = "png" then
                                if rs2.recordcount > 1 then
                                    Response.Write "<div class=""col-md-4"">"
                                        Response.Write "<div class=""center mt-2""><img src=""/temp/dosya/" & dosyaAdi & """ class=""img-fluid mx-auto d-block"" /></div>"
                                    Response.Write "</div>"
                                else
                                    Response.Write "<div class=""center""><img src=""/temp/dosya/" & dosyaAdi & """ class=""img-fluid mx-auto d-block"" /></div>"
                                end if
                            end if
                            if dosyaUzanti = "pdf" or dosyaUzanti = "pptx" then
                                Response.Write "<div class=""text-center""><a href=""/temp/dosya/" & dosyaAdi & """ target=""_blank""><img src=""/template/icon/" & dosyaUzanti & ".png"" title=""" & translate("Dosyayı İndir","","") & """ style=""width:64px"" /><br />" & dosyaAdiOrjinal & "</a></div>"
                            end if
                        rs2.movenext
                        next
                        if rs2.recordcount > 1 then
                            Response.Write "</div>"
                        end if
                        rs2.close
                    Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                else
                    Response.Write "<div class=""col-md-12 mt-2 h5"">" & rs("baslik") & "</div>"
                end if
            rs.movenext
            next
        end if
    rs.close






				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
%>