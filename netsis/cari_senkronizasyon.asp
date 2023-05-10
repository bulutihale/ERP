<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    modul   =   Request.QueryString("modul")
   	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modul   =   "netsis.cari"
    modulAd =   modul
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Cari Senkronizasyonu Başladı")

yetkiManager = yetkibul("manager")



sorgu       =   ""
sorgu		=	sorgu & "SELECT t1.CARI_KOD, " & firmaSSOdb & ".dbo.TRK(t1.CARI_IL) as CARI_IL, " & firmaSSOdb & ".dbo.TRK(t1.VERGI_DAIRESI) as VERGI_DAIRESI, t1.VERGI_NUMARASI,"_
	&" " & firmaSSOdb & ".dbo.TRK(t1.CARI_ISIM) as CARI_ISIM"_
	&" FROM " & firmaSSOdb & ".DBO.TBLCASABIT t1"_
	&" ORDER BY t1.CARI_KOD asc" & vbcrlf
rs.open sorgu,sbsv5,1,3

for zi = 1 to rs.recordcount
	CARI_KOD		=	rs("CARI_KOD")
	CARI_ISIM		=	rs("CARI_ISIM")
	CARI_IL			=	rs("CARI_IL")
	VERGI_DAIRESI	=	rs("VERGI_DAIRESI")
	VERGI_NUMARASI	=	rs("VERGI_NUMARASI")
	
	sorgu = "SELECT * FROM cari.cari WHERE cariKodu = '" & CARI_KOD & "'"
	rs1.open sorgu,sbsv5,1,3
	if rs1.recordcount = 0 then
		rs1.addnew
		call logla("Cari Senkronizasyonu " & CARI_KOD & " cari Eklendi")
	end if
		rs1("firmaID")		=	firmaID
		rs1("cariKodu")		=	CARI_KOD
		rs1("cariAd")		=	CARI_ISIM
		rs1("il")			=	CARI_IL
		rs1("vergiDairesi")	=	VERGI_DAIRESI
		rs1("vergiNo")		=	VERGI_NUMARASI
		rs1("netsisDonem")	=	firmaSSOdb
	rs1.update
	rs1.close
rs.movenext
next
rs.close
call logla("Cari Senkronizasyonu Bitti")





%><!--#include virtual="/reg/rs.asp" -->



