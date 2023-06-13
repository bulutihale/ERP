<!--#include virtual="/reg/rs.asp" --><%

'	Response.Flush()
	kid						=	kidbul()
	ihaleID					=	Request.QueryString("ihaleID")
	iuID					=	Request.QueryString("iuID")
	call sessiontest()

    modulAd 		=   "Satış"
	yetkiKontrol	=	yetkibul(modulAd)


if yetkiKontrol > 0 then

sorgu = "SELECT cariID, yeniCariAd, yeniCariVergiNo FROM teklifv2.ihale WHERE id = " & ihaleID
rs.open sorgu,sbsv5,1,3
	cariID			=	rs("cariID")
	yeniCariAd		=	rs("yeniCariAd")
	yeniCariVergiNo	=	rs("yeniCariVergiNo")
rs.close


if isnull(cariID) then
	Response.Write "<div class=""bold"">Cari kayıtlı değil, Cari için yeni kayıt açılıyor...</div>"
	'######## sipariş oluşturulacak cari için cari tablosunda yeni kayıt
	sorgu = "SELECT [portal].[FN_yeniCariAc] ("&firmaID&") as yenicariKod"
	rs.open sorgu,sbsv5,1,3
		yenicariKod		=	rs("yenicariKod")
	rs.close

		sorgu = "SELECT * FROM cari.cari"
		rs.open sorgu,sbsv5,1,3
		rs.addnew
			rs("firmaID")		=	firmaID
			rs("manuelKayit")	=	1
			rs("cariKodu")		=	yenicariKod
			rs("cariAd")		=	yeniCariAd
			rs("vergiNo")		=	yeniCariVergiNo
		rs.update
			yenicariID			=	rs("cariID")
		rs.close
	'######## /sipariş oluşturulacak cari için cari tablosunda yeni kayıt

	'####### teklifv2.ihale tablosunda cariID alanına yeni cariID yi kaydet
		sorgu = "UPDATE teklifv2.ihale SET cariID = " & yenicariID & " WHERE id = " & ihaleID
		rs.open sorgu,sbsv5,3,3
	'####### teklifv2.ihale tablosunda cariID alanına yeni cariID yi kaydet

	Response.Write "<div class=""bold"">Yeni cari kaydı oluşturuldu, sipariş işlemini tekrarlayınız.</div>"
else
		sorgu = "SELECT t3.birimID, t3.uzunBirim, t1.miktar FROM teklifv2.ihale_urun t1"
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
		call logla("Teklif kaleminden sipariş Temp kaydı açılacak.iuID:"&iuID&"")
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
						Response.Write "<button type=""submit"" class=""btn form-control btn-success"" >Kaydet</button>"
							call clearfix()
						Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</form>"
			end if
end if
		else
			call yetkisizGiris("","","")
		end if
%>

