<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    modulID =   "137"
	aramaad	=	Request.Form("aramaad")
    Response.Flush()
'###### ANA TANIMLAMALAR
' |Toplu Mail#Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Gönderebilir=5,Silebilir=6


yetkiTM = yetkibul(modulAd)


'###### ARAMA FORMU
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-header text-white bg-warning"">Adres Arama : " & aramaad & "</div>"
                Response.Write "<div class=""card-body"">"
					Response.Write "<form action=""/toplumail/adres_karaliste.asp"" method=""post"" class=""ortaform"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
								Response.Write "<input type=""text"" class=""form-control"" placeholder=""Adres"" name=""aramaad"" value=""" & aramaad & """>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-1 my-1""><button type=""submit"" class=""btn btn-warning"">" & translate("ARA","","") & "</button></div>"
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




'####### TOPLU MAİL ADRESİ EKLEME
	if yetkiTM > 0 then
        if hata = "" then
            Response.Write "<form action=""/toplumail/adres_liste_ekle.asp"" method=""post"" class=""ajaxform"">"
            call forminput("islem","Ekle","","","islem","hidden","islem","")
            call forminput("altModul","Kara Liste","","","altModul","hidden","altModul","")
            call forminput("tur","email","","","tur","hidden","tur","")
            Response.Write "<div class=""container-fluid scroll-ekle3"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-primary"">Kara Listeye Adres Ekleme</div>"
                    Response.Write "<div class=""card-body"">"
                    Response.Write "<div class=""row"">"
                        Response.Write "<div class=""col-sm-12 my-1"">"
                        Response.Write "<span class=""badge badge-secondary"">Her satıra bir adres gelecek şekilde mail adreslerini buraya yapıştırın</span>"
                            call formtextarea("maillistesi",maillistesi,"","","","","maillistesi","")
                        Response.Write "</div>"
                        Response.Write "<div class=""col-auto my-1"">"
                            Response.Write "<button type=""submit"" class=""btn btn-primary"">Ekle</button>"
                            Response.Write "<div id=""progressDiv"" class=""ml-3""></div>"
                        Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</form>"
        end if
	end if
'####### TOPLU MAİL ADRESİ EKLEME







'####### ADRES LİSTESİ
	if yetkiTM > 0 then
        if hata = "" then
            Response.Write "<div class=""container-fluid scroll-ekle3"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-primary"">Kara Listede Bulunan Adresler (Kara listeye eklenen adresler silinemezler)</div>"
                    Response.Write "<div class=""card-body"">"
                    Response.Write "<div class=""row"">"
                        sorgu = "Select top 30 * from toplumail.blacklist where firmaID = " & firmaID
                        if aramaad = "" then
                        else
                            sorgu = sorgu & " and (adres like N'%" & aramaad & "%')" & vbcrlf
                        end if
                        sorgu = sorgu & "order by tarih desc"
                        rs.Open sorgu, sbsv5, 1, 3
                            if rs.recordcount > 0 then
                                Response.Write "<div class=""table-responsive"">"
                                Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
                                Response.Write "<th scope=""col"">Tarih</th>"
                                Response.Write "<th scope=""col"">Adres</th>"
                                Response.Write "<th scope=""col"">Tür</th>"
                                Response.Write "<th scope=""col"">Kaynak</th>"
                                ' if yetkiTM >= 3 then
                                '     Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
                                ' end if
                                Response.Write "</tr></thead><tbody>" 
                                    for i = 1 to rs.recordcount
                                        ' adresGrupID       =	rs("blacklistID")
                                        ' adresGrupID64     =   adresGrupID
                                        ' adresGrupID64     =   base64_encode_tr(adresGrupID64)
                                        tarih				=	rs("tarih")
                                        adres               =	rs("adres")
                                        kaynak              =	rs("kaynak")
                                        Response.Write "<tr>"
                                            Response.Write "<td>" & tarih & "</td>"
                                            Response.Write "<td>" & kvkkMaske(adres,2,yetkiTM) & "</td>"
                                            if instr(adres,"@") > 0 then
                                                tur = "Email"
                                            else
                                                tur = "SMS"
                                            end if
                                            Response.Write "<td>" & tur & "</td>"
                                            ' Response.Write "<td>" & adres & "</td>"
                                            Response.Write "<td>" & kaynak & "</td>"
                                        ' if yetkiTM >= 3 then
                                        '     Response.Write "<td class=""text-right"" nowrap>"
                                        '     if yetkiTM >= 5 then
                                        '         '# Adresleri İncele
                                        '             adresGrupID64 =	adresGrupID
                                        '             adresGrupID64 =	base64_encode_tr(adresGrupID64)
                                        '             Response.Write "<a href=""/toplumail/adres_liste/" & adresGrupID64 & """ title=""" & translate("Grup içindeki adresleri incele","","") & """ class=""ml-2"" >"
                                        '             Response.Write "<i class=""icon user-add"
                                        '             Response.Write """></i>"
                                        '             Response.Write "</a>"
                                        '         '# Adresleri İncele
                                        '     end if
                                        '     if yetkiTM >= 5 then
                                        '         '# Mail Gönder
                                        '             adresGrupID64 =	adresGrupID
                                        '             adresGrupID64 =	base64_encode_tr(adresGrupID64)
                                        '             Response.Write "<a href=""/toplumail/gonder/|" & adresGrupID64 & "|"" title=""" & translate("Mail Gönder","","") & """ class=""ml-2"" >"
                                        '             Response.Write "<i class=""icon email-go"
                                        '             Response.Write """></i>"
                                        '             Response.Write "</a>"
                                        '         '# Mail Gönder
                                        '     end if
                                        '     if yetkiTM >= 3 then
                                        '         '# Şablon düzenle
                                        '             adresGrupID64 =	adresGrupID
                                        '             adresGrupID64 =	base64_encode_tr(adresGrupID64)
                                        '             Response.Write "<a onClick=""modalajax('/toplumail/adres_yeni.asp?adresGrupID=" & adresGrupID64 & "')"" title=""" & translate("Adres Grubunu Düzenle","","") & """ class=""ml-2"" >"
                                        '             Response.Write "<i class=""icon page-white-edit"
                                        '             Response.Write """></i>"
                                        '             Response.Write "</a>"
                                        '         '# Şablon düzenle
                                        '     end if
                                        '     if yetkiTM >= 6 then
                                        '         '# Şablon sil
                                        '             adresGrupID64 =	adresGrupID
                                        '             adresGrupID64 =	base64_encode_tr(adresGrupID64)
                                        '             Response.Write "<a onClick="""
                                        '             Response.Write "bootmodal('Adres Grubunu Silmek Mi İstiyorsunuz?','custom','/toplumail/adres_onay.asp?islem=sil&adresGrupID=" & adresGrupID64 & "','','Sil','Silme','btn-danger','btn-success','','ajax','3000','','');"
                                        '             Response.Write """ title=""" & translate("Adres Grubunu Sil","","") & """ class=""ml-1"" >"
                                        '             Response.Write "<i class=""icon delete"
                                        '             Response.Write """></i>"
                                        '             Response.Write "</a>"
                                        '         '# Şablon sil
                                        '     end if
                                        '     Response.Write "</td>"
                                        ' end if
                                        Response.Write "</tr>"
                                        Response.Flush()
                                    rs.movenext
                                    next
                                Response.Write "</tbody>"
                                Response.Write "</table>"
                                Response.Write "</div>"
                            else
                                call yetkisizGiris("Kara listeye eklenmiş adres bulunamadı","","")
                            end if
                        rs.close
                    Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"
        else
            call yetkisizGiris("Kara listeyi görmek için yeterli yetkiniz bulunmamaktadır","","")
        end if
	end if
'####### ADRES LİSTESİ









'##### yetkisi olmayan için kelimeyi maskeler
'##### yetkisi olmayan için kelimeyi maskeler
'## call kvkkMaske("deneme",2,4)
	' function kvkkMaske(byVal kelime,byVal minYetki,byVal mevcutYetki)
	' 	if kelime <> "" then
	' 		if mevcutYetki >= minYetki then
	' 			'göster
	' 			kvkkMaske = kelime
	' 		else
	' 			'gizle
	' 			kvkkMaske = left(kelime,2)
	' 			for fnki = 1 to len(kelime)
	' 				kvkkMaske = kvkkMaske & "*"
	' 			next
	' 			kvkkMaske = kvkkMaske & right(kelime,2)
	' 		end if
	' 	else
	' 		kvkkMaske = ""
	' 	end if
	' end function
'##### yetkisi olmayan için kelimeyi maskeler
'##### yetkisi olmayan için kelimeyi maskeler


%><!--#include virtual="/reg/rs.asp" -->