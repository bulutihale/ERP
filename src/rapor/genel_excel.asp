<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    ' call sessiontest()
    kid				=	kidbul()
    modulAd 		=   "Raporlar"
	' yetkiKontrol    =	yetkibul("Raporlar")
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


'## misafir girişi için ID transferi
    if Session("raporID") <> "" then
        gorevID = Session("raporID")
    end if
'## misafir girişi için ID transferi

Response.Flush()

if gorevID = "" then
    call yetkisizGiris("Ulaşmaya Çalıştığınız Rapor Bulunamadı","","")
else
	'### RAPOR BİLGİLERİNİ AL
        sorgu = "Select raporAd,raporSQL,entegrasyonDB,sayac,dosyaAdi,misafirErisimi from rapor.raporIndex where raporID = " & gorevID
        rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount > 0 then
                raporAd     	=   rs("raporAd")
                raporSQL    	=   rs("raporSQL")
                entegrasyonDB	=	rs("entegrasyonDB")
                misafirErisimi	=	rs("misafirErisimi")
                dosyaAdi    	=	rs("dosyaAdi")
                rs("sayac")		=	rs("sayac") + 1
                rs.update
            end if
        rs.close
	'### RAPOR BİLGİLERİNİ AL
	'### YETKİ KONTROLÜ YAP
        if misafirErisimi = false then
            sorgu = "Select count(*) from rapor.raporYetki where raporID = " & gorevID & " and kid = " & kid
            rs.open sorgu, sbsv5, 1, 3
                yetkiRapor = rs(0)
            rs.close
        else
            yetkiRapor = 1
        end if
	'### YETKİ KONTROLÜ YAP
	if yetkiRapor = 0 then
		call yetkisizGiris("Bu Raporu Görme Yetkiniz Yok : " & raporAd,"","")
	else
		' if yetkiKontrol > 0 then
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
                    sonuc = ""
                    sonuc = sonuc & "<!DOCTYPE html><html lang=""en""><head><meta charset=""utf-8"">" & vbcrlf
                    sonuc = sonuc & "</head>" & vbcrlf
                    sonuc = sonuc & "<body>" & vbcrlf
                    sonuc = sonuc & "<table border=""1"" align=""center"" style=""font-size:10px;"" cellpadding=""0"" cellspacing=""0"">" & vbcrlf
                        sonuc = sonuc & "<tr>" & vbcrlf
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
                                sonuc = sonuc & "<th scope=""col"">" & baslik & "</th>" & vbcrlf
                            next
                        sonuc = sonuc & "</tr>" & vbcrlf
						if rs.recordcount > 0 then
							for i = 1 to rs.recordcount
                                sonuc = sonuc & "<tr>" & vbcrlf
								for ti = 0 to ubound(raporBasliklarArr)
                                    sonuc = sonuc & "<td>"
                                    sonuc = sonuc & rs(ti)
                                    sonuc = sonuc & "</td>" & vbcrlf
								next
                                sonuc = sonuc & "</tr>" & vbcrlf
							rs.movenext
							next
						end if
                    sonuc = sonuc & "</table>" & vbcrlf
                    sonuc = sonuc & "</body>" & vbcrlf
                    sonuc = sonuc & "</html>"
            rs.close
            '#### DOSYA KONTROL
                if klasorkontrol("/temp/dosya/" & firmaID) = false then
                    call klasorolustur("/temp/dosya/" & firmaID)
                end if
            '#### DOSYA KONTROL
            Set objStream = server.CreateObject("ADODB.Stream")
            objStream.Open
            objStream.CharSet = "UTF-8"
                objStream.WriteText sonuc
            objStream.SaveToFile Server.Mappath("/temp/dosya/" & firmaID & "/" & dosyaAdi),2
            objStream.Close
            set objStream = Nothing
            '####
                if misafirErisimi = true then
                    Response.Write "<div class=""container mt-5"">"
                        Response.Write "<div class=""row mt-2"">"
                        Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
                            Response.Write "<div class=""card"">"
                            Response.Write "<div class=""card-header text-white bg-primary"">" & raporAd & "</div>"
                            Response.Write "<div class=""card-body"">"
                                Response.Write "<div class=""row"">"
                                    Response.Write "<div class=""col-lg-12"">"
                                        Response.Write "<a href=""" & "/temp/dosya/" & firmaID & "/" & dosyaAdi & """ target=""_blank"" class=""btn btn-warning form-control"">Excel Dosyasını İndir</a>"
                                    Response.Write "</div>"
                                    call clearfix()
                                Response.Write "</div>"
                            Response.Write "</div>"
                            Response.Write "</div>"
                        Response.Write "</div>"
                        Response.Write "</div>"
                    Response.Write "</div>"
                else
                    Response.Write "<a href=""" & "/temp/dosya/" & firmaID & "/" & dosyaAdi & """>"
                    Response.Write "Buraya tıklayarak dosyayı indirebilirsiniz"
                    Response.Write "</a>"
                end if
            '####
		' else
		' 	call yetkisizGiris("Raporu Görme Yetkiniz Yok","","")
		' end if
	end if
end if




%><!--#include virtual="/reg/rs.asp" -->