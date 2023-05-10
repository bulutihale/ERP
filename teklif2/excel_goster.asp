<!--#include virtual="/reg/rs.asp" --><%

Server.ScriptTimeout = 1200

Response.Charset = "utf-8"


Response.Flush()

'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr = Split(kidarr,"#")
		musteriID			=	kidarr(0)
		mtimeout			=	kidarr(1)
		kad					=	kidarr(2)
		sayfaKayitSayisi	=	int(kidarr(3))
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr

	id64					=	Request.QueryString("id")
	id						=	id64
	ihaleID					=	base64_decode_tr(id)
	
	
'####### anahtar_kelime TABLOSU ÇEK	
'####### anahtar_kelime TABLOSU ÇEK	
				sorgu = "Select anahtarKelime from anahtar_kelime WHERE musteriID = " & musteriID
				rs.open sorgu,sbsv5,1,3
				if rs.recordcount > 0 then
					for i = 1 to rs.recordcount
						degerler =  rs("anahtarKelime") &"|"&degerler
					rs.movenext
					next
				rs.close
				degerler = left(degerler,len(degerler)-1)
				end if
				anahtarKelimeListe = degerler

'####### /anahtar_kelime TABLOSU ÇEK	
'####### /anahtar_kelime TABLOSU ÇEK	

f 			= Request.QueryString("f")
ExcelFile 	= Server.Mappath(f)

	Set ExcelConnection = Server.CreateObject("ADODB.Connection")
	ExcelConnection.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & ExcelFile & ";Extended Properties=""Excel 12.0 Xml;HDR=YES"";"
	Set rsx = Server.CreateObject("ADODB.Recordset")
	Set rsx2 = Server.CreateObject("ADOX.Catalog")
	rsx2.ActiveConnection = ExcelConnection



	For tnum = 0 To rsx2.Tables.count - 1
		Set tbl = rsx2.Tables(tnum)
		ilktabload = tbl.Name
		exit for
	Next
	


	rsx.open "SELECT * FROM [" & ilktabload & "]",ExcelConnection
	
	sutunsayi = 0
	FOR EACH Field IN rsx.Fields
		sutunsayi = sutunsayi + 1
	NEXT
Response.Write "<button type=""button"" class=""close"" aria-label=""Close"">"
Response.Write "<span aria-hidden=""true"" onClick=""$('.urunlistediv').addClass('d-none');"">&times;</span>"
Response.Write "</button>"
call clearfix()
	Response.Write "<div class=""card"">"
	Response.Write "<div class=""card-body"">"
	Response.Write "<h5 class=""card-header"">Excel Ürün Listesi</h5>"
		Response.Write "<table class=""table-striped"" border=""1"">"
		Response.Write "<thead><tr class="""">"
		Response.Write "<th>"
		Response.Write "</th>"
		Response.Write "<th>"
		Response.Write "Sıra No"
		Response.Write "</th>"
		Response.Write "<th>"
		Response.Write "Ürün Adı"
		Response.Write "</th>"
		Response.Write "<th>"
		Response.Write "Miktar"
		Response.Write "</th>"
		Response.Write "<th>"
		Response.Write "Birim"
		Response.Write "</th>"
		Response.Write "</tr></thead><tbody>"
	di = 1
	do while not rsx.eof
		if rsx.eof then
			exit do
		end if
		if di = 1 then
			for ai = 0 to sutunsayi - 1
				if trim(rsx(ai).Name) = "Sıra" then
					ssira = ai
				end if
				if trim(rsx(ai).Name) = "Cinsi" then
					scinsi = ai
				end if
				if trim(rsx(ai).Name) = "Miktarı" then
					smiktari = ai
				end if
				if trim(rsx(ai).Name) = "Birim" then
					sbirim = ai
				end if
				if trim(rsx(ai).Name) = "Açıklama" then
					saciklama = ai
				end if
			next
			rsx.movenext
		end if

	if not isnull(rsx(ssira).value) then'boş sıra atla
		Response.Write "<tr>"
			if not isnull(rsx(ssira).value) AND isnull(rsx(scinsi).value) then
				kisimGelen		= 	rsx(ssira).value
				noktaNerede		=	instr(kisimGelen,".")
				
				kisimNo			=	mid(kisimGelen,1,noktaNerede-1)
		Response.Write "<td colspan=""3"">"
				Response.Write "<span class=""font-weight-bold"">"&rsx(ssira).value&"</span>"		'kısım no'yu yazdırmak için
		Response.Write "</td>"
			elseif not isnull(rsx(ssira).value) AND not isnull(rsx(scinsi).value) then
			
	'###### urunKaydet için ajax script detay.asp'de yer alıyor
	'###### urunKaydet için ajax script detay.asp'de yer alıyor
		Response.Write "<td>"
				Response.Write "<input type=""checkbox"" id="""&di&""" class=""urunKaydet"">"
		Response.Write "</td>"
	'###### urunKaydet için ajax script detay.asp'de yer alıyor
	'###### urunKaydet için ajax script detay.asp'de yer alıyor
		Response.Write "<td>"
				Response.Write rsx(ssira).value'sıra no'yu yazdırmak için.
		Response.Write "</td>"
				siraNo		= rsx(ssira).value
				
			end if
		Response.Write "<td>"
		
'###### anahtar kelime karşılaştırmaları
'###### anahtar kelime karşılaştırmaları

		anahtarKelime	= split(anahtarKelimeListe,"|")
		sonuc 	= 	0
		t 		=	0
		for zi = 0 to ubound(anahtarKelime)
			t = instr(lcase(rsx(scinsi).value),lcase(anahtarKelime(zi)))
			sonuc = sonuc + t
		next
		
'###### anahtar kelime karşılaştırmaları
'###### anahtar kelime karşılaştırmaları

			if sonuc > 0 then
				Response.Write "<span class=""bg-yellow"">"&rsx(scinsi).value&"</span>"
			else
				Response.Write rsx(scinsi).value
			end if
			cinsi	=	rsx(scinsi).value
			
		Response.Write "</td>"
		Response.Write "<td>"
			Response.Write rsx(smiktari).value
			miktar	=	rsx(smiktari).value
		Response.Write "</td>"
		Response.Write "<td>"
			Response.Write rsx(sbirim).value
			birim	=	rsx(sbirim).value
		Response.Write "</td>"
		Response.Write "<input id=""veri"&di&""" type=""hidden"" value="""&kisimNo&"|"&siraNo&"|"&cinsi&"|"&miktar&"|"&birim&""" "
		Response.Write "</tr>"
	end if'boş sıra atla
	di = di + 1
	rsx.movenext
	loop
	rsx.close
		Response.Write "</tbody></table>"
	Response.Write "</div>"
	Response.Write "<div class=""card-footer bg-transparent"">Excel Liste Sonu</div>"
	Response.Write "</div>"
%>
<script>
$(window).on('load', function(){
    $('#exceLoading').fadeOut(1000);
})
</script>


















