<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    modulID =   "137"
    Response.Flush()
'###### ANA TANIMLAMALAR


gonderimID	=	Request.Form("gonderimID")
call mailGonderToplu(gonderimID)


call jsac("/toplumail/gonderim_liste.asp")


%><!--#include virtual="/reg/rs.asp" -->