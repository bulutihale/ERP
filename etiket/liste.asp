<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    aramaad =   Request.Form("aramaad")
    hata    =   ""
    modulAd =   "Etiket"
    hastaID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Etiket Listesi Ekranı")

yetkiEtiket = yetkibul("Etiket")

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and opener = "" and yetkiEtiket > 0 then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
		Response.Write "<form action=""/etiket/liste.asp"" method=""post"" class=""ortaform"">"
		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-9 my-1"">"
		Response.Write "<input type=""text"" autocomplete=""off"" class=""form-control"" placeholder=""" & translate("Stok Kodu - Stok Adı","","") & """ name=""aramaad"" value=""" & aramaad & """>"
		Response.Write "</div>"
		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"

        if yetkiEtiket >= 6 then
            Response.Write "<div class=""col-sm-3 my-1""><button type=""button"" class=""btn btn-danger"" onClick=""modalajax('/etiket/etiket_yeni.asp')"">" & translate("YENİ ETİKET","","") & "</a></div>"
        end if

		Response.Write "</div>"
		Response.Write "</form>"
				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU



'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" and yetkiEtiket > 0 then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">" & translate("Stok Kodu","","") & "</th>"
		Response.Write "<th scope=""col"" class="""">" & translate("Revizyon","","") & "</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Stok Adı","","") & "</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Mamül Adı","","") & "</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Etiket Dili","","") & "</th>"
		' Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Menşei","","") & "</th>"
		' Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Grubu","","") & "</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Ölçü","","") & "</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Durum","","") & "</th>"
		' Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Son Güncelleme","","") & "</th>"

		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">&nbsp;</th>"
		Response.Write "</tr></thead><tbody>"
            sorgu = "Select" & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.etiketID," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.stokKodu," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.stokAdi," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.mamulAdi," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.dil," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.mensei," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.grubu," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.olcu," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.pantoneKodu," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.aciklama," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.revizyon," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.tarih," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.dosyaSayi," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.durum" & vbcrlf
			sorgu = sorgu & "from agrobest.etiket" & vbcrlf
			sorgu = sorgu & "where agrobest.etiket.sonRevizyon = 'True' and (agrobest.etiket.durum <> N'SİLİNDİ' or agrobest.etiket.durum is null)" & vbcrlf
			if aramaad = "" then
			else
                sorgu = sorgu & " and ( agrobest.etiket.stokKodu like '%" & aramaad & "%'" & vbcrlf
				sorgu = sorgu & " or agrobest.etiket.stokAdi like N'%" & aramaad & "%')" & vbcrlf
			end if
			sorgu = sorgu & " order by agrobest.etiket.stokAdi ASC" & vbcrlf
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					etiketID	=	rs("etiketID")
					Response.Write "<tr>"
					Response.Write "<td>"
                    Response.Write rs("stokKodu")
					Response.Write "</td>"
					Response.Write "<td class=""d-sm-none"">"
                    Response.Write rs("revizyon")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("stokAdi")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("mamulAdi")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("dil")
					Response.Write "</td>"
                    ' Response.Write "<td>"
                    ' Response.Write rs("mensei")
					' Response.Write "</td>"
                    ' Response.Write "<td>"
                    ' Response.Write rs("grubu")
					' Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("olcu")
					Response.Write "</td>"
                    Response.Write "<td"
                    if rs("durum") = "BASILABILIR" then
                        Response.Write " class=""table-success"""
                    elseif rs("durum") = "DURDURULDU" then
                        Response.Write " class=""table-warning"""
                    end if
                    Response.Write " title=""" & rs("aciklama") & """"
                    Response.Write ">"
                    Response.Write rs("durum")
					Response.Write "</td>"
                    ' Response.Write "<td>"
                    ' Response.Write rs("tarih")
					' Response.Write "</td>"
					Response.Write "<td class=""text-right"">"
					if yetkiEtiket >= 6 then
						'# UPLOAD
						'# UPLOAD
						Response.Write "&nbsp;<div title=""" & translate("Dosya Yükleme","","") & """ class=""badge badge-pill "
						if rs("dosyaSayi") = 0 then
							Response.Write " badge-danger"
						else
							Response.Write " badge-success"
						end if
						Response.Write """ onClick=""modalajax('/dosya/yukle1.asp?modul=ZXRpa2V0&gorevID=" & etiketID & "');"">"
							Response.Write rs("dosyaSayi")
							Response.Write "&nbsp;"
						Response.Write "<i class=""mdi mdi-folder-upload"
						Response.Write """></i></div>"
						'# UPLOAD
						'# UPLOAD
					end if
					if yetkiEtiket = 1 or yetkiEtiket >= 5 then
						'# DOSYALAR
						'# DOSYALAR
						Response.Write "&nbsp;<div title=""" & translate("Dosya Ayrıntıları","","") & """ class=""badge badge-pill "
						if rs("dosyaSayi") = 0 then
							Response.Write " badge-danger"
						else
							Response.Write " badge-success"
						end if
						Response.Write """ onClick=""modalajax('/etiket/etiket_ayrinti.asp?modul=ZXRpa2V0&gorevID=" & etiketID & "');"">"
							Response.Write rs("dosyaSayi")
							Response.Write "&nbsp;"
						Response.Write "<i class=""mdi mdi-file-image"
						Response.Write """></i></div>"
						'# DOSYALAR
						'# DOSYALAR
					end if
					if yetkiEtiket = 1 or yetkiEtiket >= 5 then
						'# AYRINTILAR
						'# AYRINTILAR
						Response.Write "&nbsp;<div title=""" & translate("Etiket Ayrıntıları","","") & """ class=""badge badge-pill "
						if rs("durum") = "BASILABILIR" then
							Response.Write " badge-success"
						else
							Response.Write " badge-danger"
						end if
						Response.Write """ onClick=""modalajax('/etiket/etiket_yeni.asp?gorevID=" & etiketID & "');"">"
						Response.Write "<i class=""mdi mdi-label"
						Response.Write """></i></div>"
						'# AYRINTILAR
						'# AYRINTILAR
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