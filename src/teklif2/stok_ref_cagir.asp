<!--#include virtual="/reg/rs.asp" --><%

'	Response.Flush()
	kid						=	kidbul()
	cariID					=	Request("cariID")
	stokID					=	Request("stokID")



'##### YETKİ BUL
'##### YETKİ BUL
	sorgu		=	""
'##### YETKİ BUL
'##### YETKİ BUL


sorgu = "SELECT cariUrunFiyat, paraBirim FROM stok.stokRef WHERE firmaID = " & firmaID & " AND silindi = 0 AND stokID = " & stokID & " AND cariID = " & cariID
rs.open sorgu, sbsv5, 1, 3
	if rs.recordcount > 0 then
		cariUrunFiyat	=	rs("cariUrunFiyat")
		paraBirim		=	rs("paraBirim")
	end if
rs.close

	Response.Write cariUrunFiyat & "|" & paraBirim
%>

