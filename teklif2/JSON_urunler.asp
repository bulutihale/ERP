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
	firmalarID			=	request.QueryString ("firmaid")
'##### /ajax ile gelen sorgu 
'##### /ajax ile gelen sorgu 


	'##### STOKLARI ÇEK select2 için JSON verisi oluştur (JOIN işlemi barkodları TMT stoklarından almak için yapıldı)
	'##### STOKLARI ÇEK select2 için JSON verisi oluştur (JOIN işlemi barkodları TMT stoklarından almak için yapıldı)
				sorgu = "Select s1.id, s1.ad, s1.ubbKod, s1.muhStokKod, s1.katalogKodu, s1.firmalarID, s1.ubbKod from stoklar s1"_
				&" WHERE (s1.ad LIKE '%"&arananKelime&"%' OR s1.ubbKod  LIKE '%"&arananKelime&"%' OR s1.muhStokKod LIKE '%"&arananKelime&"%')"_
				&" AND s1.musteriID = " & musteriID & ""_
				&" AND s1.firmalarID = " & firmalarID & " AND s1.netsisPasif = 0 ORDER BY ad"
				rs.open sorgu,sbsv5,1,3
				
					response.Write "{"
					response.Write """items"": "
					response.Write "["
				for i = 1 to rs.recordcount
					Response.Write "{"
					Response.Write """id"":"&rs("id")&","
					Response.Write """text"":"""&rs("ad")&""""

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

	'##### /STOKLARI ÇEK select2 için JSON verisi oluştur
	'##### /STOKLARI ÇEK select2 için JSON verisi oluştur




%>

