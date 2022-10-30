<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()



	'##### request
	'##### request
		kid						=	kidbul()
		idAlan					=	Request.Form("idAlan")
		alan					=	Request.Form("alan")
		id						=	Request.Form("id")
		tablo					=	Request.Form("tablo")
		deger					=	Request.Form("deger")
	'##### request
	'##### request






	

'##### HÜCRE EDIT
'##### HÜCRE EDIT
	'## veritabanı
		sorgu = "SELECT * FROM " & tablo & " WHERE " & idAlan & " = " & id 
		rs.open sorgu, sbsv5,1,3
		
			
			if deger = "null" OR deger = "" then
				deger = null
			end if
			
				rs(alan)		=	deger
								
			rs.update
		rs.close
	'## veritabanı

'##### HÜCRE EDIT
'##### HÜCRE EDIT 



			
			mesaj = "Kayıt Başarılı."
			call logla("Hücre Kaydet işlemi başarılı (tablo:"&tablo&") (alan:"&alan&") (id:"&id&") (deger:"&deger&")")
		
			response.Write "ok|"&mesaj&""

%>



