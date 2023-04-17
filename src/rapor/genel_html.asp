<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
    modulAd 		=   "Raporlar"
	yetkiKontrol    =	yetkibul(modulAd)
	yetkiRapor		=	0
'###### ANA TANIMLAMALAR


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


if gorevID = "" then
    call yetkisizGiris("Ulaşmaya Çalıştığınız Rapor Bulunamadı","","")
else
	'### YETKİ KONTROLÜ YAP
	sorgu = "Select count(*) from rapor.raporYetki where raporID = " & gorevID & " and kid = " & kid
	rs.open sorgu, sbsv5, 1, 3
		yetkiRapor = rs(0)
	rs.close
	'### YETKİ KONTROLÜ YAP
	'### RAPOR BİLGİLERİNİ AL
	sorgu = "Select raporAd,raporSQL,entegrasyonDB,sayac from rapor.raporIndex where raporID = " & gorevID
	rs.open sorgu, sbsv5, 1, 3
		if rs.recordcount > 0 then
			raporAd     	=   rs("raporAd")
			raporSQL    	=   rs("raporSQL")
			entegrasyonDB	=	rs("entegrasyonDB")
			rs("sayac")		=	rs("sayac") + 1
			rs.update
		end if
	rs.close
	'### RAPOR BİLGİLERİNİ AL
	if yetkiRapor = 0 then
		call yetkisizGiris("Bu Raporu Görme Yetkiniz Yok : " & raporAd,"","")
	else
		if yetkiKontrol > 0 then
			if entegrasyonDB = 0 then
            	rs.open raporSQL, sbsv5, 1, 3
			else
				sorgu = "Select * from portal.entegrasyonHariciDB where entegrasyonHariciDB = " & entegrasyonDB
            	rs.open sorgu, sbsv5, 1, 3
				if rs.recordcount > 0 then
					sunucu		=	rs("sunucu")
					database	=	rs("database")
					kullanici	=	rs("kullanici")
					sifre		=	rs("sifre")
					sunucu		=	base64_decode_tr(sunucu)
					database	=	base64_decode_tr(database)
					kullanici	=	base64_decode_tr(kullanici)
					sifre		=	base64_decode_tr(sifre)
				else
					hata = 1
				end if
				rs.close
				set sbsrapor=Server.CreateObject("ADODB.Connection")
				baglantibilgileri = "Provider=SQLOLEDB;Data Source=" & sunucu & ";Initial Catalog=" & database & ";User Id=" & kullanici & ";Password=" & sifre & ";"
				sbsrapor.Open baglantibilgileri
	            rs.open raporSQL, sbsrapor, 1, 3
			end if
			Response.Write "<div class=""container-fluid"">"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
					Response.Write "<div class=""card"">"
					Response.Write "<div class=""card-body"">"
					Response.Write "<div class=""row"">"
						Response.Write "<div class=""table-responsive"">"
						Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
						' --:Ürün Kodu,Ürün Adı,Güncel Liste Fiyatı,Birim,Ürün Barkodu,Ürün Grubu,Koli İçi Adet:--
						raporBasliklar = raporSQL
						raporBasliklar1 = instr(raporBasliklar,"--:")
						raporBasliklar = right(raporBasliklar,((len(raporBasliklar)-2)-raporBasliklar1))
						raporBasliklar1 = instr(raporBasliklar,":--")
						raporBasliklar = left(raporBasliklar,raporBasliklar1-1)
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
							Response.Flush()
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