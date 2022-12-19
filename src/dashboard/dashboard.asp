<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	Response.Charset	=	"utf-8"
	Response.Flush()
	Session("lngTimer")	=	Timer
	site				=	Request.ServerVariables("HTTP_HOST")
	kid					=	kidbul()
	personelID			=	kid
	hata				=	""
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



	sorgu = "Select" & vbcrlf
	sorgu = sorgu & "* from portal.dashboard" & vbcrlf
	sorgu = sorgu & "where personelID = " & kid & vbcrlf
	sorgu = sorgu & "order by sira ASC" & vbcrlf
	rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount > 0 then
		'### HTML KISMI
			Response.Write "<div class=""container-fluid"">"
			Response.Write "<div class=""row"">"
			for i = 1 to rs.recordcount
				modul = rs("modul")
				Response.Write "<div class=""" & modulBilgiBul(modul,"boyut") & " mb-2"">"
					Response.Write "<div class=""dash" & modul & "Div""></div>"
				Response.Write "</div>"
			rs.movenext
			next
			Response.Write "</div>"
			Response.Write "</div>"
		'### HTML KISMI
		'##### SCRIPT
			Response.Write "<scr" & "ipt type=""text/javascript"">"
			Response.Write "$(document).ready(function(){"
			rs.movefirst
			for i = 1 to rs.recordcount
				modul = rs("modul")
				Response.Write "setTimeout(function(){$('.dash" & modul & "Div').load('" & modulBilgiBul(modul,"dosya") & "');}, " & i * 1000 & ");"
			rs.movenext
			next
			Response.Write "});"
			Response.Write "</scr" & "ipt>"
		'##### SCRIPT
	end if
	rs.close










function modulBilgiBul(byVal modul,byVal bilgi)
	if modul = "doviz" then
		if bilgi = "dosya" then
			modulBilgiBul = "/portal/doviz_dashboard.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-4 col-md-4 col-sm-4 col-xs-12"
		end if
	elseif modul = "webmail" then
		if bilgi = "dosya" then
			modulBilgiBul = "/webmail/dashboard.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-4 col-md-4 col-sm-4 col-xs-12"
		end if
	elseif modul = "gorevPersonel" then
		if bilgi = "dosya" then
			modulBilgiBul = "/dashboard/it_gorevpersonel.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-4 col-md-4 col-sm-4 col-xs-12"
		end if
	elseif modul = "gorevDurum" then
		if bilgi = "dosya" then
			modulBilgiBul = "/dashboard/it_arizadurum.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-4 col-md-4 col-sm-4 col-xs-12"
		end if
	elseif modul = "gorevListesi" then
		if bilgi = "dosya" then
			modulBilgiBul = "/dashboard/it_ariza.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-8 col-md-8 col-sm-8 col-xs-12"
		end if
	elseif modul = "islemLog" then
		if bilgi = "dosya" then
			modulBilgiBul = "/dashboard/islemLog.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-8 col-md-8 col-sm-8 col-xs-12"
		end if
	end if
end function

%><!--#include virtual="/reg/rs.asp" -->