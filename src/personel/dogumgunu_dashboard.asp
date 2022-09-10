<!--#include virtual="/reg/rs.asp" --><%

    sorgu = "Select ad,dogumGunu,yer,username from personel.personel where firmaID = " & firmaID & " and month(dogumGunu) = " & month(date()) & " and day(dogumGunu) >= day(getdate()) order by day(dogumGunu)"
	rs.Open sorgu, sbsv5, 1, 3
    if rs.recordcount > 0 then



		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-dark""><a style=""color:white"">Nice Mutlu Yıllara</a></div>"
				Response.Write "<div class=""card-body"" style=""height:250px;padding:0 !important"">"




        Response.Write "<div class=""cycle_s1 col"" style=""min-height:250px"">"
        for i = 1 to rs.recordcount
            ad = rs("ad")
            dogumGunu = rs("dogumGunu")
            username = rs("username")
            yer = rs("yer")
            Response.Write "<div class=""col"" style=""background-color:white;"">"
                dosyaad = "/temp/personel/" & username & ".jpg"
                if dosyakontrol(dosyaad) = True then
                    Response.Write "<div><img src=""" & dosyaad & """ class=""img-fluid mx-auto d-block"" style=""width:140px;height:195px"" /></div>"
                else
                    Response.Write "<div><img src=""/temp/personel/john.doe.jpg"" class=""img-fluid mx-auto d-block"" style=""width:140px;"" /></div>"
                end if
                Response.Write "<div class=""text-center text-info"">" & day(dogumGunu) & " " & aylaruzun(month(dogumGunu)) & "<br /><strong>" & ad & "<br />" & yer & "</strong></div>"
            Response.Write "</div>"
        rs.movenext
        next
        Response.Write "</div>"



				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"


    end if
    rs.close






%>
