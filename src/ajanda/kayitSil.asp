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

	
	


response.Write "ok|" & planTarih & ""

	hatamesaj = "Kayıt Silindi"
	call logla("Ajanda kaydı silindi ID:" & silinecekID)

'##### /DOSYA SİL
'##### /DOSYA SİL

%>


