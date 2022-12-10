<!--#include virtual="/reg/rs.asp" -->
<%
Response.Charset="utf-8"
Response.codepage=65001

Response.Write "<style>"
	'Response.Write "page[size=""A6""] {"
	'Response.Write "width: 10.5cm;"
	'Response.Write "height: 14.8cm;"
	'Response.Write "}"

	Response.Write "page {background: white;"
		Response.Write "display: block; margin: auto auto; margin-bottom: 0.5cm; box-shadow: 0 0 0.5cm rgba(0,0,0,0.5);padding:0 1cm 0 0.5cm;"
		Response.Write "height: 14.8cm;"
		Response.Write "width: 10.5cm;"
		Response.Write "background-color:#FFFFFF;}"

	Response.Write "@media print {"
		Response.Write "body * {"
    	Response.Write "visibility: hidden;"
	Response.Write "}"

  Response.Write "#printSection,"
	Response.Write "#printSection * {"
		Response.Write "visibility: visible;"
	Response.Write "}"

  Response.Write "#printSection {"
    Response.Write "position: absolute;"
	'Response.Write "top: 3cm;"
	'Response.Write "bottom: 3cm;"
    Response.Write "left: 0;"
    Response.Write "top: 0;"
    Response.Write "width: 100%;"
    Response.Write "height: 100%;"
  Response.Write "}"

  	Response.Write "@page {"
		'Response.Write "size: 5.5in 8.5in;"
		Response.Write "margin-top: 27mm;"
		'Response.Write "font-size:2em;"
	Response.Write "}"

	Response.Write ".style1 {"
		Response.Write "font-size:24px;"
		Response.Write "height:30px;"
	Response.Write "}"

	Response.Write ".style2 {"
		Response.Write "font-size:28px;"
	Response.Write "}"

	Response.Write ".style3 {"
		'Response.Write "margin-top:7cm;"

	Response.Write "position: absolute;"
    Response.Write "left: 0;"
    Response.Write "bottom: 0;"
    'Response.Write "height: 50px;"
    'Response.Write "width: 100%;"
    'Response.Write "overflow:hidden;"
	Response.Write "}"
	
Response.Write "}"
Response.Write "</style>"

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
	receteID		=	Request.QueryString("receteID")

	modulAd =   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Son Ürün Etiketi Görüntüleme")


yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
Response.Write "<page size=""A6"">"
	if hata = "" and yetkiKontrol > 0 then
	Response.Write "<button class=""btn btn-warning pointer"" onclick=""window.print()"">YAZDIR</button>"

	sorgu = "SELECT t1.etiketAd, t1.miktar, t1.miktarBirim, t2.receteAd, t3.stokAd"
	sorgu = sorgu & " FROM recete.receteAdim t1"
	sorgu = sorgu & " INNER JOIN recete.recete t2 ON t1.receteID = t2.receteID"
	sorgu = sorgu & " INNER JOIN stok.stok t3 ON t2.stokID = t3.stokID"
	sorgu = sorgu & " WHERE t1.receteID = " & receteID & " AND t1.etiketeEkle = 1 ORDER BY sira"
	rs.open sorgu,sbsv5,1,3
		if rs.recordcount > 0 then
		Response.Write "<div class=""page"" id=""printSection"">"
			Response.Write "<table width=""100%"" style=""height:350px;"">"
				Response.Write "<thead><tr>"
					Response.Write "<th class=""style2"" style=""text-align: center;text-decoration: underline;"">" & rs("stokAd") & "</th>"
				Response.Write "</tr></thead>"
				Response.Write "<tbody>"
					for di = 1 to rs.recordcount
						receteAd	=	rs("receteAd")
						etiketAd	=	rs("etiketAd")
						miktar		=	rs("miktar")
						miktarBirim	=	rs("miktarBirim")

					Response.Write "<tr class=""style1"">"
						Response.Write "<td>" & etiketAd & "</td>"
						Response.Write "<td>" & miktar & "</td>"
						Response.Write "<td>" & miktarBirim & "</td>"
					Response.Write "</tr>"
					rs.movenext
					next
					
				Response.Write "</tbody>"
			Response.Write "</table>"
	
			Response.Write "<table class=""style3"" width=""100%"">"
				Response.Write "<tr>"
					Response.Write "<td>"
						Response.Write "<img id=""imageLogo"" src=""/template/images/clock-sand-icon.png"" height=""15"" width=""10"">"
					Response.Write "</td>"
					Response.Write "<td>Üretim Tarih</td>"
					Response.Write "<td>REF</td>"
					Response.Write "<td>REF KOD</td>"
				Response.Write "</tr>"
				Response.Write "<tr>"
					Response.Write "<td>LOT</td>"
					Response.Write "<td>LOT no</td>"
					Response.Write "<td>"
						Response.Write "<img id=""imageLogo"" src=""/template/images/factory.png"" height=""10"" width=""15"">"
					Response.Write "</td>"
				Response.Write "</tr>"
			Response.Write "</table>"
			Response.Write "</div>"
		end if
	rs.close
	
	else
		call yetkisizGiris("","","")
		hata = 1
	end if
Response.Write "</page>"
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

