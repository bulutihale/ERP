<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
	aramaad	=	Request.Form("aramaad")
    opener  =   Request.QueryString("opener")
	modulAd =   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Makine - Teçhizat Listesi Ekranı")


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
					Response.Write "<form action=""/techizat/techizat_liste.asp"" method=""post"" class=""ortaform"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""Teçhizat adı"" name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
							if yetkiKontrol >= 5 then
								Response.Write "<div class=""col-lg-9 col-sm-6 my-1 text-right"">"
									Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/techizat/techizat_yeni.asp')"">YENİ TEÇHİZAT EKLE</button>&nbsp;"
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
	if hata = "" then
	if yetkiKontrol > 0 then
		Response.Write "<div class=""table-responsive"">"
		
		
            sorgu = "SELECT t1.techizatID, t1.techizatNo, t1.techizatAd, t1.marka, t1.uretici, t1.seriNo, t1.lokasyon, t1.aciklama,"
			sorgu = sorgu & " CASE WHEN silindi= 1 THEN '<span class=""text-danger bold"">PASİF</span>' ELSE 'AKTİF' END as durum"
			sorgu = sorgu & " FROM isletme.techizat t1"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID
			sorgu = sorgu & " and t1.tur = 'Makine'"
			if aramaad = "" then
			else
				sorgu = sorgu & " and (t1.techizatAd like N'%" & aramaad & "%' OR t1.marka like N'%" & aramaad & "%' OR t1.uretici like N'%" & aramaad & "%')"
			end if
			sorgu = sorgu & " ORDER BY t1.techizatNo ASC"
			rs.Open sorgu, sbsv5, 1, 3
			
			
			if rs.recordcount > 0 then
			
				

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"

		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark"">"
			Response.Write "<tr>"
					Response.Write "<th scope=""col"">Teçhizat No</th>"
					Response.Write "<th scope=""col"">Teçhizat Adı</th>"
					Response.Write "<th scope=""col"">Marka</th>"
					Response.Write "<th scope=""col"">Üretici Firma</th>"
					Response.Write "<th scope=""col"">Seri No</th>"
					Response.Write "<th scope=""col"">Bulunduğu Yer</th>"
					Response.Write "<th scope=""col"">Açıklama</th>"
					Response.Write "<th scope=""col"">Durum</th>"
					Response.Write "<th scope=""col""></th>"
			Response.Write "</tr></thead>"
			
					
					for i = 1 to rs.recordcount
					techizatID		=	rs("techizatID")
					techizatID64 	=	techizatID
					techizatID64	=	base64_encode_tr(techizatID64)
					techizatNo		=	rs("techizatNo")
					techizatAd		=	rs("techizatAd")
					marka			=	rs("marka")
					uretici			=	rs("uretici")
					seriNo			=	rs("seriNo")
					lokasyon		=	rs("lokasyon")
					aciklama		=	rs("aciklama")
					durum			=	rs("durum")
					
					
			Response.Write "<tr>"
				Response.Write "<td class="""">" & techizatNo & "</td>"
				Response.Write "<td class="""">" & techizatAd & "</td>"
				Response.Write "<td class="""">" & marka & "</td>"
				Response.Write "<td class="""">" & uretici & "</td>"
				Response.Write "<td class="""">" & seriNo & "</td>"
				Response.Write "<td class="""">" & lokasyon & "</td>"
				Response.Write "<td class="""">" & aciklama & "</td>"
				Response.Write "<td class="""">" & durum & "</td>"
				Response.Write "<td class=""text-right"">"
					if yetkiKontrol > 2 then
						Response.Write "<div title=""" & translate("Düzenle","","") & """ class=""badge badge-pill "
						Response.Write " badge-success"
						Response.Write """"
						Response.Write " onClick=""modalajax('/techizat/techizat_yeni.asp?gorevID=" & techizatID64 & "')"">"
						Response.Write "<i class=""mdi mdi-account-convert"
						Response.Write """></i>"
						Response.Write "</div>"
					end if
				Response.Write "</td>"
					
			Response.Write "</tr>"
					rs.movenext
					next
		Response.Write "</table>"
	Response.Write "</div>"
	Response.Write "</div>"
	Response.Write "</div>"
	Response.Write "</div>"
	Response.Write "</div>"
	Response.Write "</div>"
			end if
			
			rs.close
		Response.Write "</div>"
	
	else
		call yetkisizGiris("","","")
	end if
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU












%>