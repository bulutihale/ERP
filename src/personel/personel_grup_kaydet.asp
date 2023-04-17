<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()



	'##### request
	'##### request
		kid						=	kidbul()
		personelGrupID		=	Request.Form("personelGrupID")
		personelID			=	Request.Form("personelID")
		personelGrupIndexID	=	Request.Form("personelGrupIndexID")
	'##### request
	'##### request






	

'##### HÜCRE EDIT
'##### HÜCRE EDIT
	'## veritabanı
		sorgu = "SELECT * FROM personel.personelGrupIndex WHERE personelGrupIndexID = " & personelGrupIndexID
		rs.open sorgu, sbsv5,1,3
			if rs.recordcount = 0 then
				rs.addnew
				rs("personelGrupID")	=	personelGrupID
				rs("personelID")		=	personelID
			else
				if rs("silindi") = 1 then
					rs("silindi") = 0
				else
					rs("silindi") = 1
				end if
			end if								
			rs.update
		rs.close
	'## veritabanı

'##### HÜCRE EDIT
'##### HÜCRE EDIT 

			
			mesaj = "Kayıt Başarılı."
			call logla("Personel grup kaydı tamamlandı.")
		
			response.Write "ok|"&mesaj&""

%>



