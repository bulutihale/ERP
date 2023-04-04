<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
	aramaad	=	Request.Form("aramaad")
	Response.Flush()
	call logla("Banka Listesi Ekranı")
	yetkiKontrol = yetkibul("Teklif")
'###### ANA TANIMLAMALAR



'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				'Response.Write "<div class=""row"">"
					Response.Write "<form action=""/banka/banka_liste.asp"" method=""post"" class=""ortaform"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""" & translate("Banka adı","","") & """ name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
							if yetkiKontrol >= 5 then
								Response.Write "<div class=""col-lg-9 col-sm-6 my-1 text-right"">"
									Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/banka/banka_yeni.asp')"">" & translate("Yeni Banka Ekle","","") & "</button>&nbsp;"
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
	end if
'###### ARAMA FORMU

 
'####### SONUÇ TABLOSU
	if hata = "" then
		if yetkiKontrol > 0 then
			Response.Write "<div class=""table-responsive"">"
				sorgu = "Select" & vbcrlf
				sorgu = sorgu & "portal.bankalar.*," & vbcrlf
				sorgu = sorgu & "(select Ad from portal.firma where Id = portal.bankalar.firmaID) as firmaAd" & vbcrlf
				sorgu = sorgu & "FROM portal.bankalar" & vbcrlf
				sorgu = sorgu & "WHERE silindi = 0" & vbcrlf
				sorgu = sorgu & "and firmaID in (select Id from portal.firma where portal.firma.anaFirmaID = " & firmaID & " OR portal.firma.Id = " & firmaID & ")" & vbcrlf
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
											Response.Write "<th scope=""col"">" & translate("Firma Adı","","") & "</th>"
											Response.Write "<th scope=""col"">" & translate("Hesap Adı","","") & "</th>"
											Response.Write "<th scope=""col"">" & translate("Banka Adı","","") & "</th>"
											Response.Write "<th scope=""col"">" & translate("Hesap Döviz Türü","","") & "</th>"
											Response.Write "<th scope=""col"">" & translate("Şube No","","") & "</th>"
											Response.Write "<th scope=""col"">" & translate("Şube Adı","","") & "</th>"
											Response.Write "<th scope=""col"">" & translate("Hesap No","","") & "</th>"
											Response.Write "<th scope=""col"">" & translate("IBAN","","") & "</th>"
											Response.Write "<th scope=""col"">" & translate("SWIFT Kodu","","") & "</th>"
											Response.Write "<th scope=""col"">&nbsp;</th>"
										Response.Write "</tr></thead>"
										for i = 1 to rs.recordcount
											firmaAd			=	rs("firmaAd")
											hesapAd			=	rs("hesapAd")
											bankaID			=	rs("bankalarID")
											bankaAd			=	rs("bankaAd")
											bankaID64	 	=	bankaID
											bankaID64		=	base64_encode_tr(bankaID64)
											subeAd			=	rs("subeAd")
											subeNo			=	rs("subeNo")
											hesapNo			=	rs("hesapNo")
											iban			=	rs("iban")
											paraBirim		=	rs("paraBirim")
											swiftKod		=	rs("swiftKod")
											Response.Write "<tr>"
												Response.Write "<td class="""">" & firmaAd & "</td>"
												Response.Write "<td class="""">" & hesapAd & "</td>"
												Response.Write "<td class="""">" & bankaAd & "</td>"
												Response.Write "<td class="""">" & paraBirim & "</td>"
												Response.Write "<td class="""">" & subeNo & "</td>"
												Response.Write "<td class="""">" & subeAd & "</td>"
												Response.Write "<td class="""">" & hesapNo & "</td>"
												Response.Write "<td class="""">" & iban & "</td>"
												Response.Write "<td class="""">" & swiftKod & "</td>"
												Response.Write "<td class=""text-right"">"
													if yetkiKontrol > 2 then
														Response.Write "<a title=""" & translate("Banka Düzenle","","") & """"
														Response.Write " onClick=""modalajax('/banka/banka_yeni.asp?gorevID=" & bankaID64 & "')"">"
														Response.Write "<i class=""icon page-white-edit parmak"
														Response.Write """></i>"
														Response.Write "</a>"
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
			hata = translate("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
			call yetkisizGiris("","","")
		end if
	end if
'####### SONUÇ TABLOSU





%><!--#include virtual="/reg/rs.asp" -->