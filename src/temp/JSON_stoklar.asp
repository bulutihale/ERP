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
'	arananKelime 		=	Replace(arananKelime,"Ş","þ")'NETSİS veritabanı Türkçe'ye dönüşmeden önce aramaya yapılığı ve dbo.TRK çalışmadığı için
'	arananKelime 		=	Replace(arananKelime,"İ","Ý")'NETSİS veritabanı Türkçe'ye dönüşmeden önce aramaya yapılığı ve dbo.TRK çalışmadığı için
'	arananKelime 		=	Replace(arananKelime,"Ğ","Ð")'NETSİS veritabanı Türkçe'ye dönüşmeden önce aramaya yapılığı ve dbo.TRK çalışmadığı için
	
'##### /ajax ile gelen sorgu 
'##### /ajax ile gelen sorgu 


	'##### /STOKLARI ÇEK select2 için JSON verisi oluştur
	'##### /STOKLARI ÇEK select2 için JSON verisi oluştur
	
            sorgu = "SELECT"
			sorgu = sorgu & " t1.stokID,"
			sorgu = sorgu & " t1.stokKodu,"
			sorgu = sorgu & " t1.stokAd, t1.stokBarcode" 
			sorgu = sorgu & " FROM stok.stok t1" 
			sorgu = sorgu & " WHERE (t1.stokAd like N'%" & arananKelime & "%' OR t1.stokBarcode like N'%" & arananKelime & "%' OR t1.stokKodu like N'%" & arananKelime & "%')"
			sorgu = sorgu & " ORDER BY t1.stokAd ASC"
			rs.open sorgu, sbsv5, 1, 3
			
'			stokAd = rs("stokBarcode")
'				for i = 1 to len(stokAd)
'			
'			response.write Asc(mid(stokAd,i,1)) & " <> "
'			response.write mid(stokAd,i,1) & "<br />"
'				next
'			
'				response.end
'				
				
					response.Write "{"
					response.Write """items"": "
					response.Write "["
				for i = 1 to rs.recordcount
				
		'####### chr13 ve chr10 temizle json patlamasın
					stokBarcode		=	rs("stokBarcode")
					stokAd			=	rs("stokAd")
					stokKodu		=	rs("stokKodu")
					kontrolString	= 	stokBarcode & stokAd & stokKodu
			
				if instr(kontrolString,chr(10)) > 0 OR instr(kontrolString,chr(13)) then
					stokBarcode			=	jsonTemizle(stokBarcode)
					stokAd				=	jsonTemizle(stokAd)
					stokKodu			=	jsonTemizle(stokKodu)
					rs("stokBarcode")	=	stokBarcode
					rs("stokAd")		=	stokAd
					rs("stokKodu")		=	stokKodu
					rs.update
				end if
		'####### /chr13 ve chr10 temizle json patlamasın
				
				
					Response.Write "{"
					Response.Write """id"":"&rs("stokID")&","
					Response.Write """text"":"""& stokKodu & " -- "& stokAd & " -- " & stokBarcode &""""
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

	'##### /STOKLARI ÇEK select2 için JSON verisi oluştur
	'##### /STOKLARI ÇEK select2 için JSON verisi oluştur




%>

