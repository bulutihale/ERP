<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

kid		=	kidbul()
ID		=	Request.Form("ID")
kid64	=	ID

Response.Flush()

yetki = yetkibul("bilsem")

if yetki > 5 then
	if ID <> "" then
		ID = base64_decode_tr(ID)
		rs.open "Select top(1) * from bilsem.ogretmen where ogretmenID = " & ID,sbsv5,1,3
			if rs.recordcount > 0 then
				ogretmenAd		=	rs("ogretmenAd")
				ID				=	rs("ogretmenID")
				ID64			=	ID
				ID64			=	base64_encode_tr(ID64)
			end if
		rs.close
	end if

		Response.Write "<form action=""/bilsem/ogretmen_kaydet.asp"" method=""post"" class=""ajaxform"">"
		Response.Write "<input name=""ID"" type=""hidden"" value=""" & ID64 & """ />"

			Response.Write "<div class=""panel panel-primary mt10 mb10"">"
				Response.Write "<div class=""panel-heading parmak"" onClick=""divackapa('#kisiselbilgiler')"">Kişisel Bilgileri</div>"
				Response.Write "<div class=""panel-body"" id=""kisiselbilgiler"">"
					Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Adı Soyadı</label>"
						call forminput("ogretmenAd",ogretmenAd,"","","","","ogretmenAd","")
						Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"

			Response.Write "<div class=""mt10"">"
				Response.Write "<button class=""form-control btn btn-success"" type=""submit"">"
				if ID <> "" then
					Response.Write "Güncelle"
				else
					Response.Write "Ekle"
				end if
				Response.Write "</button>"
			Response.Write "</div>"

		Response.Write "</form>"

		Response.Write "<div class=""clearfix mt10 mb10""></div>"










end if

%><!--#include virtual="/reg/rs.asp" -->