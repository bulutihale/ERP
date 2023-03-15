<!--#include virtual="/reg/rs.asp" --><%

'	Response.Flush()
	kid						=	kidbul()
	ihaleID64				=	Request.QueryString("ihaleID")
	ihaleID					=	ihaleID64
	ihaleID					=	base64_decode_tr(ihaleID64)










	sorgu = "SELECT g.id as gorusmelerID, g.gorusmeTarihi, g.gorusmeIcerik, g.gorusulenKisi, g.sonrakiAramaTarihi, ISNULL(g.sonrakiAramaID,0) as sonrakiAramaID, k.ad as kullanici"_
	&" FROM dosya.gorusmeler g"_
	&" INNER JOIN personel.personel k ON g.kid = k.id"_
	&" WHERE g.ihaleID = " & ihaleID &""_
	&" ORDER BY g.id DESC"
	rs.open sorgu,sbsv5,1,3
	
	
	
	for ti = 1 to rs.recordcount
	
	sonrakiAramaID	=	rs("sonrakiAramaID")
	
	if not isnull(rs("sonrakiAramaTarihi")) AND sonrakiAramaID = 0 then 
		bg_color 	= 	"bg-danger"
		butonDurum 	=	""
	else
		bg_color	=	""
		butonDurum	=	"d-none"
	end if
	
	Response.Write "<table id=""table_"&rs("gorusmelerID")&""" class=""tableGorusme fontkucuk2 "&bg_color&""">"
		Response.Write "<tr><td>Görüşme:</td><td>" & rs("gorusmeTarihi") & "</td></tr>"
		Response.Write "<tr><td>Görüşülen:</td><td>" & rs("gorusulenKisi") & "</td></tr>"
		Response.Write "<tr><td>Görüşen:</td><td>" & rs("kullanici") & "</td></tr>"
		Response.Write "<tr><td>İçerik:</td><td>" & rs("gorusmeIcerik") & "</td></tr>"
		Response.Write "<tr><td>Tekrar Ara:</td><td>" & rs("sonrakiAramaTarihi") & "</td>"
		Response.Write "<td><div class=""btn btn-sm bg-success m-0 p-0 rounded fontkucuk2 "&butonDurum&""" onclick=""$('#oncekiGorusmeID').val("&rs("gorusmelerID")&");$('#divYeniKayit').hide('slow').show('slow');$('#butonYeniGorusme').hide('slow');"">takip görüşmesi</div>"
		if sonrakiAramaID > 0 then
			Response.Write "<span class=""gorusmeGoster fontkucuk2 bg-info btn btn-sm m-0 p-0 rounded"" data-sonrakiaramaid="""&sonrakiAramaID&""">Görüşmeyi Göster</span>"
		end if
		Response.Write "</td>"
		Response.Write "</tr>"
	Response.Write "</table>"
	Response.Write "<hr>"
	rs.movenext
	next
	rs.close
	



%>

