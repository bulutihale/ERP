<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

    call sessiontest()
    kid		=	kidbul()

	modulAd 		=   "Fason" 

	'##### YETKİ BUL
	'##### YETKİ BUL
	yetkiKontrol	 = yetkibul(modulAd)
	'##### YETKİ BUL
	'##### YETKİ BUL

	islem			=	Request("islem")
	cariID			=	Request("cariID")
	fasonAnaID		=	Request("fasonAnaID")

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	if yetkiKontrol = 0 then
		call yetkisizGiris("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
	else

	sorgu = "SELECT t6.stokAd, t5.cariAd, t7.cariAd as fasonCariAd, t2.miktar as fasonMiktar, t3.mikBirim, t1.fasonAnaID"
	sorgu = sorgu & " FROM portal.ajanda t1"
	sorgu = sorgu & " INNER JOIN fason.fasonAna t2 ON t1.fasonAnaID = t2.id"
	sorgu = sorgu & " INNER JOIN teklif.siparisKalem t3 ON t2.siparisKalemID = t3.id"
	sorgu = sorgu & " INNER JOIN teklif.siparis t4 ON t3.siparisID = t4.sipID"
	sorgu = sorgu & " INNER JOIN cari.cari t5 ON t4.cariID = t5.cariID"
	sorgu = sorgu & " INNER JOIN stok.stok t6 ON t3.stokID = t6.stokID"
	sorgu = sorgu & " INNER JOIN cari.cari t7 ON t7.cariID = " & cariID & ""
	sorgu = sorgu & " WHERE t1.silindi = 0 AND t2.fasonCariID = " & cariID
	if fasonAnaID <> "" then
		sorgu = sorgu & " AND t2.id = " & fasonAnaID
	end if
	rs.open sorgu, sbsv5, 1, 3
	if rs.recordcount = 0 then
		Response.Write "kayıt yok"
	else
		fasonCariAd		=	rs("fasonCariAd")

		Response.Write "<div class=""container"">"
			Response.Write "<div class=""card-header text-center bold"">"
				Response.Write "<div>" & fasonCariAd & "</div>"
			Response.Write "</div>"

		Response.Write "<div class=""container"">"
			Response.Write "<div class=""row text-center bold"">"
				Response.Write "<div class=""col-4"">Mamul</div>"
				Response.Write "<div class=""col-4"">Sipariş Veren</div>"
				Response.Write "<div class=""col-4"">Miktar</div>"
			Response.Write "</div>" 
			for zi = 1 to rs.recordcount
			fasonAnaID		=	rs("fasonAnaID")
			cariAd			=	rs("cariAd")
			stokAd			=	rs("stokAd")
			fasonMiktar		=	rs("fasonMiktar")
			fasonMiktar		=	OndalikKontrol(fasonMiktar)
			mikBirim		=	rs("mikBirim")
				Response.Write "<div id=""satir"&zi&""" class=""row fontkucuk mt-2 hoverGel rounded mSatir"" onclick="""">"
					Response.Write "<div class=""col-4"">" & stokAd & "</div>"
					Response.Write "<div class=""col-4"">" & cariAd & "</div>"
					Response.Write "<div class=""col-2 text-right"">" & fasonMiktar & " " & mikBirim &"</div>"
					Response.Write "<div class=""col-1 text-center pointer"" onclick=""butonRenk('satir"&zi&"','info','mSatir'); working('DIV3','30px','30px');$('#DIV3').load('/fason/urun_detay.asp',{fasonAnaID:" & fasonAnaID & "})"" data-toggle=""popoverModal"" title="""&repAscii("fason üreticiye hammadde gönder.")&""">"
						'Response.Write "<i class=""fa fa-share pointer""></i>"
						Response.Write "<span class=""fa-stack fa-lg"">"
						Response.Write "<i class=""fa fa-truck fa-stack-1x fa-flip-horizontal""></i>"
						Response.Write "<i class=""fa fa-play fa-stack-1x text-danger fontkucuk2""></i>"
						Response.Write "</span>"
					Response.Write "</div>"
					Response.Write "<div class=""col-1 text-center pointer"" onclick=""butonRenk('satir"&zi&"','info','mSatir');working('DIV3','30px','30px');$('#DIV3').load('/fason/gelen_mamul.asp',{fasonAnaID:" & fasonAnaID & "})"" data-toggle=""popoverModal"" title="""&repAscii("fason üreticiden gelen mamul.")&""">"
						'Response.Write "<i class=""fa fa-share pointer""></i>"
						Response.Write "<span class=""fa-stack fa-lg"">"
						Response.Write "<i class=""fa fa-truck fa-stack-1x""></i>"
						Response.Write "<i class=""fa fa-play fa-stack-1x fa-flip-horizontal text-success fontkucuk2""></i>"
						Response.Write "</span>"
					Response.Write "</div>"
				Response.Write "</div>"
			rs.movenext
			next
		Response.Write "</div>"
		Response.Write "</div>"

	end if
	rs.close




	end if
%>


<!--#include virtual="/reg/rs.asp" -->






