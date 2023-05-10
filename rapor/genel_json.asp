<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Raporlar"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'##### uniq sorgu üret
	session("tabloislem") = session("tabloislem") + 1
'##### uniq sorgu üret

yetkiTeklif = yetkibul(modulAd)

orderalanar		=	Array("teklifsonuc","firmaad","teklifsayi","teklifturu","tarih","teklifkullad","id")

'##### gelen data
	start		=	Request.QueryString("start")'40 - 0
	length		=	Request.QueryString("length")'10 - 25
	orderalan	=	Request.QueryString("order[0][column]")'0-1-2-3
	ordertur	=	Request.QueryString("order[0][dir]")'asc-desc
	aramakelime	=	Request.QueryString("search[value]")'hi whatsup
	gorevID		=	Request.QueryString("id")'formID
'##### gelen data


if gorevID <> "" then
	gorevID = base64_decode_tr(gorevID)
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
		call logla("Yetkisiz açılmaa çalışılan rapor : " & raporAd)
	else
		call logla("Genel Rapor JSON : " & raporAd & " : " & aramakelime)
		'### VERİLERİ TOPARLAMA
		'### VERİLERİ TOPARLAMA
			if start = "" then
				start = 0
			end if
			if length = "" then
				length = 0
			end if
			length = int(length)
			if orderalan = "" then
				orderalan = "tarih"
			else
				orderalan = orderalanar(orderalan)
			end if
			if ordertur = "" then
				ordertur = "desc"
			end if
			dongu = 0
			ToplamKayit = 0
			ToplamSayfa = 0
		'### VERİLERİ TOPARLAMA
		'### VERİLERİ TOPARLAMA

		sorgu = "select top 10 firmaad,teklifsayi,teklifturu,tarih,teklifkullad from teklif.teklif where teklifsonuc = 4 and tarih > '2022-01-01' and silinmis = 0"
		rs.open sorgu, sbsv5, 1, 3
			if not rs.eof then
				ToplamKayit = 1'rs("ToplamKayit")
				ToplamSayfa = 1'rs("ToplamSayfa")
			end if
				Response.Write "{""draw"":" & session("tabloislem") & ",""recordsTotal"":" & ToplamKayit & ",""recordsFiltered"":" & ToplamKayit & ",""data"":["
					do While not rs.eof
						dongu = dongu + 1
						Response.Write "["
							' Response.Write """" & rs("teklifsonuc") & """"
							Response.Write """" & rs("firmaad") & """"
							Response.Write ",""" & rs("teklifsayi") & """"
							Response.Write ",""" & rs("teklifturu") & """"
							Response.Write ",""" & rs("tarih") & """"
							Response.Write ",""" & rs("teklifkullad") & """"
						Response.Write "]"
					rs.movenext
					if not rs.eof then
						Response.Write ","
					end if
					Loop
				Response.Write "]}"
		rs.close






	end if
end if


%><!--#include virtual="/reg/rs.asp" -->