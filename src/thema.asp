<!--#include virtual="/reg/rs.asp" --><%


'#### SSL
'#### SSL
'#### SSL
	if sb_ssl = 1 then
		if Request.ServerVariables("SERVER_PORT") = 443 then
		else
			Response.Redirect "https://" & Request.ServerVariables("HTTP_HOST")
		end if
	end if
'#### SSL
'#### SSL
'#### SSL



'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	Session("lngTimer")	=	Timer
	site				=	Request.ServerVariables("HTTP_HOST")
	adres				=	Request.QueryString
	db1					=	"web"
	sayfa3				=	""
	sayfa4				=	""
	sayfa5				=	""
	Session("sayfa5")	=	""
	kid					=	kidbul()
	' Response.Flush()
'	call sessiontest()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


' if firmaID = "" then
' 	Response.Write "Tanımsız Firma"
' 	Response.End()
' end if


' '###### FİRMAYI BUL
' '###### FİRMAYI BUL
' 	sorgu = "Select id,logo,logoMini,ad,url,SSO from portal.Firma where Id = " & firmaID
' 	rs.Open sorgu, sbsv5, 1, 3
' 	if rs.recordcount = 0 then
' 		Response.Write "Tanımsız Firma"
' 		Response.End()
' 	elseif rs.recordcount = 1 then
' 		firmaID		=	rs("id")
' 		firmaLogo	=	rs("logo")
' 		firmaLogo2	=	rs("logoMini")
' 		firmaAd		=	rs("ad")
' 		firmaURL	=	rs("url")
' 		firmaSSO	=	rs("SSO")
' 	end if
' 	rs.close
' '###### FİRMAYI BUL
' '###### FİRMAYI BUL



'###### ADC ÜZERİNDEN OTOMATİK LOGON
'###### ADC ÜZERİNDEN OTOMATİK LOGON
	if firmaSSO = "ADC" then
		if kid = "" then
			sorgu = "Select top 1 username from personel.clientData where (ip like '192.168.%' or ip like '10.%') and (username not like 'C:\%') and ip = '" & Request.ServerVariables("Remote_Addr") & "' and tarih > '" & tarihsql(date()) & "' order by clientDataLogID DESC"
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				clientUsername = rs("username")
			end if
			rs.close

			if clientUsername <> "" then
				sorgu = ""
				sorgu = sorgu & "SELECT" & vbcrlf
				sorgu = sorgu & "personel.id," & vbcrlf
				sorgu = sorgu & "personel.LoginHatirla," & vbcrlf
				sorgu = sorgu & "personel.expiration," & vbcrlf
				sorgu = sorgu & "personel.songiris," & vbcrlf
				sorgu = sorgu & "personel.sayac," & vbcrlf
				sorgu = sorgu & "personel.language," & vbcrlf
				sorgu = sorgu & "personel.webmailUser," & vbcrlf
				sorgu = sorgu & "replace(" & vbcrlf
				sorgu = sorgu & "replace(" & vbcrlf
				sorgu = sorgu & "STUFF((SELECT '; ' + yetkiAd+':',yetkiParametre FROM personel.personel_yetki where personel.personel.id = personel.personel_yetki.kid FOR XML PATH('')), 1, 1, '')" & vbcrlf
				sorgu = sorgu & ",'<yetkiParametre>','')" & vbcrlf
				sorgu = sorgu & ",'</yetkiParametre>','')" & vbcrlf
				sorgu = sorgu & "[yetkiler]" & vbcrlf
				sorgu = sorgu & "from personel.personel" & vbcrlf
				sorgu = sorgu & "WHERE (personel.email = '" & clientUsername & "' or personel.ceptelefon = '" & clientUsername & "'"
				sorgu = sorgu & " or personel.username = '" & clientUsername & "'"
				sorgu = sorgu & ") " & vbcrlf
				sorgu = sorgu & " and personel.personel.firmaID = " & firmaID & vbcrlf
					rs.open sorgu, sbsv5, 1, 3
						if rs.recordcount = 1 then
							id							=	rs("id")
							kid							=	id
							personelID					=	kid
							kid							=	1000 + (kid*38)
							Response.Cookies("kid")		=	base64_encode_tr(kid)
							expiration					=	rs("expiration")
							LoginHatirla				=	rs("LoginHatirla")
							yetkiler					=	rs("yetkiler") & ""
							language					=	rs("language") & ""
							webmailUser					=	rs("webmailUser") & ""
							if LoginHatirla = 0 or isnull(LoginHatirla) = True then
								LoginHatirla = 50
							end if
							if language = "" then
								rs("language")			=	"tr"
								language				=	"tr"
							end if
							Response.Cookies("klang")	=	language
							rs("songiris")				=	now()
							rs("sayac")					=	rs("sayac") + 1
							rs.update
							call jsconsole("ID : " & id)

							if yetkiler = "" then
								sorgu		=	"INSERT INTO personel.personel_yetki (kid,yetkiAd,yetkiParametre) VALUES (" & personelID & ",'login','1')"
								fn1.open sorgu, sbsv5, 3, 3
							end if
							Response.Redirect "/"
							Response.End()
						end if
					rs.close
			end if
		end if
	end if


'###### ADC ÜZERİNDEN OTOMATİK LOGON
'###### ADC ÜZERİNDEN OTOMATİK LOGON








'#### YETKİ İŞLERİ
'#### YETKİ İŞLERİ
if kid <> "" then
	sorgu = "SELECT" & vbcrlf
	sorgu = sorgu & "replace(" & vbcrlf
	sorgu = sorgu & "replace(" & vbcrlf
	sorgu = sorgu & "STUFF((SELECT '|' + yetkiAd FROM personel.personel_yetki where personel.personel_yetki.yetkiParametre > 0 and personel.personel_yetki.kid = " & kid & " and yetkiParametre > 0 FOR XML PATH('')), 1, 1, '')" & vbcrlf
	sorgu = sorgu & ",'<yetkiParametre>','')" & vbcrlf
	sorgu = sorgu & ",'</yetkiParametre>','')" & vbcrlf
	sorgu = sorgu & "[yetkiler]" & vbcrlf
	rs.open sorgu, sbsv5, 1, 3
	if not rs.eof then
		yetkiler = rs(0)
	end if
	rs.close
	kyearr = yetkiler
	kyearr = Split(kyearr,"|")
	yetkisorgu = " ("
	for ki = 0 to ubound(kyearr)
		yetkisorgu = yetkisorgu & " yetkigrup = '" & kyearr(ki) & "'" & vbcrlf
		if ubound(kyearr) > ki then
			yetkisorgu = yetkisorgu &  " or " & vbcrlf
		end if
	next
	set kyearr = Nothing
	yetkisorgu = yetkisorgu & " or yetkigrup is null )"
end if
'#### YETKİ İŞLERİ
'#### YETKİ İŞLERİ


'###### PERSONEL BUL
'###### PERSONEL BUL
if kid <> "" then
	sorgu = "Select ad,passwordExpiration,passwordChangeFirstLogin,webmailUser from Personel.Personel where (expiration is null or expiration >= '" & tarihsql(date()) & "') and Id = " & kid
	rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount = 0 then
		Response.Write "TANIMSIZ PERSONEL : " & kid
		Response.End()
	elseif rs.recordcount = 1 then
		personelAd					=	rs("ad")
		passwordExpiration			=	rs("passwordExpiration")
		passwordChangeFirstLogin	=	rs("passwordChangeFirstLogin")
		webmailUser					=	rs("webmailUser")
	end if
	rs.close
end if
'###### PERSONEL BUL
'###### PERSONEL BUL


'### 404 - 403
'### 404 - 403
	if left(adres,3) = "403" or left(adres,3) = "404" then
		gelenadresarr	=	split(adres,"/")
		if ubound(gelenadresarr) >= 3 then
			sayfa3				=	gelenadresarr(3)
			sayfa3				=	Replace(sayfa3,".html","")
			Session("sayfa3")	=	sayfa3
		end if
		if ubound(gelenadresarr) >= 4 then
			sayfa4				=	gelenadresarr(4)
			sayfa4				=	Replace(sayfa4,".html","")
			Session("sayfa4")	=	sayfa4
		end if
		if ubound(gelenadresarr) >= 5 then
			sayfa5				=	gelenadresarr(5)
			sayfa5				=	Replace(sayfa5,".html","")
			Session("sayfa5")	=	sayfa5
		end if
		set gelenadresarr = Nothing
	end if
'### 404 - 403
'### 404 - 403


'##### ADRESTEN OTOMATİK FORM OLUŞTUR
'##### ADRESTEN OTOMATİK FORM OLUŞTUR
		if inStr(adres,"?") > 0 then
			sayfacoz		=	Split(adres,"?")
			sayfaturu		=	sayfacoz(0)
			sayfaturu		=	Replace(sayfaturu,"404;","")
			sayfaturu		=	Replace(sayfaturu,":80","")
			formverileri	=	sayfacoz(1)
			if instr(formverileri,"=") > 0 then
				formverileri = Split(formverileri,"|")
				formverisayisi = ubound(formverileri)+1
				redim fvname(formverisayisi)
				redim fvdata(formverisayisi)
				for fi = 1 to formverisayisi
					fv = Split(formverileri(fi-1),"=")
						fvname(fi-1) = fv(0)
						fvdata(fi-1) = fv(1)
					set fv = Nothing
				next
				set formverileri = Nothing
				Response.Write "<!DOCTYPE HTML><html><head><meta charset=""utf-8""></head><body><form id=""q2post"" action=""" & sayfaturu & """ method=""post"">"
				for fi = 1 to formverisayisi
					Response.Write "<input type=""hidden"" name=""" & fvname(fi-1) & """ value=""" & fvdata(fi-1) & """ />"
				next
				Response.Write "</form>"
				Response.Write "<scr" & "ipt type=""text/javascript"">document.getElementById('q2post').submit();</scr" & "ipt>"
				Response.Write "</body></html>"
				Response.End()
			end if
			set sayfacoz = Nothing
		end if
'##### ADRESTEN OTOMATİK FORM OLUŞTUR
'##### ADRESTEN OTOMATİK FORM OLUŞTUR






for i = 1 to 200
	Response.Write vbcrlf
next
Response.Write "<!DOCTYPE html>"
Response.Write "<html lang=""en"">"
Response.Write "<head>"
Response.Write "<meta charset=""utf-8"">"
Response.Write "<meta name=""viewport"" content=""width=device-width, initial-scale=1, shrink-to-fit=no"">"
Response.Write "<title>" & firmaAd & "</title>"
Response.Write "<link href=""/template/fonksiyonlar.css"" rel=""stylesheet"">"
Response.Write "<link rel=""stylesheet"" href=""/template/css/style.css"">"
Response.Write "<link rel=""stylesheet"" href=""/template/vendors/mdi/css/materialdesignicons.min.css"">"
Response.Write "<link rel=""stylesheet"" href=""/template/vendors/base/vendor.bundle.base.css"">"
Response.Write "<link rel=""stylesheet"" href=""/template/vendors/datatables.net-bs4/dataTables.bootstrap4.css"">"
Response.Write "<link rel=""stylesheet"" href=""/template/bootstrap-datepicker/css/bootstrap-datepicker3.standalone.css"">"
Response.Write "<link rel=""stylesheet"" href=""/template/fonts/font-awesome-4.4.0/css/font-awesome.min.css"">"
Response.Write "<link rel=""stylesheet"" href=""/template/famfamfam/famfamfam.css"">"
Response.Write "<scr" & "ipt src=""/template/vendors/base/vendor.bundle.base.js""></scr" & "ipt>"
Response.Write "<scr" & "ipt src=""/template/jquery.form-3.4.min.js""></scr" & "ipt>"
Response.Write "<scr" & "ipt src=""/template/cycle.all.latest.js""></scr" & "ipt>"
Response.Write "<link rel=""shortcut icon"" href=""/arayuz/favicon-32x32.png"" />"
Response.Write "<link rel=""icon"" type=""image/png"" sizes=""32x32"" href=""/arayuz/favicon-32x32.png"">"

	'bu kısmı sonra seo.js ye al
	'bu kısmı sonra seo.js ye al
	Response.Write "<scr" & "ipt type=""text/javascript"">"
			Response.Write "function toastAc(mesaj,toastClass){"
			Response.Write "$.toast({"
'				Response.Write "heading: 'Headings',"			'başlık
				Response.Write "text: mesaj,"
				Response.Write "hideAfter: 5000,"				'otomatik kapan  false veya milisaniye
				Response.Write "icon: 'error',"					'info - error
'				Response.Write "loader: true,"
'				Response.Write "loaderBg: '#9EC600'"
'				Response.Write "showHideTransition: 'fade',"	'açılma kapanma şekli  slide - plain - fade
'				Response.Write "allowToastClose: false,"		'kapanma iptal
				Response.Write "stack: 15,"						'max toast sayısı  false , 1,2,3,4
				Response.Write "position: 'bottom-right',"
'				Response.Write "bgColor: '#FF1356',"
'				Response.Write "textColor: 'white'"
'				Response.Write "textAlign: 'center"
				Response.Write "class: 'class' + toastClass,"
				Response.Write "afterHidden: function () {"
					Response.Write "$.toast('class' + toastClass).reset();"
'					Response.Write "alert('Toast has been hidden.');"
				Response.Write "}"
			Response.Write "})"
		Response.Write "};"
	Response.Write "</scr" & "ipt>"
	'bu kısmı sonra seo.js ye al
	'bu kısmı sonra seo.js ye al

if kid = "" then
	bgsayi = rastgele(6,1)
	Response.Write "<style>"
		Response.Write "body {"
			Response.Write "background-image: url('/temp/background/" & firmaID & "/background" & bgsayi & ".jpg');"
			Response.Write "background-size: cover;"
		Response.Write "}"
	Response.Write "</style>"
end if




Response.Write "</head>"
Response.Write "<body>"


if kid <> "" then
	Response.Write "	<div class=""container-scroller"">"
	Response.Write "		<nav class=""navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row"">"
	Response.Write "			<div class=""navbar-brand-wrapper d-flex justify-content-center"">"
	Response.Write "				<div class=""navbar-brand-inner-wrapper d-flex justify-content-between align-items-center w-100"">  "
	Response.Write "					<a class=""navbar-brand brand-logo"" href=""/""><img src=""" & sb_logo & """ alt=""logo""/></a>"
	Response.Write "					<a class=""navbar-brand brand-logo-mini"" href=""/""><img src=""" & sb_logoMini & """ alt=""logo""/></a>"
	Response.Write "					<button class=""navbar-toggler navbar-toggler align-self-center"" type=""button"" data-toggle=""minimize""><span class=""mdi mdi-sort-variant""></span></button>"
	Response.Write "				</div>"
	Response.Write "			</div>"
	Response.Write "			<div class=""navbar-menu-wrapper d-flex align-items-center justify-content-end"">"

	' if GorevListele = True and 1 = 2 then
	' 	Response.Write "			<form action=""/gorev/liste"" method=""post"" id=""themaAramaForm"">"
	' 	Response.Write "				<input type=""hidden"" class=""form-control"" placeholder=""Arama"" name=""aramagorev"" value=""" & aramagorev & """ id=""themaAramaGorev"" />"
	' 	Response.Write "			</form>"
	' 	Response.Write "				<ul class=""navbar-nav mr-lg-4 w-100"">"
	' 	Response.Write "					<li class=""nav-item nav-search d-none d-lg-block w-100"">"
	' 	Response.Write "						<div class=""input-group"">"
	' 	Response.Write "							<div class=""input-group-prepend"">"
	' 	Response.Write "								<span class=""input-group-text"" id=""search""><i class=""mdi mdi-magnify""></i></span>"
	' 	Response.Write "							</div>"
	' 	Response.Write "							<input type=""text"" class=""form-control"" placeholder=""Arama"" aria-label=""arama"" aria-describedby=""arama"" />"
	' 	Response.Write "						</div>"
	' 	Response.Write "					</li>"
	' 	Response.Write "				</ul>"
	' end if






	'########### ÜST BAR
	'########### ÜST BAR
		Response.Write "<ul class=""navbar-nav navbar-nav-right"">"
				' if PersonelIslem = True then
				' 	Response.Write "<li class=""nav-item dropdown mr-1"">"
				' 	Response.Write "<a class=""nav-link count-indicator d-flex justify-content-center align-items-center"" href=""/personel/liste"">"
				' 	Response.Write "<i class=""mdi mdi-account mx-0"" title=""Personel Listesi""></i>"
				' 	Response.Write "</a>"
				' 	Response.Write "</li>"
				' end i
				'##### MENÜLER
				'##### MENÜLER
				'##### MENÜLER
					sorgu = "select id,"
					if klang = "tr" then
						sorgu = sorgu & "ad"
					else
						sorgu = sorgu & "ad_en as ad"
					end if
					sorgu = sorgu & ",link,icon,target from portal.menuler where (firmaID = 0 or firmaID = " & firmaID & ") and ustID = '0' and " & yetkisorgu & " and panelKullanimTuru in ('" & sb_panelKullanimTuru & "','All') and menuYeri = 'TopRight' order by sira asc"
					rs.open sorgu, sbsv5, 1, 3
						for ri = 1 to rs.recordcount
							ad		=	rs("ad")
							link	=	rs("link")
							icon	=	rs("icon")
							target	=	rs("target") & ""
							if link = "#" or isnull(link) = True then
							else
								if target = "" then
									Response.Write "<li class=""nav-item dropdown mr-1"">"
									Response.Write "<a class=""nav-link count-indicator d-flex justify-content-center align-items-center"" href=""/" & link & """>"
									Response.Write "<i class=""" & icon & """ title="""
									if klang = "tr" then
										Response.Write ad
									else
										Response.Write ad_en
									end if
									Response.Write """></i>"
									Response.Write "</a>"
									Response.Write "</li>"
								elseif target = "modal" then
									Response.Write "<li class=""nav-item dropdown mr-1"">"
									Response.Write "<a class=""nav-link count-indicator d-flex justify-content-center align-items-center"" onClick=""modalajax('/" & link & "')"">"
									Response.Write "<i class=""" & icon & """ title="""
									if klang = "tr" then
										Response.Write ad
									else
										Response.Write ad_en
									end if
									Response.Write """></i>"
									Response.Write "</a>"
									Response.Write "</li>"
								end if
							end if
						rs.movenext
						next
					rs.close
				'##### MENÜLER
				'##### MENÜLER
				'##### MENÜLER






				' if GorevEkle = True then
					' Response.Write "<li class=""nav-item dropdown mr-1"">"
					' Response.Write "<a class=""nav-link count-indicator d-flex justify-content-center align-items-center"" onClick=""modalajax('/gorev/yeni_ajax.asp')"">"
					' Response.Write "<i class=""mdi mdi-calendar-plus mx-0"" title=""Hızlı Görev Ekle""></i>"
					' Response.Write "</a>"
					' Response.Write "</li>"
				' end if

				' if GorevEkle = True then
				' 	Response.Write "<li class=""nav-item dropdown mr-1"">"
				' 	Response.Write "<a class=""nav-link count-indicator d-flex justify-content-center align-items-center"" href=""/gorev/yeni"">"
				' 	Response.Write "<i class=""mdi mdi-calendar-clock mx-0"" title=""Ayrıntılı Görev Ekle""></i>"
				' 	Response.Write "</a>"
				' 	Response.Write "</li>"
				' end if

				' if GorevListele = True then
				' 	Response.Write "<li class=""nav-item dropdown mr-1"">"
				' 	Response.Write "<a class=""nav-link count-indicator d-flex justify-content-center align-items-center"" href=""/gorev/liste"">"
				' 	Response.Write "<i class=""mdi mdi-calendar mx-0"" title=""Görev Listesi""></i>"
				' 	Response.Write "</a>"
				' 	Response.Write "</li>"
				' end if




			'## MESAJLAR
			'## MESAJLAR
				' Response.Write "<li class=""nav-item dropdown mr-1"">"
				' Response.Write "<a class=""nav-link count-indicator dropdown-toggle d-flex justify-content-center align-items-center"" id=""messageDropdown"" href=""#"" data-toggle=""dropdown"">"
				' Response.Write "<i class=""mdi mdi-bell mx-0""></i>"
				' Response.Write "<span class=""count"">5</span>"
				' Response.Write "</a>"
				' Response.Write "<div class=""dropdown-menu dropdown-menu-right navbar-dropdown"" aria-labelledby=""messageDropdown"">"
				' Response.Write "<p class=""mb-0 font-weight-normal float-left dropdown-header"">Mesajlar</p>"
				' Response.Write "<a class=""dropdown-item"">"
				' Response.Write "<div class=""item-content flex-grow"">"
				' Response.Write "<h6 class=""ellipsis font-weight-normal"">Başlık</h6>"
				' Response.Write "<p class=""font-weight-light small-text text-muted mb-0"">Mesaj</p>"
				' Response.Write "</div>"
				' Response.Write "</a>"
				' Response.Write "</div>"
				Response.Write "</li>"
			'## MESAJLAR
			'## MESAJLAR


			'## TEKLİF
			'## TEKLİF
			yetkiTeklif = yetkibul("Teklif")
			if yetkiTeklif >= 3 then
					Response.Write "<li class=""nav-item dropdown mr-1"">"
					Response.Write "<a class=""nav-link count-indicator d-flex justify-content-center align-items-center"">"
					Response.Write "<i class=""mdi mdi-basket-unfill"" title=""Yeni Teklif Oluştur"" onClick=""modalajaxfit('/teklif/teklif_yeni_modal.asp')""></i>"
					' Response.Write "<i class=""icon email"" title=""E-Mail Listesi""></i>"
					if yetkiTeklif >= 5 then
						Response.Write "<div class=""badge badge-pill badge-warning"" onClick=""modalajaxfit('/teklif/teklif_onay_modal.asp')""><span class=""teklifOnaySayi"">0</span></div>"
					end if
					Response.Write "</a>"
					Response.Write "</li>"
			end if
			'## TEKLİF
			'## TEKLİF


			'## MAİL
			'## MAİL
			if webmailUser <> "" then
					Response.Write "<li class=""nav-item dropdown mr-1"">"
					Response.Write "<a class=""nav-link count-indicator d-flex justify-content-center align-items-center"" href=""/webmail/mail"">"
					Response.Write "<i class=""mdi mdi-email-variant"" title=""E-Mail Listesi""></i>"
					' Response.Write "<i class=""icon email"" title=""E-Mail Listesi""></i>"
						Response.Write "<div class=""badge badge-pill badge-warning""><span class=""mailSayi"">0</span></div>"
					Response.Write "</a>"
					Response.Write "</li>"
			end if
			'## MAİL
			'## MAİL


			'## BİLDİRİM ALANI
			'## BİLDİRİM ALANI
				sorgu = "Select top 50 notificationID,icerik,onem from portal.notification where okundu = 0 and firmaID = " & firmaID & " and kid =  " & kid & " and tarih >= '" & tarihsql(date()-3) & "' order by notificationID desc"
				rs.Open sorgu, sbsv5, 1, 3
					Response.Write "<li class=""nav-item dropdown mr-1"
					if rs.recordcount = 0 then
						Response.Write " d-none"
					end if
					Response.Write " bildirimcontainer"">"
						Response.Write "<a class=""nav-link count-indicator dropdown-toggle d-flex justify-content-center align-items-center"" id=""messageDropdown"" href=""#"" data-toggle=""dropdown"" aria-expanded=""true"">"
							Response.Write "<i class=""mdi mdi-bell""></i>"
							Response.Write "<div class=""badge badge-pill badge-success""><span class=""bildirimsayi"">" & rs.recordcount & "</span></div>"
						Response.Write "</a>"
						Response.Write "<div class=""dropdown-menu dropdown-menu-right navbar-dropdown"" aria-labelledby=""messageDropdown"">"
							for i = 1 to rs.recordcount
								Response.Write "<a class=""dropdown-item bildirimitem bildirimitem" & rs("notificationID") & """>"
									Response.Write "<div class=""item-content flex-grow"">"
										Response.Write "<h6 class=""ellipsis font-weight-normal"" onClick=""modalajax('/portal/notificationModal.asp?gorevID=" & rs("notificationID") & "')"">"
											Response.Write rs("icerik")
										Response.Write "</h6>"
									Response.Write "</div>"
								Response.Write "</a>"
								if i = 10 then
									exit for
								end if
							rs.movenext
							next
								Response.Write "<a class=""dropdown-item bildirimitem bildirimitemTum bg-info"">"
									Response.Write "<div class=""item-content flex-grow"">"
										Response.Write "<h6 class=""ellipsis font-weight-normal"" onClick=""document.location = '/portal/notification'"">"
											Response.Write "Tüm bildirimleri incele"
										Response.Write "</h6>"
									Response.Write "</div>"
								Response.Write "</a>"
						Response.Write "</div>"
					Response.Write "</li>"
				' end if
				rs.close
			'## BİLDİRİM ALANI
			'## BİLDİRİM ALANI


			'## KULLANICI MENÜSÜ
			'## KULLANICI MENÜSÜ
			personel64 = kid
			personel64 = base64_encode_tr(personel64)
			Response.Write "<li class=""nav-item nav-profile dropdown"">"
			Response.Write "<a class=""nav-link dropdown-toggle"" href=""#"" data-toggle=""dropdown"" id=""profileDropdown""><span class=""nav-profile-name"">" & personelAd & " " & personelSoyad & "</span></a>"
			Response.Write "<div class=""dropdown-menu dropdown-menu-right navbar-dropdown"" aria-labelledby=""profileDropdown"">"
			Response.Write "<a class=""dropdown-item"" onClick=""modalajax('/personel/personel_yeni.asp?gorevID=" & personel64 & "');""><i class=""mdi mdi-settings text-primary""></i>" & translate("Ayarlar","","") & "</a>"
			Response.Write "<a class=""dropdown-item"" href=""/personel/logout.asp""><i class=""mdi mdi-logout text-primary""></i>" & translate("Çıkış","","") & "</a>"
			Response.Write "</div>"
			Response.Write "</li>"
			'## KULLANICI MENÜSÜ
			'## KULLANICI MENÜSÜ



		Response.Write "</ul>"
	'########### ÜST BAR
	'########### ÜST BAR
					Response.Write "<button class=""navbar-toggler navbar-toggler-right d-lg-none align-self-center"" type=""button"" data-toggle=""offcanvas""><span class=""mdi mdi-menu""></span></button>"
				Response.Write "</div>"
			Response.Write "</nav>"





	Response.Write "<div class=""container-fluid page-body-wrapper"">"


	'########### SOL BAR
	'########### SOL BAR
		Response.Write "<nav class=""sidebar sidebar-offcanvas"" id=""sidebar"">"
		Response.Write "<ul class=""nav"">"

			'##### MENÜLER
			'##### MENÜLER
			'##### MENÜLER
				sorgu = "select id,"
				if klang = "tr" then
					sorgu = sorgu & "ad"
				else
					sorgu = sorgu & "ad_en as ad"
				end if
				sorgu = sorgu & ",link,icon,target,yetkigrup from portal.menuler where (firmaID = 0 or firmaID = " & firmaID & ") and ustID = '0' and " & yetkisorgu & " and (panelKullanimTuru in ('" & sb_panelKullanimTuru & "','All') or panelKullanimTuru is null) and menuYeri is null order by sira asc"
				rs.open sorgu, sbsv5, 1, 3
					for ri = 1 to rs.recordcount
						ad		=	rs("ad")
						link	=	rs("link")
						icon	=	rs("icon")
						target	=	rs("target") & ""
						yetkigrup	=	rs("yetkigrup") & ""
						if link = "#" or isnull(link) = True then
							Response.Write "<li class=""nav-item""><a class=""nav-link"" data-toggle=""collapse"" href=""#ui-basic" & ri & """ aria-expanded=""false"" aria-controls=""ui-basic" & ri & """>"
							Response.Write "<i class="""
							Response.Write icon
							Response.Write " menu-icon""></i>"
							Response.Write "<span class=""menu-title"">"
							Response.Write ad
							Response.Write "</span><i class=""menu-arrow""></i></a>"
							Response.Write "<div class=""collapse"" id=""ui-basic" & ri & """>"
							Response.Write "<ul class=""nav flex-column sub-menu"">"
								if yetkigrup = "Raporlar" then
									'######### RAPORLAR
									'######### RAPORLAR
										sorgu = "Select raporID,raporAd,raporDosya,raporIcon,raporTuru from rapor.raporIndex where firmaID = " & firmaID & " and silinmis = 'False' order by siraMenu asc"
										rs3.open sorgu, sbsv5, 1, 3
											for riii = 1 to rs3.recordcount
												raporAd		=	rs3("raporAd")
												raporDosya	=	rs3("raporDosya")
												raporIcon	=	rs3("raporIcon")
												raporTuru	=	rs3("raporTuru")
												raporID		=	rs3("raporID")
												if raporTuru = "datatable" or raporTuru = "htmltable" then
													raporID64	=	raporID
													raporID64	=	base64_encode_tr(raporID64)
													raporDosya	=	"rapor/genel/" & raporID64
												end if
												Response.Write "<li class=""nav-item"">"
												Response.Write "<a href=""/"
												Response.Write raporDosya
												Response.Write """"
												Response.Write """ class=""nav-link"">"
												Response.Write "<i class="""
												Response.Write raporIcon
												Response.Write """></i>"
												Response.Write "&nbsp;"
												Response.Write raporAd
												Response.Write "</a>"
												Response.Write "</li>"
											rs3.movenext
											next
										rs3.close
									'######### RAPORLAR
									'######### RAPORLAR
								end if
							sorgu = "select id,"
							if klang = "tr" then
								sorgu = sorgu & "ad"
							else
								sorgu = sorgu & "ad_en as ad"
							end if
							sorgu = sorgu & ",link,icon,target,yetkigrup from portal.menuler where (firmaID = 0 or firmaID = " & firmaID & ") and ustID = " & rs("ID") & " and " & yetkisorgu & " order by sira asc"
							rs2.open sorgu, sbsv5, 1, 3
								for rii = 1 to rs2.recordcount
									if gelenadres4 = link then
										acikmenu = ri
									end if
									ad			=	rs2("ad")
									link		=	rs2("link")
									icon		=	rs2("icon")
									target		=	rs2("target") & ""
									if link = "#" then
										Response.Write "<li class=""nav-item""><a class=""nav-link"" href=""#"">"
										Response.Write "<i class="""
										Response.Write icon
										Response.Write " menu-icon""></i>"
										Response.Write ad
										Response.Write "</a></li>"
									else
										Response.Write "<li class=""nav-item"">"
										if target = "" then
											Response.Write "<a href=""/"
											Response.Write link
											Response.Write """"
										else
											if target = "frameless" then
												Response.Write "<a href=""/"
												Response.Write link
												Response.Write ".asp"""
											elseif target = "framelessblank" then
												Response.Write "<a href=""/"
												Response.Write link
												Response.Write ".asp"""
												Response.Write " target="""
												Response.Write target
												Response.Write """"
											else
												Response.Write "<a href=""/"
												Response.Write link
												Response.Write """"
												Response.Write " target="""
												Response.Write target
												Response.Write """"
											end if
										end if
										Response.Write """ class=""nav-link""><i class="""
										Response.Write icon
										Response.Write """></i>&nbsp;"
										Response.Write ad
										Response.Write "</a>"
										Response.Write "</li>"
									end if
								rs2.movenext
								next
							rs2.close
							Response.Write "</ul>"
							Response.Write "</div>"
							Response.Write "</li>"
						else
							Response.Write "<li class=""nav-item"">"
							if target = "" then
								Response.Write "<a href=""/"
								Response.Write link
								Response.Write """"
							elseif target = "frameless" then
									Response.Write "<a href=""/"
									Response.Write link
									Response.Write ".asp"""
							elseif target = "framelessblank" then
									Response.Write "<a href=""/"
									Response.Write link
									Response.Write ".asp"""
									Response.Write " target="""
									Response.Write target
									Response.Write """"
							elseif target = "_blank" then
									Response.Write "<a href="""
									Response.Write link
									Response.Write """"
									Response.Write " target="""
									Response.Write "_blank"
									Response.Write """"
							else
									Response.Write "<a href=""/"
									Response.Write link
									Response.Write """"
									Response.Write " target="""
									Response.Write target
									Response.Write """"
							end if
							Response.Write """ class=""nav-link"">"
							if left(icon,1) = "/" then
								Response.Write "<img src="""
								Response.Write icon
								Response.Write """/>"
							else 
								Response.Write "<i class="""
								Response.Write icon
								Response.Write """></i>"
							end if
							Response.Write "&nbsp;"
							Response.Write ad
							Response.Write "</a>"
							Response.Write "</li>"
						end if
					rs.movenext
					next
				rs.close
			'##### MENÜLER
			'##### MENÜLER
			'##### MENÜLER

		Response.Write "</ul>"
		Response.Write "</nav>"
	'########### SOL BAR
	'########### SOL BAR




		Response.Write "<div class=""main-panel"">"
			'########### ORTA ALAN
			'########### ORTA ALAN
				Response.Write "<div class=""content-wrapper"" id=""ortaalan"" style=""background:#f3f3f3 !important"">"
				'### sayfayı ateşle
				'### sayfayı ateşle
					if sayfa3 = "" then
						' if GorevListele = True then
						' 	Server.Execute "/gorev/liste.asp"
						' else
						if passwordChangeFirstLogin = True then
							Server.Execute "/personel/sifre.asp"
						else
							Server.Execute "/dashboard/dashboard.asp"
						end if
					end if
					if sayfa5 <> "" or sayfa4 <> "" then
						dosyaad = "/" & sayfa3 & "/" & sayfa4 & ".asp"
						if dosyakontrol(dosyaad) = True then
							Server.Execute dosyaad
						end if
					elseif sayfa3 <> "" then
						dosyaad = "/" & sayfa3 & ".asp"
						if dosyakontrol(dosyaad) = True then
							Server.Execute dosyaad
						end if
					end if
				'### sayfayı ateşle
				'### sayfayı ateşle
				Response.Write "</div>"
			'########### ORTA ALAN
			'########### ORTA ALAN
			'########### ALT BAR
			'########### ALT BAR
				Response.Write "<footer class=""footer"">"
				Response.Write "<div class=""d-sm-flex justify-content-center justify-content-sm-between"">"
				Response.Write "<span class=""text-muted text-center text-sm-left d-block d-sm-inline-block"">Copyright © " & year(date()) & " <a href=""http://" & firmaURL & """ target=""_blank"">" & firmaAd & "</a>. " & translate("Her Hakkı Saklıdır","","") & ".</span>"
				'Response.Write "<span class=""float-none float-sm-right d-block mt-1 mt-sm-0 text-center"">Hand-crafted & made with <i class=""mdi mdi-heart text-danger""></i></span>"
				Response.Write "</div>"
				Response.Write "</footer>"
			'########### ALT BAR
			'########### ALT BAR
		Response.Write "</div>"
	Response.Write "</div>"
	Response.Write "</div>"
else


	call logla("Şifre Giriş Ekranı")
	Response.Write "<div class=""container-fluid mt-5"">"
	Response.Write "<div class=""row"">"
		Response.Write "<div class=""col-lg-4 col-md-4 col-sm-1 col-xs-1""></div>"
		Response.Write "<div class=""col-lg-4 col-md-4 col-sm-10 col-xs-10"">"
			Response.Write "<div class=""card"">"
			Response.Write "<div class=""card-header text-white bg-primary"">" & firmaAd &" Giriş İşlemi</div>"
			Response.Write "<div class=""card-body"">"
				Response.Write "<form action=""/personel/login.asp"" method=""post"" class=""ajaxform"">"
					if firmaSSO = "" then
						Response.Write "<div>"
						Response.Write "<div class=""badge badge-secondary"">Kullanıcı Adınız</div>"
						call forminput("email",email,"","","","","email","")
						Response.Write "</div>"
						Response.Write "<div class=""mt-4"">"
						Response.Write "<div class=""badge badge-secondary"">Şifreniz</div>"
						call forminput("password",password,"","","","password","password","")
						Response.Write "</div>"
						Response.Write "<div class=""mt-4"">"
						Response.Write "<button class=""form-control btn btn-success"" type=""submit"">Giriş Yap</button>"
						Response.Write "</div>"
					elseif firmaSSO = "ADC" then
						Response.Write "<div>"
						Response.Write "<div class=""badge badge-secondary"">Bilgisayarı açtığınız kullanıcı adı</div>"
						call forminput("email",email,"","","","","email","")
						Response.Write "</div>"
						Response.Write "<div class=""mt-4"">"
						Response.Write "<div class=""badge badge-secondary"">Şifre</div>"
						call forminput("password",password,"","","","password","password","")
						Response.Write "</div>"
						Response.Write "<div class=""mt-4"">"
						Response.Write "<button class=""form-control btn btn-success"" type=""submit"">Giriş Yap</button>"
						Response.Write "</div>"
					elseif firmaSSO = "NETSIS" then
						Response.Write "<div>"
						Response.Write "<div class=""badge badge-secondary"">Kullanıcı Adınız</div>"
						call forminput("email",email,"","","","","email","")
						Response.Write "</div>"
						Response.Write "<div class=""mt-4"">"
						Response.Write "<div class=""badge badge-secondary"">Şifreniz</div>"
						call forminput("password",password,"","","","password","password","")
						Response.Write "</div>"
						Response.Write "<div class=""mt-4"">"
						Response.Write "<button class=""form-control btn btn-success"" type=""submit"">Giriş Yap</button>"
						Response.Write "</div>"
					else
						Response.Write "<div>"
						Response.Write "<div class=""badge badge-secondary"">Kullanıcı Adınız</div>"
						call forminput("email",email,"","","","","email","")
						Response.Write "</div>"
						Response.Write "<div class=""mt-4"">"
						Response.Write "<div class=""badge badge-secondary"">Şifreniz</div>"
						call forminput("password",password,"","","","password","password","")
						Response.Write "</div>"
						Response.Write "<div class=""mt-4"">"
						Response.Write "<button class=""form-control btn btn-success"" type=""submit"">Giriş Yap</button>"
						Response.Write "</div>"
					end if
				Response.Write "</form>"
			Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""col-lg-4 col-md-4 col-sm-1 col-xs-1""></div>"
	Response.Write "</div>"
	Response.Write "</div>"
end if

Response.Write "<div id=""ajax"" class=""d-none""></div>"

'#### ZAMANLANMIŞ GÖREVLER
'#### ZAMANLANMIŞ GÖREVLER
	Response.Write "<div id=""activeuserUrl"" class=""d-none"">"
	Server.Execute sb_activeuserUrl
	Response.Write "</div>"
'#### ZAMANLANMIŞ GÖREVLER
'#### ZAMANLANMIŞ GÖREVLER

Response.Write "<scr" & "ipt src=""/template/bootstrap-datepicker/js/bootstrap-datepicker.min.js""></scr" & "ipt>"
Response.Write "<scr" & "ipt src=""/template/bootstrap-datepicker/locales/bootstrap-datepicker.tr.min.js""></scr" & "ipt>"

'Response.Write "<scr" & "ipt src=""/template/vendors/chart.js/Chart.min.js""></scr" & "ipt>"
Response.Write "<scr" & "ipt src=""/template/vendors/datatables.net/jquery.dataTables.js""></scr" & "ipt>"
Response.Write "<scr" & "ipt src=""/template/vendors/datatables.net-bs4/dataTables.bootstrap4.js""></scr" & "ipt>"
Response.Write "<scr" & "ipt src=""/template/js/off-canvas.js""></scr" & "ipt>"
'Response.Write "<scr" & "ipt src=""/template/js/hoverable-collapse.js""></scr" & "ipt>"
'Response.Write "<scr" & "ipt src=""/template/js/template.js""></scr" & "ipt>"
'Response.Write "<scr" & "ipt src=""/template/js/dashboard.js""></scr" & "ipt>"
'Response.Write "<scr" & "ipt src=""/template/js/data-table.js""></scr" & "ipt>"
'Response.Write "<scr" & "ipt src=""/template/js/jquery.dataTables.js""></scr" & "ipt>"
'Response.Write "<scr" & "ipt src=""/template/js/dataTables.bootstrap4.js""></scr" & "ipt>"


Response.Write "<link href=""/template/vendors/summernote/summernote.min.css"" rel=""stylesheet"">"
Response.Write "<script src=""/template/vendors/summernote/summernote.min.js""></script>"

Response.Write "<scr" & "ipt src=""/template/select2.min.js""></scr" & "ipt>"
Response.Write "<scr" & "ipt src=""/template/bootbox.min.js""></scr" & "ipt>"
Response.Write "<scr" & "ipt src=""/template/fonksiyonlar.js""></scr" & "ipt>"
Response.Write "<scr" & "ipt type=""text/javascript"" src=""/template/toastr/toastr.min.js""></scr" & "ipt>"

Response.Write "<link href=""/template/toastr/toastr.min.css"" rel=""stylesheet"" />"
Response.Write "<link href=""/template/select2.css"" rel=""stylesheet"">"
Response.Write "<link href=""/template/select2-bootstrap4.css"" rel=""stylesheet"">"
Response.Write "<link href=""/template/swal/dist/sweetalert2.min.css"" rel=""stylesheet"" />"
Response.Write "<scr" & "ipt type=""text/javascript"" src=""/template/swal/dist/sweetalert2.min.js""></scr" & "ipt>"

Response.Write "<div class=""modal fade"" id=""modal-dialog"" tabindex=""-1"" role=""dialog"" aria-labelledby=""modalbaslik"" aria-hidden=""true""><div class=""modal-dialog modal-lg""><div class=""modal-content"" style=""background:whitesmoke;""><div class=""modal-body"" id=""modalform""></div></div></div></div>"
Response.Write "<div class=""modal fade"" id=""modal-dialogfit"" role=""dialog"" aria-labelledby=""modalbaslik"" aria-hidden=""true""><div class=""modal-dialog modal-xl""><div class=""modal-content"" style=""background:whitesmoke;""><div class=""modal-body""></div></div></div></div>"



Response.Write "</body>"
Response.Write "</html>"

%><!--#include virtual="/reg/rs.asp" -->