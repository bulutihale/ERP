<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
	modulAd 	=   "stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


'##### ajax ile gelen sorgu 
'##### ajax ile gelen sorgu 
	arananKelime		=	request.QueryString ("q")
	arananKelime		=	TRIM(arananKelime)
	arananKelime		=	replace(arananKelime,Chr(9),"")
	sart				=	request.QueryString ("sart")
	sartOzel			=	request.QueryString ("sartOzel")
'##### /ajax ile gelen sorgu 
'##### /ajax ile gelen sorgu 




	'##### CARİLERİ ÇEK select2 için JSON verisi oluştur
	'##### CARİLERİ ÇEK select2 için JSON verisi oluştur
            sorgu = "SELECT"
			sorgu = sorgu & " t1.id as depoID, t1.depoKod, t1.depoAd"
			sorgu = sorgu & " FROM stok.depo t1" 
			sorgu = sorgu & " WHERE (t1.depoAd like N'%" & arananKelime & "%' OR t1.depoKod like N'%" & arananKelime & "%')"
			sorgu = sorgu & " AND t1.silindi = 0"
			if sart = "malKabulizin" then
				sorgu = sorgu & " AND t1.malKabulizin = 1"
			elseif sart = "redGirisizin" then
				sorgu = sorgu & " AND t1.redGirisizin = 1"
			elseif sart <> "" then
				sorgu = sorgu & " AND t1.depoKategori IN "&sart&""
			end if
			if sartOzel <> "" then
				sorgu = sorgu & " AND " & sartOzel
			end if
			sorgu = sorgu & " ORDER BY t1.depoKod ASC"
			rs.open sorgu, sbsv5, 1, 3
				
					response.Write "{"
					response.Write """items"": "
					response.Write "["
				for i = 1 to rs.recordcount
					Response.Write "{"
					Response.Write """id"":"&rs("depoID")&","
					Response.Write """text"":""" & rs("depoKod") & " - " & rs("depoAd") & """"
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

	'##### /CARİLERİ ÇEK select2 için JSON verisi oluştur
	'##### /CARİLERİ ÇEK select2 için JSON verisi oluştur




%>

