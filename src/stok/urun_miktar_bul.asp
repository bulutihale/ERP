<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()



	'##### request
	'##### request
		kid						=	kidbul()
		stokID					=	Request.Form("stokID")
	'##### request
	'##### request


	'## veritabanı

		sorgu = "SELECT stok.FN_stokSay(" & firmaID & ", " & stokID & ") as urunMiktar FROM stok.stok"
		rs.open sorgu, sbsv5,1,3
					
			urunMiktar	=	rs("urunMiktar")
		Response.Write  urunMiktar

	'## veritabanı




%>



