bu dosya portal içine konsun








Response.Flush()

	Set JMail = Server.CreateObject("Jmail.Message")
	JMail.ContentType			=	"text/html"
	JMail.Charset				=	"ISO-8859-9"
	JMail.From					=	"teknik@sbstasarim.com"
	JMail.FromName				=	"Bulut İhale Bilgi"
	JMail.AddRecipientCC			"info@bulutihale.com"
	JMail.Subject				=	"Deneme Başlığı"
'	JMail.Body					=	"deneme içerik"
	JMail.HTMLBody				=	"deneme içerik"
	JMail.Priority				=	3
	JMail.MailServerUserName 	= 	"teknik@sbstasarim.com"
	JMail.MailServerPassword 	= 	"sgxuewlv12!!@3"
	JMail.Send						("212.68.61.84:587")
	set JMail = Nothing



if 1 = 2 then
'	on error resume next
	Set JMail = Server.CreateObject ("JMail.SMTPMail")
	JMail.Silent					=	true
	JMail.Logging					=	true
	JMail.charset					=	"utf-8"
	JMail.ServerAddress				=	"212.68.61.84:587"
	JMail.Sender					=	"teknik@sbstasarim.com"
	JMail.SenderName 			= 	"Bulut İhale Bilgi"
	JMail.MailServerUserName 		= 	"teknik@sbstasarim.com"
	JMail.MailServerPassword 		= 	"sgxuewlv12!!@3"

	JMail.Subject					=	"deneme başlığı"
	JMail.HTMLBody					=	"deneme içerik"
				JMail.AddRecipientbcc "destek@gozdegrubu.com"
	JMail.Priority					=	1
	JMail.AddHeader						"Originating-IP", Request.ServerVariables("REMOTE_ADDR")
	
	
	
	if not JMail.execute then
		response.write "Mesaj:" & JMail.ErrorMessage & "Kaynak : " & JMail.ErrorSource & "Log : " & JMail.Log
	end if
	set JMail = Nothing
end if


	%>