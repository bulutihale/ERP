<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    kid64	=	ID
    depoID 			=   Request.Form("depoID")
	modulAd 		=   "Depo"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

Response.Flush() 

	yeniLotGetir	=	lotOlusturFunc(depoID)
	
	Response.Write yeniLotGetir


%><!--#include virtual="/reg/rs.asp" -->