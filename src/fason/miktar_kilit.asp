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

	fasonAnaID				=	Request("fasonAnaID")
	isTur					=	"fason"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

Response.Flush()



			sorgu = ""
			sorgu = sorgu & "UPDATE portal.ajanda SET fasonMiktarKilit = 1"
			sorgu = sorgu & " WHERE silindi = 0"
			sorgu = sorgu & " AND bagliAjandaID = (SELECT id FROM portal.ajanda WHERE fasonAnaID = " & fasonAnaID & " AND silindi = 0)"
			rs.open sorgu, sbsv5, 3, 3


%><!--#include virtual="/reg/rs.asp" -->






