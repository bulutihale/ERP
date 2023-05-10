<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()



	'##### request
	'##### request
		kid						=	kidbul()
		stokID					=	Request.Form("stokID")
		lot						=	Request.Form("lot")
	'##### request
	'##### request


	'## veritabanı

		sorgu = "SELECT stok.FN_lotSktBul(" & firmaID & ", " & stokID & ", '" & lot & "') as lotSKT FROM stok.stok"
		rs.open sorgu, sbsv5,1,3
					
			lotSKT	=	rs("lotSKT")

		Response.Write  lotSKT

	'## veritabanı




%>



