<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    durum	=   Request.QueryString("durum")
    durum2	=   Request.QueryString("durum2")
		if durum <> "" then q = "" else q = "tumListe" end if
		if durum2 <> "" then q2 = "" else q2 = "sifirGoster" end if
	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modulAd =   "stok"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Tanımlanmış koliler Listeleniyor") 

yetkiKontrol = yetkibul(modulAd)


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and opener = "" and yetkiKontrol > 0 then

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				'Response.Write "<div class=""row"">"
					Response.Write "<form action=""/stok/koli_liste.asp"" method=""post"" class=""ortaform"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""Ürün adı"" name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
							if yetkiKontrol >= 8 then
								Response.Write "<div class=""col-lg-9 col-sm-3 my-1 text-right"">"
									Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/stok/koli_yeni.asp')"">YENİ KOLİ TANIMLA</button>&nbsp;" 
								Response.Write "</div>"
							end if
						Response.Write "</div>"
					Response.Write "</form>"
				'Response.Write "</div>"
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


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" and yetkiKontrol > 0 then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"

		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">Koli Adı</th>"
		if yetkiKontrol >= 5 then
			Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
		end if
		Response.Write "</tr></thead><tbody>"

            sorgu = "SELECT"
			sorgu = sorgu & " t1.koliID, t1.ad as koliAd," 
			sorgu = sorgu & " CASE WHEN t1.silindi = 1 THEN '<span class=""text-danger"">PASİF</span>' ELSE 'AKTİF' END as durum"
			sorgu = sorgu & " FROM stok.koli t1" 
			sorgu = sorgu & " WHERE firmaID = " & firmaID
			sorgu = sorgu & " AND t1.silindi = 0"
			rs.open sorgu, sbsv5, 1, 3
			
			
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					koliID			=	rs("koliID")
					durum			=	rs("durum")
					koliID64	 	=	koliID
					koliID64		=	base64_encode_tr(koliID64)
					koliAd			=	rs("koliAd")
					Response.Write "<tr>"
						Response.Write "<td>" & koliAd & "</td>"
						Response.Write "<td class=""text-center"">" & durum &  "</td>"
						Response.Write "<td class=""text-right"">"
					if yetkiKontrol >= 5 then
						'# stok düzenle
						Response.Write "<div class=""badge badge-pill badge-success"""
							Response.Write " onClick=""modalajax('/stok/koli_yeni.asp?gorevID=" & koliID64 & "');"">"
							Response.Write "<i class=""mdi mdi-account-convert""></i>"
						Response.Write "</div>"
						'# stok düzenle
					end if
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

				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"

	else
		call yetkisizGiris("","","")
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU





%>

