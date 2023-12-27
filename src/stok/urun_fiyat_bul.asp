<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()



	'##### request
	'##### request
		kid						=	kidbul()
		stokID					=	Request("stokID")

	'##### request
	'##### request


	'## veritabanı

		sorgu = "SELECT TOP(1) t1.miktar, t1.mikBirim, t1.birimFiyat, t1.paraBirim, t2.siparisTarih FROM teklif.siparisKalem t1"
		sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
		sorgu = sorgu & " WHERE siparisTur = 'SA' AND t1.stokID = " & stokID & ""
		rs.open sorgu, sbsv5,1,3

		if rs.recordcount > 0 then
			birimFiyat		=	rs("birimFiyat")
			paraBirim		=	rs("paraBirim")
			miktar			=	rs("miktar")
			mikBirim		=	rs("mikBirim")
			siparisTarih	=	rs("siparisTarih")

		Response.Write  birimFiyat & " " & paraBirim & "(" & OndalikKontrol(miktar) & " " & mikBirim & ") <br><span class=""fontkucuk2""> Sipariş Tarih:" & siparisTarih & "</span>"
		else
			Response.Write "<code class=""fontkucuk2"">Kayıt Yok</code>"
		end if
		rs.close

		

	'## veritabanı




%>



