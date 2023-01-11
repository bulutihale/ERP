<%
'sabitler
saat		=	hour(time())
dakika		=	minute(time())
gun			=	day(date())
ay			=	month(date())
yil			=	year(date())
bugun		=	date()

renklerArr	=	Array("danger","danger","warning""success","primary","info")


Function browser()
	strUserAgent = Request.ServerVariables("HTTP_USER_AGENT")
	if inStr(strUserAgent, "rv:11") > 0 then browser =  "IE"'ie11 15 aralık 2013
	if inStr(strUserAgent, "MSIE 11") > 0 then browser =  "IE"'varsayım
	if inStr(strUserAgent, "MSIE 10") > 0 then browser =  "IE"
	if inStr(strUserAgent, "MSIE 9") > 0 then browser =  "IE"
	if inStr(strUserAgent, "MSIE 8") > 0 then browser =  "IE"
	if inStr(strUserAgent, "MSIE 7") > 0 then browser =  "IE"
	if inStr(strUserAgent, "MSIE 6") > 0 then browser =  "IE"
	if inStr(strUserAgent, "MSIE 5") > 0 then browser =  "IE"
	if inStr(strUserAgent, "MSIE 4") > 0 then browser =  "IE"
	if inStr(strUserAgent, "MSIE 3") > 0 then browser =  "IE"
	if inStr(strUserAgent, "MSIE 2") > 0 then browser =  "IE"
	if inStr(strUserAgent, "Chrome") > 0 then browser =  "Chrome"
	if inStr(strUserAgent, "Opera") > 0 then browser =  "Opera"
	if inStr(strUserAgent, "Firefox") > 0 then browser =  "FireFox"
	if inStr(strUserAgent, "BlackBerry") > 0 then browser =  "BlackBerry"
End Function

Function unique()
	aa = now()'year(date())&month(date())&day(date())&hour(time())&minute(date())&second(date())
	aa = Replace(aa,":","")
	aa = Replace(aa," ","")
	aa = Replace(aa,".","")
	unique = aa
End Function

Function siparisnouret()
	siparisnouret = right(unique,12)
End Function

Function yukariyuvarla(sayi)
	if sayi-cint(sayi)>0 then
		yukariyuvarla=cint(sayi)+1
	else
		yukariyuvarla=cint(sayi)
	end if
End function

Function asagiyuvarla(sayi)
	if sayi-cint(sayi)<0 then
		asagiyuvarla=cint(sayi)-1
	else
		asagiyuvarla=cint(sayi)
	end if
End function

Function dosyakontrol(adres)
	if adres = "" then
	else
		set fs=Server.CreateObject("Scripting.FileSystemObject")
		if fs.FileExists(Server.Mappath(adres)) = True then
			dosyakontrol = True
		else
			dosyakontrol = False
		end if
		set fs = Nothing
	end if
end function

'############################################################################################################################ TEST
'############################################################################################################################ TEST
'############################################################################################################################ TEST
'############################################################################################################################ GÜVENLİK
'############################################################################################################################ GÜVENLİK
'############################################################################################################################ GÜVENLİK

function sessiontest()
	kid		=	kidbul()
	hedef	=	"/personel/login"
	if kid = "" then
		call jsgit(hedef)
		Response.End()
	else
		if isnumeric(kid) = True then
		else
			call jsgit(hedef)
			Response.End()
		end if
	end if
end function


function kidbul()
	kid_enc = Request.Cookies("kid")
	if kid_enc <> "" then
		kid_enc = base64_decode_tr(kid_enc)
		if isnumeric(kid_enc) = true then
			kidbul=(kid_enc-1000)/38
		end if
	end if
end function

function ssoIDbul()
	kid_enc = Request.Cookies("SSO")
	if kid_enc <> "" then
		if isnumeric(kid_enc) = true then
			ssoIDbul=kid_enc / 90210
		end if
	end if
end function

function jsonTemizle(deger)
'select2 için json oluştururken patlatan karakterleri temizle
	if not isnull(deger) then
		deger = Replace(deger,chr(10),"")
		deger = Replace(deger,chr(13),"")
	end if
	jsonTemizle	= deger
end function

Function sqltemizle(kelime)'şifre için
	kelime = Replace(kelime,"%27","")
	kelime = Replace(kelime,chr(8),"")
	kelime = Replace(kelime,chr(9),"")
	kelime = Replace(kelime,chr(10),"")
	kelime = Replace(kelime,chr(11),"")
	kelime = Replace(kelime,chr(12),"")
	kelime = Replace(kelime,chr(13),"")
	kelime = Replace(kelime,chr(14),"")
	kelime = Replace(kelime,chr(15),"")
	kelime = Replace(kelime,chr(34),"")
	kelime = Replace(kelime,chr(39),"")

		For si = 1 To Len(kelime)
			Krktr = Mid(kelime, si, 1)
			Krktr = Asc(Krktr)
			Krktr = Krktr - 15
			Krktr = Krktr Mod 256
			if Krktr < 1 then
				Krktr = Replace(Krktr,"-","")
			end if
			Krktr = Chr(Krktr)
			Cozuln = Cozuln & Krktr
		Next
			Cozuln = Replace(Cozuln,chr(39),"!")
			Cozuln = Replace(Cozuln,chr(34),"!")
			Cozuln = Replace(Cozuln,chr(60),"!")
			Cozuln = Replace(Cozuln,chr(62),"!")
			sqltemizle = Cozuln
End Function

function sqlinj(byVal deger)
	for kiinj = 0 to len(deger)
		karakterinj = left(right(deger,len(deger)-kiinj),1)
		if karakterinj = chr(33) or karakterinj = chr(34) or karakterinj = chr(35) or karakterinj = chr(36) or karakterinj = chr(37) or karakterinj = chr(38) or karakterinj = chr(39) or karakterinj = chr(40) or karakterinj = chr(41) or karakterinj = chr(42) or karakterinj = chr(61) or karakterinj = chr(63) or karakterinj = chr(64) then
			Response.End()
'			sitelog(12)'tag ile hack denemesi
		End if
	next
end function

Function htmlad(ad)
	htmlad = ad
	if ad <> "" then
		htmlad = Replace(htmlad,"İ","i")
		htmlad = Replace(htmlad,"I","i")
		htmlad = Replace(htmlad,"ı","i")
		htmlad = lcase(htmlad)
		htmlad = Replace(htmlad," ","-")
		htmlad = Replace(htmlad,"__","-")
		htmlad = Replace(htmlad,"/","")
		htmlad = Replace(htmlad,"\","")
		htmlad = Replace(htmlad,"$","")
		htmlad = Replace(htmlad,"@","")
		htmlad = Replace(htmlad,"€","")
		htmlad = Replace(htmlad,".","")
		htmlad = Replace(htmlad,"…","")
		htmlad = Replace(htmlad,",","")
		htmlad = Replace(htmlad,"!","")
		htmlad = Replace(htmlad,"*","")
		htmlad = Replace(htmlad,"'","")
		htmlad = Replace(htmlad,":","")
		htmlad = Replace(htmlad,"%","")
		htmlad = Replace(htmlad,"+","")
		htmlad = Replace(htmlad,"(","")
		htmlad = Replace(htmlad,")","")
		htmlad = Replace(htmlad,";","")
		htmlad = Replace(htmlad,"«","")
		htmlad = Replace(htmlad,"»","")
		htmlad = Replace(htmlad,"&","")
		htmlad = Replace(htmlad,"н","")
		htmlad = Replace(htmlad,"?","")
		htmlad = Replace(htmlad,"ü","u")
		htmlad = Replace(htmlad,"ş","s")
		htmlad = Replace(htmlad,"ö","o")
		htmlad = Replace(htmlad,"Ö","O")
		htmlad = Replace(htmlad,"Ğ","G")
		htmlad = Replace(htmlad,"ğ","g")
		htmlad = Replace(htmlad,"Ü","U")
		htmlad = Replace(htmlad,"'","")
		htmlad = Replace(htmlad,"ç","c")
		htmlad = Replace(htmlad,"Ç","C")
		htmlad = Replace(htmlad,"Ş","S")
		htmlad = Replace(htmlad,chr(34),"")
		htmlad = Replace(htmlad," ","-")
		htmlad = Replace(htmlad,"  ","-")
		htmlad = Replace(htmlad,"  ","-")
		htmlad = Replace(htmlad," ","-")
		htmlad = Replace(htmlad," ","-")
		htmlad = Replace(htmlad,"&","-")
		htmlad = Replace(htmlad,"’","-")
		htmlad = Replace(htmlad,"…","")
		htmlad = Replace(htmlad,"	","-")
		htmlad = Replace(htmlad,"_","-")
		htmlad = Replace(htmlad,"--","-")
		htmlad = Replace(htmlad,"--","-")
		htmlad = Replace(htmlad,"--","-")
		htmlad = Replace(htmlad,"--","-")
		htmlad = Replace(htmlad,"ø","")
		if right(htmlad,1) = "-" then
			htmlad = left(htmlad,len(htmlad)-1)
		end if
		if left(htmlad,1) = "-" then
			htmlad = right(htmlad,len(htmlad)-1)
		end if
	end if
End Function


Function ucasetr(gelen)
	if gelen <> "" then
		gelen = Replace(gelen,"ı","I")
		gelen = Replace(gelen,"i","İ")
		gelen = ucase(gelen)
		ucasetr = gelen
	end if
End Function

Function temptemizle()
	Set fso = CreateObject("Scripting.FileSystemObject")
		Set ana = fso.GetFolder(Server.Mappath("/temp"))
		Set dosyalar=ana.Files
			for each dosyaa in dosyalar
				dosyaa.Delete
			next
		Set dosyaa = Nothing
		Set dosyalar = Nothing
		Set ana = Nothing
		Set ana = fso.GetFolder(Server.Mappath("/temp2"))
		Set dosyalar=ana.Files
			for each dosyaa in dosyalar
				dosyaa.Delete
			next
		Set dosyaa = Nothing
		Set dosyalar = Nothing
		Set ana = Nothing
	Set fso = Nothing
End Function

Public Function RSSTemizle(strInput)
	strInput = Replace(strInput,"&", "&amp;", 1, -1, 1)
	strInput = Replace(strInput,"'", "", 1, -1, 1)
	strInput = Replace(strInput,"""", "&quot;", 1, -1, 1)
	strInput = Replace(strInput, ">", "&gt;", 1, -1, 1)
	strInput = Replace(strInput,"<","&lt;", 1, -1, 1)
'	strInput = Replace(strInput,"/","-", 1, -1, 1)
'	strInput = Replace(strInput,":", "", 1, -1, 1)
	strInput = Replace(strInput,",", "", 1, -1, 1)
	strInput = Replace(strInput,"н", "", 1, -1, 1)
	strInput = Replace(strInput,"!", "", 1, -1, 1)
	strInput = Replace(strInput,"~", "&tilde;", 1, -1, 1)
	RSSTemizle = strInput
End Function

Function dosyaadtemizle(dosyaadi)'güvenli dosya uzantılarını belirle
	dosyaadi = htmlad(dosyaadi)
	if right(dosyaadi,3) = "pdf" then dosyaadiyeni = left(dosyaadi,len(dosyaadi)-3) & ".pdf"
	if right(dosyaadi,3) = "xls" then dosyaadiyeni = left(dosyaadi,len(dosyaadi)-3) & ".xls"
	if right(dosyaadi,4) = "xlsx" then dosyaadiyeni = left(dosyaadi,len(dosyaadi)-4) & ".xlsx"
	if right(dosyaadi,3) = "zip" then dosyaadiyeni = left(dosyaadi,len(dosyaadi)-3) & ".zip"
	if right(dosyaadi,3) = "rar" then dosyaadiyeni = left(dosyaadi,len(dosyaadi)-3) & ".rar"
	if right(dosyaadi,3) = "doc" then dosyaadiyeni = left(dosyaadi,len(dosyaadi)-3) & ".doc"
	if right(dosyaadi,4) = "docx" then dosyaadiyeni = left(dosyaadi,len(dosyaadi)-4) & ".docx"
	if right(dosyaadi,3) = "txt" then dosyaadiyeni = left(dosyaadi,len(dosyaadi)-3) & ".txt"
	if right(dosyaadi,3) = "jpg" then dosyaadiyeni = left(dosyaadi,len(dosyaadi)-3) & ".jpg"
	if right(dosyaadi,3) = "png" then dosyaadiyeni = left(dosyaadi,len(dosyaadi)-3) & ".png"
	if right(dosyaadi,3) = "gif" then dosyaadiyeni = left(dosyaadi,len(dosyaadi)-3) & ".gif"
	if right(dosyaadi,3) = "bmp" then dosyaadiyeni = left(dosyaadi,len(dosyaadi)-3) & ".bmp"
	if right(dosyaadi,3) = "asp" then call modalend("Güvenlik","Sistem Tarafından Yasaklanmış Bir Dosya Yüklemeye Çalışıyorsunuz")
	if right(dosyaadi,3) = "asa" then call modalend("Güvenlik","Sistem Tarafından Yasaklanmış Bir Dosya Yüklemeye Çalışıyorsunuz")
	if right(dosyaadi,3) = "css" then call modalend("Güvenlik","Sistem Tarafından Yasaklanmış Bir Dosya Yüklemeye Çalışıyorsunuz")
	if right(dosyaadi,2) = "js" then call modalend("Güvenlik","Sistem Tarafından Yasaklanmış Bir Dosya Yüklemeye Çalışıyorsunuz")
	if right(dosyaadi,3) = "htm" then call modalend("Güvenlik","Sistem Tarafından Yasaklanmış Bir Dosya Yüklemeye Çalışıyorsunuz")
	if right(dosyaadi,4) = "html" then call modalend("Güvenlik","Sistem Tarafından Yasaklanmış Bir Dosya Yüklemeye Çalışıyorsunuz")
	if dosyaadiyeni = "" then call modalend("Güvenlik","Yüklemeye Çalıştığınız Dosya Türü Belirlenemedi")
	dosyaadtemizle = dosyaadiyeni
End function


Function RemoveHTML( strText )
	Dim RegEx

	Set RegEx = New RegExp

	RegEx.Pattern = "<[^>]*>"
	RegEx.Global = True

	RemoveHTML = RegEx.Replace(strText, "")
End Function
'############################################################################################################################ GÜVENLİK
'############################################################################################################################ GÜVENLİK
'############################################################################################################################ GÜVENLİK
'############################################################################################################################ TARİH İŞLEMLERİ
'############################################################################################################################ TARİH İŞLEMLERİ
'############################################################################################################################ TARİH İŞLEMLERİ
Function tarihlog(tarih)'110505 yymmdd
	yil = right(year(tarih),2)
	if month(tarih) < 10 then ay = "0" & month(tarih) else ay = month(tarih)
	if day (tarih) < 10 then gun = "0" & day(tarih) else gun = day(tarih)
	tarihlog = yil & ay & gun
End Function

function tarihlog2(tarih)
	yil = right(year(tarih),2)
	if month(tarih) < 10 then ay = "0" & month(tarih) else ay = month(tarih)
	if day(tarih) < 10 then gun = "0" & day(tarih) else gun = day(tarih)
	if hour(tarih) < 10 then saat = "0" & hour(tarih) else saat = hour(tarih)
	if minute(tarih) < 10 then dakika = "0" & minute(tarih) else dakika = minute(tarih)
	if second(tarih) < 10 then saniye = "0" & second(tarih) else saniye = second(tarih)
	tarihlog2 = yil & ay & gun & saat & dakika & saniye
end function

Function tarihsql(tarih)'2011-11-21 00:00:00
	tarih		=	trim(tarih)
	tarihsql	=	year(tarih) & "-" & month(tarih) & "-" & day(tarih) & " 00:00:00"
End Function

Function tarihsql2(tarih)'2011-11-21
	tarih		=	trim(tarih)
	tarihsql2	=	year(tarih) & "-" & month(tarih) & "-" & day(tarih)
End Function

Function tarihsqlfull(tarih)'2011-11-21 23:14:55
	tarihsqlfull = year(tarih) & "-" & month(tarih) & "-" & day(tarih) & " " & hour(tarih) & ":" & minute(tarih) & ":" & second(tarih)
End Function

Function tarihjp(tarih)'2011-11-21
	if day(tarih) < 10 then gun = "0" & day(tarih) else gun = day(tarih)
	if month(tarih) < 10 then ay = "0" & month(tarih) else ay = month(tarih)
	tarihjp = year(tarih) & "-" & ay & "-" & gun
End Function

Function tarihtr(tarih)'21.11.2011
	if month(tarih) < 10 then ay = "0" & month(tarih) else ay = month(tarih)
	if day(tarih) < 10 then gun = "0" & day(tarih) else gun = day(tarih)
	tarihtr = gun & "." & ay & "." & year(tarih)
End Function


function tarihgorev(tarih)
	if tarih <> "" then
		if hour(tarih) < 10 then saat = "0" & hour(tarih) else saat = hour(tarih)
		if minute(tarih) < 10 then dakika = "0" & minute(tarih) else dakika = minute(tarih)
		tarihgorev = day(tarih) & " " & aylarkisa(month(tarih)) & " - " & saat & ":" & dakika
	else
		tarihgorev = ""
	end if
end function


Function jquerydate(date)'12,31,2011
	jquerydate = month(date) & "," & day(date) & "," & year(date)
End Function

function tarihayinilkgunu(byVal ay, byVal yil)
	tarihayinilkgunu = cdate("01." & ay & "." & yil)
end function

function tarihayinsongunu(byVal ay, byVal yil)
	tarihayinsongunu = cdate(ayingunleri(ay,yil) & "." & ay & "." & yil)
end function

function tarihjson(byVal tarih, byVal tur)
'2014-06-13T07:00:00-05:00
	yil		=	year(tarih)
	if month(tarih) < 10 then ay = "0" & month(tarih) else ay = month(tarih)
	if day(tarih) < 10 then gun = "0" & day(tarih) else gun = day(tarih)

	if hour(tarih) < 10 then saat = "0" & hour(tarih) else saat = hour(tarih)
	if minute(tarih) < 10 then dakika = "0" & minute(tarih) else dakika = minute(tarih)

	if tur = "gun" then tarihjson	=	yil & "-" & ay & "-" & gun
	if tur = "gunsaat" then tarihjson	=	yil & "-" & ay & "-" & gun & "T" & saat & ":" & dakika & ":00+02:00"
end function

function ayingunleri(strMonth,strYear)
	dim strDays	 
	Select Case cint(strMonth)
		Case 1,3,5,7,8,10,12:
			strDays = 31
		Case 4,6,9,11:
		strDays = 30
		Case 2:
		if  ((cint(strYear) mod 4 = 0  and  _
			cint(strYear) mod 100 <> 0)  _
			or ( cint(strYear) mod 400 = 0) ) then
		strDays = 29
		else
			strDays = 28 
		end if	
	End Select 
	ayingunleri = strDays
end function

function tarihtruzun(tarih)
	tarihtruzun = day(tarih) & " " & aylaruzun(month(tarih)) & " " & year(tarih)
end function

function tarihsaattruzun(tarih)
	if hour(tarih) < 10 then saat = "0" & hour(tarih) else saat = hour(tarih)
	if minute(tarih) < 10 then dakika = "0" & minute(tarih) else dakika = minute(tarih)
	if second(tarih) < 10 then saniye = "0" & second(tarih) else saniye = second(tarih)
	tarihsaattruzun = day(tarih) & " " & aylaruzun(month(tarih)) & " " & year(tarih) & " - " & saat & ":" & dakika & ":" & saniye
end function

function tarihsaattrkisa(tarih)
	if hour(tarih) < 10 then saat = "0" & hour(tarih) else saat = hour(tarih)
	if minute(tarih) < 10 then dakika = "0" & minute(tarih) else dakika = minute(tarih)
'	if second(tarih) < 10 then saniye = "0" & second(tarih) else saniye = second(tarih)
	tarihsaattrkisa = day(tarih) & "." & month(tarih) & "." & right(year(tarih),2) & " " & saat & ":" & dakika
end function

function tarihrdate(tarih)'"2014-06-17T16:57:46.323"
	if tarih = "" then tarih = now()
	yil		=	year(tarih)
	ay		=	month(tarih)
	if ay < 10 then ay = "0" & ay
	gun		=	day(tarih)
	if gun < 10 then gun = "0" & gun
	saat	=	hour(tarih)
	if saat < 10 then saat = "0" & saat
	dakika	=	minute(tarih)
	if dakika < 10 then dakika = "0" & dakika
	saniye	=	second(tarih)
	if saniye < 10 then saniye = "0" & saniye
	tarihrdate = yil & "-" & ay & "-" & gun & "T" & saat & ":" & dakika & ":" & saniye & ".000"
end function

function tarihRFC822(tarih)
'Response.Write tarih
'Mon, 13 Jul 2015 23:48:39 +0200
'Wed, 02 Oct 2002 15:00:00 +0200
'Tue, 14 jul 2015 04:03:25 +0200
	if tarih = "" then tarih = now()
	yil		=	year(tarih)
	ay		=	month(tarih)
	if ay < 10 then ay = "0" & ay
	gun		=	day(tarih)
	if gun < 10 then gun = "0" & gun
	saat	=	hour(tarih)
	if saat < 10 then saat = "0" & saat
	dakika	=	minute(tarih)
	if dakika < 10 then dakika = "0" & dakika
	saniye	=	second(tarih)
	if saniye < 10 then saniye = "0" & saniye

	tarihRFC822 = gunlerortaen(weekday(tarih-1)) & ", " & gun & " " & aylarkisaen(ay) & " " & yil & " " & saat & ":" & dakika & ":" & saniye & " +0300"

end function

function tarihkisaengun(tarih)			'02-dec-2018
	if instr(tarih,"-") > 0 then
		tarihtemp = Split(tarih,"-")
		gun		=	tarihtemp(0)
		ay		=	lcase(tarihtemp(1))
		yil		=	tarihtemp(2)
		for di = 0 to ubound(aylarkisaen)
			if ay = aylarkisaen(di) then
				ay = di
			end if
		next
		tarihkisaengun = gun & "." & ay & "." & yil
	end if
end function

'############################################################################################################################ TARİH İŞLEMLERİ
'############################################################################################################################ TARİH İŞLEMLERİ
'############################################################################################################################ TARİH İŞLEMLERİ
'############################################################################################################################ TARİH İŞLEMLERİ
Function alert(uyari)
	Response.Write "<script type=""text/javascript"">alert('" & uyari & "');</script>"
End Function

Function alertend(uyari)
	Response.Write "<script type=""text/javascript"">alert('" & uyari & "');</script>"
	Response.End()
End Function

Function modal(byVal baslik, byVal icerik)
	call jquerykontrol()
	Response.Write "<script type=""text/javascript"">$(document).ready(function(){"
	if baslik = "" then
		Response.Write "$('#modal-dialog .modal-header').addClass('hide');"
	else
		Response.Write "$('#modal-dialog .modal-header').removeClass('hide');"
		Response.Write "$('#modal-dialog .modalbaslik').text('" & baslik & "');"
	end if
	Response.Write "$('#modal-dialog .modal-body').html('" & icerik & "');"
	Response.Write "$('#modal-dialog').modal('show');"
	Response.Write "});</scr" & "" & "ipt>"
End Function

Function modalend(byVal baslik, byVal icerik)
	call jquerykontrol()
	Response.Write "<script type=""text/javascript"">$(document).ready(function(){"
	if baslik = "" then
		Response.Write "$('#modal-dialog .modal-header').addClass('hide');"
	else
		Response.Write "$('#modal-dialog .modal-header').removeClass('hide');"
		Response.Write "$('#modal-dialog .modalbaslik').text('" & baslik & "');"
	end if
	Response.Write "$('#modal-dialog .modal-body').html('" & icerik & "');"
	Response.Write "$('#modal-dialog').modal('show');"
	Response.Write "});</scr" & "" & "ipt>"
	Response.End()
End Function

Function modalajax(byVal baslik, byVal icerik)
	if left(icerik,1) = "/" then
	else
		icerik = "/" & icerik
	end if
	%><script type="text/javascript">$(document).ready(function(){$('#modal-dialog-ajax .modal-header').removeClass('hide');$('#modal-dialog-ajax .modal-footer').removeClass('hide');$('#modal-dialog-ajax .modalbaslik').text('<%=baslik%>');$('#modal-dialog-ajax .modal-body').load('<%=icerik%>');$('#modal-dialog-ajax').modal('show');});</script><%
End Function

Function modalajaxfit(byVal baslik, byVal icerik)
	if left(icerik,1) = "/" then
	else
		icerik = "/" & icerik
	end if
	%><script type="text/javascript">$(document).ready(function(){$('#modal-dialogfit .modal-header').removeClass('hide');$('#modal-dialogfit .modal-footer').removeClass('hide');$('#modal-dialogfit .modalbaslik').text('<%=baslik%>');$('#modal-dialogfit .modal-body').load('<%=icerik%>');$('#modal-dialogfit').modal('show');});</script><%
End Function

Function modalbasliksiz(byVal icerik)
	%><script type="text/javascript">$(document).ready(function(){$('#modal-dialog .modal-header').css('display','none');$('#modal-dialog .modal-body').html('<%=icerik%>');$('#modal-dialog').modal('show');});</script><%
End Function

Function modalajaxkapat()
	%><script type="text/javascript">$(document).ready(function(){$('#modal-dialog-ajax').modal('hide');});</script><%
End Function

Function jsgit(byVal adres)
	call jquerykontrol()
	Response.Write "<scr" & "ipt type=""text/javascript"">"
	Response.Write "$().ready(function(){"
	Response.Write "document.location = '"
	Response.Write adres
	Response.Write "';"
	Response.Write "});"
	Response.Write "</scr" & "ipt>"
End Function

Function uyar(uyari)
	if Session("bootstrap") = True then
		call modalbasliksiz(uyari)
	else
		Response.Write "<script type=""text/javascript"">alert('" & uyari & "');</script>"
	end if
End Function

Function uyarend(uyari)
	if Session("bootstrap") = True then
		call modalbasliksiz(uyari)
	else
		Response.Write "<script type=""text/javascript"">alert('" & uyari & "');</script>"
	end if
	Response.End()
End Function

Function uyarmaac(byVal adres)
	%><script type="text/javascript">
		$().ready(function(){
			$('#ortaalan').load('<%=adres%>');
//			$('body,html').animate({scrollTop: 0}, 1800);return false;
		});
	</script><%
End Function

Function uyarmagit(byVal adres)
	%><script type="text/javascript">
		$().ready(function(){
			document.location = '<%=adres%>';
		});
	</script><%
End Function

Function uyarmagitdelay(byVal adres,byVal saniye)
	Response.Write "<scr" & "ipt type=""text/javascript"">"
	Response.Write "$().ready(function(){"
	Response.Write "setTimeout(function(){ document.location = '" & adres & "';}, " & saniye & "000 );"
	Response.Write "});"
	Response.Write "</scr" & "ipt>"
End Function

Function rastgele(UHigh,LLow)
	Randomize
	intLength = UHigh
	rastgele = CInt((Rnd * 1000)Mod intLength) + LLow
End Function

Function uyardiv(byVal mesaj,byVal tur)
	%><div class="alert alert-<%=tur%>"><%=mesaj%><button data-dismiss="alert" class="close" type="button"><i class="icon-remove"></i></button></div><%
End Function

'############################################################################################################################ KULLANICI İŞLEMLERİ
'############################################################################################################################ KULLANICI İŞLEMLERİ
'############################################################################################################################ KULLANICI İŞLEMLERİ


Public Function sifrele(data)
	For i = 1 To Len(data)
	Krktr = Mid(data, i, 1)
	Krktr = Chr((Asc(Mid(data, i, 1)) - 15) Mod 256)
	Cozuln = Cozuln & Krktr
	Next
		Cozuln = Replace(Cozuln,chr(39),"!")
		Cozuln = Replace(Cozuln,chr(34),"!")
		Cozuln = Replace(Cozuln,chr(60),"!")
		Cozuln = Replace(Cozuln,chr(62),"!")
	sifrele = Cozuln
End Function



'############################################################################################################################ KULLANICI İŞLEMLERİ
'############################################################################################################################ KULLANICI İŞLEMLERİ
'############################################################################################################################ KULLANICI İŞLEMLERİ
'############################################################################################################################ EMAIL İŞLEMLERİ
'############################################################################################################################ EMAIL İŞLEMLERİ
'############################################################################################################################ EMAIL İŞLEMLERİ
Function emailat(byVal baslik, byVal icerik,byVal hedef)'alias
	ek			=	""
	gonderen	=	mail_fromemail
	urlid		=	urlidbul()
	call hizlimailat(baslik,icerik,gonderen,hedef,ek)
'	call hizlimailat(baslik,icerik,gonderen,"teknik@sbstasarim.com",ek)
End Function

Function emailkontrol(emailadresi)'yenisi
	emmm = emailadresi
	if len(emmm) < 6 then emailkontrol = "hata"
	if left(emmm,1) = "@" or right(emmm,1) = "@" then emailkontrol = "hata"
	if left(right(emmm,2),1) = "." then emailkontrol = "hata"

	seviyeler1 = split(emailadresi,"@")
	if ubound(seviyeler1) <> 1 then
		emailkontrol = "hata"
'		call modalend("Email",kelime(29))
	end if
	if emailkontrol <> "hata" then
		seviyeler2 = split(seviyeler1(1),".")
		if len(seviyeler2(0)) < 4 then emailkontrol = "hata"
		kturkce = Array("","ç","Ç","ö","Ö","İ","ı","ğ","Ğ","Ü","ü","!","é","£","#","^","+","$","%","½","&","/","{","(","[",")","]","=","}","?","\","|","*",",",":",";","`","~","<",">","â","ê","î")
		uzantilar = Array("","com","net","org","info","biz","com.tr","net.tr","org.tr","edu.tr","gov.tr","ru","co.uk")

		for ui = 1 to ubound(uzantilar)
			if right(emmm,len(uzantilar(ui))) = uzantilar(ui) then uzanti = "ok" else uzanti = "hata"
			if uzanti = "ok" then exit for
		next
		for ei = 1 to len(emmm)
			kar = right(left(emmm,ei),1)
			for ki = 1 to ubound(kturkce)
				if kar = kturkce(ki) then emailkontrol = "hata"
			next
		next
	end if

	if emailkontrol = "hata" or uzanti = "hata" then
		' emailkontrol = "xxx"
		'call modalend("Email",kelime(59))
	else
		emailkontrol = ""
	end if
End Function


Function emailtemizle(gelenemail)'eskisi
	kturkce = Array("","ç","Ç","ö","Ö","İ","ı","ğ","Ğ","Ü","ü","!","é","£","#","^","+","$","%","½","&","/","{","(","[",")","]","=","}","?","\","|","*",",",":",";","`","~","<",">","â","ê","î")
	uzantilar = Array("","com","net","org","info","biz","com.tr","net.tr","org.tr","edu.tr","gov.tr","gen.tr","ru","co.uk","az","de")

	if len(gelenemail) < 6 then emailsonuc = "hata"
	if left(gelenemail,1) = "@" or right(gelenemail,1) = "@" then emailsonuc = "hata"
	if left(right(gelenemail,2),1) = "." then emailsonuc = "hata"

	if emailsonuc <> "hata" then

		gelenemail = Replace(gelenemail," ","")
		gelenemail = Replace(gelenemail,",",".")
		seviyeler1 = split(gelenemail,"@")
		if ubound(seviyeler1) <> 1 then emailsonuc = "hata"

		if emailsonuc <> "hata" then

			seviyeler2 = split(seviyeler1(1),".")
			if len(seviyeler2(0)) < 2 then emailsonuc = "hata"

			if emailsonuc <> "hata" then

				for ui = 1 to ubound(uzantilar)
					if right(gelenemail,len(uzantilar(ui))) = uzantilar(ui) then uzanti = "ok" else uzanti = "hata"
					if uzanti = "ok" then exit for
				next

				for ei = 1 to len(gelenemail)
					kar = right(left(gelenemail,ei),1)
					for ki = 1 to ubound(kturkce)
						if kar = kturkce(ki) then emailsonuc = "hata"
					next
				next
			end if
		end if
	end if

	emailtemizle = gelenemail
	if emailsonuc = "hata" or uzanti = "hata" then emailtemizle = ""
End Function

function emailbul(icerik)
	icerik = Replace(icerik,"+AEA-","@")
	icerik = Replace(icerik,"AQA-","@")
	icerik = Replace(icerik,"+AF8-","_")
	icerik = Replace(icerik,"+AF8","_")
	icerik = Replace(icerik,"(at)","@")
	bas = Instr(1,icerik,"@")
	if icerik = "" or bas = "" or bas = 0 then
		emailbul = ""
	else
	if bas < 20 then onisaret = bas-1 else onisaret = 20
	
		icerik = Mid(icerik,bas-onisaret,50)
			gelenveri = icerik
			gelenveri = Replace(gelenveri,"<","")
			gelenveri = Replace(gelenveri,">","")
			gelenveri = Replace(gelenveri,"SMTP"," ")
			gelenveri = Replace(gelenveri,":"," ")
			gelenveri = Replace(gelenveri,"["," ")
			gelenveri = Replace(gelenveri,"]"," ")
			gelenveri = Replace(gelenveri,"'"," ")
			gelenveri = Replace(gelenveri,chr(10),",")
			gelenveri = Replace(gelenveri,chr(13),",")
			gelenveri = Replace(gelenveri,"'"," ")
			gelenveri = Replace(gelenveri,"  "," ")
			gelenveri = Replace(gelenveri,"  "," ")
			gelenveri = Replace(gelenveri," ",",")
			gelenveri = Replace(gelenveri,",,",",")
			gelenveri = Replace(gelenveri,",,",",")
	
			gelenveri = Split(gelenveri,",")
	
				for gi = 0 to ubound(gelenveri)
					icerik = emailtemizle(gelenveri(gi))
					if icerik = "" then
					else
						bulunanmail = icerik
					end if
				next
			set gelenveri = Nothing
		emailbul = bulunanmail
	end if
end function




Function tckontrol(no)
	if isnumeric(no) = True and len(no) = 11 then
		toplam = 0
		for ri = 0 to 9
		rakam = right(no,len(no)-ri)
		rakam  = left(rakam,1)
		toplam = toplam + rakam
		next
		sonrakam = right(toplam,1)
		kontrolbiti = right(no,1)
		if sonrakam = kontrolbiti then
			tckontrol = True
		else
			tckontrol = False
		end if
	else
		tckontrol = False
	end if
end function

Function telnotemizle(byVal telefon, byVal uyari)'telnotemizle(numara,True) -- uyarı boş , false gelmeli
	if len(telefon) = 10 then
		telnotemizle = telefon
	elseif len(telefon) < 10 then
		telnotemizle = telefon
	elseif telefon = "" then
		telnotemizle = ""
	elseif isnull(telefon) = True then
		telnotemizle = ""
	else
		telefon = Replace(telefon,"+","")
		telefon = Replace(telefon,".","")
		telefon = Replace(telefon," ","")
		telefon = Replace(telefon,",","")
		telefon = right(telefon,10)
		telefon = "+90" & telefon
		if len(telefon) = 13 then
			telnotemizle = telefon
		else
'''			if uyari = True then call uyarid(1,true)
		end if
	end if
End Function
'############################################################################################################################ EMAIL İŞLEMLERİ
'############################################################################################################################ EMAIL İŞLEMLERİ
'############################################################################################################################ EMAIL İŞLEMLERİ



Function ototag(icerik)
	sqlotodb = "SELECT source,target from url_tag where urlid = " & Session("urlid")
	Set otodb = Server.CreateObject("ADODB.Recordset")
	otodb.Open sqlotodb, sbsv5, 1, 3
		if otodb.recordcount > 0 then
		for ki = 1 to otodb.recordcount
		if otodb("source") <> "" and otodb("target") <> "" and isnull(otodb("source")) = False and isnull(otodb("target")) = False and icerik <> "" then
			icerik = Replace(icerik,otodb("source"),otodb("target"))
		end if
		otodb.movenext:next
		end if
	otodb.close
	set otodb = Nothing
	'backlink koruması
	if icerik <> "" then
		icerik = Replace(icerik,"target=""_blank""","target=""_blank"" rel=""nofollow""")
	end if
	'backlink koruması
	ototag = icerik
End Function

Function sbstimeryaz(byVal kod, byVal gorev)
	sqlsbtb = "SELECT top(1) * from sbs_timer"
	Set sbtb = Server.CreateObject("ADODB.Recordset")
	sbtb.Open sqlsbtb, sbsv5, 1, 3
	sbtb.addnew
		sbtb("tarih")		= date()
		sbtb("gorev")		= gorev
		sbtb("gorevkod")	= kod
	sbtb.update
	sbtb.close
	set sbtb = Nothing
End Function

Function sbstimeroku(byVal kod)
	sqlsbtb = "SELECT top(1) * from sbs_timer where gorevkod = '" & kod & "' and tarih = '" & tarihsql(date()) & "'"
	Set sbtb = Server.CreateObject("ADODB.Recordset")
	sbtb.Open sqlsbtb, sbsv5, 1, 3
		if sbtb.recordcount = 1 then sbstimeroku = True else sbstimeroku = False
	sbtb.close
	set sbtb = Nothing
End Function


'############################################################################################################################ DÖVİZ İŞLEMLERİ
'############################################################################################################################ DÖVİZ İŞLEMLERİ
'############################################################################################################################ DÖVİZ İŞLEMLERİ

Function dovizcevirici()'eski
	Response.Write "<div class=""dovizdiv""><div class=""dovizbaslik"">" & kelime(43) & "</div><div class=""dovizhr""></div><div style=""margin: 0 auto"">"
	Response.Write "<div class=""input-prepend input-append""><span class=""add-on"">$</span><input type=""text"" value=""1"" onkeyup=""dovizcevir(this.value,'1');"" class=""span1"" />"
	Response.Write "<span class=""add-on"" id=""doviz1"">" & kurhesapla(1,1) & "TL</span></div>"
	Response.Write "<div class=""input-prepend input-append""><span class=""add-on"">€</span><input type=""text"" value=""1"" onkeyup=""dovizcevir(this.value,'2');"" class=""span1"" />"
	Response.Write "<span class=""add-on"" id=""doviz2"">" & kurhesapla(1,2) & "TL</span></div>"
	Response.Write "</div></div>"
	if Session("yuvarlaksite") = True then Response.Write "<script type=""text/javascript"">$(function(){$("".dovizdiv"").corner();});</script>"
End Function

Function moduldovizcevirici(birimler)
	Response.Write "<div class=""dovizdiv""><div class=""dovizbaslik""></div>"
	Response.Write "<div class=""input-group""><span class=""input-group-addon"">$</span><input type=""text"" class=""form-control"" value=""1"" onkeyup=""dovizcevir(this.value,'1');""><span class=""input-group-addon"" id=""doviz1"">" & formatnumber(kurhesapla(1,1),2) & " TL</span></div>"
	Response.Write "<div class=""input-group""><span class=""input-group-addon"">€</span><input type=""text"" class=""form-control"" value=""1"" onkeyup=""dovizcevir(this.value,'2');""><span class=""input-group-addon"" id=""doviz2"">" & formatnumber(kurhesapla(1,2),2) & " TL</span></div>" 
	Response.Write "</div>"

'	Response.Write "<div class=""dovizdiv""><div class=""dovizbaslik""></div><div class=""dovizhr""></div><div style=""margin: 0 auto"">"
'	Response.Write "<div class=""input-group""><span class=""add-on"">$</span><input type=""text"" value=""1"" onkeyup=""dovizcevir(this.value,'1');"" />"
'	Response.Write "<span class=""add-on"" id=""doviz1"">" & kurhesapla(1,1) & "TL</span></div>"
'	Response.Write "<div class=""input-group""><span class=""add-on"">€</span><input type=""text"" value=""1"" onkeyup=""dovizcevir(this.value,'2');"" />"
'	Response.Write "<span class=""add-on"" id=""doviz2"">" & kurhesapla(1,2) & "TL</span></div>"
'	Response.Write "</div></div>"
End Function

Function moduldovizkurlari(birimler)
	if birimler <> "" then
		birimler = "0," & birimler
		dovizbirim = Split(birimler,",")
		sqldovdb = "SELECT top(6) tarih,birim,kur from dovizkurlari order by id desc"
		Set dovdb = Server.CreateObject("ADODB.Recordset")
		dovdb.Open sqldovdb, sbsv5, 1, 3
			for mdi = 1 to dovdb.recordcount
				if dovdb("birim") = 1 then dovizbirim(1) = dovdb("kur")
				if dovdb("birim") = 2 then dovizbirim(2) = dovdb("kur")
				if dovdb("birim") = 3 then dovizbirim(3) = dovdb("kur")
				doviztarih = dovdb("tarih")
			dovdb.movenext:next
		dovdb.close
		set dovdb = Nothing
	end if
	Response.Write "<div class=""row"">"
	Response.Write "<div class=""dovizkurlari""><div class=""dovizkurlaribaslik h4""></div><div class=""dovizkurlaritarih"">" & doviztarih & "</div>"
	for dbi = 1 to ubound(dovizbirim)
'		Response.Write "<div><div class=""dovizkurlarikurad"">" & dovizbirimleri(dbi) & " : </div><div class=""dovizkurlarikurpara"">" & formatnumber(dovizbirim(dbi),2) & " TL</div><div class=""clearfix""></div></div>"
		Response.Write "<div><div class=""dovizkurlarikurad text-center"">" & dovizbirimleri(dbi) & " : " & formatnumber(dovizbirim(dbi),2) & " TL</div><div class=""clearfix""></div></div>"
	next
	Response.Write "</div>"
	Response.Write "</div>"
End Function

function dovizkur(byVal birim,byVal tur)
	if birim <> "" then
		if tur = "" then
			kurtur = "kur"
		else
			kurtur = tur
		end if
		sqldovdb = "SELECT top(1) " & kurtur & " from dovizkurlari where birim = " & birim & " order by id desc"
		Set dovdb = Server.CreateObject("ADODB.Recordset")
		dovdb.Open sqldovdb, sbsv5, 1, 3
			if dovdb.recordcount > 0 then
				dovizkur = dovdb(kurtur)
				if isnull(dovizkur) = True then
					call dovizguncelle()
				end if
			else
				call dovizguncelle()
			end if
		dovdb.close
		set dovdb = Nothing
	end if
end function

Function kurhesapla(byVal rakam, byVal birim)
	if birim = 0 then kurhesapla = rakam
	if birim = 1 or birim = 2 then
		sqldovdb = "SELECT * from dovizkurlari where tarih = '" & tarihsql(bugun) & "' and birim = " & birim
		Set dovdb = Server.CreateObject("ADODB.Recordset")
		dovdb.Open sqldovdb, sbsv5, 1, 3
			if dovdb.recordcount = 1 then
				kurhesapla = rakam * dovdb("kur")
			else
				call dovizguncelle()
				sqlm2db = "SELECT * from dovizkurlari where tarih = '" & tarihsql(bugun) & "' and birim = " & birim
				Set m2db = Server.CreateObject("ADODB.Recordset")
				m2db.Open sqlm2db, sbsv5, 1, 3
				if m2db.recordcount = 0 then
					sqlm2db = "SELECT * from dovizkurlari where tarih = '" & tarihsql(bugun-1) & "' and birim = " & birim
					Set m2db = Server.CreateObject("ADODB.Recordset")
					m2db.Open sqlm2db, sbsv5, 1, 3
				end if
				kurhesapla = rakam * m2db("kur")
				m2db.close
				set m2db = Nothing
				set sqlm2db = Nothing
			end if
		dovdb.close
		set dovdb = Nothing
		set sqldovdb = Nothing
	end if
End Function

Function dovizguncelle()

	sqlmdb = "SELECT top(1) * from dovizkurlari where tarih = '" & tarihsql(bugun) & "' "
	Set mdb = Server.CreateObject("ADODB.Recordset")
	mdb.Open sqlmdb, sbsv5, 1, 3
	if mdb.recordcount = 0 then

		if err.number = 0 then
			mdb.addnew
			mdb("kur")		=	kurcek("USD")
			mdb("kursat")	=	kurceksat("USD")
			mdb("tarih")	=	date()
			mdb("birim")	=	1
			mdb("birimad")	=	"USD"
			mdb.update
			mdb.addnew
			mdb("kur")		=	kurcek("EUR")
			mdb("kursat")	=	kurceksat("EUR")
			mdb("tarih")	=	date()
			mdb("birim")	=	2
			mdb("birimad")	=	"EUR"
			mdb.update
			mdb.addnew
			mdb("kur")		=	kurcek("GBP")
			mdb("kursat")	=	kurceksat("GBP")
			mdb("tarih")	=	date()
			mdb("birim")	=	3
			mdb("birimad")	=	"GBP"
			mdb.update
			mdb.addnew
			mdb("kur")		=	kurcek("CAD")
			mdb("kursat")	=	kurceksat("CAD")
			mdb("tarih")	=	date()
			mdb("birim")	=	4
			mdb("birimad")	=	"CAD"
			mdb.update
			mdb.addnew
			mdb("kur")		=	kurcek("AUD")
			mdb("kursat")	=	kurceksat("AUD")
			mdb("tarih")	=	date()
			mdb("birim")	=	5
			mdb("birimad")	=	"AUD"
			mdb.update
			mdb.addnew
			mdb("kur")		=	kurcek("NOK")
			mdb("kursat")	=	kurceksat("NOK")
			mdb("tarih")	=	date()
			mdb("birim")	=	6
			mdb("birimad")	=	"NOK"
			mdb.update
		else
		end if
	else
		if isnull(mdb("kursat")) = True or isnull(mdb("kur")) = True then
			fn1.open "Delete dovizkurlari where tarih = '" & tarihsql(bugun) & "' ",sbsv5,3,3
			call dovizguncelle()
		end if
	end if
	mdb.close
	set mdb = Nothing
End Function


function kurcek(byVal kurturu)
	set xmlhttp = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
	path = "http://www.tcmb.gov.tr/kurlar/today.xml"
	xmlhttp.Open "GET", path, False
	xmlhttp.send "at"
	if xmlhttp.Status = 200 Then
		gelenveri		=	xmlhttp.responseText
		bolunmusveri	=	Split(gelenveri, "<Currency CrossOrder=")
		for bi = 0 to ubound(bolunmusveri)
			if instr(bolunmusveri(bi),kurturu) > 0 then
				kuryeri			=	Instr(1,bolunmusveri(bi),"<ForexBuying>")
				kur				=	Mid(bolunmusveri(bi),kuryeri+13,6)
				kur				=	Replace(kur,".",",")
				kur				=	Replace(kur,"<","")
				kur				=	Replace(kur,"/","")
				kur				=	Replace(kur,"F","")
				kur				=	Replace(kur,"o","")
				kur				=	Replace(kur,"r","")
				kur				=	Replace(kur,"e","")
				kur				=	Replace(kur,"x","")
				kurcek			=	kur
			exit for
			end if
		next
	end If
	if kurcek = "" then kurcek = 0
end function

function kurceksat(byVal kurturu)
	Set xmlhttp = CreateObject("MSXML2.XMLHTTP")
	path = "http://www.tcmb.gov.tr/kurlar/today.xml"
	xmlhttp.Open "GET", path, False
	xmlhttp.send "at"
	if xmlhttp.Status = 200 Then
		gelenveri		=	xmlhttp.responseText
		bolunmusveri	=	Split(gelenveri, "<Currency CrossOrder=")
		for bi = 0 to ubound(bolunmusveri)
			if instr(bolunmusveri(bi),kurturu) > 0 then
				kuryeri			=	Instr(1,bolunmusveri(bi),"<ForexSelling>")
				kur				=	Mid(bolunmusveri(bi),kuryeri+14,6)
				kur				=	Replace(kur,".",",")
				kur				=	Replace(kur,"<","")
				kur				=	Replace(kur,">","")
				kur				=	Replace(kur,"/","")
				kur				=	Replace(kur,"F","")
				kur				=	Replace(kur,"o","")
				kur				=	Replace(kur,"r","")
				kur				=	Replace(kur,"e","")
				kur				=	Replace(kur,"x","")
				kurceksat		=	kur
			exit for
			end if
		next
	end If
	if kurceksat = "" then kurceksat = 0
end function


function kurcekdun(byVal kurturu)
	tarih = date()-1
	if weekday(tarih) = 0 then
		tarih = date()-2
	end if
	if weekday(tarih) = 1 then
		tarih = date()-3
	end if
	ay = left("0" & month(tarih),2)
	gun = left("0" & day(tarih),2)
	yil = year(tarih)
	link = "http://www.tcmb.gov.tr/kurlar/" & yil & ay & "/" & gun & ay & yil & ".xml"
	Set xmlhttp = CreateObject("MSXML2.XMLHTTP")
	path = link
	xmlhttp.Open "GET", path, False
	xmlhttp.send "at"
	if xmlhttp.Status = 200 Then
		gelenveri		=	xmlhttp.responseText
		bolunmusveri	=	Split(gelenveri, "<Currency CrossOrder=")
		for bi = 0 to ubound(bolunmusveri)
			if instr(bolunmusveri(bi),kurturu) > 0 then
				kuryeri			=	Instr(1,bolunmusveri(bi),"<ForexBuying>")
				kur				=	Mid(bolunmusveri(bi),kuryeri+13,6)
				kur				=	Replace(kur,".",",")
				kur				=	Replace(kur,"<","")
				kur				=	Replace(kur,"/","")
				kur				=	Replace(kur,"F","")
				kur				=	Replace(kur,"o","")
				kur				=	Replace(kur,"r","")
				kur				=	Replace(kur,"e","")
				kur				=	Replace(kur,"x","")
				kurcekdun		=	kur
			exit for
			end if
		next
	end If
	if kurcekdun = "" then kurcekdun = 0
end function


Function pdfuret(byval url, byval dosya, byval dad, byval dde)
%><script type="text/javascript">
		$().ready(function(){
			$('#ajax').load('/pdf.asp?url=<%=url%>&dos=<%=dosya%>&dad=<%=dad%>&dde=<%=dde%>');
		});
	</script><%
End Function

'############################################################################################################################ DÖVİZ İŞLEMLERİ
'############################################################################################################################ DÖVİZ İŞLEMLERİ
'############################################################################################################################ DÖVİZ İŞLEMLERİ


function sayacgoster()
	sayactur = urlsabit("sayac")
	if sayactur = 1 then
	end if
end function

function urlsabit(alan)
	if alan <> "" then
	if Session("urlid") = "" then
'urlid yi bulan kodu buraya yaz
'urlid yi bulan kodu buraya yaz
'urlid yi bulan kodu buraya yaz
'urlid yi bulan kodu buraya yaz
'urlid yi bulan kodu buraya yaz
	else
		sqlusdb = "SELECT " & alan & " from url_sabitler where urlid = " & Session("urlid")
		Set usdb = Server.CreateObject("ADODB.Recordset")
		usdb.Open sqlusdb, sbsv5, 1, 3
			if usdb.recordcount > 0 then
				urlsabit = usdb(alan)
			end if
		usdb.close
		set usdb = Nothing
	end if
	end if
end function

function turkcele(gelen)
	if gelen <> "" then
		gelen = trim(gelen)
		gelen = Replace(gelen,"&Uuml;","Ü")
		gelen = Replace(gelen,"&uuml;","ü")
		gelen = Replace(gelen,"&Ccedil;","Ç")
		gelen = Replace(gelen,"&ccedil;","ç")
		gelen = Replace(gelen,"&Ouml;","Ö")
		gelen = Replace(gelen,"&ouml;","ö")
		gelen = Replace(gelen,"ð","ğ")
		gelen = Replace(gelen,"ý","ı")
		gelen = Replace(gelen,"þ","ş")
		gelen = Replace(gelen,"Ý","İ")
		gelen = Replace(gelen,"Þ","Ş")
		gelen = Replace(gelen,"Ã§","ç")
		gelen = Replace(gelen,"%20"," ")
		gelen = Replace(gelen,"ÄŸ","ğ")
		gelen = Replace(gelen,"Ä±","ı")
		gelen = Replace(gelen,"Ã¶","ö")
		gelen = Replace(gelen,"Ã¼","ü")
		gelen = Replace(gelen,"ÅŸ","ş")
		gelen = replace(gelen,"Ãœ","Ü")
		gelen = replace(gelen,"Ã‡","Ç")
		gelen = replace(gelen,"Ã–","Ö")
		gelen = replace(gelen,"Ä°","İ")
		gelen = Replace(gelen,"S*","Ş")
		gelen = Replace(gelen,"s*","ş")
		gelen = Replace(gelen,"G*","Ğ")
		gelen = Replace(gelen,"g*","ğ")
		gelen = Replace(gelen,"I*","İ")
		gelen = Replace(gelen,"i*","ı")
		gelen = Replace(gelen,"C*","Ç")
		gelen = Replace(gelen,"c*","ç")
		gelen = Replace(gelen,"O*","Ö")
		gelen = Replace(gelen,"o*","ö")
		gelen = Replace(gelen,"U*","Ü")
		gelen = Replace(gelen,"u*","ü")
		gelen = Replace(gelen,"%20"," ")
		gelen = Replace(gelen,"Å&#382;","Ş")
		gelen = Replace(gelen,"Å"&chr(158),"Ş")
		gelen = Replace(gelen,"Ä"&chr(158),"Ğ")
		gelen = Replace(gelen,"â€™","'")
		
	end if
	turkcele = gelen
end function

function turkcelekodla(kelime)
	if isnull(kelime) = False and kelime <> "" then
		kelime = Replace(kelime,"ş","s*")
		kelime = Replace(kelime,"Ş","S*")
		kelime = Replace(kelime,"Ğ","G*")
		kelime = Replace(kelime,"ğ","g*")
		kelime = Replace(kelime,"İ","I*")
		kelime = Replace(kelime,"ı","i*")
		kelime = Replace(kelime,"ç","c*")
		kelime = Replace(kelime,"Ç","C*")
		kelime = Replace(kelime,"ö","o*")
		kelime = Replace(kelime,"Ö","O*")
		kelime = Replace(kelime,"ü","u*")
		kelime = Replace(kelime,"Ü","U*")
		kelime = Replace(kelime," ","%20")
		kelime = Replace(kelime,"–","-")
	end if
	turkcelekodla = kelime
end function

function sessionbul()
	if Session("urlid") = "" then
		site = Request.ServerVariables("HTTP_HOST")
		site = Replace(site,"www.","")
		sqlsitedb = "Select id from url where url = '" & site & "' or url2 = '" & site & "'"
		Set sitedb = Server.CreateObject("ADODB.Recordset")
		sitedb.Open sqlsitedb, sbsv5, 1, 3
		if sitedb.recordcount > 0 then
			Session("urlid") = sitedb("id")
		end if
		sitedb.close
		set sitedb = Nothing
	end if
end function










Function dosyaturu(uzanti)
		if uzanti = "application/msword" then dosyaturu = "doc"
		if uzanti = "application/vnd.openxmlformats-officedocument.wordprocessingml.document" then dosyaturu = "docx"
		if uzanti = "application/msexcel" then dosyaturu = "xls"
		if uzanti = "application/vnd.ms-excel" then dosyaturu = "xls"
		if uzanti = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" then dosyaturu = "xlsx"
		if uzanti = "application/vnd.ms-excel.sheet.macroEnabled.12" then dosyaturu = "xlsm"
		if uzanti = "application/pdf" then dosyaturu = "pdf"
		if uzanti = "text/plain" then dosyaturu = "txt"
		if uzanti = "text/html" then dosyaturu = "html"
		if uzanti = "image/png" then dosyaturu = "png"
		if uzanti = "image/bmp" then dosyaturu = "bmp"
		if uzanti = "image/jpg" then dosyaturu = "jpg"
End Function


function jsonveri(veri)
	if veri <> "" then
		veri = Replace(veri,"	"," ")
		veri = Replace(veri,"  "," ")
		veri = Replace(veri,"  "," ")
		veri = Replace(veri,chr(34),"")
		veri = Replace(veri,chr(39),"")
		veri = trim(veri)
	else
		veri = ""
	end if
	jsonveri = veri
end function



function gununurunu()
	sqlgundb = "Select top(1) * from urun_gruplar_log where tur = 'gunluk' and tarih = '" & tarihsql(date()) & "' and urlid = " & Session("urlid")
	Set gundb = Server.CreateObject("ADODB.Recordset")
	gundb.Open sqlgundb, sbsv5, 1, 3
	if gundb.recordcount = 0 then
	'yeni oluştur
		sqlgun2db = "Select top(1) id from urun_gruplar_log where tur = 'gunluk' and urlid = " & Session("urlid") & " order by tarih desc"
		Set gun2db = Server.CreateObject("ADODB.Recordset")
		gun2db.Open sqlgun2db, sbsv5, 1, 3
		if gun2db.recordcount > 0 then
			sonurunid = gun2db("id")
		else
			sonurunid = 0
		end if
		gun2db.close
		set gun2db = Nothing
			'rastgele bir kayıt seç
			sqlgun3db = "Select top(1) urlid,urunid from urun_gruplar where tur = 'gunluk' and urunid not in (" & sonurunid & ") order by newid()"
			Set gun3db = Server.CreateObject("ADODB.Recordset")
			gun3db.Open sqlgun3db, sbsv5, 1, 3
			if gun3db.recordcount > 0 then
				sqlgun4db = "Select top(1) * from urun_gruplar_log"
				Set gun4db = Server.CreateObject("ADODB.Recordset")
				gun4db.Open sqlgun4db, sbsv5, 1, 3
					gun4db.addnew
					gun4db("tarih")		=	date()
					gun4db("urlid")		=	Session("urlid")
					gun4db("urunid")	=	gun3db("urunid")
					gun4db("tur")		=	"gunluk"
					gun4db.update
				gun4db.close
				set gun4db = Nothing
			else
				sqlgun4db = "Select top(1) * from urun_gruplar_log"
				Set gun4db = Server.CreateObject("ADODB.Recordset")
				gun4db.Open sqlgun4db, sbsv5, 1, 3
					gun4db.addnew
					gun4db("tarih")		=	date()
					gun4db("urlid")		=	Session("urlid")
					gun4db("urunid")	=	0
					gun4db("tur")		=	"gunluk"
					gun4db.update
				gun4db.close
				set gun4db = Nothing
			end if
			gun3db.close
			set gun3db = Nothing
			'rastgele bir kayıt seç
	'yeni oluştur
	else
		if gundb("urunid") > 0 then
			call modulgununurunu(gundb("urunid"))
		end if
	end if
	gundb.close
	set gundb = Nothing
end function

Function modulgununurunu(byVal urun)
	Response.Write "<div class=""modulgununurunucontainer""><div class=""modulgununurunubaslik"">Günün Ürünü</div>"
'		Response.Write "<div class=""urunblok urunblok1 col-lg-4 col-md-4 col-sm-4 col-xs-12"">"
		call urungrup("7","gununurunu",1,1,urun,"")
'		Response.Write "</div>"
	Response.Write "</div>"
End Function

function al(nesne)
	al = Request.QueryString(nesne)
	if al = "" then al = Request.Form(nesne)
end function




function formselect(ad,tur,deger,degergorsel)
'call formselect("aktif","10","True","Aktif|Pasif")
	degergorsel = Split(degergorsel,"|")

	Response.Write "<select name=""" & ad & """>"

	if tur = "10" then
		Response.Write "<option value=""True"""
			if deger = "True" then Response.Write " selected"
		Response.Write ">" & degergorsel(0) & "</option>"
		Response.Write "<option value=""False"""
			if deger = "False" then Response.Write " selected"
		Response.Write ">" & degergorsel(1) & "</option>"
	end if

	Response.Write "</select>"
	set degergorsel = Nothing
end function

function jsontable(byVal isimler, byVal alanlar, byVal sortsira, byVal sortdurum, byVal database, byVal guncelle, byVal silme, byVal yeni, byVal ek2, byVal ek3)
	session("tabloislem") = 0
	Response.Cookies("jsonuniq" & database) = alanlar & "|" & guncelle & "|" & silme

	isim = Split(isimler,"|")
	alan = Split(alanlar,"|")

	if yeni = "True" then
		Response.Write "<div class=""pull-right""><a class=""btn btn-success"" onclick=""$('#ortaalan').load('/" & database & "/yeni.asp');"">Yeni Ekle</a></div><div class=""clearfix""></div>"
	end if


	Response.Write "<table class=""display jsontable"" cellspacing=""0"" width=""100%"">"
	Response.Write "<thead>"
	Response.Write "<tr>"
	for ii = 0 to ubound(isim)
		Response.Write "<th>"
		Response.Write isim(ii)
		Response.Write "</th>"
	next
	if guncelle = "True" or silme = "True" then Response.Write "<th>İşlem</th>"
	Response.Write "</tr>"
	Response.Write "</thead>"
	Response.Write "<tfoot>"
	Response.Write "<tr>"
	for ii = 0 to ubound(isim)
		Response.Write "<th>"
		Response.Write isim(ii)
		Response.Write "</th>"
	next
	if guncelle = "True" or silme = "True" then Response.Write "<th>İşlem</th>"
	Response.Write "</tr>"
	Response.Write "</tfoot>"
	Response.Write "</table>"


	Response.Write "<script type=""text/javascript"">$(document).ready(function() {$('.jsontable').dataTable( {processing: true,serverSide: true,order: [[ " & sortsira & ", """ & sortdurum & """ ]],ajax: '/json_liste.asp?d=" & database & "'});});</script>"

end function

function aktifpasif(deger)
	if deger = True then
		aktifpasif = aktifarr(1)
	else
		aktifpasif = aktifarr(0)
	end if
end function


function buyukharfler(kelime)
	degerler = "-ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZWXQWÄ°"
	if instr(degerler,kelime) > 0 then
		buyukharfler = True
	else
		buyukharfler = False
	end if
end function



'################################################### BINARY İŞLEMLERİ WUHUUUUU
'################################################### BINARY İŞLEMLERİ WUHUUUUU
'################################################### BINARY İŞLEMLERİ WUHUUUUU
function binary2file()
a=Request.TotalBytes
bin=Request.BinaryRead(a)

if isnull(bin) = False then
	strBinaryContents = bin

	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	Set objFile = objFSO.CreateTextFile(Server.MapPath("/temp2/" & unique() & "-" & rastgele(1000,5) & ".jpg"))
	objFile.Write(RSBinaryToString(strBinaryContents))
	objFile.Close
	Set objFile=Nothing
	Set objFSO=Nothing
end if
end function


Private Function RSBinaryToString(xBinary)
	Dim Binary
	If vartype(xBinary)=8 Then Binary = MultiByteToBinary(xBinary) Else Binary = xBinary

	Dim RS, LBinary
	Const adLongVarChar = 201
	Set RS = CreateObject("ADODB.Recordset")
	LBinary = LenB(Binary)

	If LBinary>0 Then
		RS.Fields.Append "mBinary", adLongVarChar, LBinary
		RS.Open
		RS.AddNew
		RS("mBinary").AppendChunk Binary 
		RS.Update
		RSBinaryToString = RS("mBinary")
	Else  
		RSBinaryToString = ""
	End If
End Function

Function MultiByteToBinary(MultiByte)
response.write MultiByte
	Dim RS, LMultiByte, Binary
	Const adLongVarBinary = 205
	Set RS = CreateObject("ADODB.Recordset")
	LMultiByte = LenB(MultiByte)
	If LMultiByte>0 Then
		RS.Fields.Append "mBinary", adLongVarBinary, LMultiByte
		RS.Open
		RS.AddNew
		RS("mBinary").AppendChunk MultiByte & ChrB(0)
		RS.Update
		Binary = RS("mBinary").GetChunk(LMultiByte)
	End If
	MultiByteToBinary = Binary
End Function

Function readBinary(path)
	Dim a
	Dim fso
	Dim file
	Dim i
	Dim ts
	Set fsoo = CreateObject("Scripting.FileSystemObject")
	Set file = fsoo.getFile(Server.Mappath(path))
	If isNull(file) Then
		MsgBox("File not found: " & path)
		Exit Function
	End If
	Set ts = file.OpenAsTextStream()
	a = makeArray(file.size)
	i = 0
	While Not ts.atEndOfStream
		a(i) = ts.read(1)
		i = i + 1
	Wend
	ts.close
	readBinary = Join(a,"")
End Function


Function makeArray(n)
	Dim s 
	s = Space(n) 
	makeArray = Split(s," ")
End Function


Sub writeBinary(bstr, path)
	Dim fso
	Dim ts
	Set fso = CreateObject("Scripting.FileSystemObject")
	On Error Resume Next
	Set ts = fso.createTextFile(Server.MapPath(path))
	If Err.number <> 0 Then
		MsgBox(Err.message)
		Exit Sub
	End If
	On Error GoTo 0
	ts.Write(bstr)
	ts.Close
End Sub
'################################################### BINARY İŞLEMLERİ WUHUUUUU
'################################################### BINARY İŞLEMLERİ WUHUUUUU
'################################################### BINARY İŞLEMLERİ WUHUUUUU





Function parayaz(byVal tutar, byVal parabirimi)
	tutar=replace(tutar,".","")
	virgul=instr(1,tutar,",")
	sol_taraf=mid(tutar,1,virgul-1)
	sag_taraf=mid(tutar,virgul+1,2)
	
	'ALTINCI BASAMAĞI YAZMA
	if len(sol_taraf)=6 then
		basamak6=int(sol_taraf/100000)
		if basamak6=1 then basamak_alti="YÜZ"
		if basamak6=2 then basamak_alti="İKİ YÜZ"
		if basamak6=3 then basamak_alti="ÜÇ YÜZ"
		if basamak6=4 then basamak_alti="DÖRT YÜZ"
		if basamak6=5 then basamak_alti="BEŞ YÜZ"
		if basamak6=6 then basamak_alti="ALTI YÜZ"
		if basamak6=7 then basamak_alti="YEDİ YÜZ"
		if basamak6=8 then basamak_alti="SEKİZ YÜZ"
		if basamak6=9 then basamak_alti="DOKUZ YÜZ"
		if basamak6=0 then basamak_alti=""
		sol_taraf=mid(sol_taraf,2,len(sol_taraf)-1)
	end if
	
	'BEŞİNCİ BASAMAĞI YAZMA
	if len(sol_taraf)=5 then
		basamak5=int(sol_taraf/10000)
		if basamak5=1 then basamak_bes="ON"
		if basamak5=2 then basamak_bes="YİRMİ"
		if basamak5=3 then basamak_bes="OTUZ"
		if basamak5=4 then basamak_bes="KIRK"
		if basamak5=5 then basamak_bes="ELLİ"
		if basamak5=6 then basamak_bes="ATMIŞ"
		if basamak5=7 then basamak_bes="YETMİŞ"
		if basamak5=8 then basamak_bes="SEKSEN"
		if basamak5=9 then basamak_bes="DOKSAN"
		if basamak5=0 then basamak_bes=""
		sol_taraf=mid(sol_taraf,2,len(sol_taraf)-1)
	end if
	
	'DÖRDÜNCÜ BASAMAĞI YAZMA
	if len(sol_taraf)=4 then
		basamak4=int(sol_taraf/1000)
		if basamak4=1 then
			if basamak5<>"" then
				basamak_dort="BİR BİN"
			else
				basamak_dort="BİN"
			end if
		end if
		if basamak4=2 then basamak_dort="İKİ BİN"
		if basamak4=3 then basamak_dort="ÜÇ BİN"
		if basamak4=4 then basamak_dort="DÖRT BİN"
		if basamak4=5 then basamak_dort="BEŞ BİN"
		if basamak4=6 then basamak_dort="ALTI BİN"
		if basamak4=7 then basamak_dort="YEDİ BİN"
		if basamak4=8 then basamak_dort="SEKİZ BİN"
		if basamak4=9 then basamak_dort="DOKUZ BİN"
		if basamak4=0 then
			if basamak5<>"" then
				basamak_dort="BİN"
			else
				basamak_dort=""
			end if
		end if
		sol_taraf=mid(sol_taraf,2,len(sol_taraf)-1)
	end if
	
	'ÜÇÜNCÜ BASAMAĞI YAZMA
	if len(sol_taraf)=3 then
		basamak3=int(sol_taraf/100)
		if basamak3=1 then basamak_uc="YÜZ"
		if basamak3=2 then basamak_uc="İKİYÜZ"
		if basamak3=3 then basamak_uc="ÜÇYÜZ"
		if basamak3=4 then basamak_uc="DÖRTYÜZ"
		if basamak3=5 then basamak_uc="BEŞYÜZ"
		if basamak3=6 then basamak_uc="ALTIYÜZ"
		if basamak3=7 then basamak_uc="YEDİYÜZ"
		if basamak3=8 then basamak_uc="SEKİZYÜZ"
		if basamak3=9 then basamak_uc="DOKUZYÜZ"
		if basamak3=0 then basamak_uc=""
		sol_taraf=mid(sol_taraf,2,len(sol_taraf)-1)
	end if
	
	'İKİNCİ BASAMAĞI YAZMA
	if len(sol_taraf)=2 then
		basamak2=int(sol_taraf/10)
		if basamak2=1 then basamak_iki="ON"
		if basamak2=2 then basamak_iki="YİRMİ"
		if basamak2=3 then basamak_iki="OTUZ"
		if basamak2=4 then basamak_iki="KIRK"
		if basamak2=5 then basamak_iki="ELLİ"
		if basamak2=6 then basamak_iki="ATMIŞ"
		if basamak2=7 then basamak_iki="YETMİŞ"
		if basamak2=8 then basamak_iki="SEKSEN"
		if basamak2=9 then basamak_iki="DOKSAN"
		if basamak2=0 then basamak_iki=""
		sol_taraf=mid(sol_taraf,2,len(sol_taraf)-1)
	end if
	
	'BİRİNCİ BASAMAĞI YAZMA
	if len(sol_taraf)=1 then
		basamak1=int(sol_taraf/1)
		if basamak1=1 then basamak_bir="BİR"
		if basamak1=2 then basamak_bir="İKİ"
		if basamak1=3 then basamak_bir="ÜÇ"
		if basamak1=4 then basamak_bir="DÖRT"
		if basamak1=5 then basamak_bir="BEŞ"
		if basamak1=6 then basamak_bir="ALTI"
		if basamak1=7 then basamak_bir="YEDİ"
		if basamak1=8 then basamak_bir="SEKİZ"
		if basamak1=9 then basamak_bir="DOKUZ"
		if basamak1=0 then basamak_bir=""
		sol_taraf=mid(sol_taraf,2,len(sol_taraf)-1)
	end if
	
	
	'SAĞ TARAFIN İKİNCİ BASAMAĞI YAZMA
	if len(sag_taraf)=2 then
		basamak2=int(sag_taraf/10)
		if basamak2=1 then basamak_k_iki="ON"
		if basamak2=2 then basamak_k_iki="YİRMİ"
		if basamak2=3 then basamak_k_iki="OTUZ"
		if basamak2=4 then basamak_k_iki="KIRK"
		if basamak2=5 then basamak_k_iki="ELLİ"
		if basamak2=6 then basamak_k_iki="ATMIŞ"
		if basamak2=7 then basamak_k_iki="YETMİŞ"
		if basamak2=8 then basamak_k_iki="SEKSEN"
		if basamak2=9 then basamak_k_iki="DOKSAN"
		if basamak2=0 then basamak_k_iki=""
		sag_taraf=mid(sag_taraf,2,len(sag_taraf)-1)
	end if

	'SAĞ TARAFIN BİRİNCİ BASAMAĞI YAZMA

	if len(sag_taraf)=1 then
		basamak1=int(sag_taraf/1)
		if basamak1=1 then basamak_k_bir="BİR"
		if basamak1=2 then basamak_k_bir="İKİ"
		if basamak1=3 then basamak_k_bir="ÜÇ"
		if basamak1=4 then basamak_k_bir="DÖRT"
		if basamak1=5 then basamak_k_bir="BEŞ"
		if basamak1=6 then basamak_k_bir="ALTI"
		if basamak1=7 then basamak_k_bir="YEDİ"
		if basamak1=8 then basamak_k_bir="SEKİZ"
		if basamak1=9 then basamak_k_bir="DOKUZ"
		if basamak1=0 then basamak_k_bir=""
		sag_taraf=mid(sag_taraf,2,len(sag_taraf)-1)
	end if

	if parabirimi = 1 then prBir="KURUŞ"
	if parabirimi = 2 then prBir="CENT"
	if parabirimi = 3 then prBir="CENT"

	dim kurus
	if not basamak_k_iki = "" or not basamak_k_bir = "" then
		kurus = "&nbsp;"&basamak_k_iki&"&nbsp;"&basamak_k_bir&"&nbsp;"&prBir
	end if

	if parabirimi = 1 then prBirim="TÜRK LİRASI"
	if parabirimi = 2 then prBirim="AMERİKAN DOLARI"
	if parabirimi = 3 then prBirim="EURO"

	parayaz = basamak_alti&"&nbsp;"&basamak_bes&"&nbsp;"&basamak_dort&"&nbsp;"&basamak_uc&"&nbsp;"&basamak_iki&"&nbsp;"&basamak_bir&"&nbsp;"&prBirim&"&nbsp;"&kurus
End Function


function resimcek(byVal strURL)
'örnek kullanım call resimcek(urladres,ID,resimtur=prod/gallery)
	if len(strURL) > 20 and left(strURL,4) = "http" then
		strURL = Replace(strURL, "'", "")
		Set objHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
		set img		=	Server.CreateObject("Persits.Jpeg")

		if right(strURL,4) = ".png" then
			img.PNGOutput		=	True
			img.Interpolation	=	15
			img.quality			=	100
			resimadi			=	"/temp/temp.png"
			objHTTP.Open "GET", strURL, false
			objHTTP.Send()
			img.OpenBinary(objHTTP.responseBody)
			img.save Server.MapPath(resimadi)
			set img = Nothing
			set objHTTP = nothing
		else
			resimadi = "/temp/temp.jpg"
			objHTTP.Open "GET", strURL, false
			objHTTP.Send()
				'mevcut dosyayı sil
					set FSO = Createobject("Scripting.FileSystemObject")
					if FSO.FileExists(Server.MapPath(resimadi)) = True then
						Fso.DeleteFile Server.MapPath(resimadi)
					End If
					set FSO = Nothing
				'mevcut dosyayı sil
				'binary olarak ramdeki bilgiyi al dosyaya kaydet
					set DataStream = CreateObject("ADODB.Stream")
					DataStream.Open
					DataStream.Type = 1
					DataStream.Write objHTTP.ResponseBody
					DataStream.Position = 0
					DataStream.SaveToFile Server.MapPath(resimadi)
					DataStream.Close
					set DataStream = Nothing
				'binary olarak ramdeki bilgiyi al dosyaya kaydet
			set objHTTP = nothing
		end if
	resimcek = resimadi
	end if
end function



function resimislem(byVal dosya, byVal width, byVal height, byVal export, byVal watermark, byVal islem, byVal kalite, byVal ek1, byVal ek2, byVal ek3, byVal ek4)
	resimislem	=	NULL
	hata		=	0
	if watermark = "" then watermark = 0

	if export = "" then
		export = "/temp/export.jpg"
	end if

	if islem = "" then
		'#### bilgileri topla
			set img		=	Server.CreateObject("Persits.Jpeg")
			'Response.Write img.version
			img.PNGOutput		=	True
			img.Interpolation	=	15
			img.quality			=	100

			on error resume next
			img.open		Server.MapPath(dosya)
			if err.number <> "0" then'										-2147221451
				okunandosya = readBinary(dosya)
				okunanheader = left(okunandosya,600)
				if instr(okunanheader,"ÿØÿà") > 0 then
					resimbaslangic = instr(okunanheader,"ÿØÿà")
					onek = "ÿØÿá"
					Response.Write "Hatalı JPEG tamir ediliyor...."
					resimson = len(okunandosya)
					resimbaslangic = resimson - resimbaslangic -3
					gercekdosya = right(okunandosya,resimbaslangic)
					gercekdosya = onek & gercekdosya
					call writeBinary(gercekdosya,dosya)
					set okunandosya = Nothing
					on error goto 0
					img.open		Server.MapPath(dosya)
					Response.Write "Hatalı JPEG tamir edildi.."
				end if
			end if
			on error goto 0

'			if width = "" and height = "" then
'			else
'				intDimen = width
'			end if

		'#### bilgileri topla

		'#### CANVAS
			on error resume next
			orW=img.OriginalWidth
			orH=img.OriginalHeight

			if orW > orH then
				enbuyukalan = orW
				xOff=0
				yOff= (orW - (orH * orW / orW))/2
			else
				enbuyukalan = orH
				xOff= (orH - (orW * orH / orH))/2
				yOff=0
			end if


			set bg	=	Server.CreateObject("Persits.Jpeg")
			bg.New enbuyukalan, enbuyukalan, &HFFFFFF
			bg.Quality = 100
			bg.Canvas.DrawImage xOff, yOff, img
			bg.save Server.MapPath(export)
			errnumber = err.number
			if errnumber > 0 then
				Response.Write "Hatalı Resim Dosyası"
'				Response.End()
				hata = 1
			end if
			on error goto 0
		'#### CANVAS


		if width < enbuyukalan then
			dimen = width
		else
			dimen = enbuyukalan
		end if


		'#### RESIZE
		if hata = 0 then
			img.open		Server.MapPath(export)
			img.Width	=	dimen
			img.Height	=	img.OriginalHeight * dimen / img.OriginalWidth
			img.FlattenAlpha( &HFFFFFFFF )
			img.ToRGB()
			img.save Server.MapPath(export)
			img.save Server.MapPath("/temp/export2.jpg")
		end if
		'#### RESIZE



		'#### watermark
		if hata = 0 then
			if watermark = 1 then
'				rs9.open "SELECT * FROM txtcontent WHERE ID=3 OR ID=117 OR ID=118 OR ID=119 OR ID=120 OR ID=121 OR ID=122 OR ID=123", conn, 1, 3
'					for ri = 1 to rs9.recordcount
'						if rs9("ID") = "3" then strURL = rs9("content")
'						if rs9("ID") = "117" then strWater = rs9("content")
'						if rs9("ID") = "118" then strWaterFont = rs9("content")
'						if rs9("ID") = "119" then strWatersize = rs9("content")
'						if rs9("ID") = "120" then strWaterColor = rs9("content")
'						if rs9("ID") = "121" then strWaterOpacity = rs9("content")
'						if rs9("ID") = "122" then strWaterYer = rs9("content")
'						if rs9("ID") = "123" then strWaterFontBold = rs9("content")
'					rs9.movenext
'					next
'				rs9.close
'
'				img.open		Server.MapPath(export)
'					text = Replace(strURL, "http://","")
'					text = Replace(text,"/","")
'					fsize = strWaterSize
'					img.canvas.font.color=&H000000
'					img.Canvas.Font.Size = fsize
'					intWidth = img.Canvas.GetTextExtent(Text, 162)+30
'					intXYer = (strWaterYer mod 3)+1
'					intYYer = (strWaterYer \ 3)+1
'					select case intXYer 
'						case 1:intX = 1
'						case 2:intX = int(img.Width-intWidth-fsize+1)/2
'						case 3:intX = img.Width-intWidth-fsize+1
'					end select
'					select case intYYer 
'						case 1:intY = fsize+1
'						case 2:intY = int(img.Height-1)/2
'						case 3:intY = img.Height-1
'					end select
'					img.canvas.Font.Bold = strWaterFontBold
'					img.Canvas.Font.Opacity = strWaterOpacity / 100
'					if strWaterColor = 1 then
'						img.canvas.font.color=&H000000
'					else
'						img.canvas.font.color=&HFFFFFF
'					end if
'					img.Canvas.Font.Size = fsize
'					img.Canvas.PrintTextEx Text, intX, intY, strWaterFont
'					if strWaterColor = 1 then
'						img.canvas.font.color=&HFFFFFF
'					else
'						img.canvas.font.color=&H000000
'					end if
'					img.Canvas.Font.Size = fsize
'					img.Canvas.PrintTextEx Text, intX-1, intY-1, strWaterFont
'				img.save		Server.MapPath(export)
			end if
			if watermark = 2 then
				'## fligranı aç - en boy öğren - resim boyuna oranla
				fligrandosya	=	urlsabit("resimfligran")
				if isnull(fligrandosya) = False and fligrandosya <> "" then
					bg.open				Server.MapPath(fligrandosya)
					fw				=	bg.OriginalWidth
					'fh				=	bg.OriginalHeight
					fbosw			=	width - fw
					fsol			=	fbosw / 2
					fust			=	fbosw / 2
					'## fligranı göm
					img.open		Server.MapPath(export)
					img.Canvas.DrawPNG fsol, fust, Server.MapPath(fligrandosya)
					img.save Server.MapPath(export)
					'set fl = Nothing
				end if
			end if
		end if
		'#### watermark

		'#### byee
			set img = nothing
			set bg = nothing
		'#### byee
		if hata = 0 then
			resimislem = True
		else
			resimislem = False
		end if
	end if

	if kalite = "" then kalite = 100
	if kalite < 100 then
		kalite = cint(kalite)
		set img		=	Server.CreateObject("Persits.Jpeg")
		img.open		Server.MapPath(export)
		img.Quality	=	kalite
		img.save		Server.MapPath(export)
		resimislem = img.Binary
		set img = nothing
	else
		set img		=	Server.CreateObject("Persits.Jpeg")
		img.open		Server.MapPath(export)
		resimislem = img.Binary
		set img = nothing
	end if
end function


function qrcode(strText,intSize)
	qrcode = "https://chart.googleapis.com/chart?cht=qr&chs=" & intSize & "x" & intSize & "&chld=L|1&chl=" & server.URLEncode(strText)
end function

function dosyasil(dosya)
	Set fsof = CreateObject("Scripting.FileSystemObject")
		if fsof.FileExists(Server.Mappath(dosya)) = True then
			fsof.DeleteFile(Server.Mappath(dosya))
			dosyasil = True
		else
			dosyasil = False
		end if
	Set fsof = Nothing
end function







' Functions for encoding string to Base64
	Function base64_encode( byVal strIn )
		Base64Chars	=	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
		For n = 1 To Len( strIn ) Step 3
			c1 = Asc( Mid( strIn, n, 1 ) )
			c2 = Asc( Mid( strIn, n + 1, 1 ) + Chr(0) )
			c3 = Asc( Mid( strIn, n + 2, 1 ) + Chr(0) )
			w1 = Int( c1 / 4 )
			w2 = ( c1 And 3 ) * 16 + Int( c2 / 16 )
			If Len( strIn ) >= n + 1 Then
				w3 = ( c2 And 15 ) * 4 + Int( c3 / 64 )
			Else
				w3 = -1
			End If
			If Len( strIn ) >= n + 2 Then
				w4 = c3 And 63
			Else
				w4 = -1
			End If
			strOut = strOut + mimeencode( w1 ) + mimeencode( w2 ) + mimeencode( w3 ) + mimeencode( w4 )
		Next
		base64_encode = strOut
	End Function

	Function mimeencode( byVal intIn )
		Base64Chars	=	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
		If intIn >= 0 Then
			mimeencode = Mid( Base64Chars, intIn + 1, 1 )
		Else
			mimeencode = ""
		End If
	End Function

	' Function to decode string from Base64
	Function base64_decode( byVal strIn )
		Base64Chars	=	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
		For n = 1 To Len( strIn ) Step 4
			w1 = mimedecode( Mid( strIn, n, 1 ) )
			w2 = mimedecode( Mid( strIn, n + 1, 1 ) )
			w3 = mimedecode( Mid( strIn, n + 2, 1 ) )
			w4 = mimedecode( Mid( strIn, n + 3, 1 ) )
			If w2 >= 0 Then strOut = strOut + Chr( ( ( w1 * 4 + Int( w2 / 16 ) ) And 255 ) )
			If w3 >= 0 Then strOut = strOut + Chr( ( ( w2 * 16 + Int( w3 / 4 ) ) And 255 ) )
			If w4 >= 0 Then strOut = strOut + Chr( ( ( w3 * 64 + w4 ) And 255 ) )
		Next
		base64_decode = strOut
	End Function


function base64_encode_tr(kelime)
	if kelime <> "" then
		kelime = turkcelekodla(kelime)
		kelime = base64_encode(kelime)
		base64_encode_tr = kelime
	end if
end function


function base64_decode_tr(kelime)
	if kelime <> "" then
		kelime = base64_decode(kelime)
		kelime = turkcele(kelime)
		base64_decode_tr = kelime
	end if
end function


	Function mimedecode( byVal strIn )
		Base64Chars	=	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
		If Len( strIn ) = 0 Then
			mimedecode = -1
			Exit Function
		Else
			mimedecode = InStr( Base64Chars, strIn ) - 1
		End If
	End Function



function sifrekontrol(kelime)
	sifrekontrol = True
	if kelime = "" then
		sifrekontrol = False
	else
		if len(kelime) < 6 then sifrekontrol = False
		if left(kelime,6) = "123456" or left(kelime,6) = "987654" or left(kelime,6) = "147258" or left(kelime,6) = "147258" or left(kelime,6) = "112233" or left(kelime,6) = "111111" or left(kelime,6) = "123123" then sifrekontrol = False
		if left(kelime,6) = "qwerty" or left(kelime,6) = "asdfgh" or left(kelime,6) = "zxcvbn" or left(kelime,6) = "qweasd" then sifrekontrol = False
	end if
end function










function jsonad(kelime)
	jsonad = kelime
	jsonad = Trim(kelime)
	if len(jsonad)>0 then
		jsonad = Replace(jsonad,"/","")
		jsonad = Replace(jsonad,"\","")
		jsonad = Replace(jsonad,"$","")
		jsonad = Replace(jsonad,"@","")
		jsonad = Replace(jsonad,"€","")
		jsonad = Replace(jsonad,"…","")
		jsonad = Replace(jsonad,",","")
		jsonad = Replace(jsonad,"'","")
		jsonad = Replace(jsonad,";","")
		jsonad = Replace(jsonad,"«","")
		jsonad = Replace(jsonad,"»","")
		jsonad = Replace(jsonad,"&","")
		jsonad = Replace(jsonad,"н","")
		jsonad = Replace(jsonad,"'","")
		jsonad = Replace(jsonad,chr(34),"")
		jsonad = Replace(jsonad,"’","-")
		'boşluk ayarlama
		jsonad = Replace(jsonad,"  "," ")
		jsonad = Replace(jsonad,"  "," ")
		jsonad = Replace(jsonad,"  "," ")
		jsonad = Replace(jsonad,"	","-")
		'boşluk ayarlama
	end if
end function



function loginturubul()
	if Request.Cookies("loginturu") <> "" then
		if Request.Cookies("loginturu") = "crm" then loginturubul = "CRM"
		if Request.Cookies("loginturu") = "b2b" then loginturubul = "B2B"
	else
		loginturubul = "CRM"
	end if
end function


function ofisler(id)
	if id <> "" then
		sqlusdb = "SELECT ad from ofisler where id = " & id
		Set usdb = Server.CreateObject("ADODB.Recordset")
		usdb.Open sqlusdb, ecev5, 1, 3
			ofisler = usdb(0)
		usdb.close
		set usdb = Nothing
	end if
end function


function ozelveriece(byVal id, byVal alan, byVal db)
if id = "" then
	ozelveriece = ""
else
	sqlusdb = "SELECT " & alan & " from " & db & " where id = " & id
	Set usdb = Server.CreateObject("ADODB.Recordset")
	usdb.Open sqlusdb, ecev5, 1, 3
	if usdb.recordcount > 0 then
		ozelveriece = usdb(0)
	end if
	usdb.close
	set usdb = Nothing
end if
end function


Function tarihjp2(tarih)'2011-11-21
	yil = year(tarih)
	if month(tarih) < 10 then ay = "0" & month(tarih) else ay = month(tarih)
	if day(tarih) < 10 then gun = "0" & day(tarih) else gun = day(tarih)
	tarihjp2 =  yil & "-" & ay & "-" & gun
End Function

function jsindir(dosya)
	Response.Write "<script type=""text/javascript"">$(document).ready(function(){document.location = '" & dosya & "';})</script>"
end function



Function jsfunction(byVal icerik)
	%><script type="text/javascript">$(document).ready(function(){<%=icerik%>});</script><%
End Function





function fbjsontr(kelime)
	if kelime <> "" then
		fbjsontr = kelime
		fbjsontr = Replace(fbjsontr,"\u015e","Ş")
		fbjsontr = Replace(fbjsontr,"\u015f","ş")
		fbjsontr = Replace(fbjsontr,"\u00D6","Ö")
		fbjsontr = Replace(fbjsontr,"\u00f6","ö")
		fbjsontr = Replace(fbjsontr,"\u00DC","Ü")
		fbjsontr = Replace(fbjsontr,"\u00FC","ü")
		fbjsontr = Replace(fbjsontr,"\u00fc","ü")
		fbjsontr = Replace(fbjsontr,"\u00c7","Ç")
		fbjsontr = Replace(fbjsontr,"\u00e7","ç")
		fbjsontr = Replace(fbjsontr,"\u0130","İ")
		fbjsontr = Replace(fbjsontr,"\u0131","ı")
		fbjsontr = Replace(fbjsontr,"\u011e","Ğ")
		fbjsontr = Replace(fbjsontr,"\u011f","ğ")
		fbjsontr = Replace(fbjsontr,"\u0040","@")
	else
		fbjsontr = ""
	end if
end function




function classdeger(byVal classadi,byVal deger)
	%><script type="text/javascript">$(document).ready(function(){$('.<%=classadi%>').html('<%=deger%>');});</script><%
end function








function bootmodal(byVal mesaj,byVal tur,byVal okhedef,byVal cancelhedef, byVal okbaslik, byVal cancelbaslik, byVal okstyle, byVal cancelstyle, byVal ek1, byVal ek2, byVal closedelay, byVal formverileri, byVal ek5)
'örnek : call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	%><script type="text/javascript">$().ready(function(){bootmodal('<%=turkcele(mesaj)%>','<%=tur%>','<%=okhedef%>','<%=cancelhedef%>','<%=okbaslik%>','<%=cancelbaslik%>','<%=okstyle%>','<%=cancelstyle%>','<%=ek1%>','<%=ek2%>','<%=closedelay%>','<%=formverileri%>','<%=ek5%>')});</script><%
end function

function formyap(byVal hedef, byVal degerler)
	if hedef <> "" and degerler <> "" then
		if instr(degerler,"=") > 0 then
			degerler = Split(degerler,"|")
			formverisayisi = ubound(degerler)+1
			redim fvname(formverisayisi)
			redim fvdata(formverisayisi)
			for fi = 1 to formverisayisi
				fv = Split(degerler(fi-1),"=")
					fvname(fi-1) = fv(0)
					fvdata(fi-1) = fv(1)
				set fv = Nothing
			next
			set degerler = Nothing
			Response.Write "<!DOCTYPE HTML><html><head><meta charset=""utf" & "-8""></head><body><form id=""q2post"" action=""" & hedef & """ method=""post"">"
			for fi = 1 to formverisayisi
				Response.Write "<input type=""hidden"" name=""" & fvname(fi-1) & """ value=""" & fvdata(fi-1) & """ />"
			next
			Response.Write "</form>"
			Response.Write "<script type=""text/javascript"">document.getElementById('q2post').submit();</sc" & "" & "ript>"
			Response.Write "</body></html>"
			Response.End()
		end if
	end if
end function


function hashkodla(byVal tur,byVal data)
'sha1
'sha1lcase
'md5
'md5lcase
'data = "?xtm=" & xtm & "&ts=" & ts & "&sn=" & sn & "&mac=" & mac & "&sesstimeout=" & sesstimeout & "&idletimeout=" & idletimeout
	strHostAddress = "http://crm.sbstasarim.com/code/code.asp?tur=" & tur
	Set SrvHTTPS = Server.CreateObject("MSXML2.ServerXMLHTTP")
	SrvHTTPS.open "POST", strHostAddress, false
	SrvHTTPS.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
	SrvHTTPS.send data
	gelenveri = SrvHTTPS.responseXML.xml
	Set objDoc = CreateObject("Microsoft.XMLDOM")
	objDoc.async = False
	objDoc.LoadXml(gelenveri)
	Set ObjeListesi = objDoc.getElementsByTagName("authentication")
	For Each Obje In ObjeListesi
		hashkodla = Obje.childNodes(0).Text
	next
	Set ObjeListesi = Nothing
end function


function jquerykontrol()'jquery yüklü mü değil mi ? Değilse yükle
	Response.Write "<script type=""text/javascript"">"
	Response.Write "if (typeof jQuery === 'undefined') {"
	Response.Write "document.write('<script src=""//sbstasarim.com/jquery/core/jquery-2.1.1.min.js"">\x3C/script>')"
	Response.Write "}else{"
	Response.Write "}"
	Response.Write "</script>"
end function


function jqueryformkontrol()'jquery form yüklü mü değil mi ? Değilse yükle
	Response.Write "<script type=""text/javascript"">"
	Response.Write "if (typeof ajaxForm === 'undefined') {"
	Response.Write "document.write('<script src=""//sbstasarim.com/jquery/core/jquery.form-3.4.min.js"">\x3C/script>')"
	Response.Write "}else{"
	Response.Write "}"
	Response.Write "$('.ajaxform').ajaxForm({target:'#ajax',type:'POST'});"
	Response.Write "</script>"
end function


function sqlcalistir(sqlsorgu)
	if sqlsorgu <> "" then
		Set sedb = Server.CreateObject("ADODB.Recordset")
		sedb.Open sqlsorgu, sbsv5, 1, 3
		set sedb = Nothing
	end if
end function


function jsrun(komut)
	Response.Write "<script type=""text/javascript"">$(document).ready(function(){" & komut & "});</script>"
end function


function mobilkontrol()
	mobil = False
	browserlar = Array("up.browser","up.link","mmp","symbian","smartphone","midp","wap","phone","windows ce","pda","mobile","mini","palm","ipad","android","tablet")

	userbrowser = lcase(Request.ServerVariables("HTTP_USER_AGENT"))
	for bi = 0 to ubound(browserlar)
		if instr(userbrowser,browserlar(bi)) > 0 then
			mobil = True
		end if
	next
	mobilkontrol = mobil
end function

function jsconsole(deger)
	Response.Write "<script type=""text/javascript"">"
	Response.Write "console.log ('"
'	Response.Write FormatNumber(Timer-Session("lngTimer"),3,True)
'	Response.Write " || "
	Response.Write deger
	Response.Write "');"
	Response.Write "</script>"
end function


function tarihr2date(tarih)'2014-11-28T16:08:53Z
	if tarih = "" then tarih = now()
	tarih	=	Replace(tarih,"Z","")
	tarih	=	Replace(tarih,"T"," ")
	yil		=	year(tarih)
	ay		=	month(tarih)
	if ay < 10 then ay = "0" & ay
	gun		=	day(tarih)
	if gun < 10 then gun = "0" & gun
	saat	=	hour(tarih)
	if saat < 10 then saat = "0" & saat
	dakika	=	minute(tarih)
	if dakika < 10 then dakika = "0" & dakika
	saniye	=	second(tarih)
	if saniye < 10 then saniye = "0" & saniye
	tarihr2date = gun & "." & ay & "." & yil
end function

function tarihmulti(tarih)
	'2015-09-24T12:51:34Z			'senaryo 2
	tarih	=	Replace(tarih,"+0000","")
	tarih	=	Replace(tarih,"+0100","")
	tarih	=	Replace(tarih,"+0200","")
	tarih	=	Replace(tarih,"+0300","")
	'günler
	tarih	=	Replace(tarih,"Mon,","")
	tarih	=	Replace(tarih,"Tue,","")
	tarih	=	Replace(tarih,"Wed,","")
	tarih	=	Replace(tarih,"Thu,","")
	tarih	=	Replace(tarih,"Fri,","")
	tarih	=	Replace(tarih,"Sat,","")
	tarih	=	Replace(tarih,"Sun,","")
	'aylar
	tarih	=	Replace(tarih," Jan ",".01.")
	tarih	=	Replace(tarih," Feb ",".02.")
	tarih	=	Replace(tarih," Mar ",".03.")
	tarih	=	Replace(tarih," Apr ",".04.")
	tarih	=	Replace(tarih," May ",".05.")
	tarih	=	Replace(tarih," Jun ",".06.")
	tarih	=	Replace(tarih," Jul ",".07.")
	tarih	=	Replace(tarih," Aug ",".08.")
	tarih	=	Replace(tarih," Sep ",".09.")
	tarih	=	Replace(tarih," Oct ",".10.")
	tarih	=	Replace(tarih," Nov ",".11.")
	tarih	=	Replace(tarih," Dec ",".12.")
	'meridyen
	tarih	=	Replace(tarih,"Z","")
	tarih	=	Replace(tarih,"T"," ")

	tarihmulti = tarih
end function




function saatbul(byVal tarih)
	if tarih = "" or isnull(tarih) = True then
	else
		saat	=	hour(tarih)
		dakika	=	minute(tarih)
		saatbul = saat & ":" & dakika
	end if
end function


function xmlverigonder(byVal sunucu, byVal veri, byVal yontem, byVal verituru, byVal ekheader1ad, byVal ekheader1val, byVal ek3, byVal ek4, byVal ek5)
'sonuc = xmlverigonder("http://php.sbstasarim.com/applepush/simplepush23.php","token=xxx","POST","","","","","","")
'	ekheader1ad		=	"Authorization: key="
'	ekheader1val	=	"AIzaSyAI1Of06S5kdfL2fTKSZJaSLGdVpt47W8g"
	if yontem = "" then
		yontem = "POST"
	end if
	if verituru = "" then
		kontenttype = "application/x-www-form-urlencoded"
		verituru = "xml"
	elseif verituru = "json" then
		kontenttype = "application/json"
	end if

	Set SrvHTTPS = Server.CreateObject("MSXML2.ServerXMLHTTP")
	SrvHTTPS.open yontem, sunucu, false
	if ekheader1ad <> "" then
		SrvHTTPS.setRequestHeader ekheader1ad,ekheader1val
	end if
	SrvHTTPS.setRequestHeader "Content-Type",kontenttype
	SrvHTTPS.send veri

	if verituru = "xml" then
		xmlverigonder = SrvHTTPS.responseXML.xml
	else
		xmlverigonder = SrvHTTPS.responseText
	end if
end function

function markabul(markaid)
	if markaid <> "" then
		sqlmdb = "Select ad from urun_marka where id = " & uid
		Set mdb = Server.CreateObject("ADODB.Recordset")
		mdb.Open sqlmdb, sbsv5, 1, 3
			if mdb.recordcount > 0 then
				markabul = mdb("ad")
			end if
		mdb.close
		set mdb = Nothing
	end if
end function


function iphonenotification(byVal mesaj,byVal pushID,byVal site)
'	adres	=	"http://php.sbstasarim.com/applepush/simplepush" & site & ".php"
'	veri	=	"token=" & pushID & "&message=" & mesaj
'	Set SrvHTTPS = Server.CreateObject("MSXML2.ServerXMLHTTP")
'	SrvHTTPS.open "POST", adres, false
'	SrvHTTPS.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
'	SrvHTTPS.send veri
'	gelen = SrvHTTPS.responseText
'	iphonenotification = "Gönderim Başarılı"
	call apklog("iphone-notification","pushID","")
end function



Function hizlimailat(byVal baslik, byVal icerik,byVal gonderen,byVal hedef,byVal ek)

' BU
' ESKİDİ
' YENİSİ
' call mailgonder(baslik,icerik,gonderen,gonderenAd,hedef,ekDosya,basariliMesaj,hataMesaj,"","","","","")



	'call hizlimailat(baslik,icerik,gonderen,hedef,ek)
	if hedef <> "" then
		'http://www.dimac.net/Products/w3Jmail/Version37/Reference/RefStart.htm
'		on error resume next
		Set JMail = Server.CreateObject ("JMail.SMTPMail")
		JMail.Silent					=	true
		JMail.Logging					=	true
		JMail.charset					=	"utf-8"
		JMail.ServerAddress				=	sb_mailserver
		JMail.Sender					=	gonderen
		JMail.Subject					=	baslik
		JMail.HTMLBody					=	icerik
		JMail.Priority					=	1
		JMail.AddHeader						"Originating-IP", Request.ServerVariables("REMOTE_ADDR")
		hedef = Replace(hedef,";",",")
		if instr(hedef,",") > 0 then
			hedefar = Split(hedef,",")
			for hei = 0 to ubound(hedefar)
				JMail.AddRecipientbcc			hedefar(hei)
			next
		else
			JMail.AddRecipientbcc			hedef
		end if
'		JMail.AddRecipientbcc				"teknik@sbstasarim.com"
		if ek <> "" then
			' if left(ek,1) = "/" then
				' JMail.AddAttachment				("C:\HostingSpaces\sbstasarim3\tio.sbstasarim.com\backup\yedek25092022170245.bak")
			' else
				JMail.AddAttachment				Server.Mappath(ek)
			' end if
		end if

		if not JMail.execute then
			Response.Write "Mesaj:" & JMail.ErrorMessage & "Kaynak : " & JMail.ErrorSource & "Log : " & JMail.Log
		end if
		if jmaillog = True then
			jmaillog = JMail.Log
		end if
		set JMail = Nothing
		call jsconsole("mail")
'		on error goto 0
	end if
End Function

function sablonmailat(byVal sablonID,byVal sablonturu,byVal hedef,byVal ek1,byVal ek2,byVal ek3,byVal ek4)
'	if sablonID = "" and sablonturu = "" then
	if sablonID = "" then
	else
		if hedef = "" or isnull(hedef) = True then
		else
			if sablonID <> "" then
				sasorgu = "Select * from mail_sablonlar where id = " & sablonID
			end if
			if sablonturu <> "" and sasorgu = "" then
				sasorgu = "Select * from mail_sablonlar where " & sablonturu & " = 'True'"
			end if
			if sasorgu <> "" then
				'mail gönder
				fn1.open sasorgu,sbsv5,1,3
					if fn1.recordcount > 0 then
						baslik			=	fn1("baslik")
						icerik			=	fn1("icerik")
						gonderen		=	fn1("gonderen")
						adminkopya		=	fn1("adminkopya")
						fn1("sayac")	=	fn1("sayac") + 1
						fn1.update
					end if
				fn1.close
				if baslik <> "" and icerik <> "" and hedef <> "" then
					call hizlimailat(baslik,icerik,gonderen,hedef,"")
					if isnull(adminkopya) = True or adminkopya = "" then
					else
						adminkopya = Replace(adminkopya,";",",")
						adminmailler = Split(adminkopya,",")
						for ai = 0 to ubound(adminmailler)
							call hizlimailat(baslik & " / " & hedef,icerik,gonderen,adminmailler(ai),"")
						next
						set adminmailler = Nothing
					end if
				end if
			end if
		end if
	end if
end function

function apkhashyap(byVal telno ,byVal urlid ,byVal devid ,byVal pusid ,byVal cocuk ,byVal velii , byVal velid)
	urlid = urlidbul()
	if telno = "" then
		if Request.Form("p") <> "" then
			telno = Request.Form("p")
			if telno = "null" then telno = ""
		end if
	end if
	if devid = "" then
		if Request.Form("d") <> "" then
			devid = Request.Form("d")
		end if
	end if
	if pusid = "" then
		if Request.Form("pushID") <> "" then
			pusid = Request.Form("pushID")
		end if
	end if
	apkhash = telno & "|" & urlid & "|" & devid & "|" & pusid & "|" & cocuk & "|" & velii & "|" & velid
	apkhash = base64_encode_tr(apkhash)
	Response.Cookies("apkhash") = apkhash
	Response.Cookies("apkhash").Expires = date()+30
end function

function apkpushidbul(byVal devid)
	apkpushidbul = ""
	if devid <> "" then
		rs.open "Select top(1) rq from apklog where ip = '" & Request.ServerVariables("REMOTE_ADDR") & "' and rq like '%" & devid & "%' and rq like '%apk_rqpushp%' order by id desc",sbsv5,1,3
			if rs.recordcount > 0 then
				rqpush			=	rs("rq")
				pushdeger		=	instr(rqpush,"pushID=")
				pushdeger		=	pushdeger + 6
				pushID			=	right(rqpush,len(rqpush)-pushdeger)
				apkpushidbul	=	pushID
			end if
		rs.close
	end if
end function


function hatakaydet(byVal deg1,byVal deg2, byVal deg3)
	if Session("urlid") = "" then
		call urlidbul()
	end if
	if Session("urlid") <> "" then
		sqladb = "SELECT top(1) * from urun_odeme_log"
		Set adb = Server.CreateObject("ADODB.Recordset")
		adb.Open sqladb, sbsv5, 1, 3
		adb.addnew
			adb("urlid")		=	Session("urlid")
			adb("gelenform")	=	Request.Form
			adb("bilgi1")		=	deg2
			adb("bilgi2")		=	deg3
			adb("allhttp")		=	Request.ServerVariables("ALL_HTTP")
			adb("tarih")		=	now()
		adb.update
		adb.close
		set adb = Nothing
'		call jsconsole(deg3)
	end if
end function

Function repTr(text)
	if text <> "" then
		text	=	Replace(text,"ı","i")
		text	=	Replace(text,"ğ","g")
		text	=	Replace(text,"ü","u")
		text	=	Replace(text,"ş","s")
		text	=	Replace(text,"ö","o")
		text	=	Replace(text,"ç","c")

		text	=	Replace(text,"Ğ","G")
		text	=	Replace(text,"Ü","U")
		text	=	Replace(text,"Ş","S")
		text	=	Replace(text,"İ","I")
		text	=	Replace(text,"Ç","C")
		text	=	Replace(text,"Ö","O")

		text	=	Replace(text,"&#287;","g")
		text	=	Replace(text,"&#252;","u")
		text	=	Replace(text,"&#351;","s")
		text	=	Replace(text,"&#305;","i")
		text	=	Replace(text,"&#246;","o")
		text	=	Replace(text,"&#231;","c")

		text	=	Replace(text,"&#286;","G")
		text	=	Replace(text,"&#220;","U")
		text	=	Replace(text,"&#350;","S")
		text	=	Replace(text,"&#304;","I")
		text	=	Replace(text,"&#214;","O")
		text	=	Replace(text,"&#199;","C")
		repTr	=	text
	end if
End Function




function kidbilgi(byVal alan)
	kidbilgi = alan
	if instr(alan,"{") > 0 then
		kidbi = Request.Cookies("kidbi")
		if kidbi <> "" then
			kidbi = base64_decode_tr(kidbi)
			if instr(kidbi,"||") > 0 then
				'kidbi	=	uyedb("id") & "||" & uyedb("ad") & "||" & uyedb("soyad") & "||" & uyedb("email") & "||" & uyedb("tel") & "||" & dbadilla
				kidbiar		=	Split(kidbi,"||")
				uyeid		=	kidbiar(0)
				uyead		=	kidbiar(1)
				uyesoyad	=	kidbiar(2)
				uyemail		=	kidbiar(3)
				uyetel		=	kidbiar(4)
				dbadilla	=	kidbiar(5)
				kidbilgi = Replace(kidbilgi,"{uyeid}",uyeid)
				kidbilgi = Replace(kidbilgi,"{uyead}",uyead)
				kidbilgi = Replace(kidbilgi,"{uyesoyad}",uyesoyad)
				kidbilgi = Replace(kidbilgi,"{uyemail}",uyemail)
				kidbilgi = Replace(kidbilgi,"{uyetel}",uyetel)
				set kidbiar = Nothing
			end if
		end if
	else
		kidbi = Request.Cookies("kidbi")
		if kidbi <> "" then
			kidbi = base64_decode_tr(kidbi)
			if instr(kidbi,"||") > 0 then
				'kidbi	=	uyedb("id") & "||" & uyedb("ad") & "||" & uyedb("soyad") & "||" & uyedb("email") & "||" & uyedb("tel") & "||" & dbadilla
				kidbiar		=	Split(kidbi,"||")
				uyeid		=	kidbiar(0)
				uyead		=	kidbiar(1)
				uyesoyad	=	kidbiar(2)
				uyemail		=	kidbiar(3)
				uyetel		=	kidbiar(4)
				dbadilla	=	kidbiar(5)
				if alan = "dbadilla" then
					kidbilgi = dbadilla
				end if
				if alan = "uyeid" then
					kidbilgi = uyeid
				end if
				if alan = "uyead" then
					kidbilgi = uyead
				end if
				if alan = "uyesoyad" then
					kidbilgi = uyesoyad
				end if
				if alan = "uyeadsoyad" then
					kidbilgi = uyead & " " & uyesoyad
				end if
				if alan = "uyemail" then
					kidbilgi = uyemail
				end if
				if alan = "uyetel" then
					kidbilgi = uyetel
				end if
				set kidbiar = Nothing
			end if
		end if
	end if
end function


function smsgonder(byVal sb_smsBaslik, byVal gonderimayrinti, byVal numara, byVal mesaj)
	sunucu = sb_smsOperator
	'####### NUMARA VE MESAJ DÜZENLEME
	'####### NUMARA VE MESAJ DÜZENLEME
		if isnull(numara) = True then
			numara	=	""
		end if
		numara		=	Trim(numara)
		numara		=	Replace(numara," ","")
		numara		=	Replace(numara,")","")
		numara		=	Replace(numara,"(","")
		numara		=	Replace(numara,"*","")
		numara		=	Replace(numara,"+","")
		numara		=	Replace(numara,"_","")
		numara		=	Replace(numara,"EV","")
		numara		=	Replace(numara,"CEP","")
		numara		=	Replace(numara,"-","")
		numara		=	Replace(numara,"</p>","")
		numara		=	Replace(numara,"<br/>","")
		numara		=	Replace(numara,"#","")
		numara		=	Replace(numara,"X","")
		numara		=	Replace(numara,"*","")
		if left(numara,1) = "9" then
			numara = right(numara,len(numara)-1)
		end if
		if left(numara,1) = "0" then
			numara = right(numara,len(numara)-1)
		end if
		mesaj		=	Replace(mesaj,"Ö","O")
		mesaj		=	Replace(mesaj,"Ç","C")
		mesaj		=	Replace(mesaj,"Ş","S")
		mesaj		=	Replace(mesaj,"İ","I")
		mesaj		=	Replace(mesaj,"Ğ","G")
		mesaj		=	Replace(mesaj,"Ü","U")
		mesaj		=	Replace(mesaj,"ö","o")
		mesaj		=	Replace(mesaj,"ç","c")
		mesaj		=	Replace(mesaj,"ş","s")
		mesaj		=	Replace(mesaj,"ı","i")
		mesaj		=	Replace(mesaj,"ğ","g")
		mesaj		=	Replace(mesaj,"ü","u")
		mesaj		=	Replace(mesaj,"&","")
		mesaj		=	Replace(mesaj,"  "," ")
		mesaj		=	Replace(mesaj,"  "," ")
		mesaj		=	Replace(mesaj,"  "," ")
		mesaj		=	Replace(mesaj,"  "," ")
		mesaj		=	Replace(mesaj,"  "," ")
		mesaj		=	left(mesaj,155)
	'####### NUMARA VE MESAJ DÜZENLEME
	'####### NUMARA VE MESAJ DÜZENLEME

	'###### SMS GÖNDERİM İŞLERİ
	'###### SMS GÖNDERİM İŞLERİ
	if numara <> "" and mesaj <> "" then
		if left(numara,1) = "5" then
			if sunucu = "digicell" then
				'### MESAJ BLOK
				'### MESAJ BLOK
					adres		=	"http://api.sms.digicell.com.tr:8080/api/smspost/v1"
					zaman		=	"2015.7.23.9.30.0"
					veri		=	"<sms>"
					veri		=	veri & "<username>kcs</username>"
					veri		=	veri & "<password>856d2f307a7b865b5b5a61c0f28bf9cf</password>"
					veri		=	veri & "<header>" & gonderenbaslik & "</header>"
					veri		=	veri & "<validity>2880</validity>"
					veri		=	veri & "<sendDateTime>" & zaman & "</sendDateTime>"
					veri		=	veri & "<message>"
					veri		=	veri & "<gsm>"
					veri		=	veri & "<no>" & numara & "</no>"
					veri		=	veri & "</gsm>"
					veri		=	veri & "<msg><![CDATA[" & mesaj & "]]></msg>"
					veri		=	veri & "</message>"
					veri		=	veri & "</sms>"
				'### MESAJ BLOK
				'### MESAJ BLOK
				'### MESAJ GÖNDER
				'### MESAJ GÖNDER
					Set SrvHTTPS = Server.CreateObject("MSXML2.ServerXMLHTTP")
					SrvHTTPS.open "POST", adres, false
					SrvHTTPS.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
					SrvHTTPS.send	veri
					gelendata	=	SrvHTTPS.responseText
					Set SrvHTTPS = Nothing
					'if err.level = 0 then
						smsgonderimdurum = True
					'else
					'	smsgonderimdurum = False
					'end if
				'### MESAJ GÖNDER
				'### MESAJ GÖNDER
				'### ARŞİVLE
				'### ARŞİVLE
					sorgu =  "Select top(1) * from Bildirim.SMSArsiv"
					fn1.open sorgu,sbsv5,1,3
						fn1.addnew
						fn1("durum")		=	""
						fn1("mesaj")		=	mesaj
						fn1("numara")		=	numara
						fn1("gonderen")		=	gonderenbaslik
						fn1("tarih")		=	now()
						fn1("gonderimID")	=	gelendata
						fn1("baslik")		=	gonderimayrinti
						fn1("sunucu")		=	sunucu
						fn1.update
					fn1.close
				'### ARŞİVLE
				'### ARŞİVLE
			end if
			if sunucu = "netgsm" then
				adres = "http://api.netgsm.com.tr/bulkhttppost.asp?usercode=" & SMSUser & "&password=" & SMSPass & "&gsmno=" & numara & "&message=" & mesaj & "&msgheader=" & gonderenbaslik & "&startdate=&stopdate="
				Set SrvHTTPS = Server.CreateObject("MSXML2.ServerXMLHTTP")
				SrvHTTPS.open "GET", adres, false
				SrvHTTPS.send()
				gelenveri	=	SrvHTTPS.responseText
				smsgonder = gelenveri
				'### ARŞİVLE
				'### ARŞİVLE
					sorgu =  "Select top(1) * from Bildirim.SMSArsiv"
					fn1.open sorgu,sbsv5,1,3
						fn1.addnew
						fn1("durum")		=	""
						fn1("mesaj")		=	mesaj
						fn1("numara")		=	numara
						fn1("gonderen")		=	gonderenbaslik
						fn1("tarih")		=	now()
						' fn1("gonderimID")	=	gelendata
						fn1("baslik")		=	gonderimayrinti
						fn1("sunucu")		=	sunucu
						fn1.update
					fn1.close
				'### ARŞİVLE
				'### ARŞİVLE
			end if
			if sunucu = "mobilpark" then
				Set xmlhttp = CreateObject("MSXML2.XMLHTTP")
				adres = "https://service.mobilpark.biz/http/SendMsg.aspx?username=" & sb_smsApiUser & "&password=" & sb_smsApiPass & "&from=" & sb_smsBaslik & "&to=" & numara & "&text=" & mesaj
				xmlhttp.Open "GET", adres, False
				xmlhttp.send "at"
				if xmlhttp.Status = 200 Then
					gelenveri		=	xmlhttp.responseText'ID: J17837830 To: 5053376198
				end if
				set xmlhttp = Nothing
				if gelenveri <> "" then
					gelenarr = Split(gelenveri," ")
					gelenveri = gelenarr(1)
				end if
				'### ARŞİVLE
				'### ARŞİVLE
					sorgu =  "Select top(1) * from sms.gecmis"
					fn1.open sorgu,sbsv5,1,3
						fn1.addnew
						fn1("durum")		=	"Sonuç Bekleniyor"
						fn1("mesaj")		=	mesaj
						fn1("telefon")		=	numara
						fn1("gonderen")		=	sb_smsBaslik
						fn1("tarih")		=	now()
						fn1("gonderimID")	=	gelenveri
						fn1("baslik")		=	gonderimayrinti
						fn1("sunucu")		=	sunucu
						fn1("firmaID")		=	firmaID
						fn1("gonderimUnique") = 0

						fn1.update
					fn1.close
				'### ARŞİVLE
				'### ARŞİVLE
			end if
			'### NAC
			'### NAC
				if sunucu = "nac" then
					'#### VERİ BLOĞU
					'#### VERİ BLOĞU
						veri = ""
						' veri = veri & "{""Credential"": {""Username"":""kaybilsem"",""Password"":""8muKNfcJ"",""ResellerID"":1298},"
						veri = veri & "{"
						veri = veri & """type"": 1,"
						veri = veri & """sendingType"": 0,"
						veri = veri & """title"": """ & gonderimayrinti & ""","
						veri = veri & """content"": """ & mesaj & ""","
						veri = veri & """number"": 90" & numara & ","
						veri = veri & """encoding"": 0,"
						veri = veri & """sender"": """ & gonderenbaslik & ""","
						' veri = veri & """periodicSettings"": null,"
						' veri = veri & """sendingDate"": null,"
						veri = veri & """validity"": 60"
						' veri = veri & """pushSettings"": null"
						veri = veri & "}"
					'#### VERİ BLOĞU
					'#### VERİ BLOĞU

					'#### SEND
					'#### SEND
						Set http = Server.CreateObject("msxml2.ServerXMLHTTP.6.0")
						http.Open "POST", "http://smslogin.nac.com.tr:9587/sms/create", False', "kaybilsem","8muKNfcJ"
						http.setTimeouts 5000, 5000, 10000, 10000 'ms - resolve, connect, send, receive'
						http.setRequestHeader "Content-Type","application/json"
						http.setRequestHeader "Authorization", "Basic a2F5Ymlsc2VtOjhtdUtOZmNK"
						http.Send veri
						gelendata	=	http.responseText
					'#### SEND
					'#### SEND

					'#### ÇÖZÜMLE
					'#### ÇÖZÜMLE
						call jsconsole("Gelen Data : " & gelendata)'{"err":null,"data":{"pkgID":4625395}}
						gelenXML	=	gelendata
						gelendata	=	Replace(gelendata,"""","")
						gelendata	=	Replace(gelendata,"}","")
						gelendata	=	Replace(gelendata,"{","")
						gelendata1	=	instr(gelendata,"pkgID:")
						gonderimID	=	right(gelendata,len(gelendata)-(gelendata1+5))
					'#### ÇÖZÜMLE
					'#### ÇÖZÜMLE

					'#### KAYIT
					'#### KAYIT
							fn1.open "Select top(1) * from sms.gecmis",sbsv5,1,3
								fn1.addnew
								fn1("durum")			=	"Sonuç Bekleniyor"
								fn1("mesaj")			=	mesaj
								fn1("telefon")			=	numara
								fn1("gonderen")			=	gonderenbaslik
								fn1("tarih")			=	now()
								fn1("gonderimID")		=	gonderimID
								fn1("baslik")			=	gonderimayrinti
								fn1("sunucu")			=	sunucu
								if grupID <> "" then
									fn1("grupID")		=	grupID
								end if
								fn1("cevapXML")			=	gelenXML
								fn1("gonderimUnique")	=	0
								fn1.update
							fn1.close
							call jsconsole("SMS ATILDI : " & numara)
					'#### KAYIT
					'#### KAYIT
				end if
			'### NAC
			'### NAC


		end if
	end if
	'###### SMS GÖNDERİM İŞLERİ
	'###### SMS GÖNDERİM İŞLERİ
end function


function smsdurum(byVal gonderimID)
gonderimIDarr	=	split(gonderimID,"-")
		gonderimID		=	gonderimIDarr(0)
		gonderimID		=	int(gonderimID)

veri				=	"<packet version=""1.0"">"
veri				=	veri & "<header>"
veri				=	veri & "<auth userName=""5010-gozdegrubu"" password=""63021"" />"
veri				=	veri & "</header>"
veri				=	veri & "<body>"
veri				=	veri & "<getMessageStatus useGrouping=""1"">"
veri				=	veri & "<msgIdList>"
veri				=	veri & "<msgId>" & gonderimID & "</msgId>"
veri				=	veri & "</msgIdList>"
veri				=	veri & "</getMessageStatus>"
veri				=	veri & "</body>"
veri				=	veri & "</packet>"

		Set SrvHTTPS = Server.CreateObject("MSXML2.ServerXMLHTTP")
		SrvHTTPS.open "POST","http://service.mobilpark.biz/xml/default.aspx", false
		SrvHTTPS.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
		SrvHTTPS.send	veri
		smsdurum	=	SrvHTTPS.responseText
		
		Set objDoc	=	server.createObject("Microsoft.XMLDOM")
	objDoc.loadXML(smsdurum)
	gonderimID	=	objDoc.getElementsByTagName("scode").item(0).text
	
	
end function

function modalkapat()
	call jquerykontrol()
	Response.Write "<script type=""text/javascript"">"
	Response.Write "$().ready(function(){"
	Response.Write "$('.modal').modal('hide');"
	Response.Write "});"
	Response.Write "</script>"
end function

function ozelloginform(byVal dbad)
	skidolf = kidbul()
	dbadenc = dbad
	dbadenc = base64_encode_tr(dbadenc)
	if left(skidolf,1) = "t" or skidolf = "" then
		Response.Write "<div class=""row border-ccc border-r10 pt10 pb10"">"
		Response.Write "<div class=""col-lg-12 mb10"">"
		Response.Write "<button class=""form-control btn btn-info"" type=""button"" onClick=""modalajax('','/sayfa/uyelik/formozel.asp?od=" & dbadenc & "');"">Üye Ol</button>"
		Response.Write "</div>"
		Response.Write "<div class=""clearfix""></div>"
		Response.Write "<form class=""ajaxform"" method=""post"" action=""/sayfa/uyelik/login_ozel.asp"">"
		Response.Write "<input type=""hidden"" name=""urlid"" value=""" & Session("urlid") & """ />"
		Response.Write "<input type=""hidden"" name=""dbadilla"" value=""" & dbadenc & """ />"
		Response.Write "<div class=""col-lg-12"">"
		Response.Write "<input class=""form-control"" type=""email"" name=""email"" placeholder=""Email Adresiniz"" />"
		Response.Write "</div>"
		Response.Write "<div class=""col-lg-12 mt5"">"
		Response.Write "<input class=""form-control"" type=""password"" name=""sifre"" placeholder=""Şifreniz"" />"
		Response.Write "</div>"
		Response.Write "<div class=""col-lg-12 mt5"">"
		Response.Write "<button class=""form-control btn btn-warning"" type=""submit"">Giriş</button>"
		Response.Write "</div>"
'		Response.Write "<div class=""col-lg-12 mt5"">"
'		Response.Write "<a class=""btn btn-block btn-social btn-facebook"" href=""http://www.sbstasarim.com/sayfa/uyelik/oauth_fb.asp?hedef=" & Request.ServerVariables("HTTP_HOST") & """><i class=""fa fa-facebook""></i> | Facebook İle Giriş Yap</a>"
'		Response.Write "</div>"
		Response.Write "</form>"
		Response.Write "</div>"
		Response.Write "<div class=""clearfix""></div>"
	else
		skad = Request.Cookies("skad")
		Response.Write "<div class=""row border-ccc border-r10 pt10 pb10"">"
		Response.Write "<form class=""ajaxform"" method=""post"" action=""/sayfa/uyelik/login_ozel.asp"">"
		Response.Write "<input type=""hidden"" name=""urlid"" value=""" & Session("urlid") & """ />"
		Response.Write "<input type=""hidden"" name=""dbadilla"" value=""" & dbadenc & """ />"
		'ek alanlar
			fn1.open "Select * from url_menusiralama where aktif = 'True' and ustid = 0 and uyelik = 'True' and urlid = " & Session("urlid") & " order by sira asc",sbsv5,1,3
			if fn1.recordcount > 0 then
				for fi = 1 to fn1.recordcount
					Response.Write "<div class=""col-lg-12"">"
					Response.Write "<a"
					if isnull(fn1("link")) = True or fn1("link") = "" then
					else
						Response.Write " href="""
						Response.Write fn1("link")
						Response.Write """"
						if left(fn1("link"),1) = True then
							Response.Write " target=""_blank"""
						end if
					end if
					if isnull(fn1("kod")) = True or fn1("kod") = "" then
					else
						Response.Write " onClick="""
						Response.Write fn1("kod")
						Response.Write """"
					end if
					Response.Write ">"
					ad = fn1("ad")
					ad = kidbilgi(ad)
					Response.Write ad
					Response.Write "</a>"
	
					fn2.open "Select * from url_menusiralama where ustid = " & fn1("id") & " order by sira asc",sbsv5,1,3
					if fn2.recordcount > 0 then
						Response.Write "<ul class=""col-lg-12"">"
						for fii = 1 to fn2.recordcount
							if uye = True then
								if fn2("uyelik") = True then
									Response.Write "<li>"
									ad = fn2("ad")
									ad = kidbilgi(ad)
									Response.Write ad
									Response.Write "</li>"
								end if
							else
								if fn2("uyelik") = False then
									Response.Write "<li>"
									Response.Write "<a"
									if isnull(fn2("link")) = True or fn2("link") = "" then
									else
										Response.Write " href="""
										Response.Write fn2("link")
										Response.Write """"
										if left(fn2("link"),1) = True then
											Response.Write " target=""_blank"""
										end if
									end if
									if isnull(fn2("kod")) = True or fn2("kod") = "" then
									else
										Response.Write " onClick="""
										Response.Write fn2("kod")
										Response.Write """"
									end if
									Response.Write ">"
									Response.Write fn2("ad")
									Response.Write "</a>"
									Response.Write "</li>"
								end if
							end if
						fn2.movenext
						next
						Response.Write "</ul>"
					end if
					fn2.close
	
					Response.Write "</div>"
				fn1.movenext
				next
			end if
			fn1.close
		'ek alanlar
		Response.Write "</form>"
		Response.Write "</div>"
		Response.Write "<div class=""clearfix""></div>"
	end if
end function

function formatpara(byVal tutar, byVal kur)
	if intKurushane = "" then
		intKurushane = 2
	end if
	if tutar = "" or isnull(tutar) = True or kur = "" then
		formatpara = ""
	else
		kur = int(kur)
		tutar = formatnumber(tutar,intKurushane)
		if kur = 1 then
			formatpara = tutar & " TL"
		end if
		if kur = 2 then
			formatpara = tutar & " $"
		end if
		if kur = 3 then
			formatpara = tutar & " €"
		end if
	end if
end function

function tarihkontrol(byVal tarih,byVal uyari)
	'1.1.2015
	hata = 0
	if tarih = "" or isnull(tarih) = True then
		hata = 1
	end if

	if hata = 0 then
		dtdt = tarih
		dtdt = Replace(dtdt,".","")
		if isnumeric(dtdt) = True then
		else
			hata = 1
		end if
	end if

	if hata = 0 then
		if len(tarih) > 7 and len(tarih) < 11 then
		else
			hata = 1
		end if
	end if

	if hata = 0 then
		dogumyili = right(tarih,4)
		if isnumeric(dogumyili) = True then
			dogumyili = int(dogumyili)
			if dogumyili < 1915 then
				hata = 1
			end if
		else
			hata = 1
		end if
	end if

	if hata = 0 then
		if instr(tarih,".") > 0 then
		else
			hata = 1
		end if
	end if

	if hata = 0 then
		tarr = Split(tarih,".")
		if ubound(tarr) = 2 then
			tarr(0) = int(tarr(0))
			tarr(1) = int(tarr(1))
			tarr(2) = int(tarr(2))
			if isnumeric(tarr(0)) = false then
				hata = 1
			end if
			if isnumeric(tarr(1)) = false then
				hata = 1
			end if
			if isnumeric(tarr(2)) = false then
				hata = 1
			end if
			if hata = 0 then
				if tarr(0) > 31 then
					hata = 1
				end if
				if tarr(1) > 12 then
					hata = 1
				end if
			end if
		else
			hata = 1
		end if
		set tarr = Nothing
	end if
	if hata = 0 then
		tarihkontrol = cdate(tarih)
	else
		if uyari <> "" then
			call bootmodal(uyari,"custom","","","","Tamam","","btn-danger","","","","","")
		end if
		Response.End()
	end if
end function

function verikontrol(byVal veri,byVal uyari,byVal enaz,byVal ek1)
	hata = 0
	if veri = "" then
		hata = 1
	end if

	if hata = 0 then
		if enaz = "" then
			enaz = 1
		else
			enaz = int(enaz)
		end if
	end if

	if hata = 0 then
		if len(veri) < enaz then
			hata = 1
		end if
	end if

	if hata = 0 then
		veritemp = veri
		veritemp = lcase(veritemp)
		veriar = "aaa|bbb|ccc|ddd|eee|fff|azq|zzz|qqq|qwe|wer|ttt|yyy|uuu|123456|asd|zxc|sdf|dfg|fgh"
		veriar = Split(veriar,"|")
		for vi = 0 to ubound(veriar)
			if instr(veritemp,veriar(vi)) > 0 then
				hata = 1
			end if
		next
		set veriar = Nothing
	end if

	if hata = 0 then
		verikontrol = veri
	else
		if uyari <> "" then
			call bootmodal(uyari,"custom","","","","Tamam","","btn-danger","","","","","")
		end if
		Response.End()
	end if
end function


function logla(byVal islem)
'//FIXME - islem kısmında tek tırnak gelince patlıyor
	FNtarih			=	tarihsaatsql(now())
	FNpersonelID	=	kid
	FNip			=	Request.ServerVariables("REMOTE_ADDR")
	if gorevID = "" or isnumeric(gorevID) = False then
		FNgorevID		=	0
	else
		FNgorevID		=	gorevID
	end if
	FNislem			=	islem
	if FNpersonelID = "" then
		FNpersonelID = 0
	end if
	if modulAd = "" then
		modulAd = ""			'burayı ileride doldururum
	end if
	veri			=	"'" & FNtarih & "','" & FNpersonelID & "','" & FNip & "','" & FNgorevID & "','" & FNislem & "','" & firmaID & "','','" & modulAd & "'"
	sorgu		=	"INSERT INTO personel.personel_log VALUES (" & veri & ")"
	fn1.open sorgu, sbsv5, 3, 3
end function

Function tarihsaatsql(tarih)'2011-11-21 00:00:00
	tarihsaatsql = year(tarih) & "-" & month(tarih) & "-" & day(tarih) & " " & hour(tarih) & ":" & minute(tarih) & ":" & second(tarih)
End Function


Function jsrundelay(byVal adres,byVal saniye)
	call jsrun("setTimeout(function(){" & adres & "}, " & saniye & "000 );")
End Function

Function jsac(byVal adres)
	Response.Write "<scr" & "ipt type=""text/javascript"">"
		Response.Write "$().ready(function(){$('#ortaalan').load('" & adres & "');});"
	Response.Write "</scr" & "ipt>"
End Function

Function focusinput(byVal inputAd)
	call jsrun("$('#" & inputAd & "').focus();")
        call jsrun("$('#" & inputAd & "').addClass('border-danger');")
		call jsrun("setTimeout(function(){$('#" & inputAd & "').removeClass('border-danger');}, 1500 );")
		sanipi = 1500
		for iipi = 1 to 5
			sanipi = sanipi + 150
			call jsrun("setTimeout(function(){$('#" & inputAd & "').addClass('border-danger');}, " & sanipi & ");")
			sanipi = sanipi + 150
			call jsrun("setTimeout(function(){$('#" & inputAd & "').removeClass('border-danger');}, " & sanipi & ");")
		next
		for iipi = 1 to 30
			sanipi = sanipi + 50
			call jsrun("setTimeout(function(){$('#" & inputAd & "').addClass('border-danger');}, " & sanipi & ");")
			sanipi = sanipi + 50
			call jsrun("setTimeout(function(){$('#" & inputAd & "').removeClass('border-danger');}, " & sanipi & ");")
		next
end function

Function jsacdelay(byVal adres,byVal saniye)
	Response.Write "<scr" & "ipt type=""text/javascript"">"
		Response.Write "$().ready(function(){"
			Response.Write "setTimeout(function(){"
				Response.Write "$('#ortaalan').load('" & adres & "');"
			Response.Write "}, " & saniye & " );"
		Response.Write "});"
	Response.Write "</scr" & "ipt>"
End Function

Function jsacmodal(byVal adres)
	Response.Write "<scr" & "ipt type=""text/javascript"">"
		Response.Write "$().ready(function(){$('#modalform').load('" & adres & "');});"
	Response.Write "</scr" & "ipt>"
End Function


function pencerekapat()
	Response.Write "<script type=""text/javascript"">"
	Response.Write "$(document).ready(function(){"
	Response.Write "window.close();"'firefox
	Response.Write "location.href = 'http://closekiosk';"'chrome
	Response.Write "})"
	Response.Write "</script>"
end function


'formtextarea("aciklama",aciklama,"","Cihaz ile ilgili ayrıntılar","mt10","","","")
function formtextarea(byVal formad,byVal formdeger, byVal formonclick, byVal formplaceholder, byVal formcss, byVal ozel, byVal nesneID, byVal ek3)
	Response.Write "<div class=""clearfix""></div>"
	Response.Write "<div>"
	Response.Write "<textarea class=""form-control "
	Response.Write formcss
	Response.Write """ placeholder="""
	Response.Write formplaceholder
	Response.Write """ name="""
	Response.Write formad
	Response.Write """"
	if ozel = "readonly" then
		Response.Write " readonly"
	end if
	if nesneID <> "" then
		Response.Write " id="""
		Response.Write nesneID
		Response.Write """"
	end if
	if formonclick <> "" then
		Response.Write " onClick="""
		Response.Write formonclick
		Response.Write """"
		Response.Write " onKeyUp="""
		Response.Write formonclick
		Response.Write """"
	end if
	Response.Write ">"
	Response.Write formdeger
	Response.Write "</textarea>"
	Response.Write "</div>"
end function

'forminput("aciklama",aciklama,"","Cihaz ile ilgili ayrıntılar","mt10","","","")
function forminput(byVal formad,byVal formdeger, byVal formonclick, byVal formplaceholder, byVal formcss, byVal ozel, byVal nesneID, byVal ek3)
	Response.Write "<div class=""clearfix""></div>"
	Response.Write "<div>"
	Response.Write "<input class=""form-control "
	Response.Write formcss
	Response.Write """ placeholder="""
	Response.Write formplaceholder
	Response.Write """ name="""
	Response.Write formad
	Response.Write """"
	if nesneID <> "" then
		Response.Write " id="""
		Response.Write nesneID
		Response.Write """"
	end if
	if ozel = "password" then
		Response.Write " type=""password"""
	elseif ozel = "hidden" then
		Response.Write " type=""hidden"""
	else
		Response.Write " type=""text"""
	end if
	Response.Write " value="""
	Response.Write formdeger
	Response.Write """"
	if formonclick <> "" then
		Response.Write " onClick="""
		Response.Write formonclick
		Response.Write """"
		Response.Write " onChange="""
		Response.Write formonclick
		Response.Write """"
		Response.Write " onInput="""
		Response.Write formonclick
		Response.Write """"
	end if
	if ek3 <> "" then
		Response.Write " " & ek3 & " "
	end if
	if ozel = "readonly" then
		Response.Write " readonly"
	elseif ozel = "autocompleteOFF" then
		Response.Write " autocomplete=""off"""
	elseif left(ozel,4) = "data" then
		dataarr = Split(ozel,"=")
		Response.Write " " & dataarr(0)
		Response.Write "="""
		Response.Write dataarr(1)
		Response.Write """"
	end if
	Response.Write " />"
	Response.Write "</div>"
end function


function formhidden(byVal formad,byVal formdeger, byVal formonclick, byVal formplaceholder, byVal formcss, byVal ek1, byVal nesneID, byVal ek3)
	Response.Write "<input name="""
	Response.Write formad
	Response.Write """"
	if nesneID <> "" then
		Response.Write " id="""
		Response.Write nesneID
		Response.Write """"
	end if
	if formcss <> "" then
		Response.Write " class="""
		Response.Write formcss
		Response.Write """"
	end if
	Response.Write " type=""hidden"" value="""
	Response.Write formdeger
	Response.Write """ />"
end function

function formselectv2(byVal formad,byVal formdeger, byVal formonclick, byVal formplaceholder, byVal formcss, byVal ozel, byVal nesneID, byVal degerler, byVal ek3)
	if isnumeric(formdeger) = True then
		formdeger = int(formdeger)
	end if
	Response.Write "<div class=""clearfix""></div>"
	Response.Write "<div>"
	Response.Write "<select class=""form-control "
	Response.Write formcss
	Response.Write """ placeholder="""
	Response.Write formplaceholder
	Response.Write """ name="""
	Response.Write formad
	Response.Write """"
	if nesneID <> "" then
		Response.Write " id="""
		Response.Write nesneID
		Response.Write """"
	end if
	if formonclick <> "" then
		Response.Write " onChange="""
		Response.Write formonclick
		Response.Write """"
	end if
	if ozel = "readonly" then
		Response.Write " readonly"
	end if
	if ek3 <> "" then
		Response.Write " " & ek3 & " "
	end if
	Response.Write ">"
		if instr(degerler,"=") > 0 then
			degerler = Split(degerler,"|")
			formverisayisi = ubound(degerler)+1
			redim fvname(formverisayisi)
			redim fvdata(formverisayisi)
			for fi = 1 to formverisayisi
				fv = Split(degerler(fi-1),"=")
					fvname(fi-1) = fv(0)
					fvdata(fi-1) = fv(1)
				set fv = Nothing
			next
			set degerler = Nothing
			for fi = 1 to formverisayisi
				Response.Write "<option value=""" & fvdata(fi-1) & """"
				if isnumeric(fvdata(fi-1)) = True then
					fvdata(fi-1) = int(fvdata(fi-1))
				end if
				if formdeger = fvdata(fi-1) then
					Response.Write " selected"
				end if
				Response.Write ">"
				Response.Write fvname(fi-1)
				Response.Write "</option>"
			next
		end if
	Response.Write "</select>"
	Response.Write "</div>"
end function

function clearfix()
	Response.Write "<div class=""clearfix""></div>"
end function


function tckimlikdogrula(byVal ad,byVal soyad,byVal dogumyili, byVal tcno)
	ad = ucase(ad)
	soyad = ucase(soyad)
	veri = ""
	veri = veri & "<?xml version=""1.0"" encoding=""utf-8""?><soap12:Envelope xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"" xmlns:soap12=""http://www.w3.org/2003/05/soap-envelope""><soap12:Body><TCKimlikNoDogrula xmlns=""http://tckimlik.nvi.gov.tr/WS"">"
	veri = veri & "<TCKimlikNo>" & tcno & "</TCKimlikNo>"
	veri = veri & "<Ad>" & ad & "</Ad>"
	veri = veri & "<Soyad>" & soyad & "</Soyad>"
	veri = veri & "<DogumYili>" & dogumyili & "</DogumYili>"
	veri = veri & "</TCKimlikNoDogrula></soap12:Body></soap12:Envelope>"
		strHostAddress	=	"https://tckimlik.nvi.gov.tr/Service/KPSPublic.asmx?WSDL"
		Set SrvHTTPS	=	Server.CreateObject("MSXML2.ServerXMLHTTP")
		SrvHTTPS.open "POST", strHostAddress, false
'		SrvHTTPS.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
		SrvHTTPS.setRequestHeader "Content-Type","text/xml; charset=utf-8"
		SrvHTTPS.send veri
		gelenveri = SrvHTTPS.responsetext
'		gelenveri = SrvHTTPS.responseXML.xml
'	tckimlikdogrula = gelenveri
		Set objDoc = CreateObject("Microsoft.XMLDOM")
		objDoc.async = False
		objDoc.LoadXml(gelenveri)
		Set ObjeListesi = objDoc.getElementsByTagName("TCKimlikNoDogrulaResult")
		for Each result In ObjeListesi
			tckimlikdogrula = result.childNodes(0).Text
		next
		set ObjeListesi = Nothing
		set objDoc = Nothing
end function







function klasorolustur(byVal adres)
	Set fso = CreateObject("Scripting.FileSystemObject")
		if fso.FolderExists(Server.Mappath(adres)) = True then
		else
			fso.CreateFolder(Server.Mappath(adres))
		end if
	Set fso = Nothing
end function


Function klasorkontrol(adres)
	if adres = "" then
	else
		set fs=Server.CreateObject("Scripting.FileSystemObject")
		if fs.FolderExists(Server.Mappath(adres)) = True then
			klasorkontrol = True
		else
			klasorkontrol = False
		end if
		set fs = Nothing
	end if
end function


Function truefalse(deger,cevap)
	if deger = True then
		if cevap = "varyok" then
			truefalse = translate("Var","","")
		end if
	else
		if cevap = "varyok" then
			truefalse = translate("Yok","","")
		end if
	end if
end function


function yetkibul(byVal alan)
	uyarimesaj = "<div class=""alert alert-danger"">Açmaya çalıştığınız sayfayı açmak için yeterli yetkiniz bulunmamaktadır.</div>"
	if kid = "" then
		kid = kidbul()
	end if
	if kid = "" then
		yetkibul = False
	else
		if alan = "" then
			if uyarimesajgoster = False then
			else
				Response.Write uyarimesaj
			end if
			yetkibul = False
		else
			alan = Replace(alan,"-","_")
			rssorgu = "Select yetkiParametre from personel.personel_yetki where kid = " & kid & " and yetkiAd = N'" & alan & "'"
			fn1.open rssorgu,sbsv5,1,3
			if fn1.recordcount = 0 then
				if uyarimesajgoster = False then
				else
					Response.Write uyarimesaj
				end if
				yetkibul = False
			else
				if fn1(0) > 0 then
					yetkibul = fn1(0)
				else
					if yetkisaf = "" then
						if uyarimesajgoster = False then
						else
							Response.Write uyarimesaj
						end if
					end if
					yetkibul = 0
				end if
			end if
			fn1.close
		end if
	end if
end function


function yetkisizGiris(byVal gelenmetin, byVal gelenbaslik,byVal ek3)
		if gelenmetin = "" then
			call logla("Yetkisiz Giriş")
		else
			call logla(gelenmetin)
		end if
		if gelenbaslik = "" then
			gelenbaslik = "Hata Oluştu"
		end if
		Response.Write "<div class=""container-fluid mt-5"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-3 col-md-3 col-sm-1 col-xs-1""></div>"
			Response.Write "<div class=""col-lg-6 col-md-6 col-sm-10 col-xs-10"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-primary"">" & gelenbaslik & "</div>"
				Response.Write "<div class=""card-body text-center"">"
				if gelenmetin = "" then
					Response.Write "Bu alana girmek için yetkiniz yeterli değil."
				else
					Response.Write gelenmetin
				end if
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-3 col-md-3 col-sm-1 col-xs-1""></div>"
		Response.Write "</div>"
		Response.Write "</div>"
end function


function translate(byVal kelime, byVal kelime2, byVal kelime3)
	if kelime <> "" then
		for li = 0 to ubound(languageSozluk)
			languageKelime = Split(languageSozluk(li),"=")
			if languageKelime(0) = kelime then
				translate = languageKelime(1)
				if kelime2 <> "" then
					translate = Replace(translate,"{%1}",kelime2)
				end if
				if kelime3 <> "" then
					translate = Replace(translate,"{%2}",kelime3)
				end if
				exit for
			end if
		next
	end if
	'### YENİ EKLE
	if translate = "" then
		rssorgu = "Select top 1 * from portal.dil where dil = '" & klang & "' and anahtar = N'" & kelime & "'"
		fn1.open rssorgu,sbsv5,1,3
		if fn1.recordcount = 0 then
			fn1.addnew
			fn1("anahtar")	=	kelime
			fn1("kelime")	=	kelime
			fn1("dil")		=	klang
			fn1.update
		end if
		fn1.close
	end if
	'### YENİ EKLE
end function



function arrPersonelBul(byVal dbpersonelID,arrayDegeri)
	if dbpersonelID = 0 or isnull(dbpersonelID) = True then
		arrPersonelBul = "-"
	else
	personelDegerlerArr = arrayDegeri
	dbpersonelID		=	int(dbpersonelID)
		for pi = 0 to ubound(personelDegerlerArr)
			personelDegerlerColumnArr = Split(personelDegerlerArr(pi),"=")
			if int(personelDegerlerColumnArr(1)) = dbpersonelID then
				arrPersonelBul = personelDegerlerColumnArr(0)
				exit for
			end if
		next
	end if
end function


function netsishareketturu(byVal kod)
	select case kod
		case "A"	netsishareketturu	=	"Devir"
		case "B"	netsishareketturu	=	"Fatura"
		case "C"	netsishareketturu	=	"İade Fatura"
		case "D"	netsishareketturu	=	"Kasa"
		case "E"	netsishareketturu	=	"Müşteri Senedi"
		case "F"	netsishareketturu	=	"Borç Senedi"
		case "G"	netsishareketturu	=	"Müşteri Çeki"
		case "H"	netsishareketturu	=	"Borç Çeki"
		case "I"	netsishareketturu	=	"Protestolu Senet"
		case "J"	netsishareketturu	=	"Karşılıksız Çek"
		case "K"	netsishareketturu	=	"Dekont"
		case "L"	netsishareketturu	=	"Muhtelif"
		case else	netsishareketturu	=	"-"
	end select
end function


function rqKontrol(byVal rqalan, byVal rqmetin, Byval rqislem)
	'kullanım: rqKontrol(cariID,"Lütfen Cari Seçin","")

	if rqalan = "" or isnull(rqalan) = True then
		hatamesaj = rqmetin
		call logla(hatamesaj)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
end function

function str2int(rakam)
	if rakam = "" then
		rakam = 0
	else
		rakam = rakam & "x"
		rakam = Replace(rakam,"x","")
		rakam = int(rakam)
	end if
	str2int = rakam
end function

function kdvhesapla(toplam,oran)
	toplam		=	str2fiyat(toplam)
	oran		=	int(oran)
	kdvhesapla	=	toplam * oran / 100
end function

function str2fiyat(byVal strtutar)'netsisfiyatdüzelt
	'netsisdeki ne idüğü belirsiz para formatını money e çevirir.
	if strtutar <> "" then
		strtutar	=	strtutar & "x"
		strtutar	=	replace(strtutar,"x","")
		strtutar	=	formatnumber(strtutar,5)
		str2fiyat	=	strtutar
	else
		str2fiyat = 0
	end if
end function


function netsisb2bsipnouret()
	sorgu = "Select top(1) FATIRS_NO from TBLSIPAMAS WHERE FATIRS_NO like 'B2B%' order by FATIRS_NO DESC"
	fn1.open sorgu, ssov5, 1, 3
		if fn1.recordcount = 0 then
			netsisb2bsipnouret = "1"
			netsisb2bsipnouret = "00000000000000000000" & netsisb2bsipnouret
			netsisb2bsipnouret = right(netsisb2bsipnouret,12)
			netsisb2bsipnouret = "B2B" & netsisb2bsipnouret
		else
			netsisb2bsipnouret = fn1(0)
			netsisb2bsipnouret = right(netsisb2bsipnouret,12)
			netsisb2bsipnouret = int(netsisb2bsipnouret)
			netsisb2bsipnouret = netsisb2bsipnouret + 1
			netsisb2bsipnouret = "00000000000000000000" & netsisb2bsipnouret
			netsisb2bsipnouret = right(netsisb2bsipnouret,12)
			netsisb2bsipnouret = "B2B" & netsisb2bsipnouret
		end if
	fn1.close
end function


'###### checkbox işaretlenecek mi? kontrol fonksiyonu
	function chckKontrol(byVal degisken, byVal kontDeger)
		'degisken: kontrol edilecek değişken gelir "kontDeger" ile aynı ise checked yolla
		'kontDeger:	degisken ile aynı olup olmadığı kontrol edilecek olan değer "1", "True", "False" gibi olabilir.
		
			if degisken	=	kontDeger then
				chckDurum	=	" checked "
			else
				chckDurum	=	""
			end if
		chckKontrol	=	chckDurum

	end function
'###### /checkbox işaretlenecek mi? kontrol fonksiyonu



 Function toastrCagir(byVal mesaj, byVal mesajBaslik, byVal konum, byVal renk, byVal tip, byVal tiklamaIslem)
 
	'mesaj			: toastr tarafından görüntülenecek mesaj
	'mesajBaslik	: toastr tarafından görüntülenecek mesaj başlığı
	'konum			: "right" veya "center" değeri gelsin alt orta veya alt sağ da görüntülensin.
	'renk			: "warning", "info", "success", "error" değerlerinden biri gelsin.
	'tip			: "manuel" "otomatik" değerlerinden biri gelsin kapatma düğmesine tıklanarak mı kapansın? kendi kendine mi yok olsun?
	'tiklamaIslem	: toastr tıklandığında yapılacak işlem, fonksiyonun tamamı olabilir.
	
	 call jquerykontrol()
	 Response.Write "<scr" & "ipt type=""text/javascript"">"
	 Response.Write "$().ready(function(){"

							Response.Write "toastr.options.positionClass = 'toast-bottom-"&konum&"';"
						if tip = "manuel" then
							Response.Write "toastr.options.closeButton = true;"
							Response.Write "toastr.options.timeOut = 0;"
							Response.Write "toastr.options.extendedTimeOut = 0;"
						else
							Response.Write "toastr.options.progressBar = true;"
						end if
						'if tiklamaIslem <> "" then
							Response.Write "toastr.options.onclick = function() { " & tiklamaIslem & " };"
						'end if
							Response.Write "toastr." & renk & "('" & mesaj & "','" & mesajBaslik & "');"
	 Response.Write "});"
	 Response.Write "</scr" & "ipt>"
 End Function
 
 
 
'################### NETSİS'ten stok kalem detayları çek
	function netsisStokAd(byVal stokKod, byVal NETSISfirma)

		sorgu = "SELECT [" & NETSISfirma & "].dbo.TRK(t1.STOK_ADI) as STOK_ADI, t2.INGISIM as barkod"_
				&" FROM [" & NETSISfirma & "].[dbo].TBLSTSABIT as t1"_
				&" LEFT JOIN [" & NETSISfirma & "].[dbo].TBLSTSABITEK as t2 ON t1.STOK_KODU = t2.STOK_KODU"_
				&" WHERE t1.STOK_KODU = '" & stokKod & "'"
		fn1.open sorgu,sbsv5,1,3
		
			if fn1.recordcount > 0 then
				STOK_ADI 	=	fn1("STOK_ADI")
				barkod		=	fn1("barkod")
				netsisStokAd	=	Array(STOK_ADI, barkod)
			end if
		fn1.close
	end function
'################### /NETSİS'ten stok kalem detayları çek

 
 
 
 
 
 
 
 
 function dataTableYap(byVal dtad, byVal dtbasliklar, byVal dtjsonfile,byVal dtislemler, byVal dtsql, byVal ek1, byVal ek2, byVal ek3, byVal ek4, byVal ek5, byVal ek6, byVal ek7)
    'dtad = sayfada birden fazla datatable varsa diye ayrıştırıcı isim. Türkçe karakter ve numara olmaz
    'dtbasliklar = virgül ile ayrılmış başlıklar
    'dtjsonfile = json dosya yolu
    'dtislemler = işlemler alanı var - yok
    'dtsql = opsiyonel.  dosya içinde gösterilecek sorgu.
    Response.Write "<div class=""card"">"
    Response.Write "<div class=""card-body"">"
    Response.Write "<div class=""row"">"
    Response.Write "<div class=""col-12"">"
    Response.Write "<div class=""table-responsive"">"
        Response.Write "<table id=""" & dtad & """ class=""display"" cellspacing=""0"" width=""100%"">"
        Response.Write "<thead>"
        Response.Write "<tr>"
        dtbaslikarr = Split(dtbasliklar,",")
        for dth = 0 to ubound(dtbaslikarr)
            Response.Write "<th>" & dtbaslikarr(dth) & "</th>"
        next
        Response.Write "</thead>"
        Response.Write "</table>"
    Response.Write "</div>"
    Response.Write "</div>"
    Response.Write "</div>"
    Response.Write "</div>"
    Response.Write "</div>"

    Response.Write "<scr" & "ipt type=""text/javascript"">"
        Response.Write "$(document).ready(function() {"
            Response.Write "$('#" & dtad & "').dataTable( {"
                Response.Write "'lengthMenu': [[50, 100, 200, 500, 1000, -1], [50, 100, 200, 500, 1000, '" & translate("Hepsi","","") & "']]"
                Response.Write ",processing: true"
                Response.Write ",serverSide: true"
                Response.Write ",order: [[ 4, ""desc"" ]]"
                Response.Write ",ajax: '" & dtjsonfile & "'"
                Response.Write ",'language': {"
                Response.Write "'lengthMenu': '" & translate("Sayfa başına _MENU_ kayıt gösteriliyor","","") & "'"
                Response.Write ",'zeroRecords': '" & translate("Kayıt bulunamadı","","") & "'"
                Response.Write ",'info': '" & translate("_PAGE_ - _PAGES_ arası sayfalar gösteriliyor","","") & "'"
                Response.Write ",'infoEmpty': '" & translate("Kayıt bulunamadı","","") & "'"
                Response.Write ",'infoFiltered': '" & translate("(_MAX_ kayıt filtreleniyor)","","") & "'"
                Response.Write ",'emptyTable': '" & translate("Veri Bulunamadı","","") & "'"
                Response.Write ",'infoPostFix':''"
                Response.Write ",'thousands':  ','"
                Response.Write ",'loadingRecords': '" & translate("Yükleniyor","","") & "'"
                Response.Write ",'processing': '" & translate("İşleniyor","","") & "'"
                Response.Write ",'search': '" & translate("Ara :","","") & "'"
                Response.Write ",'paginate': {'first':'" & translate("İlk","","") & "','last':'" & translate("Son","","") & "','next':'" & translate("Sonraki","","") & "','previous':'" & translate("Önceki","","") & "'}"
                Response.Write "}"
            Response.Write "});"
        Response.Write "});"
    Response.Write "</scr" & "ipt>"



end function
 




function dosyaOlustur(byVal dosyaAd, byVal dosyaYolu, byVal dosyaIcerik, byVal ek1, byVal ek2, byVal ek3, byVal ek4, byVal ek5)
	Set objStream = server.CreateObject("ADODB.Stream")
	objStream.Open
	objStream.CharSet = "UTF-8"
    objStream.WriteText dosyaIcerik
	objStream.SaveToFile Server.Mappath(dosyaYolu & dosyaAd),2
	objStream.Close
	set objStream = Nothing
end function



Function mailgonder(byVal baslik, byVal icerik, byVal gonderen, byVal gonderenAd, byVal hedef, byVal ekDosya, byVal basariliMesaj, byVal hataMesaj, byVal ek1, byVal ek2, byVal ek3, byVal ek4, byVal ek5)
    if hedef <> "" then
        on error resume next
        set msg                 =   Server.CreateOBject("JMail.Message")
        msg.Charset             =   "UTF-8"
        msg.Logging             =   true
        msg.From                =   sb_mailsender
        msg.FromName            =   gonderenAd
        msg.MailServerUserName  =   sb_mailsender
        msg.MailServerPassword  =   sb_mailsenderPass
        msg.AddRecipient            hedef
        msg.Subject             =   baslik
        msg.Body                =   icerik
        if ekDosya = "" then
        else
            if left(ekDosya,1) = "/" then
                msg.AddAttachment ekDosya
            else
                msg.AddAttachment ekDosya
            end if
        end if
		msg.AddHeader "Originating-IP", Request.ServerVariables("REMOTE_ADDR")
        if not msg.Send(sb_mailserver) then
            dosyaAd     =   unique() & ".txt"
            dosyaYolu   =   "/temp/mailhata/"
            dosyaIcerik =   msg.log
            call dosyaOlustur(dosyaAd,dosyaYolu,dosyaIcerik,"","","","","")
            mesajicerik = hataMesaj
            call logla(mesajicerik)
            Response.Write mesajicerik & " : " & now() & "<br />"
            Response.Flush()
        else
            mesajicerik = basariliMesaj
            call logla(mesajicerik)
            Response.Write mesajicerik & " : " & now() & "<br />"
            Response.Flush()
        end if
        on error goto 0
    end if
End Function






function bildirim(byVal FNkid, byVal FNbaslik, byVal FNicerik, byVal FNonem, byVal FNgonderenKid,byVal grupID, byVal ek2, byVal ek3, byVal ek4, byVal ek5)
	fnhata = False
    ' call bildirim(gorevID,"",yetkiAd & " yetki değişikliği",1,kid,"","","","","")
	' call bildirim(kid,"Genel Bildirim","Depo Grup Bildirimi" & second(now()),1,0,"Depo","","","","")
	' CASE portal.notification.onem
	' 	WHEN 1 THEN 'Önemsiz'
	' 	WHEN 2 THEN 'Önemsiz'
	' 	WHEN 3 THEN 'Normal'
	' 	WHEN 4 THEN 'Normal'
	' 	WHEN 5 THEN 'Normal'
	' 	WHEN 6 THEN 'Normal'
	' 	WHEN 7 THEN 'Önemli'
	' 	WHEN 8 THEN 'Önemli'
	' 	WHEN 8 THEN 'Önemli'
	' 	WHEN 10 THEN 'Önemli'
	' 	ELSE 'Belirsiz'
	' END


	'###### grupID bulma
		if isnumeric(grupID) = True then
			personelGrupID = grupID
		else
			sorgu = "Select personelGrupID from personel.personelGrup where grupAd = N'" & grupID & "'"
			fn1.open sorgu, sbsv5, 1, 3
			if fn1.recordcount > 0 then
				personelGrupID = fn1("personelGrupID")
			else
				personelGrupID = 0
			end if
			fn1.close
		end if
	'###### grupID bulma

	'###### hata kontrol
	if kid = "" then
		fnhata = True
	end if
	if personelGrupID = "" then
		personelGrupID = 0
	end if



	if fnhata = False then
		if personelGrupID > 0 then
			sorgu = "Select personelID from personel.personelGrupIndex where personelGrupID = " & personelGrupID
			fn2.open sorgu, sbsv5, 1, 3
			if fn2.recordcount > 0 then
				for fi = 1 to fn2.recordcount
					FNkid = fn2("personelID")
					veri		=	FNkid & "," & firmaID & ",'" & FNbaslik & "','" & FNicerik & "'," & FNonem & "," & FNgonderenKid
					sorgu		=	"INSERT INTO portal.notification (kid,firmaID,baslik,icerik,onem,gonderenKid) VALUES (" & veri & ")"
					fn1.open sorgu, sbsv5, 3, 3
				fn2.movenext
				next
			end if
			fn2.close
		else
			veri			=	FNkid & "," & firmaID & ",'" & FNbaslik & "','" & FNicerik & "'," & FNonem & "," & FNgonderenKid
			sorgu		=	"INSERT INTO portal.notification (kid,firmaID,baslik,icerik,onem,gonderenKid) VALUES (" & veri & ")"
			fn1.open sorgu, sbsv5, 3, 3
		end if
	end if
end function







function netsisturkce(gelen,yon)'netsisturkce("","netsis")
	if yon = "" or yon = "netsis" then
		gelen = Replace(gelen,"İ","Ý")
		gelen = Replace(gelen,"Ş","Þ")
	else
		gelen = Replace(gelen,"Ý","İ")
		gelen = Replace(gelen,"Þ","Ş")
	end if
	netsisturkce = gelen
end function









function pageHeader()
	'##################################################
	'##################################################
	'##################################################
	'##################################################
		Response.Write "<!DOCTYPE html>"
		Response.Write "<html lang=""en"" ng-app=""app"">"
		Response.Write "<!--[if IE 8]><html class=""no-js lt-ie9""><![endif]-->"
		Response.Write "<!--[if IE 9]><html class=""no-js lt-ie10""><![endif]-->"
		Response.Write "<!--[if gt IE 8]><!--><html class=""no-js""><!--<![endif]-->"
		Response.Write "<head>"
		Response.Write "<meta charset=""utf-8"">"
		Response.Write "<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" />"
		Response.Write "<title>" & sb_firmaAd & " Panel</title>"
		Response.Write "<meta name=""robots"" content=""noindex"" />"
		Response.Write "<meta name=""author"" content=""" & sb_firmaAd & """ />"
		Response.Write "<link rel=""shortcut icon"" href=""/favicon.ico"" />"
		Response.Write "<meta name=""viewport"" content=""width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"">"
		Response.Write "<meta name=""apple-mobile-web-app-capable"" content=""yes"">"
		Response.Write "<link rel=""stylesheet"" href=""" & sb_cdnUrl & "/bootstrap/bootstrap.min.css"" />"
		Response.Write "<link rel=""stylesheet"" href=""/cimax/ots.css"" />"
		Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/core/modernizr-2.7.1-respond-1.4.2.min.js""></scr" & "ipt>"
		Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/core/jquery-2.1.1.min.js""></scr" & "ipt>"
		Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/bootstrap/bootstrap.min.js""></scr" & "ipt>"
		Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/core/jquery.form-3.4.min.js""></scr" & "ipt>"
		Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/bootbox/bootbox.min.js""></scr" & "ipt>"
		Response.Write "<scr" & "ipt type=""text/javascript"" src=""/cimax/ots.js""></scr" & "ipt>"
		Response.Write "<style type=""text/css"">"
		Response.Write "@import url('" & sb_cdnUrl & "/fonts/font-awesome-4.4.0/css/font-awesome.min.css');"
		Response.Write ".cezaeviEkranSimge {min-height:214px;}"
		Response.Write "body{touch-action: manipulation;}"
		Response.Write "table tr td,table tr {padding-top:0 !important;padding-bottom:0 !important}"
		Response.Write "</style>"
		Response.Write "<meta http-equiv=""refresh"" content=""360"">"
		Response.Write "</head>"
		Response.Write "<body>"
	'##################################################
	'##################################################
	'##################################################
	'##################################################
end function




function pageFooter()
	'##################################################
	'##################################################
	'##################################################
	'##################################################
		Response.Write "<div class=""modal fade"" id=""modal-dialog"" tabindex=""-1"" role=""dialog"" aria-labelledby=""modalbaslik"" aria-hidden=""true""><div class=""modal-dialog""><div class=""modal-content""><div class=""modal-body"">&nbsp;</div></div></div></div>"
		Response.Write "<div class=""modal fade"" id=""modal-dialogfit"" tabindex=""-1"" role=""dialog"" aria-labelledby=""modalbaslik"" aria-hidden=""true""><div class=""modal-dialog modal-lg""><div class=""modal-content""><div class=""modal-body"">&nbsp;</div></div></div></div>"
		Response.Write "<div id=""ajax"" class=""ajax hide""></div>"
		Response.Write "</body>"
		Response.Write "</html>"
	'##################################################
	'##################################################
	'##################################################
	'##################################################
end function


function lotOlusturFunc(depoID)

	if depoID <> "" then
		if isnumeric(depoID) = True then
			sorgu = "Select depoLotTemplate from stok.depo where id = " & depoID
			fn1.open sorgu,sbsv5,1,3
			if fn1.recordcount > 0 then
				depoLotTemplate = fn1("depoLotTemplate") & ""
			end if
			fn1.close
			'sorgu = "Select lot from stok.stokHareket WHERE stokHareketTuru = 'G' AND stokHareketTipi = 'U' AND depoID = " & depoID & " and tarih >= '" & tarihsql(bugun) & "' order by stokHareketID desc"
			sorgu = "SELECT t1.lot"
			sorgu = sorgu & " FROM stok.stokHareket t1"
			sorgu = sorgu & " LEFT JOIN stok.stokHareket t2 ON t2.stokHareketID = t1.refHareketID"
			sorgu = sorgu & " WHERE t1.stokHareketTuru = 'G'"
			'sorgu = sorgu & " AND (t1.stokHareketTipi = 'U' OR t2.stokHareketTipi = 'A' )"
			sorgu = sorgu & " AND t1.depoID = " & depoID & " AND t1.tarih >= '" & tarihsql(bugun) & "' ORDER BY t1.stokHareketID DESC"
			fn1.open sorgu,sbsv5,1,3
			if fn1.recordcount > 0 then
				sonlot = fn1("lot") & ""
			else
				sonlot = 0
			end if
			fn1.close
		end if
	end if

	if depoLotTemplate <> "" then
		sonlot1 = instr(depoLotTemplate,"[") +1
		sonlot2 = right(sonlot,(len(depoLotTemplate)-sonlot1))
		sonlot2 = int(sonlot2)
		yenilot = sonlot2+1
		yenilotformat = depoLotTemplate
		yenilotformat = replace(yenilotformat,"YYYY",yil)
		yenilotformat = replace(yenilotformat,"YY",right(yil,2))
		yenilotformat = replace(yenilotformat,"MM",right("0" & ay,2))
		yenilotformat = replace(yenilotformat,"DD",right("0" & gun,2))
		yenilotformat = Replace(yenilotformat,"[XXXX]",right("0000" & yenilot,4))
		yenilotformat = Replace(yenilotformat,"[XXX]",right("000" & yenilot,3))
		yenilotformat = Replace(yenilotformat,"[XX]",right("00" & yenilot,2))
		yenilotformat = Replace(yenilotformat,"[X]",right("0" & yenilot,1))
	else
		yenilotformat	=	0
	end if

		lotOlusturFunc	=	yenilotformat
		'lotOlusturFunc	=	sorgu
end function









%>
