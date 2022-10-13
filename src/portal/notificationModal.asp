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



    ' sorgu = "Select * from portal.notification where notificationID = " & gorevID
    sorgu = "Select okundu,onem,portal.notification.tarih,portal.notification.gonderenKid,portal.notification.kid,portal.notification.icerik,pp1.ad as gonderenAd,pp2.ad as hedefAd from portal.notification INNER JOIN personel.personel pp1 on pp1.id = portal.notification.gonderenKid INNER JOIN personel.personel pp2 on pp2.id = portal.notification.kid where notificationID = " & gorevID
    rs.Open sorgu, sbsv5, 1, 3
    if rs.recordcount > 0 then
            Response.Write "<div class=""container-fluid"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-" & renklerArr(rs("onem")) & """>"
                        Response.Write "Bildirim Ayrıntıları"
                    Response.Write "</div>"
                    Response.Write "<div class=""card-body"">"



		' Response.Write "<div class=""container-fluid"">"
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
				Response.Write rs("gonderenAd")
				Response.Write "</td>"
			Response.Write "</tr>"
			Response.Write "<tr>"
				Response.Write "<td>"
				Response.Write "Hedef"
				Response.Write "</td>"
				Response.Write "<td>"
				Response.Write rs("hedefAd")
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
		' Response.Write "</div>"



                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"


    rs("okundu") = 1
    rs.update

    end if
    rs.close




%><!--#include virtual="/reg/rs.asp" -->