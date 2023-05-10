<%
mainUrl = Request.ServerVariables("HTTP_HOST")

if sayfasonu = True then
else
	'## DB
'	sb_dbsunucu="."
	sb_dbsunucu="EVREN_ASUS\SQLEXPRESS"
	sb_dbad="sbs_tio"
	sb_dbuser="sbs_bulutihale"
	sb_dbpass="FVDFG@@!!wer3232"
end if
%>