<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

kid		=	kidbul()
ID		=	Request.QueryString("ID")
kid64	=	ID

Response.Flush()

yetki = yetkibul("bilsem")

if yetki > 5 then
	if ID <> "" then
		ID = base64_decode_tr(ID)
			sorgu = "" & vbcrlf
			sorgu = sorgu & "Select " & vbcrlf
			sorgu = sorgu & "bilsem.ogretmenIzinler.tarih " & vbcrlf
			sorgu = sorgu & ",bilsem.ogretmenIzinler.izinAciklama " & vbcrlf
			sorgu = sorgu & ",bilsem.ogretmenIzinler.ogretmenID " & vbcrlf
			sorgu = sorgu & ",bilsem.ogretmenIzinler.dersGun " & vbcrlf
			sorgu = sorgu & ",bilsem.ogretmenIzinler.dersSaatleriID " & vbcrlf
			sorgu = sorgu & ",bilsem.ogretmenIzinler.izinID " & vbcrlf
			sorgu = sorgu & "from bilsem.ogretmenIzinler " & vbcrlf
			sorgu = sorgu & "where bilsem.ogretmenIzinler.izinID = " & ID & vbcrlf
			rs.open sorgu,sbsv5,1,3
				if rs.recordcount > 0 then
					tarih			=	rs("tarih")
					ogretmenID		=	rs("ogretmenID")
					dersGun			=	rs("dersGun")
					dersSaatleriID	=	rs("dersSaatleriID")
					izinAciklama	=	rs("izinAciklama")
					ID				=	rs("izinID")
					ID64			=	ID
					ID64			=	base64_encode_tr(ID64)
				end if
			rs.close
	end if


		Response.Write "<form action=""/bilsem/izin_kaydet.asp"" method=""post"" class=""ajaxform"">"
		Response.Write "<input name=""ID"" type=""hidden"" value=""" & ID64 & """ />"

			Response.Write "<div class=""panel panel-primary mt10 mb10"">"
				Response.Write "<div class=""panel-heading parmak"" onClick=""divackapa('#kisiselbilgiler')"">İzin Ekle</div>"
				Response.Write "<div class=""panel-body"" id=""kisiselbilgiler"">"

					Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 mb10"">"
						Response.Write "<div class=""mt5"">"
						Response.Write "<label class=""label label-danger"">Öğretmen</label>"
							sorgu = "select ogretmenID,ogretmenAd from bilsem.ogretmen where silindi = 0 and firmaID = " & firmaID & " order by ogretmenAd ASC"
							rs.open sorgu,sbsv5,1,3
								degerler = "Öğretmen Seçin=|"
								do while not rs.eof
									degerler = degerler & rs("ogretmenAd")
									degerler = degerler & "="
									degerler = degerler & rs("ogretmenID")
									degerler = degerler & "|"
								rs.movenext
								loop
								degerler = left(degerler,len(degerler)-1)
								call formselectv2("ogretmenID",ogretmenID,"","","mt5","","ogretmenID",degerler,"")
							rs.close
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 mb10"">"
						Response.Write "<div class=""mt5"">"
						Response.Write "<label class=""label label-danger"">İzin Tarihi</label>"
						call forminput("tarih",tarih,"","","tarih","","tarih","")
						Response.Write "</div>"
					Response.Write "</div>"

					' Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs-12 mb10"">"
					' 	Response.Write "<div class=""mt5"">"
					' 	Response.Write "<label class=""label label-danger"">İzin Bitiş Tarihi</label>"
					' 	call forminput("tarih2",tarih2,"","","tarih","","tarih2","")
					' 	Response.Write "</div>"
					' Response.Write "</div>"

					Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 mb10"">"
						Response.Write "<div class=""mt5"">"
						Response.Write "<label class=""label label-danger"">Ders Saati</label>"
							sorgu = "select dersSaatiID,t1,t2 from bilsem.dersSaatleri where silindi = 0 and firmaID = " & firmaID & " order by t1 ASC"
							rs.open sorgu,sbsv5,1,3
								degerler = "Ders Saatini Seçin=|"
								degerler = degerler & "Tüm Gün=0|"
								do while not rs.eof
									degerler = degerler & rs("t1") & " - " & rs("t2")
									degerler = degerler & "="
									degerler = degerler & rs("dersSaatiID")
									degerler = degerler & "|"
								rs.movenext
								loop
								degerler = left(degerler,len(degerler)-1)
								call formselectv2("dersSaatleriID",dersSaatleriID,"","","mt5","","dersSaatleriID",degerler,"")
							rs.close
						Response.Write "</div>"
					Response.Write "</div>"

					Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 mb10"">"
						Response.Write "<div class=""mt5"">"
						Response.Write "<label class=""label label-danger"">İzin Notu</label>"
						call forminput("izinAciklama",izinAciklama,"","","","","izinAciklama","")
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

		if ID = "" then
			Response.Write "<div class=""mt10"">"
			Response.Write "<button class=""form-control btn btn-primary"" type=""submit"" name=""buton"" value=""devam"">"
			Response.Write "Ekle ve Eklemeye Devam Et"
			Response.Write "</button>"
			Response.Write "</div>"
		end if

		Response.Write "</form>"

		Response.Write "<div class=""clearfix mt10 mb10""></div>"










end if

%><!--#include virtual="/reg/rs.asp" -->