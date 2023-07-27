<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
    stokID				=	Request.QueryString("stokID")
	stokID64			=	stokID
	stokID64			=	base64_encode_tr(stokID64)
	lot					=	Request.QueryString("lot")
	lotSKT				=	Request.QueryString("lotSKT")
	miktar				=	Request.QueryString("miktar")
	ajandaID			=	Request.QueryString("ajandaID")
	mamulCikisDepoID	=	Request.QueryString("mamulCikisDepoID")
	modulAd 	=   "Sterilizasyon"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Sterilizasyon süreci, koli seçimi")

yetkiKontrol = yetkibul(modulAd)

			Response.Write "<div>"
				'# koli tanımla
					Response.Write "<a title=""koli - ürün eşleşmesi oluştur."""
					Response.Write " onClick=""modalajax('/stok/urun_koli_esle.asp?gorevID=" & stokID64 & "')"">"
					Response.Write "<i class=""icon package-add pointer"
					Response.Write """></i>"
					Response.Write "</a>"
				'# koli tanımla
			Response.Write "</div>"


            sorgu = "SELECT t1.koliUrunMiktar, t2.ad as koliAd, t3.stokAd as hamKoliAd, t4.stokAd as bantAd, t1.koliIndexID, t5.stokAd as urunAd, t5.stokKodu as urunStokKodu"
			sorgu = sorgu & " FROM stok.koliIndex t1"
			sorgu = sorgu & " INNER JOIN stok.koli t2 ON t1.koliID = t2.koliID"
			sorgu = sorgu & " INNER JOIN stok.stok t3 ON t2.hamKoliStokID = t3.stokID"
			sorgu = sorgu & " INNER JOIN stok.stok t4 ON t2.bantStokID = t4.stokID"
			sorgu = sorgu & " INNER JOIN stok.stok t5 ON t1.stokID = t5.stokID"
			sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.firmaID = " & firmaID & " AND t1.stokID = " & stokID & ""
			rs.open sorgu, sbsv5, 1, 3


'###### ARAMA FORMU
'###### ARAMA FORMU
	if yetkiKontrol > 2 AND rs.recordcount > 0 then
		Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
		
		urunAd			=	rs("urunAd")
		urunStokKodu	=	rs("urunStokKodu")
	Response.Write "<div class=""bold h3"">Koli Seçimi (" & urunStokKodu & " - " & urunAd	 & ")</div>"


		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
			Response.Write "<th scope=""col"">Koli Adı</th>"
			Response.Write "<th scope=""col"">Kullanılan Koli</th>"
			Response.Write "<th scope=""col"">Kullanılan Bant</th>"
			Response.Write "<th scope=""col"" class=""text-center"">Koli İçi Miktar</th>"
		Response.Write "</tr></thead><tbody>"
					
		for zi = 1 to rs.recordcount
		koliIndexID		=	rs("koliIndexID")
		koliAd			=	rs("koliAd")
		hamKoliAd		=	rs("hamKoliAd")
		bantAd			=	rs("bantAd")
		koliUrunMiktar	=	rs("koliUrunMiktar")
			Response.Write "<tr>"
				Response.Write "<td>" & koliAd & "</td>"
				Response.Write "<td>" & hamKoliAd & "</td>"
				Response.Write "<td>" & bantAd & "</td>"
				Response.Write "<td class=""text-center"">" & koliUrunMiktar & " " & miktarBirim & " </td>"
				Response.Write "<td><div class=""btn btn-sm btn-info"" onclick=""sterilizasyonDIVyukle(" & koliIndexID & ",'" & lot & "'," & miktar & "," & ajandaID & ", " & mamulCikisDepoID & ", '" & lotSKT & "'); modalkapat();"">SEÇ</div></td>"
			Response.Write "</tr>"
			Response.Flush()
		rs.movenext
		next
		rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
	else
		Response.Write "<div class=""text-danger bold"" style=""min-height:100px"">Ürün kartında (stok --> stok kartı koli tanımları sekmesi) ürünün içine konacağı koli tanımlaması yapılmamış.</div>"
		Response.Write "<div class=""pointer"" onclick=""modalajax('/stok/stok_yeni.asp?gorevID="&stokID64&"')"">koli tanımlaması ekranı.</div>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%><!--#include virtual="/reg/rs.asp" -->



<script>

	function sterilizasyonDIVyukle(koliIndexID, lot, miktar, ajandaID, mamulCikisDepoID, lotSKT) {
		working('sterilizasyonDIV2',20,20);
		$('#sterilizasyonDIV2').load("/sterilizasyon/sterilizasyon_plan.asp", {
			koliIndexID:koliIndexID,
			lot:lot,
			lotSKT:lotSKT,
			miktar:miktar,
			ajandaID:ajandaID,
			mamulCikisDepoID:mamulCikisDepoID
		});		
	}

</script>


