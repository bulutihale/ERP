<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    teklifID	=	Request.QueryString("teklifID")
	modulAd 	=   "satis"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Satış teklifi ana veri düzenleme ekranı girişi")

yetkiKontrol = yetkibul(modulAd)


if teklifID <> "" then
            sorgu = "SELECT t1.teklifNo, t2.cariAd, t1.teklifTarih"
			sorgu = sorgu & " FROM teklif.teklif t1"
			sorgu = sorgu & " INNER JOIN cari.cari t2 ON t1.cariID = t2.cariID"
			sorgu = sorgu & " WHERE t1.teklifID = " & teklifID & ""
			rs.open sorgu, sbsv5, 1, 3
				teklifNo		=	rs("teklifNo")
				cariAd			=	rs("cariAd")
				teklifTarih		=	rs("teklifTarih")
            rs.close
			
			
end if


	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<form action=""/stok/stok_ekle.asp"" method=""post"" class=""ajaxform"">"

		Response.Write "<div class=""form-row align-items-center"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary"">Stok Kodu</span>"
				call forminput("stokKodu",stokKodu,"","","","readonly","stokKodu","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary"">Ürün Ad</span>"
				call forminput("stokAd",stokAd,"","","","readonly","stokAd","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary"">Stok Türü</span>"
				call formselectv2("stokTuru",int(stokTuru),"","","stokTuru","","stokTuru",stokTipDegerler,"")
			Response.Write "</div>"
			
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary"">Kullanım Dışı</span>"
				Response.Write "<input type=""checkbox"" name=""silindi"" value=""" & chck2Deger & """ class=""chck30 form-control"" "&chck2Durum&">"
			Response.Write "</div>"
			Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if






%><!--#include virtual="/reg/rs.asp" -->









