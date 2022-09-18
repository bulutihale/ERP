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



	'#####  select2 için JSON verisi oluştur
	'#####  select2 için JSON verisi oluştur
	
            sorgu = "SELECT"
			sorgu = sorgu & " formID,"
			sorgu = sorgu & " formAd"
			sorgu = sorgu & " FROM kalite.form"
			sorgu = sorgu & " WHERE silindi = 0"
			sorgu = sorgu & " AND (formAd like N'%" & arananKelime & "%')"
			if sart <> "" then
				sorgu = sorgu & " AND formKod IN (" & sart & ")"
			end if
			sorgu = sorgu & " ORDER BY formAd ASC"
			rs.open sorgu, sbsv5, 1, 3
				
					response.Write "{"
					response.Write """items"": "
					response.Write "["
				for i = 1 to rs.recordcount
					Response.Write "{"
					Response.Write """id"":""" & rs("formID") & ""","
					Response.Write """text"":""" & rs("formAd") & """"

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

	'#####  /select2 için JSON verisi oluştur
	'#####  /select2 için JSON verisi oluştur




%>

