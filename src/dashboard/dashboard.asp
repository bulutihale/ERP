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









if firmaID = 2 then
	Response.Write "setTimeout(function(){$('.dashpdksDiv').load('/personel/pdks_dashboard.asp');}, 1000);"
	Response.Write "setTimeout(function(){$('.dashYemekListesiDiv').load('/isletme/yemek_dashboard.asp');}, 1000);"
	Response.Write "setTimeout(function(){$('.dashDogumGunuDiv').load('/personel/dogumgunu_dashboard.asp');}, 1500);"
	Response.Write "setTimeout(function(){$('.dashDuyuruDiv').load('/duyuru/duyuru_dashboard.asp?tur=duyuru');}, 2000);"
	Response.Write "setTimeout(function(){$('.dashDuyuruKDiv').load('/duyuru/duyuru_dashboard.asp?tur=kitap');}, 2500);"
end if

if yetkiIT > 0 then
		Response.Write "setTimeout(function(){$('.dashITariza').load('/dashboard/it_ariza.asp');}, 1000);"
end if
if yetkiIT > 0 then
		Response.Write "setTimeout(function(){$('.dashGorevPersonelDiv').load('/dashboard/it_gorevpersonel.asp');}, 2000);"
end if
if yetkiIT > 0 then
		Response.Write "setTimeout(function(){$('.dashGorevDurumDiv').load('/dashboard/it_arizadurum.asp');}, 3000);"
end if
		 Response.Write "setTimeout(function(){$('.dashWhatsNewDiv').load('/dashboard/whatsnew.asp');}, 5000);"
		' if entegrasyon = "netsis" then
		' 	Response.Write "setTimeout(function(){$('.dashNetsisCariDiv').load('/dashboard/netsiscari.asp');}, 20000);"
		' end if

%><!--#include virtual="/reg/rs.asp" -->