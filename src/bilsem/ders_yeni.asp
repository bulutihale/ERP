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
			sorgu = sorgu & "bilsem.ders.ogrenciID " & vbcrlf
			sorgu = sorgu & ",bilsem.ders.dersID " & vbcrlf
			sorgu = sorgu & ",bilsem.ders.ogretmenID " & vbcrlf
			sorgu = sorgu & ",bilsem.ders.dersGun " & vbcrlf
			sorgu = sorgu & ",bilsem.ders.dersSaatiID " & vbcrlf
			sorgu = sorgu & ",bilsem.ders.dersAd " & vbcrlf
			sorgu = sorgu & "from bilsem.ders " & vbcrlf
			sorgu = sorgu & "where bilsem.ders.dersID = " & ID & vbcrlf
			rs.open sorgu,sbsv5,1,3
				if rs.recordcount > 0 then
					ogrenciID		=	rs("ogrenciID")
					ogretmenID		=	rs("ogretmenID")
					dersGun			=	rs("dersGun")
					dersSaatiID		=	rs("dersSaatiID")
					dersAd			=	rs("dersAd")
					ID				=	rs("dersID")
					ID64			=	ID
					ID64			=	base64_encode_tr(ID64)
				end if
			rs.close
	end if

dersgunleriArr = Array("","Pazartesi","Salı","Çarşamba","Perşembe","Cuma","Cumartesi","Pazar")


		Response.Write "<form action=""/bilsem/ders_kaydet.asp"" method=""post"" class=""ajaxform"">"
		Response.Write "<input name=""ID"" type=""hidden"" value=""" & ID64 & """ />"

			Response.Write "<div class=""panel panel-primary mt10 mb10"">"
				Response.Write "<div class=""panel-heading parmak"" onClick=""divackapa('#kisiselbilgiler')"">Ders Ekle</div>"
				Response.Write "<div class=""panel-body"" id=""kisiselbilgiler"">"
					Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs-12 mb10"">"
						Response.Write "<div class=""mt5"">"
						Response.Write "<label class=""label label-danger"">Öğrenci</label>"
							sorgu = "select ogrenciID,ogrenciAd,ogrenciSinif from bilsem.ogrenci where silindi = 0 and firmaID = " & firmaID & " order by ogrenciAd ASC"
							rs.open sorgu,sbsv5,1,3
								degerler = "Öğrenci Seçin=|"
								do while not rs.eof
									degerler = degerler & rs("ogrenciAd") & rs("ogrenciSinif")
									degerler = degerler & "="
									degerler = degerler & rs("ogrenciID")
									degerler = degerler & "|"
								rs.movenext
								loop
								degerler = left(degerler,len(degerler)-1)
								call formselectv2("ogrenciID",ogrenciID,"","","mt5","","ogrenciID",degerler,"")
							rs.close
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs-12 mb10 hidden-xs"">"
						Response.Write "<div class=""mt5"">"
						Response.Write "<label class=""label label-danger"">Toplu Öğrenci Numarası</label>"
						call forminput("ogrenciNoIN",ogrenciNoIN,"","","","","ogrenciNoIN","")
						Response.Write "</div>"
					Response.Write "</div>"

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
						Response.Write "<label class=""label label-danger"">Ders Adı</label>"
							sorgu = "select distinct(ogretmenBrans) from bilsem.ogretmen where silindi = 0 and firmaID = " & firmaID & " order by ogretmenBrans ASC"
							rs.open sorgu,sbsv5,1,3
								degerler = "Branş Seçin=|"
								do while not rs.eof
									degerler = degerler & rs("ogretmenBrans")
									degerler = degerler & "="
									degerler = degerler & rs("ogretmenBrans")
									degerler = degerler & "|"
								rs.movenext
								loop
								degerler = left(degerler,len(degerler)-1)
								call formselectv2("dersAd",dersAd,"","","mt5","","dersAd",degerler,"")
							rs.close
						' call forminput("dersAd",dersAd,"","","","","dersAd","")
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 mb10"">"
						Response.Write "<div class=""mt5"">"
						Response.Write "<label class=""label label-danger"">Ders Günü</label>"
								degerler = "Ders Gününü Seçin=|"
								for di = 1 to ubound(dersgunleriArr)
									degerler = degerler & dersgunleriArr(di)
									degerler = degerler & "="
									degerler = degerler & di
									degerler = degerler & "|"
								next
								degerler = left(degerler,len(degerler)-1)
								call formselectv2("dersGun",dersGun,"","","mt5","","dersGun",degerler,"")

						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 mb10"">"
						Response.Write "<div class=""mt5"">"
						Response.Write "<label class=""label label-danger"">Ders Saati</label>"
							sorgu = "select dersSaatiID,t1,t2 from bilsem.dersSaatleri where silindi = 0 and firmaID = " & firmaID & " order by t1 ASC"
							rs.open sorgu,sbsv5,1,3
								degerler = "Ders Saatini Seçin=|"
								do while not rs.eof
									degerler = degerler & rs("t1") & " - " & rs("t2")
									degerler = degerler & "="
									degerler = degerler & rs("dersSaatiID")
									degerler = degerler & "|"
								rs.movenext
								loop
								degerler = left(degerler,len(degerler)-1)
								call formselectv2("dersSaatiID",dersSaatiID,"","","mt5","","dersSaatiID",degerler,"")
							rs.close
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