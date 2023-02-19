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



	'##### DATA ÇEK select2 için JSON verisi oluştur
	'##### DATA ÇEK select2 için JSON verisi oluştur
	
            sorgu = "SELECT"
			sorgu = sorgu & " koliID,"
			sorgu = sorgu & " ad"
			sorgu = sorgu & " FROM stok.koli"
			sorgu = sorgu & " WHERE silindi = 0"
			sorgu = sorgu & " AND (ad like N'%" & arananKelime & "%')"
			if sart <> "" then
				sorgu = sorgu & " AND koliID = " & sart & ""
			end if
			sorgu = sorgu & " ORDER BY ad ASC"
			rs.open sorgu, sbsv5, 1, 3
				
					response.Write "{"
					response.Write """items"": "
					response.Write "["
				for i = 1 to rs.recordcount
					Response.Write "{"
					Response.Write """id"":""" & rs("koliID") & ""","
					Response.Write """text"":""" & rs("ad") & """"

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

	'##### DATA ÇEK select2 için JSON verisi oluştur
	'##### DATA ÇEK select2 için JSON verisi oluştur




%>

