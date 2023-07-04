<!--#include virtual="/reg/rs.asp" --><%

Server.ScriptTimeout = 1200

dosyavar = False

	klasorYol64	=	Request("klasorYol")
	klasorYol	=	klasorYol64
	klasorYol	=	base64_decode_tr(klasorYol)


	Set Upload		=	Server.CreateObject("Persits.Upload")
	Upload.CodePage	=	65001
	Upload.SetMaxSize 30000000, True'30.000.000 byte = 30.000 kb = 30 mb
	Upload.OverwriteFiles = False
	Upload.Save
	Set yuklenenDosya = Upload.Files("file")

	if yuklenenDosya Is Nothing Then
		Response.Write "boş iş"
	end if

	If Not yuklenenDosya Is Nothing Then
		dosyavar = True
		dosyaadi = yuklenenDosya.filename
		dosyaadi = Replace(dosyaadi," ","-")
		dosyaadi = Replace(dosyaadi,"%","")	
		yuklenenDosya.SaveAs Server.MapPath(klasorYol & "/" & dosyaadi)
			
		call logla("dosya yüklendi. Yol: "& klasorYol & " Dosya: " & dosyaadi)

	End if

	set yuklenenDosya = Nothing
	set Upload = Nothing	



%>
