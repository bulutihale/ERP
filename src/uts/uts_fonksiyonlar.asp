<%


'############ test - canlı seçimi
'############ /test - canlı seçimi

	'ortam	=	"test"
	ortam	=	"canli"	

if ortam = "test" then
	sunucuAdi	=	"utstest"
elseif ortam = "canli" then
	sunucuAdi	=	"utsuygulama"
end if
	
'############ /test - canlı seçimi
'############ /test - canlı seçimi

'###################### VERGİ NO İLE ÜTS NO SORGULA FONKSİYONU
'###################### VERGİ NO İLE ÜTS NO SORGULA FONKSİYONU

	function vergiNoSorgula(byVal vergiNo, byVal tokenFirma)
		
		UTSurl = "https://" & sunucuAdi & ".saglik.gov.tr/UTS/rest/kurum/firmaSorgula"
		Set objUTS = Server.createobject("MSXML2.serverXMLHTTP") 
		objUTS.open "POST", UTSurl, False 
		objUTS.setRequestHeader "Content-Type", "application/json; charset=UTF-8"
		objUTS.setRequestHeader "CharSet", "utf-8"
		objUTS.setRequestHeader "utsToken", tokenFirma
		
	sorgu = "{""VRG"" : """ & vergiNo & """}"

		objUTS.send sorgu
 
		hamSonuc		=	objUTS.responseText

response.write hamSonuc

	end function

'###################### /VERGİ NO İLE ÜTS NO SORGULA FONKSİYONU
'###################### /VERGİ NO İLE ÜTS NO SORGULA FONKSİYONU
	
	
	
	
	
%>
