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

	sorgu = "SELECT t1.id FROM portal.ajanda t1 WHERE t1.bagliAjandaID = " & silinecekID & " AND t1.tamamlandi = 1"
	rs.open sorgu,sbsv5,1,3
		kayitKontrol	=	rs.recordcount
	rs.close

	if kayitKontrol = 0 then 
		sorgu = "SELECT silindi, DATEFROMPARTS(hangiYil, hangiAy, hangiGun) as planTarih FROM " & tablo & " WHERE id = " & silinecekID
		rs.open sorgu,sbsv5,1,3
			planTarih		=	rs("planTarih")
			rs("silindi")	=	1
			rs.update
		rs.close

		sorgu = "UPDATE " & tablo & " SET silindi = 1 WHERE bagliAjandaID = " & silinecekID
		rs.open sorgu,sbsv5,1,3
	
		'sorgu = "UPDATE stok.stokHareket SET silindi = 1 WHERE bagliAjandaID = " & silinecekID
		'rs.open sorgu,sbsv5,1,3

		Response.Write "ok|" & planTarih & ""

		call logla("Ajanda kaydı silindi ID:" & silinecekID)
	else
		call logla("Transfer edilmiş reçete bileşeni var ajanda kaydı silinmedi ID:" & silinecekID)
		Response.Write "silinmedi|Transfer edilmiş reçete bileşeni var ajanda kaydı silinmedi."
	end if


'##### /DOSYA SİL
'##### /DOSYA SİL

%>


