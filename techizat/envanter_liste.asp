<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
	aramaad	=	Request.Form("aramaad")
	modulAd =   "Envanter"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Envanter Listesi Ekranı")


yetkiPersonel       =   yetkibul("Personel")
yetkiBilgiIslem     =   yetkibul("Bilgi İşlem")


'###### ARAMA FORMU
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				'Response.Write "<div class=""row"">"
					Response.Write "<form action=""/techizat/envanter_liste.asp"" method=""post"" class=""ortaform"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""Cihaz adı"" name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
							if yetkiPersonel >= 1 or yetkiBilgiIslem >= 1 then
								Response.Write "<div class=""col-lg-9 col-sm-6 my-1 text-right"">"
									Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/techizat/envanter_yeni.asp')"">Yeni Cihaz Ekle</button>&nbsp;"
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





'####### SONUÇ TABLOSU
	if hata = "" then
		Response.Write "<div class=""table-responsive"">"
            sorgu = "SELECT techizatID, techizatNo, techizatAd, marka, uretici, seriNo, lokasyon, aciklama"
			' sorgu = sorgu & " CASE WHEN silindi= 1 THEN '<span class=""text-danger bold"">PASİF</span>' ELSE 'AKTİF' END as durum"
			sorgu = sorgu & " FROM isletme.techizat"
			sorgu = sorgu & " WHERE firmaID = " & firmaID
	        if (yetkiBilgiIslem > 0 or yetkiPersonel > 0) then
			    ' sorgu = sorgu & " and tur = 'Makine'"
                if aramaad = "" then
                else
                    sorgu = sorgu & " and (techizatAd like N'%" & aramaad & "%' OR marka like N'%" & aramaad & "%' OR uretici like N'%" & aramaad & "%')"
                end if
            end if
			sorgu = sorgu & " ORDER BY techizatAd ASC"
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
                                    Response.Write "<th scope=""col"">Cihaz</th>"
                                    Response.Write "<th scope=""col"">Tür</th>"
                                    Response.Write "<th scope=""col"">Ömür</th>"
                                    Response.Write "<th scope=""col"">Marka</th>"
                                    Response.Write "<th scope=""col"">Model</th>"
                                    Response.Write "<th scope=""col"">Özellik</th>"
                                    Response.Write "<th scope=""col"">Durumu</th>"
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
	end if
'####### SONUÇ TABLOSU












%><!--#include virtual="/reg/rs.asp" -->