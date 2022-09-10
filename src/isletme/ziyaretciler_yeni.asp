<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Yeni Ziyaretci Ekranı")

yetkiGuvenlik = yetkibul("guvenlik")

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiGuvenlik > 5 then
		Response.Write "<form action=""/isletme/ziyaretciler_ekle.asp"" method=""post"" class=""ajaxform"">"
		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">Ziyaretci Adı Soyadı</span>"
		Response.Write "<input type=""text"" class=""form-control"" placeholder=""Ziyaretci Adı Soyadı"" name=""adSoyad"" value=""" & adSoyad & """>"
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
			sorgu = "Select departmanID,departmanAd from personel.departman where firmaID = " & firmaID & " order by departmanAd ASC"
			rs.open sorgu,sbsv5,1,3
			if rs.recordcount > 0 then
				Response.Write "<div class=""badge badge-secondary"">Ziyaret Edilen Departman</div>"
					degerler = "=|"
					do while not rs.eof
						degerler = degerler & rs("departmanAd")
    					degerler = degerler & "="
						degerler = degerler & rs("departmanID")
						degerler = degerler & "|"
					rs.movenext
				loop
				degerler = left(degerler,len(degerler)-1)
				call formselectv2("hedefBirim",departmanID,"","","","","hedefBirim",degerler,"")
			end if
			rs.close
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
							sorgu = "Select ad,id from personel.personel where firmaID = " & firmaID & " and expiration is null order by ad ASC"
							rs.open sorgu,sbsv5,1,3
							if rs.recordcount > 0 then
							Response.Write "<div class=""badge badge-secondary"">Ziyaret Edilen Personel</div>"
									degerler = "=|"
									do while not rs.eof
										degerler = degerler & rs("ad")
    									degerler = degerler & "="
										degerler = degerler & rs("id")
										degerler = degerler & "|"
									rs.movenext
									loop
									degerler = left(degerler,len(degerler)-1)
								call formselectv2("hedefPersonel",departmanID,"","","","","hedefPersonel",degerler,"")
							end if
							rs.close
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">Ziyaret Sebebi</span>"
		Response.Write "<input type=""text"" class=""form-control"" placeholder=""Ziyaret Sebebi"" name=""ziyaretSebebi"" value=""" & ziyaretSebebi & """>"
		Response.Write "</div>"
		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU















%><!--#include virtual="/reg/rs.asp" -->