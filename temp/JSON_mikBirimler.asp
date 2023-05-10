<!--#include virtual="/reg/rs.asp" --><%

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
	sart			=	request.QueryString ("sart")
	sartOzel		=	request.QueryString ("sartOzel")
	idKullan		=	request.QueryString ("idKullan")
	anaBirimFiltre	=	request.QueryString ("anaBirimFiltre")
'##### /şart ile gelen sorgu 
'##### /şart ile gelen sorgu 



	'##### BİRİMLERİ ÇEK select2 için JSON verisi oluştur
	'##### BİRİMLERİ ÇEK select2 için JSON verisi oluştur
	
            sorgu = "SELECT"
			sorgu = sorgu & " t1.birimID, t1.kisaBirim, t1.uzunBirim"
			sorgu = sorgu & " FROM portal.birimler t1" 
			sorgu = sorgu & " WHERE t1.birimGrup = 'miktar'"
			sorgu = sorgu & " and firmaID = " & firmaID & vbcrlf
			sorgu = sorgu & " AND (t1.kisaBirim like N'%" & arananKelime & "%' OR t1.uzunBirim like N'%" & arananKelime & "%')"
			if sart <> "" then
				sorgu = sorgu & " AND t1.birimTur = '" & sart & "'"
			end if
			if sartOzel <> "" then
				sorgu = sorgu & " AND " & sartOzel
			end if
			if anaBirimFiltre <> "" then
				sorgu = sorgu & " AND t1.uzunBirim = '" & anaBirimFiltre & "'"
			end if
			sorgu = sorgu & " ORDER BY t1.uzunBirim ASC"
			rs.open sorgu, sbsv5, 1, 3
				
					response.Write "{"
					response.Write """items"": "
					response.Write "["
				for i = 1 to rs.recordcount
					Response.Write "{"
					if idKullan = "evet" then
						idDeger =  rs("birimID")
					else
						idDeger =  rs("kisaBirim")
					end if
					Response.Write """id"":""" & idDeger & ""","
					Response.Write """text"":""" & rs("kisaBirim") & " - " & translate(rs("uzunBirim"),"","") & """"

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

