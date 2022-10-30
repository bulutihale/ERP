<!--#include virtual="/reg/rs.asp" -->
<!--#include virtual="/uts/uts_fonksiyonlar.asp" -->
<%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    hata    =   ""
    modulAd =   "satis"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



yetkiKontrol = yetkibul(modulAd)

	bildirimT			=	Request.Form("bildirim")
	vergiNo				=	Request.Form("vergiNo")
	vergiNo				=	cstr(vergiNo)
	
	
	utsToken			=	"Systemab7c969f-e0d1-4631-b6f0-77fbae727bf6"'token başka firmaya ait test amaçlı!!!!!!!!!!!!!!!!!!
	

	
'############################ vergi numarası ile ÜTS kurum numaralarını sorgula
'############################ vergi numarası ile ÜTS kurum numaralarını sorgula
	if bildirimT = "vergiNoSorgula" then
	call logla("ÜTS kurum sorgula vkn:"&vergiNo&"")
		vergiNoSorgulaSonuc = vergiNoSorgula(vergiNo, utsToken)
		response.write vergiNoSorgulaSonuc
	end if
'############################ vergi numarası ile ÜTS kurum numaralarını sorgula
'############################ vergi numarası ile ÜTS kurum numaralarını sorgula
	
	
	
	
	
%>
