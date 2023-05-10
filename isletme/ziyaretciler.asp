<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
	aramaad	=	Request.Form("aramaad")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Ziyaretci Ekranı")


yetkiGuvenlik = yetkibul("guvenlik")


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" then
		Response.Write "<form action=""/isletme/ziyaretciler"" method=""post"">"
		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-3 my-1"">"
		Response.Write "<label class=""sr-only"" for=""inlineFormInputName"">Ziyaretci Adı</label>"
		Response.Write "<input type=""text"" class=""form-control"" placeholder=""Ad Soyad"" name=""aramaad"" value=""" & aramaad & """>"
		Response.Write "</div>"
		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">ARA</button></div>"
        if yetkiGuvenlik > 5 then
            Response.Write "<div class=""col-sm-3 my-1""><button type=""button"" class=""btn btn-danger"" onClick=""modalajax('/isletme/ziyaretciler_yeni.asp')"">YENİ ZİYARETCİ</a></div>"
        end if
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU



'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" and yetkiGuvenlik > 0 then
		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">Ziyaretci</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Giriş</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Çıkış</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Geldiği Birim</th>"
        Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Geldiği Personel</th>"
        Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Not</th>"
        Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">&nbsp;</th>"
		Response.Write "</tr></thead><tbody>"
            sorgu = "Select isletme.ziyaretci.ziyaretID,personel.personel.ad as personelAd,isletme.ziyaretci.t1,isletme.ziyaretci.t2,isletme.ziyaretci.adSoyad,isletme.ziyaretci.ziyaretSebebi,personel.departman.departmanAd from isletme.ziyaretci"
            sorgu = sorgu & " left join personel.personel on personel.personel.id = isletme.ziyaretci.hedefPersonel"
            sorgu = sorgu & " left join personel.departman on personel.departman.departmanID = isletme.ziyaretci.hedefBirim"
			sorgu = sorgu & " where isletme.ziyaretci.firmaID = " & firmaID
			if aramaad = "" then
			else
				sorgu = sorgu & " and (isletme.ziyaretci.adSoyad like N'%" & aramaad & "%')"
			end if
            if yetkiGuvenlik = 1 then
                sorgu = sorgu & " and (isletme.ziyaretci.hedefPersonel = " & kid & ")"
            elseif yetkiGuvenlik > 5 then
            end if
			sorgu = sorgu & " order by isletme.ziyaretci.t1 DESC"
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					Response.Write "<tr>"
                    Response.Write "<td>"
                    Response.Write rs("adSoyad")
					Response.Write "</td>"
					Response.Write "<td>"
                    Response.Write rs("t1")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("t2")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("departmanAd")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("personelAd")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("ziyaretSebebi")
					Response.Write "</td>"

                    Response.Write "<td class=""col-lg-3 my-1 text-right"">"
                    if isnull(rs("t2")) = True then
                        Response.Write "<button type=""button"" class=""btn btn-warning"" onClick=""$('#ajax').load('/isletme/ziyaretciler_cikis.asp?ziyaretID=" & rs("ziyaretID") & "');"">Çıkış Yap</button>"
                    end if
					Response.Write "</td>"


                    
					Response.Write "</tr>"
				rs.movenext
				next
			end if
			rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU












%>