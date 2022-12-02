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

yetkiIT = yetkibul("IT")
yetkiGorev = yetkibul("gorev")

	Response.Write "<div class=""container-fluid"">"
	Response.Write "<div class=""row"">"

	call bildirim(kid,"Genel Bildirim","Depo Grup Bildirimi" & second(now()),1,0,"Depo","","","","")

if yetkiIT > 0 then
		Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 mb-3"">"
			Response.Write "<a class=""btn btn-success form-control"" href=""/it/ariza_liste"">ARIZA - GÖREV LİSTESİNE GİT</a>"
		Response.Write "</div>"
end if

		'#### YEMEK LİSTESİ
		'#### YEMEK LİSTESİ
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb-2"">"
				Response.Write "<div class=""dashDovizDiv""></div>"
			Response.Write "</div>"
		'#### YEMEK LİSTESİ
		'#### YEMEK LİSTESİ

		'#### WEBMAİL
		'#### WEBMAİL
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb-2"">"
				Response.Write "<div class=""dashMailDiv""></div>"
			Response.Write "</div>"
		'#### WEBMAİL
		'#### WEBMAİL


if firmaID = 2 then
		'#### YEMEK LİSTESİ
		'#### YEMEK LİSTESİ
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb-2"">"
				Response.Write "<div class=""dashYemekListesiDiv""></div>"
			Response.Write "</div>"
		'#### YEMEK LİSTESİ
		'#### YEMEK LİSTESİ
end if
if firmaID = 2 then
		'#### DUYURU
		'#### DUYURU
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb-2"">"
				Response.Write "<div class=""dashDuyuruDiv""></div>"
			Response.Write "</div>"
		'#### DUYURU
		'#### DUYURU
end if
if firmaID = 2 then
		'#### DUYURU
		'#### DUYURU
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb-2"">"
				Response.Write "<div class=""dashpdksDiv""></div>"
			Response.Write "</div>"
		'#### DUYURU
		'#### DUYURU
end if
if firmaID = 2 then
		'#### DUYURU
		'#### DUYURU
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb-2"">"
				Response.Write "<div class=""dashDuyuruKDiv""></div>"
			Response.Write "</div>"
		'#### DUYURU
		'#### DUYURU
end if
if firmaID = 2 then
		'#### DOĞUM GÜNÜ
		'#### DOĞUM GÜNÜ
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb-2"">"
				Response.Write "<div class=""dashDogumGunuDiv""></div>"
			Response.Write "</div>"
		'#### DOĞUM GÜNÜ
		'#### DOĞUM GÜNÜ
end if
if firmaID = 3 then
		'#### WHATS NEW
		'#### WHATS NEW
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb-2"">"
				Response.Write "<div class=""dashWhatsNewDiv""></div>"
			Response.Write "</div>"
		'#### WHATS NEW
		'#### WHATS NEW
end if



if yetkiIT > 0 then
		'#### GÖREV - PERSONEL DAĞILIMI
		'#### GÖREV - PERSONEL DAĞILIMI
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb-2"">"
				Response.Write "<div class=""dashGorevPersonelDiv""></div>"
			Response.Write "</div>"
		'#### GÖREV - PERSONEL DAĞILIMI
		'#### GÖREV - PERSONEL DAĞILIMI
end if
if yetkiIT > 0 then
		'#### GÖREV - DURUM DAĞILIMI
		'#### GÖREV - DURUM DAĞILIMI
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb-2"">"
				Response.Write "<div class=""dashGorevDurumDiv""></div>"
			Response.Write "</div>"
		'#### GÖREV - DURUM DAĞILIMI
		'#### GÖREV - DURUM DAĞILIMI
end if

if yetkiIT > 0 then
		'#### GÖREVLERİM
		'#### GÖREVLERİM
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""dashITariza""></div>"
			Response.Write "</div>"
		'#### GÖREVLERİM
		'#### GÖREVLERİM
end if
if firmaID = 2 then
		'#### AKADEMİ
		'#### AKADEMİ
			' Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb-2"">"
			' 	Response.Write "<div class=""dashAkademiDiv""><img src=""/template/images/akademi_logo.png"" /></div>"
			' Response.Write "</div>"
		'#### AKADEMİ
		'#### AKADEMİ
end if












		'#### NETSİS CARİ
		'#### NETSİS CARİ
			' Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb-2"">"
			' 	Response.Write "<div class=""dashNetsisCariDiv""></div>"
			' Response.Write "</div>"
		'#### NETSİS CARİ
		'#### NETSİS CARİ

	Response.Write "</div>"
	Response.Write "</div>"













'##### SCRIPT
'##### SCRIPT
	Response.Write "<scr" & "ipt type=""text/javascript"">"
	Response.Write "$(document).ready(function(){"

if yetkiIT > 0 then
		' Response.Write "setTimeout(function(){$('.dashITariza').load('/otomatik/gunlukFaaliyetUyar.asp');}, 100);"
end if


	Response.Write "setTimeout(function(){$('.dashDovizDiv').load('/portal/doviz_dashboard.asp');}, 1000);"
	Response.Write "setTimeout(function(){$('.dashMailDiv').load('/webmail/dashboard.asp');}, 2000);"



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

		Response.Write ""
		Response.Write ""
		Response.Write ""
		Response.Write ""
	Response.Write "});"
	Response.Write "</scr" & "ipt>"
'##### SCRIPT
'##### SCRIPT







'##### ENTEGRASYON VARSA GÜNCELLE
'##### ENTEGRASYON VARSA GÜNCELLE
	' if entegrasyon = "netsis" then
	' 	call logla("Netsis Carileri Eşitleniyor")
	' 	Server.Execute "/webservis/netsisCariSYNC.asp"
	' end if
'##### ENTEGRASYON VARSA GÜNCELLE
'##### ENTEGRASYON VARSA GÜNCELLE


%>