<!--#include virtual="/reg/rs.asp" --><%

'	Response.Flush()
	kid						=	kidbul()
	id						=	Request.QueryString("id")
	ihaleID					=	Request.QueryString("ihaleID")
	ihaleID64				=	ihaleID
	ihaleID64				=	base64_encode_tr(ihaleID64)
	stoklarID				=	Request.QueryString("stoklarID")
	urunsec					=	stoklarID
	ayar_firmaBagimsizCari	=	1
	call sessiontest()


'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr = Split(kidarr,"#")
		musteriID			=	kidarr(0)
		mtimeout			=	kidarr(1)
		kad					=	kidarr(2)
		sayfaKayitSayisi	=	int(kidarr(3))
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr


'##### ajax ile gelen sorgu 
'##### ajax ile gelen sorgu 
	arananKelime		=	request.QueryString ("q")
	firmaID				=	request.QueryString ("firmaid")
'##### /ajax ile gelen sorgu 
'##### /ajax ile gelen sorgu 




	'##### CARİLERİ ÇEK select2 için JSON verisi oluştur
	'##### CARİLERİ ÇEK select2 için JSON verisi oluştur
				sorgu = "Select c.id, c.ad, c.muhCariKod from cariler c WHERE ad LIKE '%"&arananKelime&"%' AND c.musteriID = " & musteriID & " AND c.firmaID = "&firmaID&" AND c.netsisPasif = 0 ORDER BY ad"
				rs.open sorgu,sbsv5,1,3
				
					response.Write "{"
					response.Write """items"": "
					response.Write "["
				for i = 1 to rs.recordcount
					Response.Write "{"
					Response.Write """id"":"&rs("id")&","
					Response.Write """text"":"""&rs("ad")&"-"&rs("muhCariKod")&""""
					if i < rs.recordcount then
						Response.Write "},"
					else
						Response.Write "}"
					end if	
				rs.movenext
				next
					Response.Write "]"
					Response.Write "}"
				rs.close

	'##### /CARİLERİ ÇEK select2 için JSON verisi oluştur
	'##### /CARİLERİ ÇEK select2 için JSON verisi oluştur




%>

