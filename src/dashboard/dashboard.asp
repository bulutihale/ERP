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
	islem				=	Request.QueryString("islem")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


	call logla("Welcome Dashboard")


Response.Write "<i onClick=""modalajax('/dashboard/dashboard_duzenle.asp');"" style=""position:fixed;right:4px;"" class=""icon layout-add parmak"" title=""" & translate("Dashboard dizilimini değiştir","","") & """></i>"


	sorgu = "Select" & vbcrlf
	sorgu = sorgu & "* from portal.dashboard" & vbcrlf
	sorgu = sorgu & "where (personelID = " & kid & " or personelID = 0)" & vbcrlf
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
	else
		if islem = "" then
			'varsayılan dashboard oluştur
			rs.addnew
				rs("kid")			=	kid
				rs("firmaID")		=	firmaID
				rs("personelID")	=	kid
				rs("modul")			=	"doviz"
				rs("modulAd")		=	"Döviz Bilgileri"
				rs("sira")			=	99
			rs.update
			rs.addnew
				rs("kid")			=	kid
				rs("firmaID")		=	firmaID
				rs("personelID")	=	kid
				rs("modul")			=	"havaDurumu"
				rs("modulAd")		=	"Hava Durumu"
				rs("sira")			=	99
			rs.update
			'varsayılan dashboard oluştur
			call jsac("/dashboard/dashboard.asp")
		end if
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
			modulBilgiBul = "col-lg-4 col-md-4 col-sm-4 col-xs-12"
		end if
	elseif modul = "havaDurumu" then
		if bilgi = "dosya" then
			modulBilgiBul = "/dashboard/havadurumu.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-4 col-md-4 col-sm-4 col-xs-12"
		end if
	elseif modul = "teklifDurum" then
		if bilgi = "dosya" then
			modulBilgiBul = "/dashboard/teklif_durum.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-4 col-md-4 col-sm-4 col-xs-12"
		end if
	end if
end function

	on error resume next
	veri = "localIP=" & Request.ServerVariables("REMOTE_ADDR") & "&kid=" & kid & "&firmaID=" & firmaID
	sonuc = xmlverigonder("https://erp.sbstasarim.com/whereiam.asp",veri,"POST","text","","","","","")
	if sonuc = "1" then
		'sabit de aynı fikirde mi?
		'sabitleri yeniden oluştur
	elseif sonuc = "0" then
	end if
	on error goto 0

%><!--#include virtual="/reg/rs.asp" -->