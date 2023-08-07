<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	cariID			=	Request.Form("cariID")
	kalemSec		=	Request.Form("kalemSec")
    modulAd =   "Mal Kabul"
    modulID =   "89"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU

		Response.Write "<div class=""table-responsive mt-3"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr class=""text-center"">"
		Response.Write "<th class=""col-1"" scope=""col""></th>"
		Response.Write "<th class=""col-1"" scope=""col"">Kod</th>"
		Response.Write "<th class=""col-3"" scope=""col"">Ürün Adı</th>"
		Response.Write "<th class=""col-1"" scope=""col"">Miktar</th>"
		Response.Write "<th class=""col-1"" scope=""col""><span>Gelen</span> / <span class=""text-danger"">İptal</span></th>"
		Response.Write "<th class=""col-1"" scope=""col""></th>"
		Response.Write "<th class=""col-4"" scope=""col""></th>"
		Response.Write "</tr></thead><tbody>"
		
            sorgu = "SELECT"
			sorgu = sorgu & " t1.id as siparisKalemID, t3.stokID, t1.miktar, t1.mikBirim, t1.birimFiyat, t1.paraBirim, t3.stokKodu, t3.stokAd, t1.kalemNot, t2.siparisTarih,"
			sorgu = sorgu & " ISNULL((SELECT SUM(t4.miktar) FROM stok.stokHareket t4 WHERE t4.siparisKalemID = t1.id AND t4.silindi = 0),0) as teslimEdilen,"
			sorgu = sorgu & " (SELECT DISTINCT(miktarBirim) FROM stok.stokHareket WHERE siparisKalemID = t1.id) as teslimBirim,"
			sorgu = sorgu & " ISNULL(t1.eksikMiktarKapat,0) as eksikMiktarKapat"
			sorgu = sorgu & " FROM teklif.siparisKalem t1"
			sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
			sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
			sorgu = sorgu & " WHERE t2.firmaID = " & firmaID & " AND t2.cariID = " & cariID & " AND t2.siparisTur = 'SA'"
			sorgu = sorgu & " ORDER BY t3.stokAd, t2.siparisTarih"
			rs.open sorgu, sbsv5, 1, 3
'response.Write sorgu
			
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					siparisKalemID		=	rs("siparisKalemID")
					stokID				=	rs("stokID")
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					kalemNot			=	rs("kalemNot")
					miktar				=	rs("miktar")
					mikBirim			=	rs("mikBirim")
					teslimEdilen		=	rs("teslimEdilen")
					teslimBirim			=	rs("teslimBirim")
					birimFiyat			=	rs("birimFiyat")
					paraBirim			=	rs("paraBirim")
					siparisTarih		=	rs("siparisTarih")
					eksikMiktarKapat	=	rs("eksikMiktarKapat")
					bakiye				=	cdbl(teslimEdilen) + cdbl(eksikMiktarKapat)

					teslimDurum	=	""
					satirClass	=	""
					butonDurum	=	""
					if cdbl(miktar) = cdbl(bakiye) then
						teslimDurum	=	"tam"
						satirClass 	= 	" table-success "
						butonDurum	=	"gizli"
					elseif cdbl(miktar) > cdbl(bakiye) then
						teslimDurum	=	"eksik"
					end if
					
					Response.Write "<tr class=""" & satirClass & """>"
						Response.Write "<td class=""text-center"">" 
							Response.Write "<div class=""satirSec btn btn-secondary border rounded p-0"""
								Response.Write """ onclick=""inputKontrol("&siparisKalemID&", "&cariID&");$('.inputDIV').html('');"" "
								Response.Write """ data-sipkalemid=""" & siparisKalemID & """"
								Response.Write """ data-stokid=""" & stokID & """"
								Response.Write """ data-stokkodu=""" & stokKodu & """"
								Response.Write """ data-miktar=""" & miktar & """"
								Response.Write """ data-mikbirim=""" & mikBirim & """"
								Response.Write """ data-teslimedilen=""" & teslimEdilen & """"
							Response.Write ">SEÇ</div>"
						Response.Write "</td>"
						
						
						
						Response.Write "<td>" & stokKodu & "</td>"
						Response.Write "<td>" & stokAd & "<div class=""fontkucuk2 ml-3 text-danger""><em>" & kalemNot & "</em></div></td>"
						Response.Write "<td class=""text-right pointer"" onclick=""$('#gelenMiktar').val('"&miktar&"');"">" & miktar & " " & mikBirim & "</td>"
						Response.Write "<td class=""text-center bold"">"
							Response.Write  "<span>" & teslimEdilen & " " & teslimBirim & "</span>"
							Response.Write  "<span class=""text-danger""> / " & eksikMiktarKapat & " " & mikBirim & "</span>"
							Response.Write  "<div class=""w-100 p-0""></div>"
						Response.Write "</td>"
						Response.Write "<td class=""text-center"">"
							Response.Write "<div class=""btn btn-warning border rounded"" onclick=""modalajaxfit('/malKabul/mal_giris_detay.asp?siparisKalemID="&siparisKalemID&"&stokID="&stokID&"')"">detay</div>"
						Response.Write "</td>"
						Response.Write "<td class=""px-3"">" 
							Response.Write "<div id=""inputDIV"&siparisKalemID&""" class=""row inputDIV"">"
							if kalemSec = "ok" AND teslimDurum = "eksik" then							
									call formhidden("miktarbirim",mikBirim,"","","","","","")
								Response.Write "<div class=""col-lg-10"">"
									Response.Write "<div class=""row"">"
										Response.Write "<div class=""col-lg-6 col-sm-12"">"
											Response.Write "<div class=""input-group input-group-sm p-0 m-0"">"
												'call forminput("gelenMiktar","","numara(this,true,false)","Miktar","inpReset","autocompleteOFF","gelenMiktar","")
												Response.Write "<input type=""text"" class=""form-control input input-sm"" aria-describedby=""basic-addon1"" id=""gelenMiktar"" name=""gelenMiktar"" placeholder=""Miktar"" autocomplete=""off"">"
												Response.Write "<div class=""input-group-append m-0 p-0 rounded"">"
													Response.Write "<span class=""input-group-text pointer m-0"" id=""basic-addon1"" onclick=""anaBirimMiktarHesap('gelenMiktar'," & stokID & ")""><i class=""icon calculator p-0""></i></span>"
												Response.Write "</div>"
											Response.Write "</div>"
										Response.Write "</div>"
										Response.Write "<div class=""col-lg-6 col-sm-12"">"
											call forminput("lot","","","LOT","inpReset","autocompleteOFF","lot","")
										Response.Write "</div>"
									Response.Write "</div>"
									Response.Write "<div class=""row"">"
										Response.Write "<div class=""col-lg-6 col-sm-12"">"
											call forminput("lotSKT","","","SKT","inpReset tarih","autocompleteOFF","lotSKT","")
										Response.Write "</div>"
										Response.Write "<div class=""col-lg-6 col-sm-12"">"
											call forminput("aciklama","","","Açıklama","inpReset","autocompleteOFF","aciklama","")
										Response.Write "</div>"
									Response.Write "</div>"
								Response.Write "</div>"
								Response.Write "<div class=""col-lg-2"">"
									Response.Write "<div class=""row h-100"">"
										Response.Write "<div class=""col-lg-12 col-sm-12 h-100"">"
											Response.Write "<button id=""btn_"&siparisKalemID&""" type=""submit"" onclick=""working('btn_"&siparisKalemID&"','30px','30px')"" class=""btn btn-warning rounded p-0 h-100"">KAYDET</button>"
										Response.Write "</div>"
									Response.Write "</div>"
								Response.Write "</div>"
							elseif kalemSec = "ok" AND teslimDurum = "tam" then
								Response.Write "<div class=""col-12"">"
									Response.Write "Sipariş tamamlanmış."
								Response.Write "</div>"
							end if
							Response.Write "</div>"
						Response.Write "</td>"
					Response.Write "</tr>"
					Response.Flush()
				rs.movenext
				next
			end if
			rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU







%>

<script>


$(document).ready(function() {
	$('.satirSec').on('click', function() {
		$('tr').removeClass('table-primary');
		$(this).closest('tr').addClass('table-primary');
		//mal_kabul.asp  de yer alan form'a gönder
		$('#inpStokKodu').val($(this).attr('data-stokkodu'));
		$('#inpMiktar').val($(this).attr('data-miktar'));
		$('#inpSipKalemID').val($(this).attr('data-sipkalemid'));
		$('#inpstokID').val($(this).attr('data-stokid'));
		$('#inpTeslimEdilen').val($(this).attr('data-teslimedilen'));
		$('#miktarbirim').attr('data-sart',$(this).attr('data-mikbirim'));
		if($('#miktarbirim').hasClass('select2-hidden-accessible')){
			$('#miktarbirim').val(null).trigger('change');
			$('#miktarbirim').select2('destroy')
		};//sadece siparişle aynı miktar birimini seçmek için
	});

});

	function inputKontrol(siparisKalemID, cariID) {
		
	var belgeTarih		=	$('#belgeTarih').val();
	var belgeNo			=	$('#belgeNo').val();
	var girisTarih		=	$('#girisTarih').val();
	var depoSec			=	$('#depoSec').val();
	var hata 			= 	0

	if(belgeTarih == ''){swal('','belge tarihi girilmedi');var hata = 1;return false}
	if(belgeNo == ''){swal('','belge no girilmedi');var hata = 1;return false}
	if(girisTarih == ''){swal('','giriş tarihi seçilmedi');var hata = 1;return false}
	if(depoSec == null){swal('','giriş yapılacak depo seçilmedi');var hata = 1;return false}


	if(hata == 0){
		$('#inputDIV'+siparisKalemID).load('/malKabul/mal_kabul_siparis_liste.asp #inputDIV'+siparisKalemID+' >*', {kalemSec:'ok',cariID:cariID});
		}else if(hata == 1){alert('hata')};


				}
		
		
		
		
	
</script>












