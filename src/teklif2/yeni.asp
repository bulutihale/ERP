<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    modulID =   "109"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


	sorgu		=	""
	sayfaadi	=	"Yeni Dosya "


	'##### FİRMALARIMI ÇEK
	'##### FİRMALARIMI ÇEK
				sorgu = "Select id, ad as firmaAD from portal.firma WHERE id = " & firmaID
				rs.open sorgu,sbsv5,1,3
					degerler = "=|"
					do while not rs.eof
						degerler = degerler & rs("firmaAD")
						degerler = degerler & "="
						degerler = degerler & rs("id")
						degerler = degerler & "|"
					rs.movenext
					loop
					if degerler = "" then
					else
						degerler = left(degerler,len(degerler)-1)
					end if
				rs.close
				firmalardegerler = degerler
	'##### /FİRMALARIMI ÇEK
	'##### /FİRMALARIMI ÇEK

    modulAd =   "Teklif"
    modulID =   "109"

yetkiTeklif = yetkibul(modulAd)



if yetkiTeklif > 0 then

'##### TABLO
'##### TABLO
Response.Write "<form class=""ajaxform"" action=""/teklif2/kaydet.asp"">"
Response.Write "<input type=""hidden"" name=""tip"" id=""tip"" value="""" />"

Response.Write "<div class=""row"">"
Response.Write "<div class=""col-lg-12"">"
Response.Write "<div class=""card"">"
Response.Write "<div class=""card-header""><i class=""fa fa-align-justify""></i> " & sayfaadi & "</div>"
Response.Write "<div class=""card-body row"">"


'##### SOL ALAN
'##### SOL ALAN
	Response.Write "<div class=""col-lg-4"">"
	Response.Write "<div class=""jumbotron"">"
	Response.Write "<div class=""row"">"
	
		Response.Write "<div class=""col-lg-12"">"
		if firmaSec = "" then
			firmasec = 5
		end if
		Response.Write "<div class=""badge badge-secondary rounded-left"">Firmam Seçimi</div>"
			call formselectv2("firmasec",firmasec,"","funcFirmasec();","firmasec","","firmasec",firmalardegerler,"")
		Response.Write "</div>"
		

	'##### CARİ SEÇİMİ
	'##### CARİ SEÇİMİ
		Response.Write "<div class=""col-lg-12"">"
			Response.Write "<hr class=""bg-danger"">"
				Response.Write "<div class=""btn btn-sm btn-info rounded"" onclick=""$('#divCariSec').show('slow');$('#divYeniCari').addClass('d-none');"">Kayıtlı cari için teklif</div>"
				Response.Write "<div class=""btn btn-sm btn-warning rounded ml-2"" onclick=""$('#divCariSec').hide('slow');$('#divYeniCari').removeClass('d-none');$('#carisec').val(null).trigger('change');"">Yeni cari için teklif</div>"
				call clearfix()
					Response.Write "<div id=""divCariSec"" class=""mt-3"">"
						Response.Write "<div class=""badge badge-secondary rounded-left"">Cari Seçimi</div>"
						call formselectv2("cariID","","","","formSelect2 cariID pb-2","","cariID","","data-holderyazi=""Cari adı, cari kodu, vergi no"" data-jsondosya=""JSON_cariler"" data-miniput=""3"" data-defdeger="""&defDeger&"""")
					Response.Write "</div>"
					Response.Write "<div id=""divYeniCari"" class=""mt-3 d-none"">"
						Response.Write "<div class=""m-0 p-0"">Vergi No :</div>"
						call clearfix()
						Response.Write "<input id=""yeniCariVergiNo"" name=""yeniCariVergiNo"" type=""text"">"
						Response.Write "<div id=""utsNoListe""></div>"
					Response.Write "<hr class=""bg-danger"">"
						call clearfix()
						Response.Write "<div class=""m-0 p-0"">Cari Ad :</div>"
						call clearfix()
						Response.Write "<textarea id=""yeniCariAd"" name=""yeniCariAd"" class=""col-12"" rows=""4""></textarea>"
					Response.Write "</div>"
			Response.Write "<hr class=""bg-danger"">"
		Response.Write "</div>"
	'##### /CARİ SEÇİMİ
	'##### /CARİ SEÇİMİ
	
	'##### USER SEÇİMİ
	'##### USER SEÇİMİ
		Response.Write "<div class=""col-lg-12"">"
		Response.Write "<div class=""badge badge-secondary rounded-left"">Dosya Sorumlusu Seçimi</div>"
		Response.Write "<select id=""dosyaSorumlu"" class=""form-control select2-single"" name=""dosyaSorumlu"">"
		Response.Write "<option></option>"
			sorgu = "select k.ad, k.id from personel.personel k where k.firmaID = " & firmaID & " order by k.ad asc"
			rs.open sorgu,sbsv5,1,3
			for i = 1 to rs.recordcount
				Response.Write "<option value=""" & rs("id") & """>" & rs("ad") & "</option>"
			rs.movenext
			next
			rs.close
		Response.Write "</select>"
		Response.Write "</div>"
	'##### /USER SEÇİMİ
	'##### /USER SEÇİMİ
	
	Response.Write "</div>"'row
	Response.Write "</div>"'cont
	Response.Write "</div>"'col3
'##### SOL ALAN
'##### SOL ALAN

	Response.Write "<div class=""col-lg-8"">"
'##### SEKMELER
'##### SEKMELER
		Response.Write "<ul class=""nav nav-tabs"" role=""tablist"">"
			Response.Write "<li class=""nav-item"">"
				Response.Write "<a id=""bubirID"" class=""active nav-link fontkucuk"" data-toggle=""tab"" href=""#bayi"" role=""tab"" aria-controls=""bayi"">Firma</a>"
			Response.Write "</li>"
			
			Response.Write "<li class=""nav-item"">"
				Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#dog_temin"" role=""tab"" aria-controls=""dog_temin"">Doğrudan Temin</a>"
			Response.Write "</li>"
				
			Response.Write "<li class=""nav-item"">"
				Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#ozel_hast"" role=""tab"" aria-controls=""ozel_hast"">Özel Hastane</a>"
			Response.Write "</li>"			

			Response.Write "<li class=""nav-item"">"
				Response.Write "<a class=""nav-link fontkucuk"" data-toggle=""tab"" href=""#proforma"" role=""tab"" aria-controls=""proforma"">İhracat Proforma</a>"
			Response.Write "</li>"			
			
		Response.Write "</ul>"
'##### /SEKMELER
'##### /SEKMELER
	Response.Write "<div class=""tab-content"">"



'##### DOĞRUDAN TEMİN
'##### DOĞRUDAN TEMİN
	Response.Write "<div class=""tab-pane"" id=""dog_temin"" role=""tabpanel"">"
		Response.Write "<div class=""jumbotron border border border-info"">"
			Response.Write "<h2 class=""text-center"">Doğrudan Temin Dosyası</h2>"
			Response.Write "<div class=""row mt-2"">"
				Response.Write "<div class=""col-lg-3 "">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Doğrudan Temin Numarası</div>"
					call forminput("ikn_dog_temin","","","Alım No","","","ikn_dog_temin","")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-3"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Alım Tarihi</div>"
					call forminput("tarih_ihale_dog_temin",tarih_ihale,"","Alım Tarihi","tarih","","tarih_ihale_dogTemin","AutCompOff")
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""row mt-2"">"
				Response.Write "<div class=""col-lg-12"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Alım Adı</div>"
					call forminput("ad_dog_temin",ad,"","Alım Adı","","","ad","")
				Response.Write "</div>"
			Response.Write "</div>"
				Response.Write "<div class=""col-lg-12 mt-4"">"
					Response.Write "<button name=""dog_temin"" class=""kaydet btn-block btn-primary"" type=""submit"" onClick=""$('#tip').val('dog_temin');"">kaydet</button>"
				Response.Write "</div>"
		Response.Write "</div>"
	Response.Write "</div>"
'##### /DOĞRUDAN TEMİN
'##### /DOĞRUDAN TEMİN

 
'##### BAYİ FİYATI
'##### BAYİ FİYATI
	Response.Write "<div class=""active tab-pane"" id=""bayi"" role=""tabpanel"">"
		Response.Write "<div class=""jumbotron border border-info"">"
			Response.Write "<h2 class=""text-center"">Firma Teklifi</h2>"
			' Response.Write "<div class=""col-lg-3 "">"
			' 	Response.Write "<div class=""badge badge-secondary rounded-left"">Dosya Numarası</div>"
			' 	call forminput("ikn_bayi","","","Dosya No","","","ikn_bayi","")
			' Response.Write "</div>"
			Response.Write "<div class=""col-lg-12 mt-2"">"
				Response.Write "<div class=""badge badge-secondary rounded-left"">Teklif Adı</div>"
				call forminput("ad_bayi",ad,"","Alım Adı","","","ad_bayi","")
			Response.Write "</div>"
			Response.Write "<div class=""container row"">"
				Response.Write "<div class=""col-lg-9 mt-2"">"
					call formhidden("bayiDosyaTipi","stok","","Alım Adı","","","bayiDosyaTipi","")
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""container row mt-2"">"
				Response.Write "<div id=""tarih2_bayi"" class=""col-lg-2"">"
				Response.Write "<div class=""badge badge-secondary rounded-left"">Teklif Tarihi</div>"
				call forminput("tarih_ihale_bayi",tarih_ihale,"","Alım Tarihi","tarih","","tarih_ihale_bayi","AutCompOff")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Ödeme Vadesi</div>"
					call forminput("odemeVadeBayi","","","Vade","sadeceGun","","odemeVadeBayi","")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Teklif Geçerlilik</div>"
					call forminput("teklifGecerlikBayi","","","Geçerlilik","sadeceGun","","teklifGecerlikBayi","")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Teslimat Süresi</div>"
					call forminput("teslimatSureBayi","","","Teslimat Süresi","sadeceGun","","teslimatSureBayi","")
				Response.Write "</div>"
			Response.Write "</div>"
				Response.Write "<div class=""col-lg-12 mt-4"">"
					Response.Write "<button name=""bayi"" class=""btn-block btn-primary"" type=""submit"" onClick=""$('#tip').val('bayi');"">kaydet</button>"
				Response.Write "</div>"
		Response.Write "</div>"
	Response.Write "</div>"
'##### /BAYİ FİYATI
'##### /BAYİ FİYATI

'##### ÖZEL HASTANE
'##### ÖZEL HASTANE
	Response.Write "<div class=""tab-pane"" id=""ozel_hast"" role=""tabpanel"">"
		Response.Write "<div class=""jumbotron border border-info"">"
			Response.Write "<h2 class=""text-center"">Özel Hastane Teklifi</h2>"		
			Response.Write "<div class=""container row mt-2"">"			
				Response.Write "<div class=""col-lg-3 "">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Alım Numarası</div>"
					call forminput("ikn_ozel_hast","","","Alım No","","","ikn_ozel_hast","")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-3"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Alım Tarihi</div>"
					call forminput("tarih_ihale_ozel_hast",tarih_ihale,"","Alım Tarihi","tarih","","tarih_ihale_ozel_hast","AutCompOff")
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""container row mt-2"">"			
				Response.Write "<div class=""col-lg-12 mt-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Alım Adı</div>"
					call forminput("ad_ozel_hast",ad,"","Alım Adı","","","ad_bayi","")
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""container row mt-2"">"
				Response.Write "<div class=""col-lg-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Ödeme Vadesi</div>"
					call forminput("odemeVadeOzHast","","","Vade","","","odemeVadeOzHast","")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Teklif Geçerlilik</div>"
					call forminput("teklifGecerlikOzHast","","","Geçerlilik","","","teklifGecerlikOzHast","")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Teslimat Süresi</div>"
					call forminput("teslimatSureOzHast","","","Teslimat Süresi","","","teslimatSureOzHast","")
				Response.Write "</div>"
			Response.Write "</div>"
				Response.Write "<div class=""col-lg-12 mt-4"">"
					Response.Write "<button name=""ozel_hast"" class=""kaydet btn-block btn-primary"" type=""submit"" onClick=""$('#tip').val('ozel_hast');"">kaydet</button>"
				Response.Write "</div>"
		Response.Write "</div>"
	Response.Write "</div>"
'##### /ÖZEL HASTANE
'##### /ÖZEL HASTANE


'##### İHRACAT PROFORMA
'##### İHRACAT PROFORMA

	Response.Write "<div class=""tab-pane"" id=""proforma"" role=""tabpanel"">"
		Response.Write "<div class=""jumbotron border border-info"">"
			Response.Write "<h2 class=""text-center"">İhracat Teklifi</h2>"
			Response.Write "<div class=""container row mt-2"">"
				Response.Write "<div id=""tarih2_proforma"" class=""col-lg-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Teklif Tarihi</div>"
					call forminput("tarih_ihale_bayi",tarih_ihale,"","Alım Tarihi","tarih","","tarih_ihale_bayi","AutCompOff")
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""container row"">"
				Response.Write "<div class=""col-lg-12 mt-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Teklif Adı</div>"
					call forminput("ad_proforma",ad,"","Alım Adı","","","ad_bayi","")
				Response.Write "</div>"
			Response.Write "</div>"
				Response.Write "<div class=""col-lg-12 mt-4"">"
					Response.Write "<button name=""proforma"" class=""btn-block btn-primary"" type=""submit"" onClick=""$('#tip').val('proforma');"">kaydet</button>"
				Response.Write "</div>"
		Response.Write "</div>"
	Response.Write "</div>"
'##### /İHRACAT PROFORMA
'##### /İHRACAT PROFORMA








Response.Write "</div>"

Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"

'##### /TABLO
'##### /TABLO






	else
		response.Write "<script>$(document).ready(function() {toastr.options.positionClass = 'toast-bottom-right';toastr.info('Yeni Dosya Kaydetme yetkisi tanımlanmamış. (Yetki No:6)','Yetki yok!');});</script>"
end if
%>









	
	
	
		
<script>
	$(document).ajaxSuccess(function(){
		
		$('.yeniCariDIV').on('click', function () {
		
			$("#yeniCariAd").val($(this).text());
	
		});
	});
				
				
	$(document).ready(function(){

	//vergi numarasından ÜTS tanımlayıcı no sorgula
		$('#yeniCariVergiNo').on('input', function () {
		
			var firmamID		=	$('#firmasec').val();
			var vergiNo			=	$('#yeniCariVergiNo').val();
			var bildirim		=	'vergiNoSorgula';
			
				$.ajax({
					type:'POST',
					url :'/utsN/utsNislemYap.asp',
					data :{'bildirim':bildirim,'vergiNo':vergiNo,'firmamID':firmamID,
								},
					beforeSend: function() {

						$('#vergiNoSorgula').html("<img src='/image/working2.gif' width='20' height='20'/>");
					  },
							success: function(sonuc) {

								var data = JSON.parse(sonuc);

								if(data.length == 0){swal('','Vergi No ile ilişkili ÜTS No yok','error');
									$('#vergiNoSorgula').text('sorgula');
								} else{
									$('#utsNoListe').html('');
									$("#yeniCariAd").val('');
									for (var key in data)
										{
											//console.log(data);
											
											$('#utsNoListe').append('<div class="form-check yeniCariDIV">\
																	<input id="radio'+key+'" class="form-check-input" type="radio" name="utsKurumNo" value="'+data[key].KRN+'">\
																	<span class="form-check-div pointer" for="radio'+key+'" onclick="">'+data[key].GAD+'</span>\
																	</div>\
																	<hr class="pt-2 m-0">\
																	').show('slow');
											$('#vergiNoSorgula').addClass('d-none');
										}// döngü bitti
									}
							}
				});
					
		});
	//vergi numarasından ÜTS tanımlayıcı no sorgula
		});
</script>


