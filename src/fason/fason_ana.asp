<!--#include virtual="/reg/rs.asp" --><%


'###### FİLTRELER
'###### FİLTRELER
		
	siparisKalemID	=	Request.Form("siparisKalemID")
	stokID			=	Request.Form("stokID")
    modulAd 		=   "Fason"


	
	

'###### FİLTRELER
'###### FİLTRELER

	yetkiKontrol	 = yetkibul(modulAd)

	if yetkiKontrol = 0 then
		call yetkisizGiris("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
	else
	


	sorgu = "SELECT DISTINCT t1.id as fasonAnaID, t4.cariAd, t5.cariAd as fasonCariAd, t2.sipMiktar, t6.receteID"
	sorgu = sorgu & " FROM fason.fasonAna t1"
	sorgu = sorgu & " INNER JOIN teklif.siparisKalem t2 ON t1.siparisKalemID = t2.id"
	sorgu = sorgu & " INNER JOIN teklif.siparis t3 ON t2.siparisID = t3.sipID"
	sorgu = sorgu & " INNER JOIN cari.cari t4 ON t3.cariID = t4.cariID"
	sorgu = sorgu & " INNER JOIN cari.cari t5 ON t1.fasonCariID = t5.cariID"
	sorgu = sorgu & " LEFT JOIN portal.ajanda t6 ON t1.siparisKalemID = t6.siparisKalemID AND t6.silindi = 0 AND isTur = 'fason'"
	sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.siparisKalemID = " & siparisKalemID
	rs.open sorgu, sbsv5, 1, 3

		cariAd			=	rs("cariAd")
		sipMiktar		=	rs("sipMiktar")
		receteID		=	rs("receteID")


		if isnull(receteID) then
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-10"">"
					Response.Write "<table class=""table m-0 bold text-secondary"">"
						Response.Write "<tr class=""p-0"">"
							'Response.Write "<td class=""btn btn-info rounded m-1"" onclick=""$('#divSekmeIcerik').load('/fason/fason_anaVeri.asp?id="&siparisKalemID&"&stokID="&stokID&"')"">Ana Veri<span id=""btn1""></span></td>"
							'Response.Write "<td class=""btn btn-info rounded m-1"" >Ürün Seçimi<span id=""btn2""></span></td>"
						Response.Write "<tr>"
					Response.Write "</table>"
				Response.Write "</div>"
			Response.Write "</div>"
		end if
		'Response.Write "<div id=""divSekme1"" class=""table-responsive mt-3"">"

			Response.Write "<table border=""1"" class=""table table-sm table-striped table-bordered"">"
				Response.Write "<thead>"
					Response.Write "<th>"
						Response.Write "Sipariş Veren"
					Response.Write "</th>"
				Response.Write "</thead>"

				Response.Write "<tbody>"
					Response.Write "<tr>"
						Response.Write "<td class=""bold"">"
							Response.Write cariAd
						Response.Write "</td>"
					Response.Write "</tr>"
			do until rs.EOF
				fasonAnaID		=	rs("fasonAnaID")
				fasonCariAd		=	rs("fasonCariAd")
				
				Response.Write "<tr>"
					Response.Write "<td class="""">"
						Response.Write "<span class=""ml-4 bold "">Fason Firma: </span>"
						Response.Write "<span class=""pointer"">" & fasonCariAd & "</span>"
						Response.Write "<span class=""btn btn-sm btn-info ml-2"" onclick=""$('#divReceteKalemler').html('');working('divSekmeIcerik','30px','30px');$('#divSekmeIcerik').load('/fason/recete_sec.asp?id="&siparisKalemID&"&stokID="&stokID&"&fasonAnaID="&fasonAnaID&"')"">seç</span>"
					Response.Write "</td>"
				Response.Write "</tr>"

			rs.movenext
			loop
			rs.close
				Response.Write "</tbody>"
			Response.Write "</table>"

		'Response.Write "</div>"

	Response.Write "<div id=""divSekmeIcerik""></div>"
	Response.Write "<div id=""divReceteKalemler""></div>"
end if
%>



<script>



	function toggleTextInput(chckID, inputID) {
		
		// Checkbox'un durumuna göre metin giriş alanının durumunu değiştir
		if($("#"+chckID).is(":checked")){
			$("#"+inputID).prop("disabled", false); // Etkinleştir
		} else {
			$("#"+inputID).prop("disabled", true); // Devre dışı bırak
		}
	}

	
	function sevkMiktarKilitle(receteID, siparisKalemID, fasonAnaID) {
		$.post('/fason/miktar_kilit.asp',{fasonAnaID:fasonAnaID}, function(){
			working('divReceteKalemler','30px','30px');
			$('#divReceteKalemler').load('/fason/recete_kalem.asp',{receteID:receteID,siparisKalemID:siparisKalemID,fasonAnaID:fasonAnaID});
		})
	}


</script>
