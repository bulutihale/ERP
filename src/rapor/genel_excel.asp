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
                ' ############# EXCEL İŞLERİ
                    ExcelFile = Server.Mappath("/temp/dosya/" & firmaID & "/" & dosyaAdi)
                    call dosyakopyala("/temp/sablon.xlsx","/temp/dosya/" & firmaID & "/" & dosyaAdi)
                    ilktabload  =   "Sayfa1"
                    Set ExcelConnection = Server.CreateObject("ADODB.Connection")
                    ' ExcelConnection.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & ExcelFile & ";Extended Properties=""Excel 12.0; HDR=Yes; IMEX=3; MODE=Share; READONLY=False"";"
                    ExcelConnection.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & ExcelFile & ";Extended Properties=""Excel 8.0;HDR=No;"";"
                    Set rsx = Server.CreateObject("ADODB.Recordset")
                    Set rsx2 = Server.CreateObject("ADOX.Catalog")
                    rsx2.ActiveConnection = ExcelConnection
                    ' ######### İLK SAYFA ADINI ÖĞREN
                        For tnum = 0 To rsx2.Tables.count - 1
                            Set tbl = rsx2.Tables(tnum)
                            ilktabload = tbl.Name
                            exit for
                        Next
                    ' ######### İLK SAYFA ADINI ÖĞREN
                    '######## BAŞLIKLARI OLUŞTUR
                        rsx.open "SELECT * FROM [" & ilktabload & "]",ExcelConnection, 3,3
                            raporBasliklar = raporSQL
                            raporBasliklar1 = instr(raporBasliklar,"--:")
                            raporBasliklar = right(raporBasliklar,((len(raporBasliklar)-2)-raporBasliklar1))
                            raporBasliklar1 = instr(raporBasliklar,":--")
                            raporBasliklar = left(raporBasliklar,raporBasliklar1-1)
                            raporBasliklarArr = Split(raporBasliklar,",")
                            rsx.movefirst
                            for ri = 0 to ubound(raporBasliklarArr)
                                if instr(raporBasliklarArr(ri)," as ") > 0 then
                                    baslikArr = Split(raporBasliklarArr(ri)," as ")
                                    baslik = baslikArr(1)
                                    baslik = Replace(baslik,"'","")
                                else
                                    baslik = raporBasliklarArr(ri)
                                end if
                                rsx.Fields(ri).value =   baslik
                            next
                        rsx.update
                    '######## BAŞLIKLARI OLUŞTUR
                    '######## BAŞLIKLARI TEMİZLE
                        rsx.movefirst
                        for i = ubound(raporBasliklarArr)+1 to 9
                            rsx.Fields(i).value = ""
                        next
                        rsx.update
                    '######## BAŞLIKLARI TEMİZLE
                    '######## DATA INSERT
                        if rs.recordcount > 0 then
                            for i = 1 to rs.recordcount
                                rsx.addnew
                                for ti = 0 to ubound(raporBasliklarArr)
                                    rsx.Fields(ti).value = rs(ti)
                                next
                                rsx.update
                            rs.movenext
                            next
                        end if
                    '######## DATA INSERT
                    rsx.close
                ' ############# EXCEL İŞLERİ
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