<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Zimmet"
    Response.Flush()
    ' yardimYetki = yetkibul("Yardım")
'###### ANA TANIMLAMALAR







    call yetkisizGiris("","","")




%><!--#include virtual="/reg/rs.asp" -->