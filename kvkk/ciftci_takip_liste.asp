<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
	aramaad	=	Request.Form("aramaad")
    opener  =   Request.Form("opener")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

Response.Flush()

call logla("KVKK Çiftçi Listesi Ekranı")

yetkiKVKK = yetkibul("kvkk")

if yetkiKVKK > 2 then
    '###### ARAMA FORMU
    '###### ARAMA FORMU
        if hata = "" then
            Response.Write "<form action=""/kvkk/ciftci_takip_liste.asp"" method=""post"" class=""ortaform"">"
            Response.Write "<div class=""form-row align-items-center"">"
            Response.Write "<div class=""col-sm-3 my-1"">"
            Response.Write "<input type=""text"" class=""form-control"" placeholder=""Ad Soyad"" name=""aramaad"" value=""" & aramaad & """>"
            Response.Write "</div>"
            Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">ARA</button></div>"
            Response.Write "</div>"
            Response.Write "</form>"
        end if
    '###### ARAMA FORMU
    '###### ARAMA FORMU


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" then
		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
                            Response.Write "<th>Sayı</th>"
                            Response.Write "<th>Tarih</th>"
                            Response.Write "<th>Adı Soyadı</th>"
                            Response.Write "<th>Telefon</th>"
                            Response.Write "<th>Email</th>"
                            Response.Write "<th>Bitki 1</th>"
                            Response.Write "<th>Dekar 1</th>"
                            Response.Write "<th>Bitki 2</th>"
                            Response.Write "<th>Dekar 2</th>"
                            Response.Write "<th>SMS Onay</th>"
		                Response.Write "</tr></thead><tbody>"
						sorgu = "" & vbcrlf
						sorgu = sorgu & "Select tarih,ad,telefon,email,SMSonay,agrobest.bitkiler.bitkiAd,kvkk.kisi.dekar,bitki2.bitkiAd as bitki2Ad,kvkk.kisi.dekar2 from kvkk.kisi" & vbcrlf
						sorgu = sorgu & "left JOIN agrobest.bitkiler on agrobest.bitkiler.bitkiID = kvkk.kisi.bitkiID" & vbcrlf
						sorgu = sorgu & "left JOIN agrobest.bitkiler as bitki2 on bitki2.bitkiID = kvkk.kisi.bitki2ID" & vbcrlf
                        if aramaad = "" then
                        else
                            sorgu = sorgu & " where kvkk.kisi.ad like N'%" & aramaad & "%'"
                        end if
						sorgu = sorgu & "order by kvkk.kisi.id asc"

                        rs.open sorgu,sbsv5,1,3
                        for ri = 1 to rs.recordcount
                            Response.Write "<tr>"
                            Response.Write "<td>" & ri & "</td>"
                            Response.Write "<td>" & rs("tarih") & "</td>"
                            Response.Write "<td>" & rs("ad") & "</td>"
                            if yetkiKVKK > 6 then
                                Response.Write "<td>" & rs("telefon") & "</td>"
                                Response.Write "<td>" & rs("email") & "</td>"
                            else
                                Response.Write "<td>********" & right(rs("telefon"),2) & "</td>"
                                if rs("email") & "" <> "" then
                                    Response.Write "<td>" & left(rs("email"),2) & "********" & right(rs("email"),2) & "</td>"
                                else
                                    Response.Write "<td>&nbsp;</td>"
                                end if
                            end if
							Response.Write "<td>" & rs("bitkiAd") & "</td>"
							Response.Write "<td>" & rs("dekar") & "</td>"
							Response.Write "<td>" & rs("bitki2Ad") & "</td>"
							Response.Write "<td>" & rs("dekar2") & "</td>"
                            Response.Write "<td "
                            if rs("SMSonay") = True then
                                Response.Write " class=""success"">"
                            else
                                Response.Write " class=""danger"">"
                            end if
                            Response.Write rs("SMSonay") & "</td>"
                            Response.Write "</tr>"
                        rs.movenext
                        next
                        rs.close

		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU

else

    Response.Write "Yetkisiz işlem"
    call logla("Yetkisiz işlem")


end if








%>