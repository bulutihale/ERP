<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
	modulAd 	=   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


'##### ajax ile gelen sorgu 
'##### ajax ile gelen sorgu 
	arananKelime		=	request.QueryString ("q")
	sart				=	request.QueryString ("sart")
'##### /ajax ile gelen sorgu 
'##### /ajax ile gelen sorgu 




	'##### select2 için JSON verisi oluştur
	'##### select2 için JSON verisi oluştur
            sorgu = "SELECT"
			sorgu = sorgu & " t1.istasyonID, t1.istasyonAd"
			sorgu = sorgu & " FROM isletme.istasyon t1" 
			sorgu = sorgu & " WHERE (t1.istasyonAd like N'%" & arananKelime & "%')"
			sorgu = sorgu & " AND t1.silindi = 0"
			sorgu = sorgu & " ORDER BY t1.istasyonAd ASC"
			rs.open sorgu, sbsv5, 1, 3
				
					response.Write "{"
					response.Write """items"": "
					response.Write "["
				for i = 1 to rs.recordcount
					Response.Write "{"
					Response.Write """id"":"&rs("istasyonID")&","
					Response.Write """text"":""" & rs("istasyonAd") & """"
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

	'##### / select2 için JSON verisi oluştur
	'##### / select2 için JSON verisi oluştur




%>

