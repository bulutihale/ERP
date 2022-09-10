<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	Session("lngTimer")	=	Timer
	site				=	Request.ServerVariables("HTTP_HOST")
	kid					=	kidbul()
	personelID			=	kid
	mobil				=	mobilkontrol()
	hata				=	""
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


'###### FİRMAYI BUL
'###### FİRMAYI BUL
	sorgu = "Select Id from portal.Firma where url = '" & site & "'"
	rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount = 0 then
		hata = "Tanımsız Firma"
	elseif rs.recordcount = 1 then
		firmaID			=	rs("Id")
	end if
	rs.close
	call logla("Personel Çıkış Yaptı")
'###### FİRMAYI BUL
'###### FİRMAYI BUL


	Response.Cookies("kid")				=	""
	Response.Cookies("kid").Expires		=	date()-5

	Session.Abandon()
	Response.Redirect "/"
%>