<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()



	'##### request
	'##### request
		kid						=	kidbul()
		islem					=	Request.Form("islem")
		koliIndexID				=	Request.Form("koliIndexID")
		stokID					=	Request.Form("stokID")
		koliID					=	Request.Form("koliID")
		koliUrunMiktar			=	Request.Form("koliUrunMiktar")
	'##### request
	'##### request





	

'##### HÜCRE EDIT
'##### HÜCRE EDIT
	'## veritabanı

		sorgu = "SELECT *"
		sorgu = sorgu & " FROM stok.koliIndex t1"
		sorgu = sorgu & " WHERE"
		if islem = "silinecek" then
			sorgu = sorgu & " t1.koliIndexID = " & koliIndexID
		else
			sorgu = sorgu & " t1.stokID = " & stokID & " AND t1.koliID = " & koliID & " AND silindi = 0"
		end if
		rs.open sorgu, sbsv5,1,3
			if islem = "silinecek" AND rs.recordcount > 0 then
				call logla("Koli index bilgisi siliniyor koliIndexID:"&koliIndexID&"")
				rs("silindi")	=	1
				rs.update
			end if

			if islem = "yeniKayit" then
				call logla("Yeni koli index bilgisi ekleniyor koliIndexID:"&koliIndexID&"")
				rs.addnew
					rs("kid")				=	kid
					rs("firmaID")			=	firmaID
					rs("stokID")			=	stokID
					rs("koliID")			=	koliID
					rs("koliUrunMiktar")	=	koliUrunMiktar
				rs.update
			end if
			
		rs.close

		Response.Write  "İşlem Yapıldı"

	'## veritabanı



'##### HÜCRE EDIT
'##### HÜCRE EDIT 


%>



