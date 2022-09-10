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
    modul   =   "netsis.stok"
    modulAd =   modul
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Stok Senkronizasyonu Başladı")

yetkiManager = yetkibul("manager")



sorgu       =   ""
sorgu		=	sorgu & "SELECT t1.STOK_KODU,"_
	&" " & firmaSSOdb & ".dbo.TRK(t1.STOK_ADI) as STOK_ADI,"_
	&" t2.INGISIM as stokBarcode"_
	&" FROM " & firmaSSOdb & ".DBO.TBLSTSABIT t1"_
	&" LEFT JOIN " & firmaSSOdb & ".dbo.TBLSTSABITEK t2 ON t1.STOK_KODU = t2.STOK_KODU"_
	&" ORDER BY t1.STOK_KODU asc" & vbcrlf

rs.open sorgu,sbsv5,1,3

for zi = 1 to rs.recordcount
	STOK_KODU	=	rs("STOK_KODU")
	STOK_ADI	=	rs("STOK_ADI")
	stokBarcode	=	rs("stokBarcode")
	
	sorgu = "SELECT * FROM stok.stok WHERE stokKodu = '" & STOK_KODU & "'"
	rs1.open sorgu,sbsv5,1,3
	if rs1.recordcount = 0 then
		rs1.addnew
		call logla("Stok Senkronizasyonu " & STOK_KODU & " Ürün Eklendi")
	end if
		rs1("firmaID")		=	firmaID
		rs1("stokKodu")		=	STOK_KODU
		rs1("stokAd")		=	STOK_ADI
		rs1("stokBarcode")	=	stokBarcode
		rs1("netsisDonem")	=	firmaSSOdb
	rs1.update
	rs1.close
rs.movenext
next
rs.close
call logla("Stok Senkronizasyonu Bitti")





%><!--#include virtual="/reg/rs.asp" -->