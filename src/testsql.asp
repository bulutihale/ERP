<!--#include virtual="/reg/rs.asp" --><%

	sorgu = "select tarih as 'Teklif Tarihi',firmaad as 'Firma Adı',teklifkullad as 'Personel',toplam1 as 'Teklif Tutarı' from teklif.teklif where teklifsonuc = 4 and tarih > '2022-01-01' and silinmis = 0"
	rs.open sorgu, sbsv5, 1, 3

    dongu = 0
    for each column in rs.fields
        Response.Write typename(rs(dongu).value)
        Response.Write "<br />"
        dongu = dongu + 1
    next
	rs.close


' redim degiskenler(dongu)



' for ab = 0 to ubound(degiskenler)
'     degiskenler(ab) = 0
' next





' 	sorgu = "select tarih as 'Teklif Tarihi',firmaad as 'Firma Adı',teklifkullad as 'Personel',toplam1 as 'Teklif Tutarı' from teklif.teklif where teklifsonuc = 4 and tarih > '2022-01-01' and silinmis = 0"
' 	rs.open sorgu, sbsv5, 1, 3
'     for i = 1 to rs.recordcount
'         degiskenler(2) = degiskenler(2) + rs(3)
'     rs.movenext
'     next
' 	rs.close


' ' for i = 5 to 80
' '     degiskenler(2) = degiskenler(2) + i
' ' next

' Response.Write degiskenler(2)

%>