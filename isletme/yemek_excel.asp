<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
	aramaad	=	Request.Form("aramaad")
    opener  =   Request.QueryString("opener")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Yemek Listesi Ekranı")


haftabasi = weekday(date()-1)

' ilktarih = "1.5.2022"
' ilktarih = cdate(ilktarih)

gunArr = ""
yemek1Arr = ""
yemek2Arr = ""
yemek3Arr = ""
yemek4Arr = ""

'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" then
		sonuc = sonuc & "<div class=""table-responsive"">"
            sorgu = "Select top 30 * from isletme.yemekListe"
			sorgu = sorgu & " where isletme.yemekListe.firmaID = " & firmaID
            sorgu = sorgu & " and isletme.yemekListe.tarih > '" & tarihsql(date()-haftabasi) & "'"
            ' sorgu = sorgu & " and isletme.yemekListe.tarih > '" & tarihsql(ilktarih-haftabasi) & "'"
			sorgu = sorgu & " order by isletme.yemekListe.tarih ASC"
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
                for i = 1 to rs.recordcount
                    gunArr = gunArr & "," & tarihtr(rs("tarih"))
                    yemek1Arr = yemek1Arr & "," & rs("yemek1")
                    yemek2Arr = yemek2Arr & "," & rs("yemek2")
                    yemek3Arr = yemek3Arr & "," & rs("yemek3")
                    yemek4Arr = yemek4Arr & "," & rs("yemek4")
                rs.movenext
                next
			end if
			rs.close

gunArr = Split(gunArr,",")
yemek1Arr = Split(yemek1Arr,",")
yemek2Arr = Split(yemek2Arr,",")
yemek3Arr = Split(yemek3Arr,",")
yemek4Arr = Split(yemek4Arr,",")

sonuc = ""




sonuc = sonuc & "<!DOCTYPE html><html lang=""en""><head><meta charset=""utf-8"">"
sonuc = sonuc & "</head>"
sonuc = sonuc & "<body>"


		sonuc = sonuc & "<table border=""1"" align=""center"" style=""font-size:10px;"" cellpadding=""0"" cellspacing=""0"">"
            sonuc = sonuc & "<tr>"
                sonuc = sonuc & "<td align=""center"" height=""60"">"
                    sonuc = sonuc & "<img src=""https://portal.agrobestgrup.com/template/images/agrobestlogo121.jpg"" style=""width:100px;"" />"
                sonuc = sonuc & "</td>"
                sonuc = sonuc & "<td colspan=""5"" align=""center""><font size=""5"">" & ucase(aylaruzun(month(cdate(gunArr(10))))) & " AYI YEMEK LİSTESİ"
                sonuc = sonuc & "</font></td>"
            sonuc = sonuc & "</tr>"

            
            for si = 0 to 4
                sonuc = sonuc & "<tr align=""center"">"
                    sonuc = sonuc & "<td>"
                    sonuc = sonuc & "TARİH"
                    sonuc = sonuc & "</td>"
                    for i = 1 to 5
                        sonuc = sonuc & "<td><strong>"
                        sonuc = sonuc & gunArr(i+(si*5))
                        sonuc = sonuc & "</strong></td>"
                    next
                sonuc = sonuc & "</tr>"
                    sonuc = sonuc & "<tr align=""center"">"
                        ' if si = 1 then
                            sonuc = sonuc & "<td rowspan=""3"" valign=""middle"" width=""150"">"
                            sonuc = sonuc & "ANA YEMEK"
                            sonuc = sonuc & "</td>"
                        ' end if
                        for i = 1 to 5
                            sonuc = sonuc & "<td width=""100"">"
                            sonuc = sonuc & yemek1Arr(i+(si*5))
                            sonuc = sonuc & "</td>"
                        next
                        sonuc = sonuc & "</tr>"
                        sonuc = sonuc & "<tr align=""center"">"
                        for i = 1 to 5
                            sonuc = sonuc & "<td>"
                            sonuc = sonuc & yemek2Arr(i+(si*5))
                            sonuc = sonuc & "</td>"
                        next
                        sonuc = sonuc & "</tr>"
                        sonuc = sonuc & "<tr align=""center"">"
                        for i = 1 to 5
                            sonuc = sonuc & "<td>"
                            sonuc = sonuc & yemek3Arr(i+(si*5))
                            sonuc = sonuc & "</td>"
                        next
                        sonuc = sonuc & "</tr>"
                        sonuc = sonuc & "<tr align=""center"">"
                            sonuc = sonuc & "<td rowspan=""4"">"
                            sonuc = sonuc & "SALATA, MEYVE, TATLI VB."
                            sonuc = sonuc & "</td>"
                        for i = 1 to 5
                            sonuc = sonuc & "<td>"
                            sonuc = sonuc & yemek4Arr(i+(si*5))
                            sonuc = sonuc & "</td>"
                        next
                        sonuc = sonuc & "</tr>"

                        sonuc = sonuc & "<tr align=""center"">"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                        sonuc = sonuc & "</tr>"
                        sonuc = sonuc & "<tr align=""center"">"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                        sonuc = sonuc & "</tr>"
                        sonuc = sonuc & "<tr align=""center"">"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                            sonuc = sonuc & "<td>&nbsp;</td>"
                        sonuc = sonuc & "</tr>"
            next


                        sonuc = sonuc & "<tr align=""center"">"
                            sonuc = sonuc & "<td><strong>HAZIRLAYAN</strong></td>"
                            sonuc = sonuc & "<td colspan=""2""><strong>HÜSEYİN AYDINLI</strong></td>"
                            sonuc = sonuc & "<td><strong>ONAYLAYAN</strong></td>"
                            sonuc = sonuc & "<td colspan=""2""><strong>FÜSUN TOROS</strong></td>"
                        sonuc = sonuc & "</tr>"
                        sonuc = sonuc & "<tr align=""center"">"
                            sonuc = sonuc & "<td><strong>İMZA</strong></td>"
                            sonuc = sonuc & "<td colspan=""2"">&nbsp;</td>"
                            sonuc = sonuc & "<td><strong>İMZA</strong></td>"
                            sonuc = sonuc & "<td colspan=""2"">&nbsp;</td>"
                        sonuc = sonuc & "</tr>"


        sonuc = sonuc & "</table>"

sonuc = sonuc & "</body>"
sonuc = sonuc & "</html>"

	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU



	Set objStream = server.CreateObject("ADODB.Stream")
	objStream.Open
	objStream.CharSet = "UTF-8"

objStream.WriteText sonuc
' Response.Write sonuc

	objStream.SaveToFile Server.Mappath("/temp/yemeklistesi.xls"),2
	objStream.Close
	set objStream = Nothing




%>