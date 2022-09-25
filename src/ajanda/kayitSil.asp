<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()




	'##### request
	'##### request
		kid					=	kidbul()
		silinecekID			=	Request.Form("silinecekID")
		tablo				=	Request.Form("tablo")
	'##### request
	'##### request
	


'##### DOSYA SİL
'##### DOSYA SİL

		sorgu = "SELECT silindi, DATEFROMPARTS(hangiYil, hangiAy, hangiGun) as planTarih FROM " & tablo & " WHERE id = " & silinecekID
		rs.open sorgu,sbsv5,1,3
			planTarih		=	rs("planTarih")
			rs("silindi")	=	1
			rs.update
		rs.close

		sorgu = "UPDATE " & tablo & " SET silindi = 1 WHERE bagliAjandaID = " & silinecekID
		rs.open sorgu,sbsv5,1,3
	


response.Write "ok|" & planTarih & ""

	hatamesaj = "Kayıt Silindi"
	call logla("Ajanda kaydı silindi ID:" & silinecekID)

'##### /DOSYA SİL
'##### /DOSYA SİL

%>


