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

		sorgu = "SELECT ISNULL(t1.anaBirimID,0) as anaBirimID, t2.uzunBirim"
		sorgu = sorgu & " FROM stok.stok t1"
		sorgu = sorgu & " LEFT JOIN portal.birimler t2 ON t1.anaBirimID = t2.birimID"
		sorgu = sorgu & " WHERE t1.stokID = " & stokID
		rs.open sorgu, sbsv5,1,3
			anaBirimID	=	rs("anaBirimID")
			uzunBirim	=	rs("uzunBirim")
		rs.close

		sorgu = "SELECT stok.FN_stokHareketKontrol(" & firmaID & ", " & stokID & ") as hareketKontrol"
		rs.open sorgu, sbsv5,1,3
				hareketKontrol	=	rs("hareketKontrol")
		rs.close
	'## veritabanı
			stokID64	=	stokID
			stokID64	=	base64_encode_tr(stokID64)
		if anaBirimID = 0 AND hareketKontrol = 0 then
			sonuc		=	"/stok/stok_yeni.asp?a=hareketKontrol&gorevID=" & stokID64
		else
			'sonuc	=	"tanimlanamaz"
			sonuc	=	anaBirimID&"|"&uzunBirim&"|"&stokID64
		end if



'##### HÜCRE EDIT
'##### HÜCRE EDIT 

			response.Write sonuc

%>



