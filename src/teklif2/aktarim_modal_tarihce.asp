<!--#include virtual="/reg/rs.asp" --><%

'	Response.Flush()
	kid						=	kidbul()
	ihaleID					=	Request.QueryString("ihaleID")
	ihaleUrunID				=	Request.QueryString("ihaleUrunID")
	ayar_firmaBagimsizCari	=	1
	call sessiontest()


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


'##### YETKİ BUL
'##### YETKİ BUL
	sorgu		=	""
	sayfaadi	=	"Dosya Detay"
'##### YETKİ BUL
'##### YETKİ BUL




	'##### CARİLERİ ÇEK
	'##### CARİLERİ ÇEK

	'##### /CARİLERİ ÇEK
	'##### /CARİLERİ ÇEK


		Response.Write "<table id=""urunlerTablo"" class=""table table-responsive-sm table-bordered table-sm table-hover mt-3"">"
		
		Response.Write "<thead><tr class="" text-center"">"
		Response.Write "<th class=""align-middle w-5"">Tarih</th>"
		Response.Write "<th class=""align-middle w-5"">Veren Kurum</th>"
		Response.Write "<th class=""align-middle w-5"">Alan Kurum</th>"
		Response.Write "<th class=""align-middle w-5"" colspan=""2"">Miktar</th>"
		Response.Write "</tr></thead>"
				sorgu = "Select c.ad as verenCari, ta.alanCariID, ta.tarih, ta.aktarilanMiktar, iu.birim from talep_aktarim ta INNER JOIN ihale_urun iu ON ta.ihaleUrunID = iu.id INNER JOIN cariler c ON ta.verenCariID = c.id WHERE ta.musteriID = " & musteriID & " AND ihaleUrunID = " & ihaleUrunID & " order by ta.id desc"
				rs.open sorgu,sbsv5,1,3
				
				if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
				
				sorgu = "Select c.ad as alanCari from cariler c WHERE c.musteriID = " & musteriID & " AND c.id = " & rs("alanCariID")
				rs2.open sorgu,sbsv5,1,3
		Response.Write "<tr>"
			Response.Write "<td class=""align-middle text-center"">"
				Response.Write formatdatetime(rs("tarih"),2)
			Response.Write "</td>"
			Response.Write "<td class=""align-middle text-left"">"
				Response.Write rs("verenCari")
			Response.Write "</td>"
			Response.Write "<td class=""align-middle text-left"">"
				Response.Write rs2("alanCari")
			Response.Write "</td>"
			Response.Write "<td class=""align-middle text-right border-right-0"">"
				Response.Write rs("aktarilanMiktar")
			Response.Write "</td>"
			Response.Write "<td class=""align-middle text-left border-left-0"">"
				Response.Write rs("birim")
			Response.Write "</td>"


				rs.movenext
				rs2.close
				next
				end if
			rs.close
	Response.Write "</tr></table>"

	


%>




