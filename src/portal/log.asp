<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

kid = kidbul()

Server.ScriptTimeout = 60000
Response.Flush()

yetki = yetkibul("manager")



	'#### TABLO
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
		Response.Write "<table class=""table table-sm table-striped table-bordered table-hover mt10""><thead><tr>"
		Response.Write "<th>Tarih</th>"
		Response.Write "<th>Kid</th>"
		Response.Write "<th>&nbsp;</th>"
		Response.Write "<th>İşlem</th>"
		Response.Write "<th>ip</th>"
		Response.Write "<th>Konum</th>"
		Response.Write "<th>İşlem</th>"
		Response.Write "</tr></thead><tbody>"
			sorgu = "Select" & vbcrlf
			sorgu = sorgu & "top(400)" & vbcrlf
			sorgu = sorgu & "personel.personel_log.Tarih" & vbcrlf
			sorgu = sorgu & ",personel.personel.ad as kidAd" & vbcrlf
			sorgu = sorgu & ",personel.personel_log.personelID" & vbcrlf
			sorgu = sorgu & ",personel.personel_log.modulAd" & vbcrlf
			sorgu = sorgu & ",portal.menuler.icon" & vbcrlf
			sorgu = sorgu & ",personel.personel_log.modulID" & vbcrlf
			sorgu = sorgu & ",personel.personel_log.islem" & vbcrlf
			sorgu = sorgu & ",personel.personel_log.IP" & vbcrlf
			sorgu = sorgu & ",personel.personel_log.geoIPdistrict" & vbcrlf
			sorgu = sorgu & "from personel.personel_log" & vbcrlf
			sorgu = sorgu & "LEFT JOIN personel.personel on personel.personel.id = personel.personel_log.personelID" & vbcrlf
			sorgu = sorgu & "LEFT JOIN portal.menuler on portal.menuler.id = personel.personel_log.modulID" & vbcrlf
			sorgu = sorgu & "where personel.personel_log.firmaID = " & firmaID & vbcrlf
			if yetki > 5 then
			else
				sorgu = sorgu & "and personel.personel_log.personelID <> 0" & vbcrlf
				sorgu = sorgu & "and personel.personel_log.personelID " & kid & vbcrlf
			end if
			sorgu = sorgu & "order by personel.personel_log.id DESC" & vbcrlf
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount > 0 then
		gi = 0
		for ri = 1 to rs.recordcount
			'icon tamir
				if rs("modulAd") <> "" and rs("modulID") = null then
					sorgu = "Select top 1 modulID from personel.personel_log where modulID is not null and modulAd = '" & rs("modulAd") & "'"
					rs2.open sorgu,sbsv5,1,3
					if rs2.recordcount > 0 then
						rs("modulID") = rs2("modulID")
						rs.update
					end if
					rs2.close
				end if
			'icon tamir



			Response.Write "<tr>"
			Response.Write "<td>" & rs("tarih") & "</td>"
			Response.Write "<td>"
			if kid = rs("personelID") then
				Response.Write "<i class=""icon medal-gold-1 mr-1""></i>"
			end if
			Response.Write rs("kidAd") & "</td>"
			if rs("icon") <> "" then
				Response.Write "<td><i class=""" & rs("icon") & """></i></td>"
			else
				Response.Write "<td>&nbsp;</td>"
			end if
			Response.Write "<td>" & rs("islem") & "</td>"
			Response.Write "<td>" & rs("ip")
			Response.Write "</td>"
			if rs("geoIPdistrict") = "" or isnull(rs("geoIPdistrict")) = true then
				geoIPdistrict = geoIP("sehir",rs("ip"))
				sorgu = "update personel.personel_log set geoIPdistrict = '" & geoIPdistrict & "' where ip = '" & rs("ip") & "'"
				rs2.open sorgu,sbsv5,3,3
				Response.Write "<td>" & geoIPdistrict & "</td>"
				gi = gi + 1
				if gi = 20 then
					exit for
				end if
			else
				Response.Write "<td>" & rs("geoIPdistrict") & "</td>"
			end if
			Response.Write "</td>"
			Response.Write "<td>"
			Response.Write "<i class=""icon exclamation"""
			if yetki = 9 then
				Response.Write " onClick="""""
			end if
			Response.Write "></i>"
			Response.Write "</td>"
			Response.Write "</tr>"
			Response.Flush()
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

'end if

%><!--#include virtual="/reg/rs.asp" -->