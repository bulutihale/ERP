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


	'##### request
	'##### request
		kid						=	kidbul()
		alan					=	Request.Form("alan")
		id						=	Request.Form("id")
		tablo					=	Request.Form("tablo")
		deger					=	Request.Form("deger")
	'##### request
	'##### request






	

'##### HÜCRE EDIT
'##### HÜCRE EDIT
	'## veritabanı
		sorgu = "SELECT * FROM " & tablo & " WHERE id = " & id
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
			call logla("ajanda","update",mesaj,modulID)
		
			response.Write "ok|"&mesaj&""

%>



