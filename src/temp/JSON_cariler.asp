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
	arananKelime		=	trim(trim(arananKelime))
'##### /ajax ile gelen sorgu 
'##### /ajax ile gelen sorgu 




	'##### CARİLERİ ÇEK select2 için JSON verisi oluştur
	'##### CARİLERİ ÇEK select2 için JSON verisi oluştur
            sorgu = "SELECT"
			sorgu = sorgu & " t1.cariID,"
			sorgu = sorgu & " t1.cariKodu,"
			sorgu = sorgu & " t1.cariAd, t1.il, t1.vergiNo" 
			sorgu = sorgu & " FROM cari.cari t1" 
			sorgu = sorgu & " WHERE (t1.cariAd like N'%" & arananKelime & "%' OR t1.vergiNo like N'" & arananKelime & "' OR t1.cariKodu like N'%" & arananKelime & "%')"
			sorgu = sorgu & " ORDER BY t1.cariAd ASC"
			rs.open sorgu, sbsv5, 1, 3
			
			if rs.recordcount > 0 then
				
					response.Write "{"
					response.Write """items"": "
					response.Write "["
				for i = 1 to rs.recordcount
					cariID			=	rs("cariID")
					cariAd			=	rs("cariAd")
					
		'####### chr13 ve chr10 temizle json patlamasın
					cariAd			=	rs("cariAd")
					kontrolString	= 	cariAd
			
				if instr(kontrolString,chr(10)) > 0 OR instr(kontrolString,chr(13)) then
					cariAd			=	jsonTemizle(cariAd)
					rs("cariAd")	=	cariAd
					rs.update
				end if
		'####### chr13 ve chr10 temizle json patlamasın
				
					Response.Write "{"
					Response.Write """id"":" & cariID & ","
					Response.Write """text"":""" & cariAd & """"
					if i < rs.recordcount then
						Response.Write "},"
					else
						Response.Write "}"
					end if	
				rs.movenext
				next
					Response.Write "]"
					Response.Write "}"
			else
				Response.Write "yok"
			end if
				rs.close

	'##### /CARİLERİ ÇEK select2 için JSON verisi oluştur
	'##### /CARİLERİ ÇEK select2 için JSON verisi oluştur




%>

