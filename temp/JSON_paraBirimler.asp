<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
	modulAd 	=   "stok"
'###### ANA TANIMLAMALAR

	'##### PARA BİRİMLERİ select2 için JSON verisi oluştur
		sorgu = "SELECT" & vbcrlf
		sorgu = sorgu & " t1.kisaBirim," & vbcrlf
		sorgu = sorgu & " t1.uzunBirim" & vbcrlf
		sorgu = sorgu & " FROM portal.birimler t1" & vbcrlf
		sorgu = sorgu & " WHERE t1.birimGrup = 'para'" & vbcrlf
		sorgu = sorgu & " and firmaID = " & firmaID & vbcrlf
		sorgu = sorgu & " ORDER BY t1.uzunBirim ASC" & vbcrlf
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
	'##### PARA BİRİMLERİ select2 için JSON verisi oluştur

%><!--#include virtual="/reg/rs.asp" -->