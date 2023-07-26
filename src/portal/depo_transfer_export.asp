<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()

	listeTur	    =	Request("listeTur")



    Response.Flush()
    call logla("Depo Transfer Export")
'###### ANA TANIMLAMALAR

'####### SONUÇ TABLOSU
    if hata = "" then
            sorgu = "SELECT"
			sorgu = sorgu & " DATEFROMPARTS(t1.hangiYil, t1.hangiAy, t1.hangiGun) as planTarih, t1.baslangicZaman, t1.bitisZaman, t2.stokID, t2.stokKodu, t2.stokAd, "
			sorgu = sorgu & " t1.id as ajandaID, t1.tamamlandi, t1.receteAdimID, t1.manuelPlan,"
			sorgu = sorgu & " ISNULL([stok].[FN_siparisMiktarBul] (t1.id , "&firmaID&"),t1.miktar) as sipMiktar,"
			sorgu = sorgu & " ISNULL([stok].[FN_receteMiktarBul] (t1.id),1) as bilesenMiktar,"
			sorgu = sorgu & " [stok].[FN_anaBirimADBul] ( t2.stokID, 'kAd') as miktarBirim,"
			sorgu = sorgu & " ISNULL(portal.FN_sipariscariAdbul("&firmaID&", t1.id),N'<span class=""font-italic bold text-info"">Manuel İstem</span>') as siparisCariAd,"
			sorgu = sorgu & " t1.icerik, t1.tarih"
			sorgu = sorgu & " FROM portal.ajanda t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID
			sorgu = sorgu & " AND t1.isTur = '" & listeTur & "'" 
			sorgu = sorgu & " AND t1.silindi = 0"
			sorgu = sorgu & " AND t1.tamamlandi = 0"
			sorgu = sorgu & " ORDER BY DATEFROMPARTS(t1.hangiYil, t1.hangiAy, t1.hangiGun) DESC"
			rs.open sorgu, sbsv5, 1, 3

        if rs.recordcount > 0 then
            sonuc = ""
            sonuc = sonuc & "<!DOCTYPE html><html lang=""en""><head><meta charset=""utf-8"">"
            sonuc = sonuc & "</head>"
            sonuc = sonuc & "<body>"
            sonuc = sonuc & "<table border=""1"" align=""center"" style=""font-size:10px;"" cellpadding=""0"" cellspacing=""0"">"
                sonuc = sonuc & "<tr>"
                sonuc = sonuc & "<th scope=""col"">Tarih</th>"
                sonuc = sonuc & "<th scope=""col"">Stok Kodu</th>"
                sonuc = sonuc & "<th scope=""col"">Ürün Adı</th>"
                sonuc = sonuc & "<th scope=""col"">Miktar</th>"
                sonuc = sonuc & "<th scope=""col"">Detay</th>"
                sonuc = sonuc & "</tr>"
            for i = 1 to rs.recordcount
                    sipMiktar			=	rs("sipMiktar")
					bilesenMiktar		=	rs("bilesenMiktar")
					bilesenToplamMiktar	=	bilesenMiktar * sipMiktar

                sonuc = sonuc & "<tr>"
                sonuc = sonuc & "<td scope=""col"">" & rs("planTarih") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("stokKodu") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("stokAd") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & bilesenToplamMiktar & " " & rs("miktarBirim")& "</td>"
                sonuc = sonuc & "<td scope=""col"" class=""text-right"">" & rs("icerik") & "</td>"
                sonuc = sonuc & "</tr>"
            rs.movenext
            next
        end if

        sonuc = sonuc & "</table>"
        sonuc = sonuc & "</body>"
        sonuc = sonuc & "</html>"
        rs.close
    end if


    '#### DOSYA KONTROL
        if klasorkontrol("/temp/dosya/" & firmaID) = false then
            call klasorolustur("/temp/dosya/" & firmaID)
        end if
    '#### DOSYA KONTROL


	Set objStream = server.CreateObject("ADODB.Stream")
	objStream.Open
	objStream.CharSet = "UTF-8"
        objStream.WriteText sonuc
	objStream.SaveToFile Server.Mappath("/temp/dosya/" & firmaID & "/depoTransferListe.xls"),2
	objStream.Close
	set objStream = Nothing

    call jquerykontrol()
    call jsgit("/temp/dosya/" & firmaID & "/depoTransferListe.xls")

%><!--#include virtual="/reg/rs.asp" -->