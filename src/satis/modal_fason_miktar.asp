<!--#include virtual="/reg/rs.asp" --><%

sessiontest()

'eklemek için

sipKalemID		=	Request("sipKalemID")

	sorgu = "SELECT ISNULL(miktarFason,0) as miktarFason, sipMiktar FROM teklif.siparisKalem WHERE id = " & sipKalemID
	rs.open sorgu, sbsv5, 1, 3
		miktarFason		=	rs("miktarFason")
		sipMiktar		=	rs("sipMiktar")
	rs.close
		Response.Write "<input type=""hidden"" id=""sipMiktar"" val=""" & sipMiktar& """>"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-12"">"
				Response.Write "<div class=""bold mb-4"">Fasonda yaptırılacak ürün miktarı</div>"
			Response.Write "</div>"

			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-lg-3 col-xs-12 mt10 mb10"">"
					call forminput("miktarFason",miktarFason,"","","text-right bold","autocompleteOFF","miktarFason","")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-9 col-xs-12 mt10 mb10"">"
					Response.Write "<div class=""btn btn-info rounded"" onclick=""fasonMiktarKaydet()"">KAYDET</div>"
				Response.Write "</div>"
			Response.Write "</div>"

		Response.Write "</div>"

%><!--#include virtual="/reg/rs.asp" -->


<script>
function fasonMiktarKaydet(){
	yeniMiktar = <%=sipMiktar%> - $('#miktarFason').val();
	var yeniMiktarsayi = yeniMiktar.toString()
	
	hucreKaydetGenel('id', '<%=sipKalemID%>', 'miktarFason', 'teklif.siparisKalem', $('#miktarFason').val(), '', 'divFasonMiktar<%=sipKalemID%>', '/satis/siparis_liste.asp', '', '')
	hucreKaydetGenel('id', '<%=sipKalemID%>', 'miktar', 'teklif.siparisKalem', yeniMiktarsayi, '', 'divMiktar<%=sipKalemID%>', '/satis/siparis_liste.asp', '', '')
	
		}
		
</script>







