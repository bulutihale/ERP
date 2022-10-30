<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

kid = kidbul()

Response.Flush()

    mesaj = "Bildirimler inceleniyor"
    call logla(mesaj)


	'#### TABLO
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
		Response.Write "<table class=""table table-sm table-striped table-bordered table-hover mt10""><thead><tr>"
		Response.Write "<th>Tarih</th>"
		Response.Write "<th>Gönderici</th>"
		Response.Write "<th>Alıcı</th>"
		Response.Write "<th>Önem</th>"
		Response.Write "<th>Başlik</th>"
		Response.Write "<th>İçerik</th>"
		Response.Write "<th>Durum</th>"
		Response.Write "</tr></thead><tbody>"
		sorgu = "Select * from portal.notificationList where firmaID = '" & firmaID & "' and (kid = " & kid & " or gonderenKid = " & kid & ") order by tarih DESC"
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount > 0 then
		for ri = 1 to rs.recordcount
			Response.Write "<tr>"
			Response.Write "<td>" & rs("tarih") & "</td>"
			Response.Write "<td>" & rs("gonderen") & "</td>"
			Response.Write "<td>" & rs("alici") & "</td>"
			Response.Write "<td>" & rs("onem") & "</td>"
			Response.Write "<td>" & rs("baslik") & "</td>"
			Response.Write "<td>" & rs("icerik") & "</td>"
			Response.Write "<td>" & rs("okundu") & "</td>"
			Response.Write "</td>"
			Response.Write "</tr>"
		rs.movenext
		next
		end if
		rs.close
		Response.Write "</table>"
				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	'#### TABLO

%><!--#include virtual="/reg/rs.asp" -->