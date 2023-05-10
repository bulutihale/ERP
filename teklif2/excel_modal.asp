<!--#include virtual="/reg/rs.asp" --><%


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

Response.Flush()

id = Request.QueryString("id")


	'##### İÇERİK TANIMLARINI ÇEK
	'##### İÇERİK TANIMLARINI ÇEK
				sorgu = "Select id,icerikTanimi from dosya_icerik WHERE musteriID = " & musteriID
				rs.open sorgu,sbsv5,1,3
					degerler = "=|"
					do while not rs.eof
						degerler = degerler & rs("icerikTanimi")
						degerler = degerler & "="
						degerler = degerler & rs("icerikTanimi")
						degerler = degerler & "|"
					rs.movenext
					loop
					if degerler = "" then
					else
						degerler = left(degerler,len(degerler)-1)
					end if
				rs.close
				icerikDegerler = degerler
	'##### /İÇERİK TANIMLARINI ÇEK
	'##### /İÇERİK TANIMLARINI ÇEK


Response.Write "<div class=""container-fluid"">"
Response.Write "<div class=""text-center col-lg-12 mb10"">"
Response.Write "<form enctype=""multipart/form-data"" method=""post"" action=""/dosya/excel_yukle.asp"" class=""ajaxform"">"
Response.Write "<input type=""hidden"" name=""id"" value=""" & id & """ />"
	Response.Write "<div class=""row"">"
		Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
			Response.Write "<input type=""file"" name=""dosya"" />"
		Response.Write "</div>"
		Response.Write "<div class=""clearfix""></div>"
		
			Response.Write "<div class=""col-lg-5"">"
			Response.Write "<label class=""badge"">Dosya İçerik Seçimi</label>"
				call formselectv2("iceriksec","","","İçerik Seçimi","iceriksec p-0","","",icerikDegerler,"multiple")
			Response.Write "</div>"
		
		Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 mt10"">"
			Response.Write "<button type=""submit"" class=""btn btn-success form-control"">Excel Dosyasını Yükle</button>"
		Response.Write "</div>"
	Response.Write "<div class=""clearfix""></div>"
	Response.Write "</div>"
Response.Write "</form></div>"
Response.Write "</div>"
%>