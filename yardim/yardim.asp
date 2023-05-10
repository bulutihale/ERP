<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Yardım"
    Response.Flush()
    yardimYetki = yetkibul("Yardım")
'###### ANA TANIMLAMALAR


'### SAYFA ID TESPİT ET
if adresGrupID64 = "" then
	if hata = "" then
		if gorevID = "" then
			gorevID64 = Session("sayfa5")

			if gorevID64 = "" then
			else
				gorevID		=	gorevID64
				gorevID		=	base64_decode_tr(gorevID)
			end if
		else
			if isnumeric(gorevID) = False then
				gorevID		=	base64_decode_tr(gorevID)
			end if
			gorevID		=	int(gorevID)
			gorevID64	=	gorevID
			gorevID64	=	base64_encode_tr(gorevID64)
		end if
	end if
else
    adresGrupID = adresGrupID64
    adresGrupID = base64_decode_tr(adresGrupID)
    gorevID = adresGrupID
end if
'### SAYFA ID TESPİT ET


if gorevID = "" then
    hata = "İçeriğe ulaşılamıyor"
end if



'###### ARAMA FORMU
	if hata = "" then
		sorgu = "Select top 1 * from portal.yardim where yardimID = " & gorevID & " and silindi = 0 order by yardimID DESC"
		rs.Open sorgu, sbsv5, 1, 3
		if rs.recordcount > 0 then
			konu            =   rs("konu")
			icerik          =   rs("icerik")
			sonGuncelleme   =   rs("sonGuncelleme")
		end if
		rs.close

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-header text-white bg-primary"">"
                Response.Write "<div class=""row"">"
                    Response.Write "<div class=""col-lg-5"">Yardım Konusu : " & konu & "</div>"
                    Response.Write "<div class=""col-lg text-right"">Son Güncelleme : " & sonGuncelleme & "</div>"
                Response.Write "</div>"
                Response.Write "</div>"
                Response.Write "<div class=""card-body"">"
                if yardimYetki >= 6 then
                    Response.Write "<form action=""/yardim/yardim_kaydet.asp"" method=""post"" class=""ajaxform"">"
                        call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")
                        Response.Write "<div class=""form-row align-items-center"">"
                            Response.Write "<div class=""col-sm-12 my-1"">"
                                Response.Write "<span class=""badge badge-secondary"">" & translate("İçerik","","") & "</span>"
                                call clearfix()
                                Response.Write "<textarea class=""summernote icerik"" name=""icerik"">" & icerik & "</textarea>"
                            Response.Write "</div>"
                            Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"" onClick=""$('.summernote').summernote('code');$('.summernote').summernote('destroy');"">" & translate("Kaydet","","") & "</button></div>"
                        Response.Write "</div>"
                    Response.Write "</form>"
                else
                    Response.Write icerik
                end if
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



%><!--#include virtual="/reg/rs.asp" -->