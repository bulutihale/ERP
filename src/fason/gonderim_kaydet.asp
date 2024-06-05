<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

    call sessiontest()
    kid		=	kidbul()

	modulAd 		=   "Fason" 

	'##### YETKİ BUL
	'##### YETKİ BUL
	yetkiKontrol	 = yetkibul(modulAd)
	'##### YETKİ BUL
	'##### YETKİ BUL

	belgeNo				=	Request("belgeNo")
	islem				=	Request("islem")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

Response.Flush()

	
	

			sorgu = ""
			sorgu = sorgu & "UPDATE fason.fasonDetay SET"
				if islem = "kaydet" then
					sorgu = sorgu & " gonderimZamani = getdate()"
				elseif islem = "iptal" AND yetkiKontrol = 9 then
					sorgu = sorgu & " gonderimZamani = null"
				end if
			sorgu = sorgu & " WHERE belgeNo = '" & belgeNo & "'"
			rs.open sorgu, sbsv5, 3, 3


%><!--#include virtual="/reg/rs.asp" -->






