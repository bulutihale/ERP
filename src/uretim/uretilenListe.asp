<!--#include virtual="/reg/rs.asp" --><%


'###### FİLTRELER
'###### FİLTRELER
		
	cariID			=	Request.Form("cariID")
	stokID			=	Request.Form("stokID")
	t1				=	Request.Form("t1")
	t2				=	Request.Form("t2")
	t3				=	Request.Form("t3")
	t4				=	Request.Form("t4")
	siparisNo		=	Request.Form("siparisNo")
    modulAd 		=   "Üretim"
	
	'####### varsayılan tarih sınırları
		if t1 = "" then t1 = date() - 60 end if
		if t2 = "" then t2 = date() end if
	'####### /varsayılan tarih sınırları
	

'###### FİLTRELER
'###### FİLTRELER

	yetkiKontrol	 = yetkibul(modulAd)

'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU

call logla("Müşteri Siparişleri Listelendi")

Response.Write "<div class=""card rounded-top"">"
Response.Write "<div class=""card-header h5"">Üretim Listesi</div>"

Response.Write "<div class=""card-body"">"
		Response.Write "<div class=""col-1 pointer"" onclick=""modalajax('/uretim/filtre.asp')""><i class=""mdi mdi-filter table-success rounded""></i></div>"
		Response.Write "<div class=""table-responsive mt-3"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr class=""text-center"">"
		Response.Write "<th class=""col-1"" scope=""col"">Sipariş Tarih</th>"
		Response.Write "<th class=""col-2"" scope=""col"">Üretim Başlangıcı</th>"
		Response.Write "<th class=""col-2"" scope=""col"">Üretim Bitişi</th>"
		Response.Write "<th class=""col-4"" scope=""col"">Ürün Adı</th>"
		Response.Write "<th></th>"
		Response.Write "</tr></thead><tbody>"
		
		
            sorgu = "SELECT"
			sorgu = sorgu & " DATEFROMPARTS(t1.hangiYil, t1.hangiAy, t1.hangiGun) as planTarih, t1.baslangicZaman, t1.bitisZaman, t2.stokID, t2.stokKodu, t2.stokAd, "
			sorgu = sorgu & " t1.id as ajandaID"
			sorgu = sorgu & " "
			sorgu = sorgu & " FROM portal.ajanda t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID
			sorgu = sorgu & " AND t1.isTur = 'uretimPlan'" 
			if stokID <> "" then
				sorgu = sorgu & " AND t2.stokID = " & stokID & ""
			end if
			if t3 <> "" then
				sorgu = sorgu & " AND t1.baslangicZaman >= '" & tarihsql(t3) &"'"	
			end if
			if t4 <> "" then
				sorgu = sorgu & " AND t1.baslangicZaman <= '" & tarihsql(t4) &"'"	
			end if
			sorgu = sorgu & " AND (t1.bitisZaman is null OR (t1.bitisZaman >= '" & tarihsql(t1) &"' AND t1.bitisZaman <= '" & tarihsql(t2) &"'))"
			sorgu = sorgu & " AND t1.silindi = 0"
			sorgu = sorgu & " ORDER BY t1.bitisZaman DESC"
			rs.open sorgu, sbsv5, 1, 3


			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					stokID				=	rs("stokID")
					stokID64	 		=	stokID
					stokID64			=	base64_encode_tr(stokID64)
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					planTarih			=	tarihtr(rs("planTarih"))
					baslangicZaman		=	rs("baslangicZaman")
					bitisZaman			=	rs("bitisZaman")
					ajandaID			=	rs("ajandaID")
					ajandaID64			=	ajandaID
					ajandaID64			=	base64_encode_tr(ajandaID64)
					
					Response.Write "<tr>"
						Response.Write "<td class=""text-center"">" & planTarih & "</td>"
						Response.Write "<td class=""text-center"">" & baslangicZaman & "</td>"
						Response.Write "<td class=""text-center"">" & bitisZaman & "</td>"
						Response.Write "<td>" & stokKodu & " - " & stokAd & "</td>"
						Response.Write "<td class=""text-right"">" & miktar & " " & mikBirim & "</td>"
						Response.Write "<td><span onclick=""window.location.href = '/uretim/uretim/uretimPlan++"&ajandaID64&"'"" class=""badge badge-pill badge-success pointer mr-2""><i class=""mdi mdi-arrow-right-bold""></i></span></td>"
					Response.Write "</tr>"
					Response.Flush()
				rs.movenext
				next
			end if
			rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"
	Response.Write "</div>"'card-body
	Response.Write "</div>"'card
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU







%>












