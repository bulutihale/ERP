<!--#include virtual="/reg/rs.asp" -->


<%

	Response.Flush()
	kid						=	kidbul()
	formStoklarID				=	Request.Form("formStoklarID")
	if formStoklarID = "" then
		formStoklarID = 0
	end if
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


'##### YETKİ BUL
'##### YETKİ BUL
	sorgu		=	""
	sayfaadi	=	"Dosya Listesi"
	'yetki		=	yetkibul("","","")
'##### YETKİ BUL
'##### YETKİ BUL

Response.Write "<div 	id=""tasiyiciDIV"">"
	Response.Write "<div class=""row"">"
		Response.Write "<div class=""col-4"">"
			Response.Write "<div class=""scroll-ekle3 pointer"">"
				sorgu = "SELECT id, muhStokKod, ad"
					sorgu = sorgu & " FROM stoklar"
					sorgu = sorgu & " WHERE id IN (SELECT stoklarID FROM ihale_urun"
					sorgu = sorgu & " WHERE ihaleID IN (SELECT id FROM ihale"
					sorgu = sorgu & " WHERE ihaleTipi IN ('acik','pazarlik')))"
					sorgu = sorgu & " ORDER BY ad"
				rs.open sorgu,sbsv5,1,3
					for zi = 1 to rs.recordcount
						stoklarID		=	rs("id")
						muhStokKod		=	rs("muhStokKod")
						urunAd			=	rs("ad")
						Response.Write "<div class=""row pointer hoverGel urunSec"""
							Response.Write " onclick=""$('.urunSec').removeClass('bg-info');"
							Response.Write " $(this).addClass('bg-info');"
							'Response.Write " $.redirect('qtest', {formStoklarID:" & stoklarID & "} )"
							Response.Write " $('#DIV2').load('qtest2.asp', {formStoklarID:" & stoklarID & "});"
							'Response.Write " haritaYukle();"
							Response.Write """>"
							Response.Write "<div class=""col-3"">" & muhStokKod & "</div>"
							Response.Write "<div class=""col-9"">" & urunAd & "</div>"
						Response.Write "</div>"
					rs.movenext
					next
				rs.close
			Response.Write "</div>"
			Response.Write "<div>"
			Response.Write "</div>"
		Response.Write "</div>"
		
		
		
		
		
		
		
		
		Response.Write "<div id=""DIV2"" class=""col-8""></div>"
	 Response.Write "</div>"
	 
	 
	 
	 
	 
	
	

Response.Write "</div>"
%>

