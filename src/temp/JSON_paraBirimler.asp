<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
	modulAd 	=   "stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR






	'##### PARA BİRİMLERİ select2 için JSON verisi oluştur
	'##### PARA BİRİMLERİ select2 için JSON verisi oluştur
	
	
            sorgu = "SELECT"
			sorgu = sorgu & " t1.kisaBirim,"
			sorgu = sorgu & " t1.uzunBirim"
			sorgu = sorgu & " FROM portal.birimler t1" 
			sorgu = sorgu & " WHERE t1.birimTur = 'para'"
			sorgu = sorgu & " ORDER BY t1.uzunBirim ASC"
			rs.open sorgu, sbsv5, 1, 3
				
					response.Write "{"
					response.Write """items"": "
					response.Write "["
				for i = 1 to rs.recordcount
					Response.Write "{"
					Response.Write """id"":""" & rs("kisaBirim") & ""","
					Response.Write """text"":""" & rs("uzunBirim") & """"

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
	
				
'					response.Write "{"
'					response.Write """items"": "
'					response.Write "["
'
'					Response.Write "{"
'					Response.Write """id"":""TL"","
'					Response.Write """text"":""TL"""
'					Response.Write "},"
'					Response.Write "{"
'					Response.Write """id"":""USD"","
'					Response.Write """text"":""USD"""
'					Response.Write "},"
'					Response.Write "{"
'					Response.Write """id"":""EUR"","
'					Response.Write """text"":""EUR"""
'					Response.Write "}"
'
'					Response.Write "]"
'					Response.Write "}"

	'##### PARA BİRİMLERİ select2 için JSON verisi oluştur
	'##### PARA BİRİMLERİ select2 için JSON verisi oluştur




%>

