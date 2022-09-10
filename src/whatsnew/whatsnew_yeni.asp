<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

kid		=	kidbul()
ID		=	Request.Form("ID")
kid64	=	ID

Response.Flush()

yetkiIT = yetkibul("IT")

if yetkiIT = 9 then

	if ID <> "" then
		ID = base64_decode_tr(ID)
		rs.open "Select top(1) * from portal.whatsnew where id = " & ID,sbsv5,1,3
			if rs.recordcount > 0 then
				ad				=	rs("ad")
				tarih			=	rs("tarih")
				aciklama		=	rs("aciklama")
				modul			=	rs("modul")
				ayrinti			=	rs("ayrinti")
				ID64			=	ID
				ID64			=	base64_encode_tr(ID64)
			end if
		rs.close
	end if

if tarih = "" then
	tarih = now()
end if


		Response.Write "<form action=""/whatsnew/whatsnew_kaydet.asp"" method=""post"" class=""ajaxform"">"
		Response.Write "<input name=""ID"" type=""hidden"" value=""" & ID64 & """ />"

			Response.Write "<div class=""panel panel-primary mt10 mb10"">"
				Response.Write "<div class=""panel-heading parmak"">Haber - Yenilik - Güncelleme Bilgileri</div>"
				Response.Write "<div class=""panel-body"">"
					Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Tarih</label>"
						call forminput("tarih",tarih,"","","","","tarih","")
						Response.Write "</div>"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Modul</label>"
							sorgu = "Select distinct modul from portal.whatsnew where (firmaID = 0 or firmaID = " & firmaID & ") order by modul asc"
							rs.open sorgu,sbsv5,1,3
								degerler = ""
								do while not rs.eof
									degerler = degerler & rs("modul")
									degerler = degerler & "="
									degerler = degerler & rs("modul")
									degerler = degerler & "|"
								rs.movenext
								loop
								degerler = left(degerler,len(degerler)-1)
								call formselectv2("modul",modul,"","","","","modul",degerler,"")
							rs.close
						Response.Write "</div>"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Güncelleme Adı</label>"
						call forminput("ad",ad,"","","","","ad","")
						Response.Write "</div>"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-success"">Açıklaması</label>"
						call forminput("aciklama",aciklama,"","","","","aciklama","")
						Response.Write "</div>"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-success"">Geniş Ayrıntı</label>"
						Response.Write "<textarea name=""ayrinti"" onClick=""$(this).ckeditor();"" class=""form-control"">" & ayrinti & "</textarea>"
						Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"

			Response.Write "<div class=""mt10"">"
				Response.Write "<button class=""form-control btn btn-success"" type=""submit"">Güncelle</button>"
			Response.Write "</div>"

		Response.Write "</form>"

		Response.Write "<div class=""clearfix mt10 mb10""></div>"

end if

%><!--#include virtual="/reg/rs.asp" -->