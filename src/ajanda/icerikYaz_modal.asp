<!--#include virtual="/reg/rs.asp" --><%

'	Response.Flush()
	kid					=	kidbul()
	hangiYil			=	Request.QueryString("hangiYil")
	hangiAy				=	Request.QueryString("hangiAy")
	hangiGun			=	Request.QueryString("hangiGun")
	call sessiontest()




'##### YETKİ BUL
'##### YETKİ BUL
	sorgu		=	""
	sayfaadi	=	"Dosya Detay"
'##### YETKİ BUL
'##### YETKİ BUL

		islemTarih	=	DateSerial(hangiYil, hangiAy, hangiGun)





	
		Response.Write "<form id=""takvimIcerik"" action=""/ajanda/icerikKaydet.asp"" method=""post"" class=""ajaxform"">"
			Response.Write "<input type=""hidden"" name=""hangiYil"" value=""" & hangiYil & """ />"
			Response.Write "<input type=""hidden"" name=""hangiAy"" value=""" & hangiAy & """ />"
			Response.Write "<input type=""hidden"" name=""hangiGun"" value=""" & hangiGun & """ />"
	Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-12 text-center h4"">" & islemTarih & "</div>"
			Response.Write "<div class=""col-12"">"
			Response.Write "<label class=""badge"">Takvim Notu</label>"
			Response.Write "<input type=""text"" class=""form-control"" name=""inpicerik"">"
			Response.Write "</div>"

			Response.Write "<div class=""col-12 mt-3"">"
				Response.Write "<button id=""icerikKaydet"" type=""submit"" class=""btn btn-sm rounded form-control btn-success"" onClick=""modalkapat();"">Kaydet</button>"
			Response.Write "</div>"
	Response.Write "</div>"
		Response.Write "</form>"
		
		
	sorgu = "SELECT id, kid, hangiYil, hangiAy, hangiGun, icerik FROM portal.ajanda WHERE silindi = 0 AND firmaID = " & firmaID & " AND kid = " & kid & " AND hangiYil = " & hangiYil & "  AND  hangiAy = " & hangiAy & " AND hangiGun = " & hangiGun
	rs.open sorgu, sbsv5,1,3
		if rs.recordcount > 0 then
				Response.Write "<hr>"
				Response.Write "<div class=""col-12 text-center h5"">Kayıtlı İşler</div>"
			for di = 1 to rs.recordcount
				ajID		=	rs("id")
				icerik		=	rs("icerik")
				Response.Write "<div class=""col-12 text-left"">"
					Response.Write "<span id=""" & ajID & """ data-tablo=""portal.ajanda"" class=""pointer kayitSil mr-2""><i class=""fa fa-minus-circle text-danger""></i></span>"
					Response.Write icerik
				Response.Write "</div>"											
	rs.movenext
	next
	end if
	rs.close


%>

