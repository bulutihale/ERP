<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
	aramaad	=	Request.Form("aramaad")
    Response.Flush()
'###### ANA TANIMLAMALAR
' |Toplu Mail#Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6


yetkiTM = yetkibul(modulAd)


call logla("Toplu mail değişken listesi ekranı")


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
					Response.Write "<form action=""/toplumail/degisken.asp"" method=""post"" class=""ortaform"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""Şablon adı"" name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
							if yetkiTM >= 3 then
								Response.Write "<div class=""col-lg-9 col-sm-3 my-1 text-right"">"
									Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/toplumail/degisken_yeni.asp')"">Yeni Değişken Ekle</button>&nbsp;" 
								Response.Write "</div>"
							end if
						Response.Write "</div>"
					Response.Write "</form>"
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

	if yetkiTM > 0 then
		Response.Write "<div class=""container-fluid scroll-ekle3"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
					sorgu = "Select top 30 * from toplumail.degisken where firmaID = " & firmaID & " and silindi = 0"
					if aramaad = "" then
					else
						sorgu = sorgu & " and (kaynak like N'%" & aramaad & "%')" & vbcrlf
					end if
					sorgu = sorgu & "order by tarih desc"
					rs.Open sorgu, sbsv5, 1, 3
						if rs.recordcount > 0 then
							Response.Write "<div class=""table-responsive"">"
							Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
							Response.Write "<th scope=""col"">Tarih</th>"
							Response.Write "<th scope=""col"">Kaynak</th>"
							Response.Write "<th scope=""col"">Hedef</th>"
							if yetkiTM >= 3 then
								Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
							end if
							Response.Write "</tr></thead><tbody>" 
								for i = 1 to rs.recordcount
									sablonID			=	rs("degiskenID")
									tarih				=	rs("tarih")
									kaynak		        =	rs("kaynak")
									hedef		        =  	rs("hedef")
									sablonID64          =   sablonID
									sablonID64          =   base64_encode_tr(sablonID64)
									Response.Write "<tr>"
										Response.Write "<td>" & tarih & "</td>"
										Response.Write "<td>" & kaynak & "</td>"
										Response.Write "<td>" & hedef &  "</td>"
									' if yetkiTM >= 3 then
									' 	Response.Write "<td class=""text-right"" nowrap>"
									' 	if yetkiTM >= 5 then
									' 		'# Mail Gönder
									' 			sablonID64 =	sablonID
									' 			sablonID64 =	base64_encode_tr(sablonID64)
									' 			Response.Write "<a href=""/toplumail/gonder/" & sablonID64 & "$"" title=""" & translate("Mail Gönder","","") & """ class=""ml-2"" >"
									' 			Response.Write "<i class=""icon email-go"
									' 			Response.Write """></i>"
									' 			Response.Write "</a>"
									' 		'# Mail Gönder
									' 	end if
									' 	if yetkiTM >= 3 then
									' 		'# Şablon düzenle
									' 			sablonID64 =	sablonID
									' 			sablonID64 =	base64_encode_tr(sablonID64)
									' 			Response.Write "<a onClick=""modalajax('/toplumail/sablon_yeni.asp?sablonID=" & sablonID64 & "')"" title=""" & translate("Şablonu Düzenle","","") & """ class=""ml-2"" >"
									' 			Response.Write "<i class=""icon page-white-edit"
									' 			Response.Write """></i>"
									' 			Response.Write "</a>"
									' 		'# Şablon düzenle
									' 	end if
									' 	if yetkiTM >= 6 then
									' 		'# Şablon sil
									' 			sablonID64 =	sablonID
									' 			sablonID64 =	base64_encode_tr(sablonID64)
									' 			Response.Write "<a onClick="""
									' 			Response.Write "bootmodal('Şablonu Silmek Mi İstiyorsunuz?','custom','/toplumail/sablon_onay.asp?islem=sil&sablonID=" & sablonID64 & "','','Sil','Silme','btn-danger','btn-success','','ajax','3000','','');"
									' 			Response.Write """ title=""" & translate("Şablonu Sil","","") & """ class=""ml-1"" >"
									' 			Response.Write "<i class=""icon delete"
									' 			Response.Write """></i>"
									' 			Response.Write "</a>"
									' 		'# Şablon sil
									' 	end if
									' 	Response.Write "</td>"
									' end if
									Response.Write "</tr>"
									Response.Flush()
								rs.movenext
								next
							Response.Write "</tbody>"
							Response.Write "</table>"
							Response.Write "</div>"
						else
							call yetkisizGiris("Değişken Bulunamadı","","")
						end if
					rs.close
				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	else
		call yetkisizGiris("Değişkenleri görmek için yeterli yetkiniz bulunmamaktadır","","")
	end if


%><!--#include virtual="/reg/rs.asp" -->