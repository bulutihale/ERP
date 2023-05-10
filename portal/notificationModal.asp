<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    kid64	=	ID
    gorevID =   Request.QueryString("gorevID")
    hata    =   ""
    modulAd =   "portal"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

if gorevID = "" then
	Response.End()
end if
if isnumeric(gorevID) = False then
	Response.End()
end if



	sorgu = "Select * from portal.notificationList where notificationID = " & gorevID
    rs.Open sorgu, sbsv5, 1, 3
    if rs.recordcount > 0 then
            Response.Write "<div class=""container-fluid"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-"
						if rs("onem") = "Önemsiz" then
							Response.Write "warning"
						elseif rs("onem") = "Normal" then
							Response.Write "primary"
						elseif rs("onem") = "Önemli" then
							Response.Write "danger"
						end if
					Response.Write """>"
                        Response.Write "Bildirim Ayrıntıları"
                    Response.Write "</div>"
                    Response.Write "<div class=""card-body"">"



		Response.Write "<div class=""row"">"
		Response.Write "<div class=""col-lg-12 col-xs-12 mt10 mb10"">"
			Response.Write "<table class=""table table-striped table-bordered table-hover"">"
			Response.Write "<tr>"
				Response.Write "<td>"
				Response.Write "Tarih"
				Response.Write "</td>"
				Response.Write "<td>"
				Response.Write rs("tarih")
				Response.Write "</td>"
			Response.Write "</tr>"
			Response.Write "<tr>"
				Response.Write "<td>"
				Response.Write "Kaynak"
				Response.Write "</td>"
				Response.Write "<td>"
				Response.Write rs("gonderen")
				Response.Write "</td>"
			Response.Write "</tr>"
			Response.Write "<tr>"
				Response.Write "<td>"
				Response.Write "Hedef"
				Response.Write "</td>"
				Response.Write "<td>"
				Response.Write rs("alici")
				Response.Write "</td>"
			Response.Write "</tr>"
			Response.Write "<tr>"
				Response.Write "<td>"
				Response.Write "Bildirim"
				Response.Write "</td>"
				Response.Write "<td>"
				Response.Write rs("icerik")
				Response.Write "</td>"
			Response.Write "</tr>"
			Response.Write "</table>"
		Response.Write "</div>"
		Response.Write "</div>"

                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"

	'###### OKUNAN BİLDİRİMİ GİZLE
		komut = "$('.bildirimitem" & rs("notificationID") & "').remove();"
		call jsrun(komut)
	'###### OKUNAN BİLDİRİMİ GİZLE

    end if
    rs.close

	sorgu = "update portal.notification set okundu = 1 where notificationID = " & gorevID
	rs.Open sorgu, sbsv5, 3, 3


	'#### OKUNMAMIŞ BİLDİRİM KALMADIYSA, ÇANI KALDIR
    sorgu = "Select count(notificationID) from portal.notification where okundu = 0 and firmaID = " & firmaID & " and kid = " & kid
    rs.Open sorgu, sbsv5, 1, 3
        bildirimsayi = rs(0)
	rs.close
	'## sayıyı güncelle
		komut = "$('.bildirimsayi').text('" & bildirimsayi & "');"
		call jsrun(komut)
	'## sayıyı güncelle
	if bildirimsayi = 0 then
		komut = "$('.bildirimcontainer').addClass('d-none');"
		call jsrun(komut)
	end if
	'#### OKUNMAMIŞ BİLDİRİM KALMADIYSA, ÇANI KALDIR






%><!--#include virtual="/reg/rs.asp" -->