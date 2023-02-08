<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    Response.Flush()
    gorevID = Request.QueryString("adresGrupID")
    islem = Request.QueryString("islem")
'###### ANA TANIMLAMALAR

call logla("Yeni Toplu Mail Adres Grubu Ekleme Ekranı")

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
        sorgu = "Select top 1 * from toplumail.adresGrup where firmaID = " & firmaID & " and adresGrupID = " & gorevID
        rs.open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            adresGrupAd         =   rs("adresGrupAd")
            adresGrupAciklama   =   rs("adresGrupAciklama")
        else
            hata = 1
        end if
        rs.close
    end if
end if


if yetkiTM >= 3 then
    if hata = "" then
		Response.Write "<form action=""/toplumail/adres_kaydet.asp"" method=""post"" class=""ajaxform"">"
        call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")
		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">Grup Adı</span>"
		    call forminput("adresGrupAd",adresGrupAd,"","","","autocompleteOFF","adresGrupAd","")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">Grup Açıklaması</span>"
		    call formtextarea("adresGrupAciklama",adresGrupAciklama,"","","","","adresGrupAciklama","")
		Response.Write "</div>"

		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
end if

%><!--#include virtual="/reg/rs.asp" -->