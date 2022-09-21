<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
	' cariID			=	Request.Form("cariID")
	' gorevID			=	Request.QueryString("gorevID")
    kid				=	kidbul()
    modulAd 		=   "Raporlar"
	yetkiKontrol    =	yetkibul(modulAd)
	yetkiRapor		=	0
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET
	if hata = "" then
		if gorevID = "" then
			gorevID64 = Session("sayfa5")
			if gorevID64 = "" then
			else
				gorevID		=	gorevID64
				gorevID		=	base64_decode_tr(gorevID)
				if isnumeric(gorevID) = False then
					gorevID		=	""
				end if
			end if
		else
			if isnumeric(gorevID) = False then
				gorevID		=	base64_decode_tr(gorevID)
			end if
			gorevID		=	int(gorevID)
			gorevID64	=	gorevID
			gorevID64	=	base64_encode_tr(gorevID64)
		end if
	end if
'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET


if gorevID = "" then
    call yetkisizGiris("Ulaşmaya Çalıştığınız Rapor Bulunamadı","","")
else
	'### YETKİ KONTROLÜ YAP
	'### YETKİ KONTROLÜ YAP
	sorgu = "Select count(*) from rapor.raporYetki where raporID = " & gorevID & " and kid = " & kid
	rs.open sorgu, sbsv5, 1, 3
		yetkiRapor = rs(0)
	rs.close
	'### YETKİ KONTROLÜ YAP
	'### YETKİ KONTROLÜ YAP
	'### RAPOR BİLGİLERİNİ AL
	'### RAPOR BİLGİLERİNİ AL
	sorgu = "Select raporAd,raporSQL from rapor.raporIndex where raporID = " & gorevID
	rs.open sorgu, sbsv5, 1, 3
		if rs.recordcount > 0 then
			raporAd     =   rs("raporAd")
			raporSQL    =   rs("raporSQL")
		end if
	rs.close
	'### RAPOR BİLGİLERİNİ AL
	'### RAPOR BİLGİLERİNİ AL


	if yetkiRapor = 0 then
		call yetkisizGiris("Bu Raporu Görme Yetkiniz Yok : " & raporAd,"","")
	else
		if yetkiKontrol > 0 then
            rs.open raporSQL, sbsv5, 1, 3
			Response.Write "<div class=""container-fluid"">"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
					Response.Write "<div class=""card"">"
					Response.Write "<div class=""card-body"">"
					Response.Write "<div class=""row"">"
						Response.Write "<div class=""table-responsive"">"
						Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
						raporBasliklar = raporSQL
						raporBasliklar = Replace(raporBasliklar,"select ","")
						raporBasliklar1 = instr(raporBasliklar," from ")
						raporBasliklar = left(raporBasliklar,raporBasliklar1)
						raporBasliklarArr = Split(raporBasliklar,",")
						for ri = 0 to ubound(raporBasliklarArr)
							if instr(raporBasliklarArr(ri)," as ") > 0 then
								baslikArr = Split(raporBasliklarArr(ri)," as ")
								baslik = baslikArr(1)
								baslik = Replace(baslik,"'","")
							else
								baslik = raporBasliklarArr(ri)
							end if
							Response.Write "<th scope=""col"">" & baslik & "</th>"
						next
						Response.Write "</tr></thead><tbody>"
						if rs.recordcount > 0 then
							for i = 1 to rs.recordcount
							Response.Write "<tr>"
								for ti = 0 to ubound(raporBasliklarArr)
									Response.Write "<td>"
									Response.Write rs(ti)
									Response.Write "</td>"
								next
							Response.Write "</tr>"
							rs.movenext
							next
						end if
						Response.Write "</tbody>"
						Response.Write "</table>"
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "</div>"
            rs.close
		else
			call yetkisizGiris("Raporu Görme Yetkiniz Yok","","")
		end if
	end if
end if




%><!--#include virtual="/reg/rs.asp" -->