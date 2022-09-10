<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    teklifID64	=	Request.QueryString("gorevID")
	teklifID	=	teklifID64
	teklifID	=	base64_decode_tr(teklifID)
    hata    	=   ""
    modulAd 	=   "satis"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Teklif dosyası detay ekranı")

yetkiKontrol = yetkibul(modulAd)




'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" and yetkiKontrol > 0 then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
				
			Response.Write "<table class=""table m-0 bold text-secondary"">"
				Response.Write "<tr class=""p-0"">"
					Response.Write "<td class=""btn border hoverGel"" onclick=""sekmeYukle('/satis/sekme_anaveri.asp','" & teklifID & "','btn1')"">Ana Veri<span id=""btn1""></span></td>"
					Response.Write "<td class=""btn border hoverGel"" onclick=""sekmeYukle('/satis/sekmeUrunler.asp','" & teklifID & "','btn2')"">Ürünler<span id=""btn2""></span></td>"
					Response.Write "<td class=""btn border hoverGel"" onclick=""sekmeYukle('/satis/sekmeRakipUhde.asp','" & teklifID & "','btn6')"">Rakip/Uhde<span id=""btn6""></span></td>"
					Response.Write "<td class=""btn border hoverGel"" onclick=""sekmeYukle('/satis/sekmeSiparis.asp','" & teklifID & "','btn9')"">Sipariş<span id=""btn9""></span></td>"
					Response.Write "<td class=""btn border hoverGel"" onclick=""sekmeYukle('/satis/sekmeTeslimat2.asp','" & teklifID & "','btn10')"">Teslimat<span id=""btn10""></span></td>"
					Response.Write "<td class=""btn border hoverGel"" onclick=""sekmeYukle('/satis/sekmeTeklif.asp','" & teklifID & "','btn12')"">Teklif<span id=""btn12""></span></td>"
					Response.Write "<td id=""tabDosyalar"" class=""btn bold text-success hoverGel"" onclick=""sekmeYukle('/dosya/upload_liste.asp','" & teklifID & "','btn13')"">Dosyalar<span id=""btn13""></span></td>"
					Response.Write "<td id="""" class=""btn bold text-warning hoverGel"" onclick=""sekmeYukle('/numune/numuneAna.asp','" & teklifID & "','btn14')"">Numuneler<span id=""btn14""></span></td>"
				Response.Write "<tr>"
			Response.Write "</table>"


				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
		
	Response.Write "<div id=""divSekmeIcerik""></div>"

	else
		call yetkisizGiris("","","")
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU


%>



<script>

	function sekmeYukle(dosyaAd, teklifID, btnNo){
		$('td span[id='+btnNo+']').html("<img src='/arayuz/working2.gif' width='20' height='20'/>");
		$('#divSekmeIcerik').load(dosyaAd+'?teklifID='+teklifID, function() {
		$('td span[id='+btnNo+']').html('');
		});
		
	}

</script>

