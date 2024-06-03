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

	listeTur			=	Request("listeTur")

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	if yetkiKontrol = 0 then
		call yetkisizGiris("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
	else


	sorgu = "SELECT DISTINCT t1.belgeNo, t1.onayZamani, t1.gonderimZamani, t1.fasonAnaID, t2.fasonCariID"
	sorgu = sorgu & " FROM fason.fasonDetay t1"
	sorgu = sorgu & " INNER JOIN fason.fasonAna t2 ON t1.fasonAnaID = t2.id"
	sorgu = sorgu & " WHERE t1.id > 0 "
	if listeTur = "onayBekleyen" OR listeTur = "" then
		sorgu = sorgu & " AND t1.onayZamani is null AND t1.gonderimZamani is null"
	elseif listeTur = "sevkBekleyen" then
		sorgu = sorgu & " AND t1.onayZamani is not null AND t1.gonderimZamani is null"
	elseif listeTur = "gonderilmis" then
		sorgu = sorgu & " AND t1.onayZamani is not null AND t1.gonderimZamani is not null"
	elseif listeTur = "hepsi" then
		sorgu = sorgu & ""
	end if
	'sorgu = sorgu & " GROUP BY t1.belgeNo, t1.onayZamani"
	sorgu = sorgu & " ORDER BY t1.belgeNo"
	rs.open sorgu, sbsv5, 1, 3

	'Response.Write "<div class=""card-body"">"
		Response.Write "<div class=""container"">"

			Response.Write "<div class=""row text-center bold mb-3"">"
				Response.Write "<div id=""btnSevk"" class=""btn btn-sm btn-secondary m-1 p-0 col-3 fsnBtn"" onclick=""butonRenk('btnSevk','success','fsnBtn');$('#divBelgeListe').load('/fason/sevk_edilecekler.asp #divBelgeListe > *', {listeTur:'sevkBekleyen'})"">Sevk Bekleyen</div>"
				Response.Write "<div id=""btnGiden"" class=""btn btn-sm btn-secondary m-1 p-0 col-3 fsnBtn"" onclick=""butonRenk('btnGiden','success','fsnBtn');$('#divBelgeListe').load('/fason/sevk_edilecekler.asp #divBelgeListe > *', {listeTur:'gonderilmis'})"">Gönderilmiş</div>"
				Response.Write "<div id=""btnTumu"" class=""btn btn-sm btn-secondary m-1 p-0 col-3 fsnBtn"" onclick=""butonRenk('btnTumu','success','fsnBtn');$('#divBelgeListe').load('/fason/sevk_edilecekler.asp #divBelgeListe > *', {listeTur:'hepsi'})"">Tümü</div>"
			Response.Write "</div>"

	Response.Write "<div id=""divBelgeListe"">"
	
			Response.Write "<div class=""row text-center bold border-bottom border-dark"">"
				Response.Write "<div class=""col-4"">Belge No</div>"
				Response.Write "<div class=""col-4"">Onay Tarihi</div>"
				Response.Write "<div class=""col-4"">Gönderim</div>"
			Response.Write "</div>"
		if rs.EOF then
			Response.Write "<div class=""mt-3 text-danger bold"">Kayıt Yok</div>"
		else
			do until rs.EOF
				fasonCariID			=	rs("fasonCariID")
				fasonAnaID			=	rs("fasonAnaID")
				belgeNo				=	rs("belgeNo")
				onayZamani			=	rs("onayZamani")
				gonderimZamani		=	rs("gonderimZamani")

				Response.Write "<div id="""&belgeNo&""" class=""row fontkucuk hoverGel mt-2 pointer belgeNoCls"" onclick=""butonRenk('"&belgeNo&"','info','belgeNoCls');$('#DIV3').html('');$('#DIV2').load('/fason/fason_verilenIs.asp',{fasonAnaID:"&fasonAnaID&",cariID:"&fasonCariID&"})"">"
					Response.Write "<div class=""col-4"">" & belgeNo & "</div>"
					Response.Write "<div class=""col-4 text-center"">" & onayZamani & "</div>"
					Response.Write "<div class=""col-4 text-center"">" & gonderimZamani & "</div>"
				Response.Write "</div>"
			rs.movenext
			loop
		end if
		'Response.Write "</div>"
	Response.Write "</div>"
	

	rs.close




	end if
%><!--#include virtual="/reg/rs.asp" -->










