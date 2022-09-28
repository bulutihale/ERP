<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
	' cariID			=	Request.Form("cariID")
	gorevID			=	Request.QueryString("gorevID")
    kid				=	kidbul()
    modulAd 		=   "Raporlar"
	yetkiKontrol    =	yetkibul(modulAd)
	yetkiRapor		=	0
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

raporAd		=	Request.Form("raporAd")
raporTuru	=	Request.Form("raporTuru")
raporSQL	=	Request.Form("raporSQL")



if raporSQL <> "" then
	rs.Open raporSQL, sbsv5, 1, 3
		Response.Write "x"
	rs.close
end if






%><!--#include virtual="/reg/rs.asp" -->