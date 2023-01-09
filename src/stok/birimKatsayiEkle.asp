<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()



	'##### request
	'##### request
		kid						=	kidbul()
		stokID					=	Request.Form("stokID")
		secilenBirimID			=	Request.Form("secilenBirim")
		katsayi1Deger			=	Request.Form("katsayi1Deger")
		katsayi2Deger			=	Request.Form("katsayi2Deger")
		anaBirimID				=	Request.Form("anaBirimID")
		islem					=	Request.Form("islem")
		stokBirimID				=	Request.Form("stokBirimID")
	'##### request
	'##### request





	

'##### HÜCRE EDIT
'##### HÜCRE EDIT
	'## veritabanı

		sorgu = "SELECT *"
		sorgu = sorgu & " FROM stok.stokBirim t1"
		sorgu = sorgu & " WHERE"
		if islem = "silinecek" then
			sorgu = sorgu & " t1.stokBirimID = " & stokBirimID
		else
			sorgu = sorgu & " t1.stokID = " & stokID & " AND t1.birimID1 = " & secilenBirimID & " AND t1.birimID2 = " & anaBirimID & " AND silindi = 0"
		end if
		rs.open sorgu, sbsv5,1,3
			if rs.recordcount > 0 then
				call logla("Eski birim katsayısı siliniyor stokID:"&stokID&"")
				rs("silindi")	=	1
				rs.update
			end if

			if islem = "yeniKayit" then
				call logla("Yeni birim katsayısı ekleniyor stokID:"&stokID&"")
				rs.addnew
					rs("kid")			=	kid
					rs("firmaID")		=	firmaID
					rs("stokID")		=	stokID
					rs("birimID1")		=	secilenBirimID
					rs("birimID2")		=	anaBirimID
					rs("birim1Katsayi")	=	katsayi1Deger
					rs("birim2Katsayi")	=	katsayi2Deger
				rs.update
			end if
			
		rs.close

		Response.Write  "İşlem Yapıldı"

	'## veritabanı



'##### HÜCRE EDIT
'##### HÜCRE EDIT 


%>



