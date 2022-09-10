<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    ID			=	Request.QueryString("ID")
    kid64		=	ID
    opener  	=   Request.Form("opener")
    gorevID 	=   Request.QueryString("gorevID")
	gorevID64	=	gorevID
	gorevID		=	base64_decode_tr(gorevID64)
	modulAd 	=   "cari"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Cari Düzenleme Ekranı Girişi")

yetkiKontrol = yetkibul(modulAd)


if gorevID <> "" then
            sorgu = "Select top 1 * from cari.cari where firmaID = " & firmaID & " AND cariID = " & gorevID
			rs.open sorgu, sbsv5, 1, 3
				cariKodu		=	rs("cariKodu")
				cariAd			=	rs("cariAd")
				silindi			=	rs("silindi")
            rs.close
			
			
			
end if


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<form action=""/cari/cari_ekle.asp"" method=""post"" class=""ajaxform"">"

		Response.Write "<div class=""form-row align-items-center"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary"">Cari Kodu</span>"
				call forminput("cariKodu",cariKodu,"","","","readonly","cariKodu","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary"">Cari Ad</span>"
				call forminput("cariAd",cariAd,"","","","readonly","cariAd","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary"">Kullanım Dışı</span>"
				call formselectv2("silindi",int(silindi),"","","silindi","","silindi",HEDegerler,"")
			Response.Write "</div>"
			Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%><!--#include virtual="/reg/rs.asp" -->





