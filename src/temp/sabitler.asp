<%
mainUrl = Request.ServerVariables("HTTP_HOST")

if sayfasonu = True then
else
	'## DB
'	sb_dbsunucu="."
	sb_dbsunucu="EVREN-ASUS\SQLEXPRESS"
	sb_dbad="sbs_tio"
	sb_dbuser="sbs_bulutihale"
	sb_dbpass="FVDFG@@!!wer3232"

		localeID = GetLocale()

		If localeID = 1033 Then
			decimalSeparator = "nokta"
		ElseIf localeID = 1055 Then
			decimalSeparator = "virgul"
		End If
end if
%>