<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()




	'##### request
	'##### request
		kid						=	kidbul()
		ihaleID64				=	Request.Form("id")
		ihaleID					=	base64_decode_tr(ihaleID64)
		modulID					=	ihaleID
		
	'##### request
	'##### request
	hatamesaj = "Kayıt Başlıyor"
	call logla("Dosya","insert",hatamesaj,modulID)
	


'##### DOSYA SİL
'##### DOSYA SİL

	sorgu = "UPDATE teklifv2.ihale SET silindi = 1 WHERE id = " & ihaleID
	rs.open sorgu,sbsv5,3,3
'##### /DOSYA SİL
'##### /DOSYA SİL




response.Write "ok|"


%>


