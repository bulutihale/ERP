<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()




	'##### request
	'##### request
		kid						=	kidbul()

		tempIDliste				=	request.form("tempIDliste[]")
		irsaliyeNo				=	request("irsaliyeNo")
	'##### request
	'##### request

	satirDegerleriArray = Split(tempIDliste, ",")

	
For i = 0 To UBound(satirDegerleriArray)
    satirDeger = satirDegerleriArray(i)

	call logla("TEMP tablosundaki ürünler için sevk edildikleri irsaliye no " & irsaliyeNo & " kayıt ediliyor. stokHareketID = " & satirDeger)


	sorgu = "UPDATE stok.stokHareket SET irsaliyeNo = '" & irsaliyeNo & "' WHERE stokHareketID = " & satirDeger
	rs.open sorgu,sbsv5,3,3

	sorgu = "DELETE teklif.siparisKalemTemp WHERE stokHareketID = " & satirDeger
	rs.open sorgu,sbsv5,3,3
Next





'call toastrCagir("İşlem Yapıldı.", "OK", "right", "success", "otomatik", "")

'call jsrun("$('#ortaalan').load('/satis/siparis_liste.asp')")

%>

