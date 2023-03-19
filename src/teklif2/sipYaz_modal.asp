<!--#include virtual="/reg/rs.asp" --><%

'	Response.Flush()
	kid						=	kidbul()
	ihaleID					=	Request.QueryString("ihaleID")
	iuID					=	Request.QueryString("iuID")
	call sessiontest()

    modulAd 		=   "Satış"
	yetkiKontrol	=	yetkibul(modulAd)


if yetkiKontrol > 0 then


sorgu = "SELECT t3.birimID, t3.uzunBirim, t1.miktar FROM dosya.ihale_urun t1"
sorgu = sorgu & " LEFT JOIN stok.stok t2 ON t1.stoklarID = t2.stokID"
sorgu = sorgu & " LEFT JOIN portal.birimler t3 ON t2.anaBirimID = t3.birimID"
sorgu = sorgu & " WHERE t1.id = " & iuID
rs.open sorgu,sbsv5,1,3
	birimID		=	rs("birimID")
	uzunBirim	=	rs("uzunBirim")
	miktar		=	rs("miktar")
rs.close

	if isnull(birimID) then
		Response.Write "<div class=""bold"">Ürüne ait ANA BİRİM seçili olmadığı için sipariş yazılamaz</div>"
	else

		Response.Write "<span class=""pointer"" data-dismiss=""modal"">&times;</span>"

		Response.Write "<form action=""/teklif2/sipYazKaydet.asp"" method=""post"" class=""ajaxform"">"
		Response.Write "<input type=""hidden"" name=""birimID"" value=""" & birimID & """ />"
		Response.Write "<input type=""hidden"" name=""iuID"" value=""" & iuID & """ />"

			Response.Write "<div class=""container-fluid row"">"
				Response.Write "<div class=""col-lg-12"">"
					Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Miktar</div>"
						Response.Write "<input style=""font-size:26px;"" class=""form-control bold"" name=""sipMiktar"" id=""sipMiktar"" value="""&miktar&""">"
					Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Birim</div>"
						Response.Write "<div class=""ml-5""><span style=""font-size:26px;"" class=""bold"">" & uzunBirim & "</span> (sipariş, ANA BİRİM cinsinden yazılmak zorundadır.)</div>"
				Response.Write "</div>"


				Response.Write "<div class=""col-lg-12"">"
				Response.Write "<button type=""submit"" class=""btn form-control btn-success"">Kaydet</button>"
					call clearfix()
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</form>"
	end if

	else
		call yetkisizGiris("","","")
	end if
%>

