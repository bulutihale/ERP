<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()



	'##### request
	'##### request
		kid						=	kidbul()
		stokID					=	Request("stokID")
		birimGonder				=	Request("birimGonder")
			'birimGonder = 1 --> sadece miktar
			'birimGonder = 2 --> sadece birim
			'birimGonder = 3 --> birim ve miktar

	'##### request
	'##### request


	'## veritabanı

		sorgu = "SELECT ISNULL(stok.FN_stokSay(" & firmaID & ", " & stokID & "),0) as urunMiktar, [stok].[FN_anaBirimADBul] ( " & stokID & ", 'uAd' ) as anaBirim FROM stok.stok"
		rs.open sorgu, sbsv5,1,3
					
			urunMiktar	=	rs("urunMiktar")
			anaBirim	=	rs("anaBirim")

		
		Response.Write  OndalikKontrol(urunMiktar) & " " & anaBirim

	'## veritabanı




%>



