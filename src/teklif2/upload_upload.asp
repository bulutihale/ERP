<!--#include virtual="/reg/rs.asp" --><%

Server.ScriptTimeout = 1200

dosyavar = False

'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr = Split(kidarr,"#") 
		musteriID	=	kidarr(0)
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr

ihaleID = Request.QueryString("id")


	Set Upload		=	Server.CreateObject("Persits.Upload")
	Upload.CodePage	=	65001
	Upload.SetMaxSize 30000000, True'30.000.000 byte = 30.000 kb = 30 mb
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
		yuklenenDosya.SaveAs Server.MapPath("/upload/" & ihaleID & "/" & dosyaadi)
	End if

	set yuklenenDosya = Nothing
	set Upload = Nothing



	if instr(dosyaadi,"idari_sartname") > 0 then
		call fnidarisartnamecozumle("/upload/" & ihaleID & "/" & dosyaadi,ihaleID)
	end if


function fnidarisartnamecozumle(dosyayolu,ihaleID)
	call dosyakopyala("/temp/ornek.xlsx","/temp/ornek2.xlsx")

	dosyadegisken = readBinary(dosyayolu)
	tablobasi = instr(dosyadegisken,"<table width=""100%"" cellpadding=""0"" cellspacing=""0"" border=""1"" class=""kisimlar"" >")
	tablosonu = instr(dosyadegisken,"</table>")
	tabloboyut	=	(tablosonu - tablobasi) + 8
	tabloicerik	=	mid(dosyadegisken,tablobasi,tabloboyut)

	tabloicerik	=	Replace(tabloicerik,"<table width=""100%"" cellpadding=""0"" cellspacing=""0"" border=""1"" class=""kisimlar"" >","")
	tabloicerik	=	Replace(tabloicerik,"</table>","")
	tabloicerik	=	Replace(tabloicerik,"<tr>","<urun>")
	tabloicerik	=	Replace(tabloicerik,"</tr>","</urun>")
	tabloicerik	=	Replace(tabloicerik,"<td>","###")
	tabloicerik	=	Replace(tabloicerik,"</td>","")
	tabloicerik	=	Replace(tabloicerik,"</b>","")
	tabloicerik	=	Replace(tabloicerik,"<b>","")
	tabloicerik	=	Replace(tabloicerik,"<td ","<deger ")
	tabloicerik	=	Replace(tabloicerik,"<deger colspan=""5"" align=""middle"">","###")


	tabloarr	=	Split(tabloicerik,"</urun> <urun>")

	f = "/temp/ornek2.xlsx"
	ExcelFile 	= Server.Mappath(f)
	Set ExcelConnection = Server.CreateObject("ADODB.Connection")
	ExcelConnection.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & ExcelFile & ";Extended Properties=""Excel 12.0 Xml;HDR=YES"";"
	Set rsx = Server.CreateObject("ADODB.Recordset")
	rsx.open "[Sheet1$]",ExcelConnection, 1, 3


	for ti = 1 to ubound(tabloarr) + 1
		d1 = ""
		d2 = ""
		d3 = ""
		d4 = ""
		d5 = ""
		sutundeger	=	tabloarr(ti-1)
		sutunarr	=	Split(sutundeger,"###")
		if ubound(sutunarr) > 0 then
			d1			=	sutunarr(1)
			d1			=	trim(d1)
		end if
		if ubound(sutunarr) > 1 then
			d2			=	sutunarr(2)
			d2			=	trim(d2)
		end if
		if ubound(sutunarr) > 2 then
			d3			=	sutunarr(5)
			d3			=	trim(d3)
		end if
		if ubound(sutunarr) > 3 then
			d4			=	sutunarr(3)
			d4			=	trim(d4)
		end if

		rsx.addnew


		if d1 <> "" then
			rsx(0).Value	=	d1
		end if
		if d2 <> "" then
			rsx(1).Value	=	d2
			rsx(2).Value	=	d3
			rsx(3).Value	=	d4
'			rsx(4).Value	=	d5
		end if

		rsx.update
		set sutunarr = Nothing

	next
	set tabloarr = Nothing
	rsx.close
	set rsx = Nothing

	ExcelConnection.Close


	dosyahedef = "/dosyalar/" & musteriID & "/urunlistesi/" & ihaleID & ".xlsx"
	call dosyakopyala("/temp/ornek2.xlsx",dosyahedef)

end function


%>
