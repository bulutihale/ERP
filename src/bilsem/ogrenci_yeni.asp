<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

kid		=	kidbul()
ID		=	Request.Form("ID")
kid64	=	ID

Response.Flush()

yetki = yetkibul("bilsem")

if yetki > 1 then
	if ID <> "" then
		ID = base64_decode_tr(ID)
		rs.open "Select top(1) * from bilsem.ogrenci where ogrenciID = " & ID,sbsv5,1,3
			if rs.recordcount > 0 then
				ogrenciAd		=	rs("ogrenciAd")
				ogrenciNo		=	rs("ogrenciNo")
				ogrenciVeli		=	rs("ogrenciVeli")
				ogrenciAnne		=	rs("ogrenciAnne")
				ogrenciAnneGSM	=	rs("ogrenciAnneGSM")
				ogrenciBaba		=	rs("ogrenciBaba")
				ogrenciBabaGSM	=	rs("ogrenciBabaGSM")
				ogrenciAlan1	=	rs("ogrenciAlan1")
				ogrenciAlan2	=	rs("ogrenciAlan2")
				ogrenciAlan3	=	rs("ogrenciAlan3")
				ogrenciProgram1	=	rs("ogrenciProgram1")
				ogrenciProgram2	=	rs("ogrenciProgram2")
				ogrenciProgram3	=	rs("ogrenciProgram3")
				ogrenciProgram4	=	rs("ogrenciProgram4")
				ogrenciOzelNot	=	rs("ogrenciOzelNot")
				ID				=	rs("ogrenciID")
				ID64			=	ID
				ID64			=	base64_encode_tr(ID64)
			end if
		rs.close
	end if

		Response.Write "<form action=""/bilsem/ogrenci_kaydet.asp"" method=""post"" class=""ajaxform"">"
		Response.Write "<input name=""ID"" type=""hidden"" value=""" & ID64 & """ />"

			Response.Write "<div class=""panel panel-primary mt10 mb10"">"
				Response.Write "<div class=""panel-heading parmak"" onClick=""divackapa('#kisiselbilgiler')"">Kişisel Bilgileri</div>"
				Response.Write "<div class=""panel-body"" id=""kisiselbilgiler"">"


					Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Adı Soyadı</label>"
						call forminput("ogrenciAd",ogrenciAd,"","","","","ogrenciAd","")
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Okul Numarası</label>"
						call forminput("ogrenciNo",ogrenciNo,"","","","","ogrenciNo","")
						Response.Write "</div>"
					Response.Write "</div>"

					Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Velisi</label>"
								degerler = "Veliyi Seçin=|ANNE=ANNE|BABA=BABA|DIGER=DIGER"
								' degerler = left(degerler,len(degerler)-1)
								call formselectv2("ogrenciVeli",ogrenciVeli,"","","mt5","","ogrenciVeli",degerler,"")
						Response.Write "</div>"
					Response.Write "</div>"

					Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Anne Adı</label>"
						call forminput("ogrenciAnne",ogrenciAnne,"","","","","ogrenciAnne","")
						Response.Write "</div>"
					Response.Write "</div>"

					Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Anne GSM</label>"
						call forminput("ogrenciAnneGSM",ogrenciAnneGSM,"","","","","ogrenciAnneGSM","")
						Response.Write "</div>"
					Response.Write "</div>"

					Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Baba Adı</label>"
						call forminput("ogrenciBaba",ogrenciBaba,"","","","","ogrenciBaba","")
						Response.Write "</div>"
					Response.Write "</div>"

					Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Baba GSM</label>"
						call forminput("ogrenciBabaGSM",ogrenciBabaGSM,"","","","","ogrenciBabaGSM","")
						Response.Write "</div>"
					Response.Write "</div>"

					Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Alan 1</label>"
							sorgu = "select DISTINCT(ogrenciAlan1) from bilsem.ogrenci where ogrenciAlan1 <> '' and ogrenciAlan1 is not null and silindi = 0 and firmaID = " & firmaID & " order by ogrenciAlan1 ASC"
							rs.open sorgu,sbsv5,1,3
								degerler = "Alan Seçin=|"
								do while not rs.eof
									degerler = degerler & rs("ogrenciAlan1")
									degerler = degerler & "="
									degerler = degerler & rs("ogrenciAlan1")
									degerler = degerler & "|"
								rs.movenext
								loop
								degerler = left(degerler,len(degerler)-1)
								call formselectv2("ogrenciAlan1",ogrenciAlan1,"","","mt5","","ogrenciAlan1",degerler,"")
							rs.close
						Response.Write "</div>"
					Response.Write "</div>"

					Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Alan 2</label>"
							sorgu = "select DISTINCT(ogrenciAlan2) from bilsem.ogrenci where ogrenciAlan2 <> '' and ogrenciAlan2 is not null and silindi = 0 and firmaID = " & firmaID & " order by ogrenciAlan2 ASC"
							rs.open sorgu,sbsv5,1,3
								degerler = "Alan Seçin=|"
								do while not rs.eof
									degerler = degerler & rs("ogrenciAlan2")
									degerler = degerler & "="
									degerler = degerler & rs("ogrenciAlan2")
									degerler = degerler & "|"
								rs.movenext
								loop
								degerler = left(degerler,len(degerler)-1)
								call formselectv2("ogrenciAlan2",ogrenciAlan2,"","","mt5","","ogrenciAlan2",degerler,"")
							rs.close
						Response.Write "</div>"
					Response.Write "</div>"

					Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Alan 3</label>"
							sorgu = "select DISTINCT(ogrenciAlan3) from bilsem.ogrenci where ogrenciAlan3 <> '' and ogrenciAlan3 is not null and silindi = 0 and firmaID = " & firmaID & " order by ogrenciAlan3 ASC"
							rs.open sorgu,sbsv5,1,3
								degerler = "Alan Seçin=|"
								do while not rs.eof
									degerler = degerler & rs("ogrenciAlan3")
									degerler = degerler & "="
									degerler = degerler & rs("ogrenciAlan3")
									degerler = degerler & "|"
								rs.movenext
								loop
								degerler = left(degerler,len(degerler)-1)
								call formselectv2("ogrenciAlan3",ogrenciAlan3,"","","mt5","","ogrenciAlan3",degerler,"")
							rs.close
						Response.Write "</div>"
					Response.Write "</div>"

					Response.Write "<div class=""col-lg-3 col-md-3 col-sm-6 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Program 1</label>"
							sorgu = "select DISTINCT(ogrenciProgram1) from bilsem.ogrenci where ogrenciProgram1 <> '' and ogrenciProgram1 is not null and silindi = 0 and firmaID = " & firmaID & " order by ogrenciProgram1 ASC"
							rs.open sorgu,sbsv5,1,3
								degerler = "Alan Seçin=|"
								do while not rs.eof
									degerler = degerler & rs("ogrenciProgram1")
									degerler = degerler & "="
									degerler = degerler & rs("ogrenciProgram1")
									degerler = degerler & "|"
								rs.movenext
								loop
								degerler = left(degerler,len(degerler)-1)
								call formselectv2("ogrenciProgram1",ogrenciProgram1,"","","mt5","","ogrenciProgram1",degerler,"")
							rs.close
						Response.Write "</div>"
					Response.Write "</div>"

					Response.Write "<div class=""col-lg-3 col-md-3 col-sm-6 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Program 2</label>"
							sorgu = "select DISTINCT(ogrenciProgram2) from bilsem.ogrenci where ogrenciProgram2 <> '' and ogrenciProgram2 is not null and silindi = 0 and firmaID = " & firmaID & " order by ogrenciProgram2 ASC"
							rs.open sorgu,sbsv5,1,3
								degerler = "Alan Seçin=|"
								do while not rs.eof
									degerler = degerler & rs("ogrenciProgram2")
									degerler = degerler & "="
									degerler = degerler & rs("ogrenciProgram2")
									degerler = degerler & "|"
								rs.movenext
								loop
								degerler = left(degerler,len(degerler)-1)
								call formselectv2("ogrenciProgram2",ogrenciProgram2,"","","mt5","","ogrenciProgram2",degerler,"")
							rs.close
						Response.Write "</div>"
					Response.Write "</div>"

					Response.Write "<div class=""col-lg-3 col-md-3 col-sm-6 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Program 3</label>"
							sorgu = "select DISTINCT(ogrenciProgram3) from bilsem.ogrenci where ogrenciProgram3 <> '' and ogrenciProgram3 is not null and silindi = 0 and firmaID = " & firmaID & " order by ogrenciProgram3 ASC"
							rs.open sorgu,sbsv5,1,3
								degerler = "Alan Seçin=|"
								do while not rs.eof
									degerler = degerler & rs("ogrenciProgram3")
									degerler = degerler & "="
									degerler = degerler & rs("ogrenciProgram3")
									degerler = degerler & "|"
								rs.movenext
								loop
								degerler = left(degerler,len(degerler)-1)
								call formselectv2("ogrenciProgram3",ogrenciProgram3,"","","mt5","","ogrenciProgram3",degerler,"")
							rs.close
						Response.Write "</div>"
					Response.Write "</div>"

					Response.Write "<div class=""col-lg-3 col-md-3 col-sm-6 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Program 4</label>"
							sorgu = "select DISTINCT(ogrenciProgram4) from bilsem.ogrenci where ogrenciProgram4 <> '' and ogrenciProgram4 is not null and silindi = 0 and firmaID = " & firmaID & " order by ogrenciProgram4 ASC"
							rs.open sorgu,sbsv5,1,3
								degerler = "Alan Seçin=|"
								do while not rs.eof
									degerler = degerler & rs("ogrenciProgram4")
									degerler = degerler & "="
									degerler = degerler & rs("ogrenciProgram4")
									degerler = degerler & "|"
								rs.movenext
								loop
								degerler = left(degerler,len(degerler)-1)
								call formselectv2("ogrenciProgram4",ogrenciProgram4,"","","mt5","","ogrenciProgram4",degerler,"")
							rs.close
						Response.Write "</div>"
					Response.Write "</div>"


					Response.Write "<div class=""col-lg-12 col-md-12 col-sm-6 col-xs-12 mb10"">"
						Response.Write "<div class=""mt10"">"
						Response.Write "<label class=""label label-danger"">Öğrenciye Özel Girilen Not</label>"
							call formtextarea("ogrenciOzelNot",ogrenciOzelNot,"","Öğrenciye Özel Girilen Not","form-control","","","")
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