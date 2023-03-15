<!--#include virtual="/reg/rs.asp" --><%

'	Response.Flush()
	kid						=	kidbul()
	ihaleID					=	Request.QueryString("ihaleID")
	ihaleUrunID				=	Request.QueryString("id")
	firmamID				=	Request.QueryString("firmamID")
	kayitTip				= 	Request.QueryString("kayitTip")
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


'##### YETKİ BUL
'##### YETKİ BUL
	sorgu		=	""
	sayfaadi	=	"Dosya Detay"
'##### YETKİ BUL
'##### YETKİ BUL




	'##### CARİLERİ ÇEK
	'##### CARİLERİ ÇEK
				sorgu = "Select c.id, COALESCE(NULLIF(c.adKisa,''), c.ad) as ad from cariler c WHERE c.musteriID = " & musteriID & " AND c.firmaID = " & firmamID
				rs.open sorgu,sbsv5,1,3
					degerler = "=|"
					do while not rs.eof
						degerler = degerler & rs("ad")
						degerler = degerler & "="
						degerler = degerler & rs("id")
						degerler = degerler & "|"
					rs.movenext
					loop
					if degerler = "" then
					else
						degerler = left(degerler,len(degerler)-1)
					end if
				rs.close
				carilerdegerler = degerler
	'##### /CARİLERİ ÇEK
	'##### /CARİLERİ ÇEK


if urunsec <> "" then
	urunsec = int(urunsec)
end if

Response.Write "<button type=""button"" class=""close"" aria-label=""Close"">"
Response.Write "<span aria-hidden=""true"" onClick=""modalkapat();"">&times;</span>"
Response.Write "</button>"

Response.Write "<form action=""/dosya/cari_kaydet.asp"" method=""post"" class=""ajaxform"">"
Response.Write "<input type=""hidden"" name=""ihaleID"" value=""" & ihaleID & """ />"
Response.Write "<input type=""hidden"" name=""ihaleUrunID"" value=""" & ihaleUrunID & """ />"
Response.Write "<input type=""hidden"" name=""kayitTip"" value=""" & kayitTip & """ />"

	Response.Write "<div class=""container-fluid"">"
	
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12"">"
			Response.Write "<label class=""badge"">Cari Seçimi</label>"
				call formselectv2("deger","","","","carisec","","degermodal",carilerdegerler,"")
				call clearfix()
			Response.Write "</div>"
		Response.Write "</div>"
		
		if kayitTip = "rakipCari" then

			sorgu = "SELECT id, grupNo, siraNo FROM ihale_urun iu WHERE ihaleID = " & ihaleID & " ORDER BY grupNo ASC, siraNo ASC" 
			rs.open sorgu,sbsv5,1,3
			for zi = 1 to rs.recordcount
				iuID	 =	rs("id")
					Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-lg-1"">"
							Response.Write "<input name=""iuID"" value="""&iuID&""" type=""checkbox"" class=""chck30 form-control"">"
					Response.Write "</div>"
					
					Response.Write "<div class=""col-lg-4 text-left pt-1"">"
							Response.Write "Kısım:" & rs("grupNo") & " - Sıra:" & rs("siraNo") &"<br>"
					Response.Write "</div>"
					
					Response.Write "<div class=""col-lg-3 text-left"">"
							Response.Write "<input name=""inputRakipFiyat_"&iuID&""" type=""text"" class=""form-control"" placeholder=""fiyat"">"
					Response.Write "</div>"
					
					Response.Write "<div class=""col-lg-3 text-left"">"
							Response.Write "<input name=""inputRakipMarka_"&iuID&""" type=""text"" class=""form-control ml-2"" placeholder=""marka"">"
					Response.Write "</div>"
					
					Response.Write "<div class=""col-lg-1"">"
							Response.Write "<input name=""yerliMali_"&iuID&""" value=""evet"" type=""checkbox"" class=""chck30 form-control"">"
					Response.Write "</div>"
					
					Response.Write "</div>"'row
		
			rs.movenext
			next
			rs.close
				Response.Write "<div class=""row"">"
		end if 'kayitTip
		
		Response.Write "<div class=""col-lg-12"">"
		Response.Write "<button type=""submit"" class=""btn form-control btn-success"">Kaydet</button>"
			call clearfix()
		Response.Write "</div>"
	Response.Write "</div>"
Response.Write "</form>"

	
Response.Write "<scr" & "ipt>"
Response.Write "$(document).ready(function() {"
Response.Write "$('.carisec').select2({theme: 'bootstrap',placeholder: 'Cari seçimi yapınız.',allowClear: true});"
Response.Write "});"




Response.Write "</scr" & "ipt>"
%>




