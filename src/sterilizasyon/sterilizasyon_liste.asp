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

	depoKategori	=	"sterilizasyon"
	baslik			=	"<span class=""h2 text-success bold"">Üretimden gelen Non - Steril Ürünler Listesi</span>"
	class1			=	" border border-success "

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
		
			sorgu = "SELECT " 
			'sorgu = sorgu & " stok.FN_stokSayDepoLot("&firmaID&", t1.stokID, " & bekleyenUrunDepoID & ", t1.lot) as miktar,"
			sorgu = sorgu & " t1.miktar,"
			sorgu = sorgu & " t3.stokKodu, t1.stokID, t3.stokAd, t1.lot, t1.lotSKT, stok.FN_anaBirimADBul(t1.stokID, 'kAd') as kisaBirim,"
			sorgu = sorgu & " portal.FN_sipariscariAdbul("&firmaID&", t1.ajandaID) as siparisCariAd, ISNULL(t1.ajandaID,0) as ajandaID, t2.id as mamulCikisDepoID"
			sorgu = sorgu & " FROM stok.stokHareket t1"
			sorgu = sorgu & " INNER JOIN stok.depo t2 ON t1.depoID = t2.id"
			sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
			sorgu = sorgu & " WHERE t2.depoKategori = '"&depoKategori&"' AND t1.silindi = 0"
			sorgu = sorgu & " AND stok.FN_stokSayDepoLot("&firmaID&", t1.stokID, " & bekleyenUrunDepoID & ", t1.lot) > 0"
			sorgu = sorgu & " GROUP BY t1.lot, t1.lotSKT, t3.stokAd,t1.stokID, t3.stokKodu, t1.ajandaID, t2.id, t1.miktar"
			rs.open sorgu, sbsv5, 1, 3

		Response.Write "<div class=""card-deck"">"
			Response.Write "<div class=""card" & class1 & """ id=""sterilizasyonDIV1"">"
				Response.Write "<div class=""card-body"">"
				Response.Write "<h5 class=""card-title"">Ürün Listesi</h5>"
					Response.Write "<div class=""row bold bg-light"">"
						Response.Write "<div class=""col-2"">LOT</div>"
						Response.Write "<div class=""col-3"">Ürün</div>"
						Response.Write "<div class=""col-3"">Sipariş Veren</div>"
						Response.Write "<div class=""col-3 text-center"">Miktar</div>"
						Response.Write "<div class=""col-1""></div>"
					Response.Write "</div>"
					do until rs.EOF
					siparisCariAd		=	rs("siparisCariAd")
					stokID				=	rs("stokID")
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					lot					=	rs("lot")
					lotSKT				=	rs("lotSKT")
					miktar				=	rs("miktar")
					kisaBirim			=	rs("kisaBirim")
					ajandaID			=	rs("ajandaID")
					mamulCikisDepoID	=	rs("mamulCikisDepoID")

					Response.Write "<div class=""row hoverGel pointer fontkucuk2"">"
						Response.Write "<div class=""col-2"">" & lot & "</div>"
						Response.Write "<div class=""col-3"">" & stokKodu & " " & stokAd & "</div>"
						Response.Write "<div class=""col-3"">" & siparisCariAd & "</div>"
						Response.Write "<div class=""col-2 text-right"">" & miktar & " " & kisaBirim & "</div>"
						Response.Write "<div class=""col-1 text-center"" onclick=""modalajaxfit('/sterilizasyon/koli_sec.asp?lotSKT="&lotSKT&"&stokID="&stokID&"&lot="&lot&"&miktar="&miktar&"&ajandaID="&ajandaID&"&mamulCikisDepoID="&mamulCikisDepoID&"')""><i class=""icon server-go""></i></div>"
					Response.Write "</div>"
					rs.movenext
					loop
					rs.close
				Response.Write "</div>"
			Response.Write "</div>"

			Response.Write "<div class=""card"" id=""sterilizasyonDIV2"">"
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