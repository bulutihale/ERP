﻿<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
	modulAd 	=   "stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	arananKelime		=	request.QueryString ("q")
	arananKelime		=	TRIM(arananKelime)
	arananKelime		=	replace(arananKelime,Chr(9),"")
'##### şart ile gelen sorgu 
'##### şart ile gelen sorgu 
	sart				=	request.QueryString ("sart")
	sartOzel			=	request.QueryString ("sartOzel")
'##### /şart ile gelen sorgu 
'##### /şart ile gelen sorgu 



	'##### BİRİMLERİ ÇEK select2 için JSON verisi oluştur
	'##### BİRİMLERİ ÇEK select2 için JSON verisi oluştur
	
            sorgu = "SELECT"
			sorgu = sorgu & " receteID,"
			sorgu = sorgu & " receteAd"
			sorgu = sorgu & " FROM recete.recete t1"
			sorgu = sorgu & " WHERE silindi = 0"
			sorgu = sorgu & " AND (receteAd like N'%" & arananKelime & "%')"
			if sart <> "" then
				sorgu = sorgu & " AND stokID = " & sart
			end if
			if sartOzel <> "" then
				sorgu = sorgu & " AND " & sartOzel
			end if
			sorgu = sorgu & " ORDER BY receteAd ASC"
			rs.open sorgu, sbsv5, 1, 3
				
					response.Write "{"
					response.Write """items"": "
					response.Write "["
				for i = 1 to rs.recordcount
					Response.Write "{"
					Response.Write """id"":""" & rs("receteID") & ""","
					Response.Write """text"":""" & rs("receteAd") & """"

					if i < rs.recordcount then
						Response.Write "},"
					else
						Response.Write "}"
					end if	
				rs.movenext
				next
					Response.Write "]"
					Response.Write "}"
				rs.close

	'##### BİRİMLERİ ÇEK select2 için JSON verisi oluştur
	'##### BİRİMLERİ ÇEK select2 için JSON verisi oluştur




%>

