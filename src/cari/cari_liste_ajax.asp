<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Cari"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Cari Listesi Ajax")

'### form data
'### form data
    aramaad =   Request.Form("aramaad")
    aramalimit  =   Request.Form("aramalimit")
'### form data
'### form data


'### hata önleme
'### hata önleme
    if aramalimit = "" then
        aramalimit  = 5
    end if
'### hata önleme
'### hata önleme


		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">Kod</th>"
		Response.Write "<th scope=""col"">Cari Adı</th>"
		Response.Write "<th scope=""col"">İl</th>"
		Response.Write "<th scope=""col"">Vergi No</th>"
		Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
		Response.Write "</tr></thead><tbody>" 
            sorgu = "SELECT"
			sorgu = sorgu & " top " & aramalimit
			sorgu = sorgu & " t1.cariID,"
			sorgu = sorgu & " t1.cariKodu,"
			sorgu = sorgu & " t1.cariAd, t1.il, t1.vergiNo" 
			sorgu = sorgu & " FROM cari.cari t1" 
			sorgu = sorgu & " WHERE firmaID = " & firmaID
			if aramaad = "" then
			else
				sorgu = sorgu & " and (t1.cariAd like N'%" & aramaad & "%' OR t1.vergiNo like N'%" & aramaad & "%' OR t1.cariKodu like N'%" & aramaad & "%')"
			end if
			sorgu = sorgu & " ORDER BY t1.cariAd ASC"
			rs.open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					cariID			=	rs("cariID")
					cariID64	 	=	cariID
					cariID64		=	base64_encode_tr(cariID64)
					cariKodu		=	rs("cariKodu")
					cariAd			=	rs("cariAd")
					il				=	rs("il")
					vergiNo			=	rs("vergiNo")
					Response.Write "<tr>"
						Response.Write "<td>" & cariKodu & "</td>"
						Response.Write "<td>" & cariAd & "</td>"
						Response.Write "<td>" & il & "</td>"
						Response.Write "<td>" & vergiNo &  "</td>"
						Response.Write "<td class=""text-right"" nowrap>"
						'# cari kullan
						teklif64 = cariID & "|"
						teklif64 =	base64_encode_tr(teklif64)
						Response.Write "<a title=""" & translate("Seç","","") & """ class=""ml-1 badge badge-pill "
						Response.Write " badge-warning"
						Response.Write """"
						Response.Write " onClick="""
						Response.Write "$('.cariAd').val('" & cariAd & "');"
						Response.Write "$('.cariKodu').val('" & cariKodu & "');"
						Response.Write "$('.cariID').val('" & cariID & "');"
						Response.Write "$('.cariliste').html('');"
						Response.Write """>"
						Response.Write "<i class=""mdi mdi-basket-unfill"
						Response.Write """></i>"
						Response.Write "</a>"
						'# cari kullan
						Response.Write "</td>"
					Response.Write "</tr>"
					Response.Flush()
				rs.movenext
				next
			end if
			rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"


%><!--#include virtual="/reg/rs.asp" -->