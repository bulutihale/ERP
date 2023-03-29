<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()



	'##### request
	'##### request
		kid						=	kidbul()
		stokID					=	Request.QueryString("stokID")
		updateInputID			=	Request.QueryString("inputID")
	'##### request
	'##### request




	Response.Write "<div class=""card"">"
		Response.Write "<div class=""card-header h4"">"
			Response.Write "Girilen birim değerini, ürüne ait ana birime çevirir."
		Response.Write "</div>"


			sorgu = "SELECT t1.stokBirimID, t2.uzunBirim as birim1Ad, t3.uzunBirim as birim2Ad, t1.birim1Katsayi, t1.birim2Katsayi FROM stok.stokBirim t1"
			sorgu = sorgu & " INNER JOIN portal.birimler t2 ON t1.BirimID1 = t2.birimID"
			sorgu = sorgu & " INNER JOIN portal.birimler t3 ON t1.BirimID2 = t3.birimID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.stokID = " & stokID & " AND t1.silindi = 0"
			rs.open sorgu, sbsv5, 1, 3

		if rs.recordcount > 0 then
			for hi = 1 to rs.recordcount
				birim1Ad		=	rs("birim1Ad")
				birim2Ad		=	rs("birim2Ad")
				birim1Katsayi	=	rs("birim1Katsayi")
				birim1Katsayi	=	replace(birim1Katsayi,",",".")
				birim2Katsayi	=	rs("birim2Katsayi")
				birim2Katsayi	=	replace(birim2Katsayi,",",".")


				Response.Write "<div class=""row text-center"">"
					call formhidden("updateInputID",updateInputID,"","","","","updateInputID","")
					Response.Write "<div class=""col-3 h3 mt-1"">"
						call forminput("birim1Miktar","","miktarHesapla($(this).val(),'"&updateInputID&"', '"&birim1Katsayi&"', '"&birim2Katsayi&"')","","miktarGiris","autocompleteOFF","birim1Miktar","")
					Response.Write "</div>"
					Response.Write "<div class=""col-3 h3 mt-1"">"
						Response.Write birim1Ad
					Response.Write "</div>"
				Response.Write "</div>"
			rs.movenext
			next
				Response.Write "<div class=""col-3 text-center"">"
					Response.Write "<span class=""bold h2 col-3"">=</span>"
				Response.Write "</div>"
				call forminput("anaBirimMiktar","","","","col-3","autocompleteOFF","anaBirimMiktar","readonly")
				Response.Write "<div class=""btn btn-info pointer"" data-dismiss=""modal"" onclick=""$('#"&updateInputID&"').val($('#anaBirimMiktar').val());"">Kullan</div>"
		else
			Response.Write "<div class=""h3"">Çevrim işlemi için birim eklenmemiş.</div>"
		end if
	rs.close
	Response.Write "</div>"
%>


<script>
	function miktarHesapla(miktar1, updateInputID, birim1Katsayi, birim2Katsayi){
		var hesaplananMiktar	=	miktar1 * (birim2Katsayi/birim1Katsayi);
		var hesaplananMiktar = hesaplananMiktar.toString(); 
		var sonuc = hesaplananMiktar.replace(".",",");
		$('#anaBirimMiktar').val(sonuc);
	}
</script>
