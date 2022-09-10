<%@ language="VBScript" %><%

  Const lngMaxFormBytes = 200

  Dim objASPError, blnErrorWritten, strServername, strServerIP, strRemoteIP
  Dim strMethod, lngPos, datNow, strQueryString, strURL, db1, sbsv5, sayfasonu

  If Response.Buffer Then
    Response.Clear
    Response.Status = "500 Sunucu Hatasi"
    Response.ContentType = "text/html"
    Response.Expires = 0
  End If

  Set objASPError = Server.GetLastError

	hatano = objASPError.Number

	if hatano = "-2147217864" or hatano = "-2147217871" or instr(objASPError.Description,"The login failed") > 0 then
'		Response.End()
	end if

	if left(objASPError.ASPDescription,7) = "Timeout" or left(objASPError.ASPDescription,20) = "Cannot open database" then
'		Response.End()
	end if


	db1 = "web"

	site = Request.ServerVariables("HTTP_HOST")
	sessiond				=	""

	mailicerik				=	""
	mailicerik				=	mailicerik & "Description : " & objASPError.Description & "<br />"
	mailicerik				=	mailicerik & "File : " & objASPError.File & "<br />"
	mailbaslik				=	"500##" & site & "##" & objASPError.File & "##" & objASPError.Line
	mailicerik				=	mailicerik & "Line : " & objASPError.Line & "<br />"
	mailicerik				=	mailicerik & "SCRIPT_NAME : " & Request.ServerVariables("SCRIPT_NAME") & "<br />"
	mailicerik				=	mailicerik & "REMOTE_ADDR : " & Request.ServerVariables("REMOTE_ADDR") & "<br />"
	smsicerik				=	""
	smsicerik				=	smsicerik & "S:" & site
	smsicerik				=	smsicerik & "#"
	smsicerik				=	smsicerik & "F:" & objASPError.File
	smsicerik				=	smsicerik & "#"
	smsicerik				=	smsicerik & "L:" & objASPError.Line

	For Each item in Session.Contents
		sessiond = sessiond & item & ":" & Session(item) & "<br />"
	next

	%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><style type="text/css">BODY { font: 8pt/12pt verdana }H1 { font: 13pt/15pt verdana }H2 { font: 8pt/12pt verdana }A:link { color: red }A:visited { color: maroon }</style></head><body><div align="center"><img src="/hata500100.png" width="660" height="445" /></div><div align="center">Hata Kodu : </div></body></html>
	<%

	on error resume next
	Set JMail = Server.CreateObject ("JMail.SMTPMail")
	JMail.Silent					=	true
	JMail.Logging					=	true
	JMail.charset					=	"utf-8"
	JMail.ServerAddress				=	"212.68.61.84:587"
	JMail.Sender					=	"teknik@sbstasarim.com"
	JMail.Subject					=	mailbaslik
	JMail.HTMLBody					=	mailicerik
	JMail.Priority					=	1
	JMail.AddHeader						"Originating-IP", Request.ServerVariables("REMOTE_ADDR")
	JMail.AddRecipientbcc				"destek@sbstasarim.com"
	if not JMail.execute then
		response.write "Mesaj:" & JMail.ErrorMessage & "Kaynak : " & JMail.ErrorSource & "Log : " & JMail.Log
	end if
	set JMail = Nothing


Response.Write mailicerik
%>