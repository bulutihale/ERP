<!--#include virtual="/reg/rs.asp" --><%


Response.ContentType = "text/html"
Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
Response.CodePage = 65001
Response.CharSet = "UTF-8"

Response.Write "<meta http-equiv=""Content-Type"" content=""text/html;charset=UTF-8"" />"

    Response.Write "<style>"
    	Response.Write "td {"
           ' Response.Write "height: 30px;"
            Response.Write "padding: 5px;"
        Response.Write "}"
    Response.Write "</style>"


	belgeNo			=	Request("belgeNo")


	'########### antet al
		sorgu = "SELECT antetPath FROM portal.firma WHERE id = " & firmaID
		rs.open sorgu, sbsv5, 1, 3
			antetPath		=	rs("antetPath")
		rs.close
	'########### antet al



		sorgu = "SELECT t5.cariAd as fasonCari, t4.stokAd as mamulAd, t6.stokAd as bilesenAd, t7.stokKodu as gidenStokKodu, t7.miktar as gidenMiktar, t7.miktarBirim,"
		sorgu = sorgu & " t7.lot as gidenLot, t1.onayZamani, t9.cariAd, t2.miktar as mamulFasonMiktar, t3.mikBirim as mamulBirim"
		sorgu = sorgu & " FROM fason.fasonDetay t1"
		sorgu = sorgu & " INNER JOIN fason.fasonAna t2 ON t1.fasonAnaID = t2.id"
		sorgu = sorgu & " INNER JOIN teklif.siparisKalem t3 ON t2.siparisKalemID = t3.id"
		sorgu = sorgu & " INNER JOIN stok.stok t4 ON t3.stokID = t4.stokID"
		sorgu = sorgu & " INNER JOIN cari.cari t5 ON t2.fasonCariID = t5.cariID"
		sorgu = sorgu & " INNER JOIN stok.stok t6 ON t1.stokID = t6.stokID"
		sorgu = sorgu & " INNER JOIN stok.stokHareket t7 ON t1.gidisStokHareketID = t7.stokHareketID"
		sorgu = sorgu & " INNER JOIN teklif.siparis t8 ON t3.siparisID = t8.sipID"
		sorgu = sorgu & " INNER JOIN cari.cari t9 ON t8.cariID = t9.cariID"
		sorgu = sorgu & " WHERE t1.belgeNo = '" & belgeNo & "'"
		rs.open sorgu, sbsv5, 1, 3
		'Response.Write sorgu
		if rs.recordcount = 0 then
			Response.Write "kayıt yok"
		else
			fasonCari			=	rs("fasonCari")
			mamulAd				=	rs("mamulAd")
			onayZamani			=	rs("onayZamani")
			cariAd				=	rs("cariAd")
			mamulFasonMiktar	=	rs("mamulFasonMiktar")
			mamulBirim			=	rs("mamulBirim")


			Response.Write "<table border=""0"" style=""width:100%;font-family:calibri;border-collapse:collapse;"">"
				Response.Write "<tr>"
					Response.Write "<td>"
						Response.Write "<img id=""imageLogo"" src=""" & antetPath & """ width=""170"" height=""auto"">"
					Response.Write "</td>"
					Response.Write "</td>"
				Response.Write "</tr>"
			Response.Write "</table>"

			Response.Write "<h3 style=""text-align:center;margin-bottom:30px;""><u>Fason Üreticiye Giden Bileşen</u></h3>"
			
			Response.Write "<table border=""1"" style=""width:100%;border-collapse:collapse;margin-bottom:50px;"">"
				Response.Write "<tbody>"
					Response.Write "<tr>"
						Response.Write "<td style=""font-weight:bold"">Belge No</td>"
						Response.Write "<td>" & belgeNo & "</td>"
						Response.Write "<td style=""font-weight:bold;text-align:right;"">Belge Tarihi</td>"
						Response.Write "<td>" & now() & "</td>"
					Response.Write "</tr>"
					Response.Write "<tr>"
						Response.Write "<td style=""font-weight:bold"">Fason Üretici</td>"
						Response.Write "<td colspan=""3"">" & fasonCari & "</td>"
					Response.Write "</tr>"
					Response.Write "<tr>"
						Response.Write "<td style=""font-weight:bold"">Sipariş Veren</td>"
						Response.Write "<td colspan=""3"">" & cariAd & "</td>"
					Response.Write "</tr>"
					Response.Write "<tr>"
						Response.Write "<td style=""font-weight:bold"">Mamul</td>"
						Response.Write "<td>" & mamulAd & "</td>"
						Response.Write "<td style=""font-weight:bold;text-align:right;"">Miktar</td>"
						Response.Write "<td>" & OndalikKontrol(mamulFasonMiktar) & " " & mamulBirim & "</td>"
					Response.Write "</tr>"
					Response.Write "<tr>"
						Response.Write "<td style=""font-weight:bold"">Onay Tarihi</td>"
						Response.Write "<td colspan=""3"">" & onayZamani & "</td>"
					Response.Write "</tr>"

				Response.Write "</tbody>"
			Response.Write "</table>"	

			Response.Write "<table border=""1"" style=""width:100%;border-collapse:collapse;font-size:11px;"">"
				Response.Write "<thead>"
					Response.Write "<tr align=""center"">"
						Response.Write "<th>Stok Kodu</th>"
						Response.Write "<th>Stok Adı</th>"
						Response.Write "<th>LOT</th>"
						Response.Write "<th>Miktar</th>"
					Response.Write "</tr>"
				Response.Write "</thead>"
				Response.Write "<tbody>"
				for hi = 1 to rs.recordcount
					gidenStokKodu		=	rs("gidenStokKodu")
					bilesenAd			=	rs("bilesenAd")
					gidenMiktar			=	rs("gidenMiktar")
					gidenMiktar			=	OndalikKontrol(gidenMiktar)
					miktarBirim			=	rs("miktarBirim")
					gidenLot			=	rs("gidenLot")
					Response.Write "<tr>"
						Response.Write "<td>" & gidenStokKodu & "</td>"
						Response.Write "<td>" & bilesenAd & "</td>"
						Response.Write "<td style=""text-align:center"">" & gidenLot & "</td>"
						Response.Write "<td style=""text-align:right"">" & gidenMiktar & " " & miktarBirim & "</td>"
					Response.Write "</tr>"
				rs.movenext
				next
				Response.Write "</tbody>"
			Response.Write "</table>"			
			

		end if
		rs.close


		Response.Write "<table style=""width:100%; margin-top:75px;"" border=""0"">"
			Response.Write "<tr style=""text-align:center"">"
				Response.Write "<td><u>TESLİM EDEN</u></td>"
				Response.Write "<td><u>TESLİM ALAN</u></td>"
			Response.Write "</tr>"
		Response.Write "</table>"


%><!--#include virtual="/reg/rs.asp" -->










