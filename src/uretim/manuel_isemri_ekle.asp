<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
	stokID			=	Request("stokID")
	talepMiktar		=	Request("talepMiktar")
	talepAciklama	=	Request("talepAciklama")
	listeTur		=	Request("listeTur")
	receteID		=	Request("receteID")
	modulAd			=   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	call rqKontrol(receteID,"Reçete seçimi yapınız","")

Response.Flush()

yetkiKontrol = yetkibul(modulAd)


	hangiYil		=	datepart("yyyy",date())
	hangiAy			=	datepart("m",date())
	hangiGun		=	datepart("d",date())

	sorgu = "SELECT stok.FN_depoKategoriBul("&receteID&") as depoKategori"
	rs.open sorgu, sbsv5,1,3	
		depoKategori	=	rs("depoKategori")
	rs.close

	sorgu = "SELECT * FROM portal.ajanda"
	rs.open sorgu, sbsv5,1,3
		rs.addnew
			rs("kid")					=	kid
			rs("firmaID")				=	firmaID
			rs("hangiGun")				=	hangiGun
			rs("hangiAy")				=	hangiAy
			rs("hangiYil")				=	hangiYil
			rs("icerik")				=	talepAciklama
			rs("stokID")				=	stokID
			rs("isTur")					=	listeTur
			rs("miktar")				=	talepMiktar
			rs("receteID")				=	receteID
			rs("manuelPlan")			=	1
			rs("depoKategori")			=	depoKategori
		rs.update
	rs.close


%><!--#include virtual="/reg/rs.asp" -->


