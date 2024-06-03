<!--#include virtual="/reg/rs.asp" --><%
response.Charset="utf-8"
response.codepage=65001

			'Response.Flush()
			'kid						=	kidbul()
			belgeNo					=	Request("belgeNo")
			'call sessiontest()
		
		
	'########## PDF için footer bilgilerini oluştur
		sorgu = "SELECT f.Ad as adUzun, f.adres, f.telefon, f.faksNo as faks, f.iletisimEposta, f.ilce, f.sehir, f.vergiDairesi, f.vergiNo, f.webSite"_
			&" FROM portal.firma f"_
			&" WHERE f.id = " & firmaID
		rs.open sorgu,sbsv5,1,3
			firmaAd			=	rs("adUzun")
			vergiDairesi	=	rs("vergiDairesi")& " V.D."
			vergiNo			=	rs("vergiNo")
			telefon 		=	rs("telefon")
			faks			=	rs("faks")
			iletisimEposta	=	rs("iletisimEposta")
			adres			=	rs("adres")
			ilce			=	rs("ilce")
			sehir			=	rs("sehir")
			webSite			=	rs("webSite")&""
		rs.close
		
		footerBilgiA =	firmaAd
		footerBilgiB =	adres & " " & ilce & " / " & sehir & " - " & vergiDairesi & " - " & vergiNo & " TEL: " & telefon & " - FAKS: " & faks
		footerBilgiC =	firmaEposta & " - " & iletisimEposta & " - " & webSite
		'footerBilgiD =	webSite
	'########## PDF için footer bilgilerini oluştur
		



		if landscapeDeger = "evet" then
			landscapeDeger 	= 	True
			bottomValue		=	10
			rightValue		=	70
		else
			landscapeDeger = False
			bottomValue		=	70
			rightValue		=	10
		end if

Set Pdf = Server.CreateObject("Persits.Pdf")
Pdf.RegKey = "IWezGNoajRMgX8JJTBDOGlVu1NjcFGyt6jgOGJnYvZFrWYz9sZiyaZiCVyKkGdIYHKM5RdVy850j"




' Create a new PDF document from a URL, use Landscape mode,
Set Doc = Pdf.CreateDocument
Set Page = Doc.Pages.Add


serverName = Request.ServerVariables("SERVER_NAME") 
serverPort = Request.ServerVariables("SERVER_PORT")

asp_dosya	=	"http://"
asp_dosya	=	asp_dosya & serverName
asp_dosya	=	asp_dosya & ":"
asp_dosya	=	asp_dosya & serverPort
asp_dosya	=	asp_dosya & "/fason/giden_urun_belge.asp?belgeNo="
asp_dosya	=	asp_dosya & belgeNo &"&pdf=yes"

'Response.Write asp_dosya
'Response.end


Doc.ImportFromUrl asp_dosya,"LeftMargin=30, RightMargin=" & rightValue & ",TopMargin=10, BottomMargin=" & bottomValue & ",scale=1,landscape="&landscapeDeger&""

if klasorkontrol("/temp/dosya/" & firmaID) = True then
else
	call klasorolustur("/temp/dosya/" & firmaID)
end if

if klasorkontrol("/temp/dosya/" & firmaID & "/fason") = True then
else
	call klasorolustur("/temp/dosya/" & firmaID & "/fason")
end if


	


Doc.Save Server.MapPath("/temp/dosya/" & firmaID & "/fason/" & belgeNo &".pdf"), true
		




		
	Response.Write "<scr"&"ipt type=""text/javascript"">"
	Response.Write "window.open('/temp/dosya/" & firmaID & "/fason/" & belgeNo&".pdf','_blank');"
	Response.Write "</scr"&"ipt>"
		
		
		

%>



















