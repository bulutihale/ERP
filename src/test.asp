<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    ID			=	Request.QueryString("ID")
    kid64		=	ID
    opener  	=   Request.Form("opener")
    gorevID 	=   Request.QueryString("gorevID")
	a			=   Request.QueryString("a")
	stokID64	=	gorevID
	gorevID64	=	gorevID
	gorevID		=	base64_decode_tr(gorevID64)
	modulAd 	=   "stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR





 sorgu = "SELECT * FROM tblstsabit"
 rsS.open sorgu, rsCari, 1, 3
     Response.Write rsS("STOK_KODU")
 rsS.close


%>