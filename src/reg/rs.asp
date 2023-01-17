<%
lngTimer	=	Timer
if sbsv5 <> "" then
	sbsv5.close
	set sbsv5 = Nothing
	sayfasonu = True
end if



if sayfasonu = True then
else
	%><!--#include virtual="/temp/sabitler.asp" --><%
	set sbsv5=Server.CreateObject("ADODB.Connection")
	baglantibilgileri = "Provider=SQLOLEDB;Data Source=" & sb_dbsunucu & ";Initial Catalog=" & sb_dbad & ";User Id=" & sb_dbuser & ";Password=" & sb_dbpass & ";"
	sbsv5.Open baglantibilgileri
	Set rs = Server.CreateObject("ADODB.Recordset")
	Set rs1 = Server.CreateObject("ADODB.Recordset")
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	Set rs3 = Server.CreateObject("ADODB.Recordset")
	Set rs4 = Server.CreateObject("ADODB.Recordset")
	Set fn1 = Server.CreateObject("ADODB.Recordset")
	Set fn2 = Server.CreateObject("ADODB.Recordset")
	Set fn3 = Server.CreateObject("ADODB.Recordset")
	'### ENERJİ KORUMASI
	'### ENERJİ KORUMASI
		if firmaID = "" then
			firmaID = Session("firmaID")
		end if
		if mainUrl = "" then
			mainUrl = Session("mainUrl")
		end if
		if firmaSSO = "" then
			firmaSSO = Session("firmaSSO")
		end if
	'### ENERJİ KORUMASI
	'### ENERJİ KORUMASI
	'### YAPICAK BİŞİ YOK :(
	'### YAPICAK BİŞİ YOK :(
		if firmaID = "" or mainUrl = "" then
			'#### firma ve sunucu bilgilerine eriş
			'#### firma ve sunucu bilgilerine eriş
				site = Request.ServerVariables("HTTP_HOST")
				sorgu = "Select Id,url,url2,url3,SSO from portal.firma where (url = '" & site & "' or url2 = '" & site & "' or url3 = '" & site & "' or url4 = '" & site & "')"
				rs.open sorgu,sbsv5,1,3
				if rs.recordcount = 1 then
					firmaID = rs("Id")
					firmaSSO = rs("SSO")
					if rs("url") = site then
						mainUrl = rs("url")
					elseif rs("url2") = site then
						mainUrl = rs("url2")
					elseif rs("url3") = site then
						mainUrl = rs("url3")
					end if
				else
					Response.Write "Fatal Error!! There is no company information.<br />Please contact IT dept!"
					Response.End()
				end if
				rs.close
			'#### firma ve sunucu bilgilerine eriş
			'#### firma ve sunucu bilgilerine eriş
			Session("mainUrl")	=	mainUrl
			Session("firmaID")	=	firmaID
			Session("firmaSSO")	=	firmaSSO
		end if
	'### YAPICAK BİŞİ YOK :(
	'### YAPICAK BİŞİ YOK :(
	'### Site sabitlerini çek
	'### Site sabitlerini çek
		%><!--#include virtual="/temp/sabitler_ek.asp" --><%
	'### Site sabitlerini çek
	'### Site sabitlerini çek
	'### SSO Başka DB ise
	'### SSO Başka DB ise
		if firmaSSO = "NETSIS" then
			set ssov5=Server.CreateObject("ADODB.Connection")
			baglantibilgileri2 = "Provider=SQLOLEDB;Data Source=" & sb_dbsunucu & ";Initial Catalog=" & firmaSSOdb & ";User Id=" & sb_dbuser & ";Password=" & sb_dbpass & ";"
			ssov5.Open baglantibilgileri2
		end if
	'### SSO Başka DB ise
	'### SSO Başka DB ise

	'### CARİ'leri dış DB'den alıyorsa
	'### CARİ'leri dış DB'den alıyorsa
		if firmaCariDBvar = 1 then
			set rsCari=Server.CreateObject("ADODB.Connection")
			cariDBbaglanti = "Provider=SQLOLEDB;Data Source=" & firmaCariSunucu & ";Initial Catalog=" & firmaCariDB & ";User Id=" & firmaCaridbUSR & ";Password=" & firmaCaridbPass & ";"
			rsCari.Open cariDBbaglanti
			Set rsC = Server.CreateObject("ADODB.Recordset")
		end if
	'### CARİ'leri dış DB'den alıyorsa
	'### CARİ'leri dış DB'den alıyorsa

	'### STOK'ları dış DB'den alıyorsa
	'### STOK'ları dış DB'den alıyorsa
		if firmaStokDBvar = 1 then
			set rsStok=Server.CreateObject("ADODB.Connection")
			stokDBbaglanti = "Provider=SQLOLEDB;Data Source=" & firmaStokSunucu & ";Initial Catalog=" & firmaStokDB & ";User Id=" & firmaStokdbUSR & ";Password=" & firmaStokdbPass & ";"
			rsStok.Open stokDBbaglanti
			Set rsS = Server.CreateObject("ADODB.Recordset")
		end if
	'### STOK'ları dış DB'den alıyorsa
	'### STOK'ları dış DB'den alıyorsa
	
	'### DİL
	'### DİL
	%><!--#include virtual="/temp/language.asp" --><%
	'### DİL
	'### DİL
	%><!--#include virtual="/reg/array.asp" --><!--#include virtual="/reg/fonksiyonlar.asp" --><%
end if
%>