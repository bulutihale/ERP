<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
	modulAd 	=   "stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	arananKelime		=	request.QueryString ("q")
'##### şart ile gelen sorgu 
'##### şart ile gelen sorgu 
	sart		=	request.QueryString ("sart")
'##### /şart ile gelen sorgu 
'##### /şart ile gelen sorgu 



	'##### BİRİMLERİ ÇEK select2 için JSON verisi oluştur
	'##### BİRİMLERİ ÇEK select2 için JSON verisi oluştur
	
            sorgu = "SELECT"
			sorgu = sorgu & " t1.kisaBirim,"
			sorgu = sorgu & " t1.uzunBirim"
			sorgu = sorgu & " FROM portal.birimler t1" 
			sorgu = sorgu & " WHERE t1.birimTur = 'miktar'"
			sorgu = sorgu & " AND (t1.kisaBirim like N'%" & arananKelime & "%' OR t1.uzunBirim like N'%" & arananKelime & "%')"
			if sart <> "" then
				sorgu = sorgu & " AND t1.birimTur = '" & sart & "'"
			end if
			sorgu = sorgu & " ORDER BY t1.uzunBirim ASC"
			rs.open sorgu, sbsv5, 1, 3
				
					response.Write "{"
					response.Write """items"": "
					response.Write "["
				for i = 1 to rs.recordcount
					Response.Write "{"
					Response.Write """id"":""" & rs("kisaBirim") & ""","
					Response.Write """text"":""" & rs("kisaBirim") & " - " & rs("uzunBirim") & """"

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

