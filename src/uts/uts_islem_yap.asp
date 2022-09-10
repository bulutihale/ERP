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

	bildirim			=	Request.Form("bildirim")
	vergiNo				=	Request.Form("vergiNo")
	vergiNo				=	cstr(vergiNo)
	
	
	utsToken			=	"Systema8ecbcd0-7707-4a79-bb9f-1f87cd087a58"'token başka firmaya ait test amaçlı!!!!!!!!!!!!!!!!!!
	

	
'############################ vergi numarası ile ÜTS kurum numaralarını sorgula
'############################ vergi numarası ile ÜTS kurum numaralarını sorgula
	if bildirim = "vergiNoSorgula" then
	call logla("ÜTS kurum sorgula vkn:"&vergiNo&"")
		vergiNoSorgulaSonuc = vergiNoSorgula(vergiNo, utsToken)
		response.write vergiNoSorgulaSonuc
	end if
'############################ vergi numarası ile ÜTS kurum numaralarını sorgula
'############################ vergi numarası ile ÜTS kurum numaralarını sorgula
	
	
	
	
	
%>
