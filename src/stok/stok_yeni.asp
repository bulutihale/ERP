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
	modulAd 	=   "stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Stok Düzenleme Ekranı Girişi")

yetkiKontrol 	=	yetkibul(modulAd)
inpKontrol		=	""


if gorevID <> "" then

            sorgu = "Select top 1 * from stok.stok where firmaID = " & firmaID & " AND stokID = " & gorevID
			rs.open sorgu, sbsv5, 1, 3
				stokKodu		=	rs("stokKodu")
				stokAd			=	rs("stokAd")
				stokTuru		=	rs("stokTuru")
				stokBarcode		=	rs("stokBarcode")
				kkDepoGiris		=	rs("kkDepoGiris")
				silindi			=	rs("silindi")
            rs.close
			
			inpKontrol	=	"readonly"
end if


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<form action=""/stok/stok_ekle.asp"" method=""post"" class=""ajaxform"">"

		Response.Write "<div class=""form-row align-items-left"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary"">Stok Kodu</span>"
				call forminput("stokKodu",stokKodu,"","","",inpKontrol,"stokKodu","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary"">Ürün Ad</span>"
				call forminput("stokAd",stokAd,"","","",inpKontrol,"stokAd","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary"">Stok Türü</span>"
				call formselectv2("stokTuru",int(stokTuru),"","","stokTuru","","stokTuru",stokTipDegerler,"")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary"">Mal Kabulde İlk Giriş Kalite Kontrol Depoya</span>"
				call formselectv2("kkDepoGiris",kkDepoGiris,"","","kkDepoGiris","","kkDepoGiris",HEDegerler,"")
			Response.Write "</div>"
		if yetkiKontrol >= 8 then
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary"">Kullanım Dışı</span>"
				call formselectv2("silindi",silindi,"","","silindi","","silindi",HEDegerler,"")
			Response.Write "</div>"
		end if
			Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%><!--#include virtual="/reg/rs.asp" -->









