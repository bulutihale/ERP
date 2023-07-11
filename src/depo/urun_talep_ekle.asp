<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
	stokID			=	Request("stokID")
	talepMiktar		=	Request("talepMiktar")
	modulAd			=   "Depo"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

Response.Flush()

yetkiKontrol = yetkibul(modulAd)


	hangiYil		=	datepart("yyyy",date())
	hangiAy			=	datepart("m",date())
	hangiGun		=	datepart("d",date())

	sorgu = "SELECT * FROM portal.ajanda"
	rs.open sorgu, sbsv5,1,3
		rs.addnew
			rs("kid")					=	kid
			rs("firmaID")				=	firmaID
			rs("hangiGun")				=	hangiGun
			rs("hangiAy")				=	hangiAy
			rs("hangiYil")				=	hangiYil
			rs("icerik")				=	"manuel talep"
			rs("stokID")				=	stokID
			rs("isTur")					=	"transfer"
			rs("miktar")				=	talepMiktar
		rs.update
	rs.close


%><!--#include virtual="/reg/rs.asp" -->


