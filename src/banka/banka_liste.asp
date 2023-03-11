<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
	aramaad	=	Request.Form("aramaad")
    opener  =   Request.QueryString("opener")
	modulAd =   "Teklif"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Banka Listesi Ekranı")


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
					Response.Write "<form action=""/banka/banka_liste.asp"" method=""post"" class=""ortaform"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""Banka adı"" name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
							if yetkiKontrol >= 5 then
								Response.Write "<div class=""col-lg-9 col-sm-6 my-1 text-right"">"
									Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/banka/banka_yeni.asp')"">YENİ BANKA EKLE</button>&nbsp;"
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
		
		
            sorgu = "Select t1.bankalarID, t1.bankaAd, t1.paraBirim, t1.subeAd, t1.subeNo, t1.hesapNo, t1.iban, t1.silindi, t2.kisaBirim as dovizTuru, t1.swiftKod"
			sorgu = sorgu & " FROM portal.bankalar t1"
			sorgu = sorgu & " INNER JOIN portal.birimler t2 ON t1.paraBirim = t2.kisaBirim AND t2.birimTur = 'para'"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID
			sorgu = sorgu & " order by t1.bankaAd ASC"
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
					Response.Write "<th scope=""col"">Banka Adı</th>"
					Response.Write "<th scope=""col"">Döviz Türü</th>"
					Response.Write "<th scope=""col"">Şube Kodu</th>"
					Response.Write "<th scope=""col"">Şube Adı</th>"
					Response.Write "<th scope=""col"">Hesap No</th>"
					Response.Write "<th scope=""col"">IBAN</th>"
					Response.Write "<th scope=""col"">swiftKod</th>"

					
			Response.Write "</tr></thead>"
			
					
					for i = 1 to rs.recordcount
					
					bankaID			=	rs("bankalarID")
					bankaAd			=	rs("bankaAd")
					bankaID64	 	=	bankaID
					bankaID64		=	base64_encode_tr(bankaID64)
					subeAd			=	rs("subeAd")
					subeNo			=	rs("subeNo")
					hesapNo			=	rs("hesapNo")
					iban			=	rs("iban")
					dovizTuru		=	rs("dovizTuru")
					swiftKod		=	rs("swiftKod")
					
			Response.Write "<tr>"
				Response.Write "<td class="""">" & bankaAd & "</td>"
				Response.Write "<td class="""">" & dovizTuru & "</td>"
				Response.Write "<td class="""">" & subeNo & "</td>"
				Response.Write "<td class="""">" & subeAd & "</td>"
				Response.Write "<td class="""">" & hesapNo & "</td>"
				Response.Write "<td class="""">" & iban & "</td>"
				Response.Write "<td class="""">" & swiftKod & "</td>"
				Response.Write "<td class=""text-right"">"
					if yetkiKontrol > 2 then
						Response.Write "<div title=""" & translate("Banka Düzenle","","") & """ class=""badge badge-pill "
						Response.Write " badge-success"
						Response.Write """"
						Response.Write " onClick=""modalajax('/banka/banka_yeni.asp?gorevID=" & bankaID64 & "')"">"
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