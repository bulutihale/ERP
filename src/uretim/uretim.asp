<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
	sipKalemID64	=	Session("sayfa5")
	sipKalemID		=	sipKalemID64
	sipKalemID		=	base64_decode_tr(sipKalemID)

	modulAd =   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Üretim Kontrolü Ekranı")


yetkiKontrol = yetkibul(modulAd)


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then

	sorgu = "SELECT t4.cariID, t3.stokID, t4.cariAd, t3.stokKodu, t3.stokAd, t1.miktar, t1.mikBirim"
	sorgu = sorgu & " FROM teklif.siparisKalem t1"
	sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
	sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
	sorgu = sorgu & " INNER JOIN cari.cari t4 ON t2.cariID = t4.cariID"
	sorgu = sorgu & " WHERE t1.id = " & sipKalemID
	rs.Open sorgu, sbsv5, 1, 3
		cariID		=	rs("cariID")
		cariAd		=	rs("cariAd")
		stokID		=	rs("stokID")
		stokKodu	=	rs("stokKodu")
		stokAd		=	rs("stokAd")
		miktar		=	rs("miktar")
		mikBirim	=	rs("mikBirim")
	rs.close

		Response.Write "<div class=""card"">"
			Response.Write "<div class=""card-header text-white bg-info"">Üretim Süreci</div>"
			Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-lg-2 col-sm-6 bold"">Sipariş Veren</div>"
					Response.Write "<div class=""col-lg-10 col-sm-6"">" & cariAd & "</div>"
				Response.Write "</div>"
				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-lg-2 col-sm-6 bold"">Stok Kodu</div>"
					Response.Write "<div class=""col-lg-10 col-sm-6"">" & stokKodu & "</div>"
				Response.Write "</div>"
				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-lg-2 col-sm-6 bold"">Ürün</div>"
					Response.Write "<div class=""col-lg-10 col-sm-6"">" & stokAd & "</div>"
				Response.Write "</div>"
				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-lg-2 col-sm-6 bold"">Miktar</div>"
					Response.Write "<div class=""col-lg-10 col-sm-6"">" & Miktar & " " & mikBirim & "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


    














%>