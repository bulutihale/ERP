<!--#include virtual="/reg/rs.asp" --><%
response.Charset="utf-8"
response.codepage=65001

			Response.Flush()
			kid						=	kidbul()
			
			pdfKaynakYol			=	Request.Form("pdfKaynakYol")	
			pdfKaynakDosya			=	Request.Form("pdfKaynakDosya")
			pdfKayitYol				=	Request.Form("pdfKayitYol")
			landscapeDeger			=	Request.Form("landscapeDeger")
			stokID64				=	Request.Form("stokID64")
			cariID64				=	Request.Form("cariID64")
			formKod					=	Request.Form("formKod")
			ayiriciTabloAd			=	Request.Form("ayiriciTabloAd")
			ayiriciTabloID			=	Request.Form("ayiriciTabloID")
			kaliteFormID			=	Request.Form("kaliteFormID")


			if landscapeDeger = "evet" then
				landscapeDeger = "true"
			elseif landscapeDeger = "hayir" then
				landscapeDeger = "false"
			end if


call sessiontest()

Set Pdf = Server.CreateObject("Persits.Pdf")
Pdf.RegKey = "IWezGNoajRMgX8JJTBDOGlVu1NjcFGyt6jgOGJnYvZFrWYz9sZiyaZiCVyKkGdIYHKM5RdVy850j"




' Create a new PDF document from a URL
Set Doc = Pdf.CreateDocument
Set Page = Doc.Pages.Add
Set Font = Doc.Fonts("Times-Roman")




serverName = Request.ServerVariables("SERVER_NAME") 
serverPort = Request.ServerVariables("SERVER_PORT")

asp_dosya	=	"http://"
asp_dosya	=	asp_dosya & serverName
asp_dosya	=	asp_dosya & ":"
asp_dosya	=	asp_dosya & serverPort
asp_dosya	=	asp_dosya & "/" & pdfKaynakYol & "/" & pdfKaynakDosya & ".asp"

if pdfKaynakDosya = "kalite_form_yap" then
	asp_dosya		=	asp_dosya & "?pdf=evet&stokID="&stokID64&"&cariID="&cariID64&"&formKod="&formKod&"&ayiriciTabloAd="&ayiriciTabloAd&"&ayiriciTabloID="&ayiriciTabloID&"&kaliteFormID="&kaliteFormID
	dosyaAd			=	ayiriciTabloAd & "_" & ayiriciTabloID & ".pdf"
	klasorAd		=	pdfKayitYol & "/" & formKod
	landscapeDeger	=	landscapeDeger
end if



'response.Write asp_dosya
'response.end


Doc.ImportFromUrl asp_dosya,"LeftMargin=10,RightMargin=10,TopMargin=10,BottomMargin=10,scale=1,landscape="&landscapeDeger&""




if klasorkontrol("/temp/dosya/" & firmaID) = True then
else
	call klasorolustur("/temp/dosya/" & firmaID)
end if

if klasorkontrol("/temp/dosya/" & firmaID & "/" & pdfKayitYol) = True then 
else
	call klasorolustur("/temp/dosya/" & firmaID & "/" & pdfKayitYol)
end if

if klasorkontrol("/temp/dosya/" & firmaID & "/" & pdfKayitYol & "/" & formKod) = True then
else
	call klasorolustur("/temp/dosya/" & firmaID & "/" & pdfKayitYol & "/" & formKod)
end if


	dosyakontrolSonuc	=	dosyakontrol("/temp/dosya/" & firmaID & "/" & pdfKayitYol & "/" & formKod & "/" & dosyaAd)


	if dosyakontrolSonuc = True then
		dosyasil("/temp/dosya/" & firmaID & "/" & pdfKayitYol & "/" & formKod & "/" & dosyaAd)
	end if




Doc.Save Server.MapPath("/temp/dosya/" & firmaID & "/" & pdfKayitYol & "/" & formKod & "/" & dosyaAd), true




%>




















