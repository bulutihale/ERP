<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    Response.Flush()
    call logla("Stok Export")
'###### ANA TANIMLAMALAR

'####### SONUÇ TABLOSU
    if hata = "" then
        sorgu = "SELECT" & vbcrlf
        sorgu = sorgu & "stok.stok.stokID," & vbcrlf
        sorgu = sorgu & "stok.FN_stokSay(7, stok.stok.stokID) as stokMiktar," & vbcrlf
        sorgu = sorgu & "stok.stok.stokKodu," & vbcrlf
        sorgu = sorgu & "stok.stok.stokAd," & vbcrlf
        sorgu = sorgu & "stok.stok.stokBarcode," & vbcrlf
        sorgu = sorgu & "stok.stok.stokTuru," & vbcrlf
        sorgu = sorgu & "stok.stok.manuelKayit," & vbcrlf
        sorgu = sorgu & "stok.stok.silindi," & vbcrlf
        sorgu = sorgu & "stok.stok.fiyat1," & vbcrlf
        sorgu = sorgu & "stok.stok.fiyat2," & vbcrlf
        sorgu = sorgu & "stok.stok.fiyat3," & vbcrlf
        sorgu = sorgu & "stok.stok.fiyat4," & vbcrlf
        sorgu = sorgu & "stok.stok.paraBirimID," & vbcrlf
        sorgu = sorgu & "pb.uzunBirim as paraBirimAd," & vbcrlf
        sorgu = sorgu & "stok.stok.kdv," & vbcrlf
        sorgu = sorgu & "portal.birimler.uzunBirim as urunAnaBirimAd"  & vbcrlf
        sorgu = sorgu & "FROM stok.stok" & vbcrlf
        sorgu = sorgu & "LEFT JOIN portal.birimler ON stok.stok.anaBirimID = portal.birimler.birimID" & vbcrlf
        sorgu = sorgu & "LEFT JOIN portal.birimler as pb ON stok.stok.paraBirimID = pb.birimID" & vbcrlf
        sorgu = sorgu & "WHERE" & vbcrlf
        sorgu = sorgu & "stok.stok.firmaID in (select Id from portal.firma where portal.firma.anaFirmaID = " & firmaID & " OR portal.firma.Id = " & firmaID & ")" & vbcrlf
        sorgu = sorgu & "order by stok.stok.stokKodu ASC" & vbcrlf
        rs.open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            sonuc = ""
            sonuc = sonuc & "<!DOCTYPE html><html lang=""en""><head><meta charset=""utf-8"">"
            sonuc = sonuc & "</head>"
            sonuc = sonuc & "<body>"
            sonuc = sonuc & "<table border=""1"" align=""center"" style=""font-size:10px;"" cellpadding=""0"" cellspacing=""0"">"
                sonuc = sonuc & "<tr>"
                sonuc = sonuc & "<th scope=""col"">" & translate("Ürün ID","","") & "</th>"
                sonuc = sonuc & "<th scope=""col"">" & translate("Ürün Kodu","","") & "</th>"
                sonuc = sonuc & "<th scope=""col"">" & translate("Ürün Adı","","") & "</th>"
                ' sonuc = sonuc & "<th scope=""col"">" & translate("Ürün Açıklama","","") & "</th>"
                sonuc = sonuc & "<th scope=""col"">" & translate("Barkod","","") & "</th>"
                sonuc = sonuc & "<th scope=""col"" class=""text-right"">" & translate("Stok Miktarı","","") & "</th>"
                sonuc = sonuc & "<th scope=""col"" class=""text-right"">" & translate("Stok Türü","","") & "</th>"
                sonuc = sonuc & "<th scope=""col"" class=""text-right"">" & translate("Durum","","") & "</th>"
                sonuc = sonuc & "<th scope=""col"" class=""text-right"">" & translate("Entegrasyon","","") & "</th>"
                sonuc = sonuc & "<th scope=""col"" class=""text-right"">" & translate("Fiyat","","") & "1</th>"
                sonuc = sonuc & "<th scope=""col"" class=""text-right"">" & translate("Fiyat","","") & "2</th>"
                sonuc = sonuc & "<th scope=""col"" class=""text-right"">" & translate("Fiyat","","") & "3</th>"
                sonuc = sonuc & "<th scope=""col"" class=""text-right"">" & translate("Fiyat","","") & "4</th>"
                sonuc = sonuc & "<th scope=""col"" class=""text-right"">" & translate("KDV","","") & "</th>"
                sonuc = sonuc & "<th scope=""col"" class=""text-right"">" & translate("Para Birimi","","") & "</th>"
                sonuc = sonuc & "</tr>"
            for i = 1 to rs.recordcount
                sonuc = sonuc & "<tr>"
                sonuc = sonuc & "<td scope=""col"">" & rs("stokID") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("stokKodu") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("stokAd") & "</td>"
                ' sonuc = sonuc & "<td scope=""col"">" & translate("Ürün Açıklama","","") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("stokBarcode") & "</td>"
                sonuc = sonuc & "<td scope=""col"" class=""text-right"">" & rs("stokMiktar") & "</td>"
                sonuc = sonuc & "<td scope=""col"" class=""text-right"">" & arrayDegerBulfn(rs("stokTuru"),stokTurDegerler) & "</td>"
                sonuc = sonuc & "<td scope=""col"" class=""text-right"">" & silindiArr(rs("silindi")) & "</td>"
                sonuc = sonuc & "<td scope=""col"" class=""text-right"">" & truefalse(rs("manuelKayit"),"yokvar") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("fiyat1") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("fiyat2") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("fiyat3") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("fiyat4") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("kdv") & "</td>"
                sonuc = sonuc & "<td scope=""col"">" & rs("paraBirimAd") & "</td>"
                sonuc = sonuc & "</tr>"
            rs.movenext
            next
        end if

        sonuc = sonuc & "</table>"
        sonuc = sonuc & "</body>"
        sonuc = sonuc & "</html>"
        rs.close
    end if


	Set objStream = server.CreateObject("ADODB.Stream")
	objStream.Open
	objStream.CharSet = "UTF-8"
        objStream.WriteText sonuc
	objStream.SaveToFile Server.Mappath("/temp/dosya/" & firmaID & "/stokexport.xls"),2
	objStream.Close
	set objStream = Nothing

    call jquerykontrol()
    call jsgit("/temp/stokexport.xls")

%><!--#include virtual="/reg/rs.asp" -->