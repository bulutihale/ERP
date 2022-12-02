<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()



	'##### request
	'##### request
		kid						=	kidbul()
		stokID					=	Request.Form("stokID")
	'##### request
	'##### request





	

'##### HÜCRE EDIT
'##### HÜCRE EDIT
	'## veritabanı

		sorgu = "SELECT ISNULL(anaBirimID,0) as anaBirimID FROM stok.stok WHERE stokID = " & stokID
		rs.open sorgu, sbsv5,1,3
			anaBirimID	=	rs("anaBirimID")
		rs.close

		sorgu = "SELECT stok.FN_stokHareketKontrol(" & firmaID & ", " & stokID & ") as hareketKontrol"
		rs.open sorgu, sbsv5,1,3
				hareketKontrol	=	rs("hareketKontrol")
		rs.close
	'## veritabanı

		if anaBirimID = 0 AND hareketKontrol = 0 then
			stokID64	=	stokID
			stokID64	=	base64_encode_tr(stokID64)
			sonuc		=	"/stok/stok_yeni.asp?a=hareketKontrol&gorevID=" & stokID64
		else
			sonuc	=	"tanimlanamaz"
		end if



'##### HÜCRE EDIT
'##### HÜCRE EDIT 

		
			response.Write sonuc

%>



