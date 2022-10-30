<!--#include virtual="/reg/rs.asp" --><%


'### FORM VERİLERİNİ TOPLA
'### FORM VERİLERİNİ TOPLA
	username	=	Request.Form("email") 
	password	=	Request.Form("password")
	password2 = password
	site		=	Request.ServerVariables("HTTP_HOST")
	call logla("Şifre Denemesi")
	if username = "" then
		hatamesaj = "Lütfen Giriş Bilgilerinizi Eksiksiz Yazın"
		call logla(hatamesaj)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
	if password = "" then
		hatamesaj = "Lütfen Şifrenizi Yazın"
		call logla(hatamesaj)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
'### FORM VERİLERİNİ TOPLA
'### FORM VERİLERİNİ TOPLA


'###### FİRMAYI BUL
'###### FİRMAYI BUL
	' sorgu = "Select id,logo,logoMini,SSO,SSOAdres,SSODomain,SSOLdap from portal.Firma where id = " & firmaID
	' rs.Open sorgu, sbsv5, 1, 3
	' if rs.recordcount = 0 then
	' 	hata = "Tanımsız Firma"
	' elseif rs.recordcount = 1 then
	' 	' firmaID		=	rs("id")
	' 	firmaLogo	=	rs("logo")
	' 	firmaLogo2	=	rs("logoMini")
	' 	SSO			=	rs("SSO") & ""
	' 	SSOAdres	=	rs("SSOAdres") & ""
	' 	SSODomain	=	rs("SSODomain") & ""
	' 	SSOLdap		=	rs("SSOLdap") & ""
	' end if
	' rs.close
	call logla("Şifre Doğrulanıyor")
'###### FİRMAYI BUL
'###### FİRMAYI BUL


if firmaSSO = "ADC" then
	if firmaSSOAdres <> "" then
		if left(firmaSSOAdres,1) = "/" then
			DCuser = username
			DCpass = password
			if instr(DCuser,"\") > 0 then
				DCuser = "agrobestgroup\" & DCuser'adrossen olabilir
				RQdata = Split(DCuser,"\")
			end if
			Set objConnection = CreateObject("ADODB.Connection")
			objConnection.Provider = "ADsDSOObject"
			With objConnection
				.Properties("User ID") = DCuser
				.Properties("Password") = DCpass
				.Properties("Encrypt password") = True
			End With
			objConnection.Open "Active Directory Provider"
			Set objCommand = CreateObject("ADODB.Command")
			Set objCommand.ActiveConnection = objConnection
			objCommand.Properties("Searchscope") = 2
			DCalanlar = Split("distinguishedname,givenName,sn,displayName,telephoneNumber,otherTelephone,mail,wWWHomePage,url,streetAddress,l,st,postalCode,userPrincipalName,sAMAccountName,userAccountControl,profilePath,scriptPath,homeDirectory,homeDrive,homeDirectory,title,department,company,manager,mobile,facsimileTelephoneNumber,info",",")
			DCSorgu = ""
			DCSayi = 27
				for i = 0 to DCSayi'ubound(DCalanlar)-1
					DCSorgu = DCSorgu & DCalanlar(i)
					DCSorgu = DCSorgu & ","
				next
			objCommand.CommandText ="select " & DCSorgu & "c FROM '" & firmaSSOLdap & "' where sAMAccountName = '" & DCuser & "' ORDER by sAMAccountname"
			on error resume next
				Set objRecordSet 				=	objCommand.Execute
					DCdisplayName				=	objRecordSet.fields("displayName")
					DCtelephoneNumber			=	objRecordSet.fields("telephoneNumber")
					DCmail						=	objRecordSet.fields("mail")
					DCuserAccountControl		=	objRecordSet.fields("userAccountControl")
					DCtitle						=	objRecordSet.fields("title")
					DCdepartment				=	objRecordSet.fields("department")
					DCmobile					=	objRecordSet.fields("mobile")
					DCfacsimileTelephoneNumber	=	objRecordSet.fields("facsimileTelephoneNumber")
					if err.Number = 0 then
						adclogin = True
					else
						adclogin = False
					end if
			on error goto 0
			if adclogin = True then
				'True|Başar Sönmez|5053376198|Basar.Sonmez@agrobestgrup.com|66048|Bilgi İşlem Takım Lideri|Bilgi İşlem|5053376198|184|
				sorgu = "Select * from personel.personel where personel.personel.username = '" & DCuser & "'"
				rs.open sorgu, sbsv5, 1, 3
					if rs.recordcount = 0 then
						rs.addnew
						rs("ad")	=	DCdisplayName
						rs("gorev")	=	DCtitle
						rs("password")	=	sqltemizle(password2)
						rs("ceptelefon")	=	DCmobile
						rs("email")	=	DCmail
						rs("username")	=	DCuser
						rs("firmaID")	=	firmaID
						rs("SSOID")		=	DCuserAccountControl
						rs.update
						personelID = rs("id")
					elseif rs.recordcount = 1 then
						if rs("password") & "" = "" then
							'### kullanıcı oluşturulmuş ama aktarılmamış
							password2 = password
							rs("ad")	=	DCdisplayName
							rs("gorev")	=	DCtitle
							rs("password")	=	sqltemizle(password2)
							rs("ceptelefon")	=	DCmobile
							rs("email")	=	DCmail
							rs("username")	=	DCuser
							rs("firmaID")	=	firmaID
							rs("SSOID")		=	DCuserAccountControl
							rs.update
							personelID = rs("id")
							'### kullanıcı oluşturulmuş ama aktarılmamış
						else
							rs("password")	=	sqltemizle(password2)
							rs.update
							'### KULLANICI ZATEN VAR
							personelID = rs("id")
							'### KULLANICI ZATEN VAR
						end if
					end if
				rs.close
				if personelID > 0 then
					sorgu		=	"INSERT INTO personel.personel_yetki (kid,yetkiAd,yetkiParametre) VALUES (" & personelID & ",'login','1')"
					fn1.open sorgu, sbsv5, 3, 3
				end if
			end if
		else
			'#### HARİCİ ADC
			'#### HARİCİ ADC
				adres	=	firmaSSOAdres
				adresek	=	username & "|" & password & "|" & firmaSSODomain & "|" & "1"
				adresek =	base64_encode_tr(adresek)
				adres	=	adres & "?ek=" & adresek
				Set SrvHTTPS = Server.CreateObject("MSXML2.ServerXMLHTTP")
				SrvHTTPS.open "POST", adres, false
				SrvHTTPS.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
				SrvHTTPS.send	veri
				gelendata	=	SrvHTTPS.responseText
				Set SrvHTTPS = Nothing
				Response.Write gelendata
				Response.End()
			'#### HARİCİ ADC
			'#### HARİCİ ADC
		end if
	end if
end if








if firmaSSO = "ADC" and adclogin = False then
	hatamesaj = "Hesabınızda bir sorun var. IT departmanı ile görüşün"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if












if firmaSSO = "NETSIS" then
	sorgu = "Select dbo.TRK(PLASIYER_ACIKLAMA) as PLASIYER_ACIKLAMA,PLASIYER_KODU From TBLCARIPLASIYER WHERE S_YEDEK1 = '" & username & "' and S_YEDEK2 = '" & password & "'"
	rs.open sorgu, ssov5, 1, 3
		if rs.recordcount = 0 then
			hatamesaj = "Netsis : Hatalı Kullanıcı adı veya şifre yazdınız"
			call logla(hatamesaj)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
			Response.End()
		else
			PLASIYER_KODU					=	rs("PLASIYER_KODU")
			PLASIYER_AD						=	rs("PLASIYER_ACIKLAMA")
			' id							=	rs("PLASIYER_KODU")
			' kid							=	id
			' kid							=	1000 + (kid*38)
			' Response.Cookies("kid")		=	base64_encode_tr(kid)
			' Response.Cookies("kidP")	=	base64_encode_tr(rs("PLASIYER_KODU"))
			' call jsconsole("ID : " & id)
		end if
	rs.close
	'### Başarılı giriş yapmış. Senkronize et
	'### Başarılı giriş yapmış. Senkronize et
		if PLASIYER_KODU <> "" then
				sorgu = "Select * from personel.personel where personel.personel.username = '" & DCuser & "'"
				rs.open sorgu, sbsv5, 1, 3
					if rs.recordcount = 0 then
						password2 = password
						rs.addnew
						rs("ad")			=	turkcele(PLASIYER_AD)
						' rs("gorev")		=	DCtitle
						rs("password")		=	sqltemizle(password2)
						' rs("ceptelefon")	=	DCmobile
						' rs("email")		=	DCmail
						rs("username")		=	username
						rs("firmaID")		=	firmaID
						rs("SSOID")			=	PLASIYER_KODU
						rs.update
						personelID			=	rs("id")
					elseif rs.recordcount = 1 then
						if rs("password") & "" = "" then
							'### kullanıcı oluşturulmuş ama aktarılmamış
							password2 = password
							rs("ad")			=	turkcele(PLASIYER_AD)
							' rs("gorev")		=	DCtitle
							rs("password")		=	sqltemizle(password2)
							' rs("ceptelefon")	=	DCmobile
							' rs("email")			=	DCmail
							rs("username")		=	username
							rs("firmaID")		=	firmaID
							rs("SSOID")			=	PLASIYER_KODU
							rs.update
							personelID			=	rs("id")
							'### kullanıcı oluşturulmuş ama aktarılmamış
						else
							rs("password")		=	sqltemizle(password2)
							rs.update
							'### KULLANICI ZATEN VAR
							personelID			=	rs("id")
							'### KULLANICI ZATEN VAR
						end if
					end if
				rs.close
				if personelID > 0 then
					sorgu		=	"INSERT INTO personel.personel_yetki (kid,yetkiAd,yetkiParametre) VALUES (" & personelID & ",'login','1')"
					fn1.open sorgu, sbsv5, 3, 3
				end if
		end if
	'### Başarılı giriş yapmış. Senkronize et
	'### Başarılı giriş yapmış. Senkronize et
end if






password	=	sqltemizle(password)
sorgu = ""
sorgu = sorgu & "SELECT" & vbcrlf
sorgu = sorgu & "personel.id," & vbcrlf
sorgu = sorgu & "personel.SSOID," & vbcrlf
sorgu = sorgu & "personel.LoginHatirla," & vbcrlf
sorgu = sorgu & "personel.expiration," & vbcrlf
sorgu = sorgu & "personel.songiris," & vbcrlf
sorgu = sorgu & "personel.sayac," & vbcrlf
sorgu = sorgu & "personel.language," & vbcrlf
sorgu = sorgu & "replace(" & vbcrlf
sorgu = sorgu & "replace(" & vbcrlf
sorgu = sorgu & "STUFF((SELECT '; ' + yetkiAd+':',yetkiParametre FROM personel.personel_yetki where personel.personel.id = personel.personel_yetki.kid FOR XML PATH('')), 1, 1, '')" & vbcrlf
sorgu = sorgu & ",'<yetkiParametre>','')" & vbcrlf
sorgu = sorgu & ",'</yetkiParametre>','')" & vbcrlf
sorgu = sorgu & "[yetkiler]" & vbcrlf
sorgu = sorgu & "from personel.personel" & vbcrlf
sorgu = sorgu & "WHERE (personel.email = '" & username & "' or personel.ceptelefon = '" & username & "' or personel.username = '" & username & "'"
if firmaSSO = "ADC" or firmaSSO = "NETSIS" then
	sorgu = sorgu & " or personel.username = '" & username & "'"
end if
sorgu = sorgu & ") and personel.password = '" & password & "'" & vbcrlf
sorgu = sorgu & " and personel.personel.firmaID = " & firmaID & vbcrlf
	rs.open sorgu, sbsv5, 1, 3
		if rs.recordcount = 0 then
			hatamesaj = "Hatalı Kullanıcı adı veya şifre yazdınız"
			call logla(hatamesaj)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
			Response.End()
		else
			'###### YETKİLERİ TEMİZE ÇEK
			'###### YETKİLERİ TEMİZE ÇEK
				' yetki = ""
				' for yi = 0 to ubound(yetkiarr)
				' 	if rs(yetkiarr(yi)) = 1 then
				' 		yetki = yetki & yetkiarr(yi) & "|"
				' 	end if
				' next
				' if right(yetki,1) = "|" then
				' 	yetki = left(yetki,len(yetki)-1)
				' end if
			'###### YETKİLERİ TEMİZE ÇEK
			'###### YETKİLERİ TEMİZE ÇEK
			id							=	rs("id")
			SSOID						=	rs("SSOID")
			kid							=	id
			personelID					=	kid
			kid							=	1000 + (kid*38)
			Response.Cookies("kid")		=	base64_encode_tr(kid)
			expiration					=	rs("expiration")
			LoginHatirla				=	rs("LoginHatirla")
			yetkiler					=	rs("yetkiler") & ""
			language					=	rs("language") & ""
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

			if SSOID & "" <> "" then
				Response.Cookies("SSO")	=	SSOID * 90210
				Response.Cookies("SSO").expires		=	date()+LoginHatirla
			end if

			if yetkiler = "" then
				sorgu		=	"INSERT INTO personel.personel_yetki (kid,yetkiAd,yetkiParametre) VALUES (" & personelID & ",'login','1')"
				fn1.open sorgu, sbsv5, 3, 3
			end if


		end if
	rs.close






	if expiration <= date() then
		hatamesaj = "Hesabınızın kulanım süresi dolmuş!"
		call logla(hatamesaj)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		call jsconsole(hatamesaj)
		Response.Cookies("kid")				=	""
		Response.Cookies("kid").Expires		=	date()-5
		' Response.Cookies("kye")				=	""
		' Response.Cookies("kye").Expires		=	date()-5
		Response.End()
	end if

	Response.Cookies("kid").expires		=	date()+LoginHatirla
	Response.Cookies("kye").expires		=	date()+LoginHatirla
	Response.Cookies("klang").expires	=	date()+LoginHatirla






	kid = personelID
	hatamesaj = "Başarılı Giriş"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	call jsgit("/")

	call bildirim(kid,"Genel Bildirim","ERP girişi yaptınız",1,0,"","","","","")


%><!--#include virtual="/reg/rs.asp" -->