<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    Response.Flush()
    gorevID = Request.QueryString("sablonID")
    islem = Request.QueryString("islem")
'###### ANA TANIMLAMALAR

call logla("Yeni Toplu Mail Şablonu Ekleme Ekranı")

yetkiTM = yetkibul(modulAd)



'### SAYFA ID TESPİT ET
	if hata = "" then
		if gorevID <> "" then
			gorevID64   =   gorevID
			gorevID		=	base64_decode_tr(gorevID)
        end if
	end if
'### SAYFA ID TESPİT ET







if yetkiTM >= 3 then
    if gorevID <> "" then
        sorgu = "Select top 1 * from toplumail.sablon where firmaID = " & firmaID & " and sablonID = " & gorevID
        rs.open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            sablonBaslik    =   rs("sablonBaslik")
            sablonIcerik    =  rs("sablonIcerik")
        else
            hata = 1
        end if
        rs.close
    end if
end if


if yetkiTM >= 3 then
    if hata = "" then
		Response.Write "<form action=""/toplumail/sablon_kaydet.asp"" method=""post"" class=""ajaxform"" enctype=""multipart/form-data"">"
        call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")
		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">Başlık</span>"
		    call forminput("sablonBaslik",sablonBaslik,"","","","autocompleteOFF","sablonBaslik","")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">İçerik</span>"
            Response.Write "<textarea class=""summernote sablonIcerik"" name=""sablonIcerik"">" & sablonIcerik & "</textarea>"
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Ek Dosya","","") & "</span>"
        Response.Write "<div><input type=""file"" name=""resim1"" /></div>"
		Response.Write "</div>"

		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"" onClick=""$('.summernote').summernote('code');$('.summernote').summernote('destroy');"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
end if


%><!--#include virtual="/reg/rs.asp" -->