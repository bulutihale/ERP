<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
	'ID			=	Request.QueryString("ID")
	'kid64		=	ID
	'opener  	=   Request.Form("opener")
    hata    	=   ""
    modulAd 	=   "Sterilizasyon"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Sterilizasyon Listesi Ekranı") 

yetkiKontrol = yetkibul(modulAd)

	depoKategori	=	"surecSterilizasyon"
	baslik			=	"<span class=""h2 text-danger bold"">Sterilizasyon Sürecine Girecek Ürünler Listesi</span>"
	class1			=	" border border-danger "

'###### ARAMA FORMU
'###### ARAMA FORMU
	if yetkiKontrol > 0 then

		
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card bg-light"">"
                Response.Write "<div class=""card-body"">"
				'Response.Write "<div class=""row"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 my-1 text-left"">"
								'Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/stok/stok_yeni.asp')"">BUTON</button>&nbsp;" 
								Response.Write baslik
							Response.Write "</div>"
						Response.Write "</div>"
				'Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		
	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" and yetkiKontrol > 0 then

	sorgu = "SELECT id FROM stok.depo WHERE depoKategori = '" & depoKategori & "'"
	rs.open sorgu,sbsv5,1,3
		bekleyenUrunDepoID	=	rs("id")
	rs.close
		
			sorgu = "SELECT t1.stokHareketID, t1.miktar, t1.koliSayi, stok.FN_koliHacimHesapla(t1.koliIndexID,'m3') as hacimLt,"
			sorgu = sorgu & " t3.stokKodu, t1.stokID, t3.stokAd, t1.lot, stok.FN_anaBirimADBul(t1.stokID, 'kAd') as kisaBirim,"
			sorgu = sorgu & " portal.FN_sipariscariAdbul("&firmaID&", t1.ajandaID) as siparisCariAd, t1.sterilCevrimID, t4.techizatID"
			sorgu = sorgu & " FROM stok.stokHareket t1"
			sorgu = sorgu & " INNER JOIN stok.depo t2 ON t1.depoID = t2.id"
			sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
			sorgu = sorgu & " LEFT JOIN stok.sterilCevrim t4 ON t1.sterilCevrimID = t4.sterilCevrimID"
			sorgu = sorgu & " WHERE t2.depoKategori = '" & depoKategori & "' AND t1.silindi = 0"
			sorgu = sorgu & " AND stok.FN_stokSayDepoLot("&firmaID&", t1.stokID, " & bekleyenUrunDepoID & ", t1.lot) > 0"
			rs.open sorgu, sbsv5, 1, 3	

		Response.Write "<div class=""card-deck"">"
			Response.Write "<div class=""card" & class1 & """ id=""surecDIV1"">"
				Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row justify-content-between mb-3"">"
					Response.Write "<div class=""bold"">Ürün Listesi</div>"
					Response.Write "<button class=""btn btn-sm bg-warning p-0"" onclick=""modalajaxfit('/sterilizasyon/cihaz_sec.asp?stokHareketID=0&techizatID="&techizatID&"')"">Sterilizatörler</button>"
				Response.Write "</div>"
				Response.Write "<table class=""table table-sm"">"	
					Response.Write "<thead class=""thead-dark"">"
						Response.Write "<th>LOT</th>"
						Response.Write "<th>Ürün</th>"
						Response.Write "<th>Sipariş Veren</th>"
						Response.Write "<th>Miktar</th>"
						Response.Write "<th>Koli</th>"
						Response.Write "<th>Hacim</th>"
					Response.Write "</thead>"
					do until rs.EOF
					stokHareketID		=	rs("stokHareketID")
					siparisCariAd		=	rs("siparisCariAd") 
					stokID				=	rs("stokID")
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					lot					=	rs("lot")
					miktar				=	rs("miktar")
					kisaBirim			=	rs("kisaBirim")
					koliSayi			=	rs("koliSayi")
					toplamHacimLt		=	rs("hacimLt") * koliSayi
					sterilCevrimID		=	rs("sterilCevrimID")
					techizatID			=	rs("techizatID")


					Response.Write "<tbody class=""hoverGel pointer fontkucuk2"">"
						Response.Write "<td>" & lot & "</td>"
						Response.Write "<td>" & stokKodu & " " & stokAd & "</td>"
						Response.Write "<td>" & siparisCariAd & "</td>"
						Response.Write "<td>" & miktar & " " & kisaBirim & "</td>"
						Response.Write "<td>" & koliSayi & "</td>"
						Response.Write "<td>" & toplamHacimLt & " m3</td>"
						Response.Write "<td onclick=""modalajaxfit('/sterilizasyon/cihaz_sec.asp?stokHareketID="&stokHareketID&"&techizatID="&techizatID&"')"">"
							if sterilCevrimID > 0 then
								Response.Write "<i class=""icon tick""></i>"
							else
								Response.Write "<i class=""icon server-add""></i>"
							end if
						Response.Write "</td>"
					Response.Write "</tbody>"
					rs.movenext
					loop
					rs.close
				Response.Write "</table>"
				Response.Write "</div>"
			Response.Write "</div>"

			Response.Write "<div class=""card"" id=""surecDIV2"">"
				Response.Write "<div class=""card-body"">"
				Response.Write "<h5 class=""card-title"">Sterilizasyon Planlama</h5>"

				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
	else
		call yetkisizGiris("","","")
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU


%>

<script>
</script>