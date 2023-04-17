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


call logla("Toplu Mail Şablon Listesi Ekranı")


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
					Response.Write "<form action=""/toplumail/sablon.asp"" method=""post"" class=""ortaform"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""Şablon adı"" name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
							if yetkiTM >= 3 then
								Response.Write "<div class=""col-lg-9 col-sm-3 my-1 text-right"">"
									Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/toplumail/sablon_yeni.asp?tur=mail')"">" & translate("Yeni Mail Şablonu Ekle","","") & "</button>&nbsp;" 
									Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/toplumail/sablon_yeni.asp?tur=sms')"">" & translate("Yeni SMS Şablonu Ekle","","") & "</button>&nbsp;" 
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
					sorgu = "Select top 30 sablonID,tarih,sablonBaslik,beklemedeSayisi,gonderildiSayisi" & vbcrlf
					sorgu = sorgu & ",(select count(gonderimID) from toplumail.gonderim where sablonID = toplumail.sablon.sablonID and durum = 'Beklemede') as Beklemede" & vbcrlf
					sorgu = sorgu & ",(select count(gonderimID) from toplumail.gonderim where sablonID = toplumail.sablon.sablonID and durum = 'Gönderildi') as Gonderildi" & vbcrlf
					sorgu = sorgu & "from toplumail.sablon where firmaID = " & firmaID & " and silindi = 0" & vbcrlf
					if aramaad = "" then
					else
						sorgu = sorgu & " and (sablonBaslik like N'%" & aramaad & "%')" & vbcrlf
					end if
					sorgu = sorgu & "order by tarih desc"
					rs.Open sorgu, sbsv5, 1, 3
						if rs.recordcount > 0 then
							Response.Write "<div class=""table-responsive"">"
							Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
							Response.Write "<th scope=""col"">Tarih</th>"
							Response.Write "<th scope=""col"">Başlık</th>"
							Response.Write "<th scope=""col"">Beklemede</th>"
							Response.Write "<th scope=""col"">Gönderildi</th>"
							if yetkiTM >= 3 then
								Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
							end if
							Response.Write "</tr></thead><tbody>" 
								for i = 1 to rs.recordcount
									sablonID			=	rs("sablonID")
									tarih				=	rs("tarih")
									sablonBaslik		=	rs("sablonBaslik")
									Beklemede			=	rs("Beklemede")
									Gonderildi			=	rs("Gonderildi")
									if Beklemede > 0 or Gonderildi > 0 then
										rs("beklemedeSayisi")	=	Beklemede
										rs("gonderildiSayisi")	=	Gonderildi
										rs.update
									end if
									sablonID64          =   sablonID
									sablonID64          =   base64_encode_tr(sablonID64)
									gonderimSayi		=	0
									gonderilenSayi		=	0
									kalanSayi			=	0
									Response.Write "<tr>"
										Response.Write "<td>" & tarih & "</td>"
										Response.Write "<td>" & sablonBaslik & "</td>"
										Response.Write "<td"
										if Beklemede > 0 then
											Response.Write " class=""bg-warning"""
										end if
										Response.Write ">" & Beklemede &  "</td>"
										Response.Write "<td>" & Gonderildi &  "</td>"
									if yetkiTM >= 3 then
										Response.Write "<td class=""text-right"" nowrap>"
										if yetkiTM >= 5 then
											'# Mail Gönder
												sablonID64 =	sablonID
												sablonID64 =	base64_encode_tr(sablonID64)
												Response.Write "<a href=""/toplumail/gonder/" & sablonID64 & "$"" title=""" & translate("Mail Gönder","","") & """ class=""ml-2"" >"
												Response.Write "<i class=""icon email-go"
												Response.Write """></i>"
												Response.Write "</a>"
											'# Mail Gönder
										end if
										if yetkiTM >= 3 then
											'# Şablon düzenle
												sablonID64 =	sablonID
												sablonID64 =	base64_encode_tr(sablonID64)
												Response.Write "<a onClick=""modalajaxfit('/toplumail/sablon_yeni.asp?sablonID=" & sablonID64 & "')"" title=""" & translate("Şablonu Düzenle","","") & """ class=""ml-2"" >"
												Response.Write "<i class=""icon page-white-edit"
												Response.Write """></i>"
												Response.Write "</a>"
											'# Şablon düzenle
										end if
										if yetkiTM >= 6 then
											'# Şablon sil
												sablonID64 =	sablonID
												sablonID64 =	base64_encode_tr(sablonID64)
												Response.Write "<a onClick="""
												Response.Write "bootmodal('Şablonu Silmek Mi İstiyorsunuz?','custom','/toplumail/sablon_onay.asp?islem=sil&sablonID=" & sablonID64 & "','','Sil','Silme','btn-danger','btn-success','','ajax','3000','','');"
												Response.Write """ title=""" & translate("Şablonu Sil","","") & """ class=""ml-1"" >"
												Response.Write "<i class=""icon delete"
												Response.Write """></i>"
												Response.Write "</a>"
											'# Şablon sil
										end if
										Response.Write "</td>"
									end if
									Response.Write "</tr>"
									Response.Flush()
								rs.movenext
								next
							Response.Write "</tbody>"
							Response.Write "</table>"
							Response.Write "</div>"
						else
							call yetkisizGiris("Şablon Bulunamadı","","")
						end if
					rs.close
				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	else
		call yetkisizGiris("Şablonları görmek için yeterli yetkiniz bulunmamaktadır","","")
	end if


%><!--#include virtual="/reg/rs.asp" -->