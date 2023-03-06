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

yetkiManager = yetkibul("Bilgi İşlem")



	sorgu = "SELECT [" & firmaSSOdb & "].[dbo].TBLSTHAR.STOK_KODU,"
	sorgu = sorgu & " SUM(CASE WHEN STHAR_GCKOD = 'G' THEN STHAR_GCMIK ELSE -1 * STHAR_GCMIK END) AS stokMiktar"
	sorgu = sorgu & " FROM TBLSTHAR  WITH(NOLOCK)"
	sorgu = sorgu & " INNER JOIN TBLSTSABIT  ON TBLSTSABIT.STOK_KODU = TBLSTHAR.STOK_KODU"
	sorgu = sorgu & " GROUP BY TBLSTHAR.STOK_KODU"
	Response.Write sorgu
	Response.End
	rs.open sorgu,sbsv5,1,3

for zi = 1 to rs.recordcount
	STOK_KODU	=	rs("STOK_KODU")
	stokMiktar	=	rs("stokMiktar")

	sorgu = "SELECT t1.stokID, stok.FN_anaBirimIDBul(t1.stokID) as anabirimID, stok.FN_anaBirimADBul(t1.stokID,'kAD') as anaBirimAd FROM stok.stok WHERE stokKodu = '" & STOK_KODU & "'"
	rs1.open sorgu,sbsv5,1,3
		stokID		=	rs1("stokID")
		anabirimID	=	rs1("anabirimID")
		anaBirimAd	=	rs1("anaBirimAd")
	rs1.close
Response.Write stokID&"<br>"
			sorgu = "SELECT * FROM stok.stokHareket"
			rs.open sorgu,sbsv5,1,3
			'rs.addnew
				rs("kid")				=	kid
				rs("firmaID")			=	firmaID
				rs("stokKodu")			=	STOK_KODU
				rs("miktar")			=	stokMiktar
				rs("miktarBirim")		=	anaBirimAd
				rs("miktarBirimID")		=	anabirimID
				rs("girisTarih")		=	now()
				rs("stokHareketTuru")	=	"G"
				rs("depoID")			=	4
				rs("fisNo")				=	null
				rs("aciklama")			=	"netsis"
				rs("belgeNo")			=	null
				rs("belgeTarih")		=	null
				rs("cevrim")			=	0
				rs("stokID")			=	stokID
				rs("cariID")			=	null
				rs("siparisKalemID")	=	null
				rs("lot")				=	ilkGiris
				rs("stokHareketTipi")	=	"A"
				rs("refHareketID")		=	null
				rs("lotSKT")			=	null
				rs("ajandaID")			=	null
			'rs1.update
			rs1.close
rs.movenext
next
rs.close
call logla("Stok Miktar Aktarımı Bitti")





%><!--#include virtual="/reg/rs.asp" -->