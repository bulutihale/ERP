<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
	aramaad	=	Request.Form("aramaad")
    opener  =   Request.QueryString("opener")
	modulAd =   "Depo"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Depo Listesi Ekranı")


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
					Response.Write "<form action=""/depo/depo_liste.asp"" method=""post"" class=""ortaform"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""Depo adı"" name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
							if yetkiKontrol >= 5 then
								Response.Write "<div class=""col-lg-9 col-sm-6 my-1 text-right"">"
									Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/depo/depo_yeni.asp')"">YENİ DEPO EKLE</button>&nbsp;"
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
		
		
            sorgu = "Select id, depoKod, depoAd, CASE WHEN depoEksiBakiye = 1 THEN 'EVET' ELSE 'HAYIR' END as depoEksiBakiye, depoKategori, ozelDepo, cariID,"
			sorgu = sorgu & " CASE WHEN depoTuru= 0 THEN 'SANAL' WHEN depoTuru= 1 THEN 'FİZİKSEL' END as depoTuru, "
			sorgu = sorgu & " CASE WHEN silindi= 1 THEN '<span class=""text-danger bold"">PASİF</span>' ELSE 'AKTİF' END as depoDurum,"
			sorgu = sorgu & " CASE WHEN malKabulizin = 1 THEN '<span class=""text-success bold"">EVET</span>' ELSE 'HAYIR' END as malKabulizin"
			sorgu = sorgu & " FROM stok.depo"
			sorgu = sorgu & " WHERE firmaID = " & firmaID
			sorgu = sorgu & " order by stok.depo.depoKod ASC"
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
					Response.Write "<th scope=""col"">Depo Kodu</th>"
					Response.Write "<th scope=""col"">Depo Adı</th>"
					Response.Write "<th scope=""col"">Depo Türü</th>"
					Response.Write "<th scope=""col"">Kategori</th>"
					Response.Write "<th scope=""col"">Mal Kabul İzin</th>"
					Response.Write "<th scope=""col"">Eksi Bakiye</th>"
					Response.Write "<th scope=""col"">Durum</th>"
					Response.Write "<th scope=""col""></th>"
			Response.Write "</tr></thead>"
			
					
					for i = 1 to rs.recordcount
					
					depoKod			=	rs("depoKod")
					depoAd			=	rs("depoAd")
					depoID			=	rs("id")
					depoID64	 	=	depoID
					depoID64		=	base64_encode_tr(depoID64)
					depoTuru		=	rs("depoTuru")
					depoEksiBakiye	=	rs("depoEksiBakiye")
					depoDurum		=	rs("depoDurum")
					malKabulizin	=	rs("malKabulizin")
					depoKategori	=	rs("depoKategori")
					ozelDepo		=	rs("ozelDepo")
					cariID			=	rs("cariID")
					
					
			Response.Write "<tr>"
				Response.Write "<td class="""">" & depoKod & "</td>"
				Response.Write "<td class="""">" & depoAd & "</td>"
				Response.Write "<td class="""">" & depoTuru & "</td>"
				Response.Write "<td class="""">" & depoKategori & "</td>"
				Response.Write "<td class="""">" & malKabulizin & "</td>"
				Response.Write "<td class="""">" & depoEksiBakiye & "</td>"
				Response.Write "<td class="""">" & depoDurum & "</td>"
				Response.Write "<td class=""text-right"">"
					if ozelDepo = 1 then
						sorgu = "SELECT cariAd FROM cari.cari WHERE cariID = " & cariID
						rs2.Open sorgu, sbsv5, 1, 3
							cariAd	=	rs2("cariAd")
						rs2.close
						Response.Write "<div class=""badge badge-pill badge-primary mr-1 help"" onclick=""swal('','" & cariAd & "')"" title=""Cariye Özel Depo""><i class=""mdi mdi-crown""></i></div>"
					end if
					if yetkiKontrol > 2 then
						Response.Write "<div title=""" & translate("Personel Düzenle","","") & """ class=""badge badge-pill "
						Response.Write " badge-success"
						Response.Write """"
						Response.Write " onClick=""modalajax('/depo/depo_yeni.asp?gorevID=" & depoID64 & "')"">"
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