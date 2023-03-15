<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()


'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr 				= 	Split(kidarr,"#")
		musteriID			=	kidarr(0)
		mtimeout			=	kidarr(1)
		kad					=	kidarr(2)
		sayfaKayitSayisi	=	int(kidarr(3))
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr



	'## veritabanı
		sorgu = "SELECT * FROM ihale_urun WHERE musteriID = " & musteriID & " order by id DESC"
		rs.open sorgu, sbsv5,1,3
		
response.Write "<table border='1'><tr>"
		For each oField in rs.fields
			response.Write "<td>"
				response.Write oField.name
			response.Write "</td>"
		next
			response.Write "</tr>"
			
				do until rs.EOF
		Response.Write "<tr>"
		
		For Each oField in rs.Fields
			Response.Write "<td>" & rs(oField.Name) & "</td>"
		Next
		rs.MoveNext
		Response.Write "</tr>"
	loop
	response.Write "</table>"
		
		rs.close
		

%>