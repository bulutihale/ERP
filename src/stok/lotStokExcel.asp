<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    Response.Flush()
    call logla("Stok Export")
'###### ANA TANIMLAMALAR

'####### SONUÇ TABLOSU
    if hata = "" then
        sorgu = "SELECT t1.lot, t1.miktar, t2.stokKodu, t2.stokAd, t3.depoAd"
        sorgu = sorgu & " FROM stok.stokLotMiktar t1"
        sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
        sorgu = sorgu & " INNER JOIN stok.depo t3 ON t1.depoID = t3.id"
        sorgu = sorgu & " ORDER BY t2.stokAd, t3.depoAd"
        rs.open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            sonuc = ""
            sonuc = sonuc & "<!DOCTYPE html><html lang=""en""><head><meta charset=""utf-8"">"
            sonuc = sonuc & "</head>"
            sonuc = sonuc & "<body>"
            sonuc = sonuc & "<table border=""1"" align=""center"" style=""font-size:10px;"" cellpadding=""0"" cellspacing=""0"">"
                sonuc = sonuc & "<tr>"
                sonuc = sonuc & "<th scope=""col"">LOT</th>"
                sonuc = sonuc & "<th scope=""col"">Miktar</th>"
                sonuc = sonuc & "<th scope=""col"">Stok Kodu</th>"
                sonuc = sonuc & "<th scope=""col"">Ürün Adı</th>"
                sonuc = sonuc & "<th scope=""col"">Depo</th>"
                sonuc = sonuc & "</tr>"
            for i = 1 to rs.recordcount
                sonuc = sonuc & "<tr>"
                sonuc = sonuc & "<td scope=""col"">" & rs("lot") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("miktar") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("stokKodu") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("stokAd") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("depoAd") & "</td>"
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
	objStream.SaveToFile Server.Mappath("/temp/dosya/" & firmaID & "/stokLotExcelexport.xls"),2
	objStream.Close
	set objStream = Nothing

    call jquerykontrol()
    call jsgit("/temp/dosya/" & firmaID & "/stokLotExcelexport.xls")

%><!--#include virtual="/reg/rs.asp" -->