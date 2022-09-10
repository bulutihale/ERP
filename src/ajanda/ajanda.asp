<!--#include virtual="/reg/rs.asp" --><%

	Response.Flush()
	kid						=	kidbul()
	ayHareket				=	cint(Request.Form("ayHareket"))
	sorgulananTarih			=	cdate(Request.Form("sorgulananTarih"))
	siparisKalemID			=	Request.QueryString("siparisKalemID")
	
	response.Write siparisKalemID
	
	call sessiontest()
	
    modulAd 		=   "Planlama"


'##### YETKİ BUL
'##### YETKİ BUL
	yetkiKontrol	 = yetkibul(modulAd)
'##### YETKİ BUL
'##### YETKİ BUL

call logla("Planlama ajanda sayfası girişi")


	
	if ayHareket = 0 AND sorgulananTarih = 0 then
		hangiYil		=	datepart("yyyy",date())
		hangiAy			=	datepart("m",date())
		sorgulananTarih	=	DateSerial(hangiYil, hangiAy, 1)
	elseif ayHareket <> 0 AND sorgulananTarih <> 0 then
		sorgulananTarih	=	DateAdd("m",ayHareket,sorgulananTarih)
		hangiYil		=	datepart("yyyy",sorgulananTarih)
		hangiAy			=	datepart("m",sorgulananTarih)
	end if
	



	'	############# 1 aylık grid
		
	
		aySonGun		=	ayingunleri(hangiAy, hangiYil)
			Response.Write "<div id=""ajandaAnaDIV"" class=""animated fadein card"">"
				Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
				Response.Write "<div class=""text-center card-body"">"
				
					Response.Write "<div id=""sabitBilgiler"" class=""d-none"" data-sorgulanantarih=""" & sorgulananTarih & """></div>"
				
				
				'##### yıl ve ay göster
					Response.Write "<div class=""h3 bold"">"
						Response.Write "<i class=""fa fa-arrow-circle-left text-success pointer ayHareket geri mr-2""></i>"
						Response.Write hangiYil & " - " & MonthName(hangiAy)
						Response.Write "<i class=""fa fa-arrow-circle-right text-success pointer ayHareket ileri ml-2""></i>"
					Response.Write "</div>"
				'##### yıl ve ay göster
				
				'###### haftanın günlerini sırala
						Response.Write "<div class=""row fontkucuk"">"
							gunlerArr	=	Array("Pazartesi","Salı","Çarşamba","Perşembe","Cuma","Cumartesi","Pazar")
							for hi = 0 to 6
								Response.Write "<div class=""col border bold text-center"">" & gunlerArr(hi) & "</div>"
							next
						Response.Write "</div>" 
				'###### haftanın günlerini sırala
				
				'###### gün kutularını sırala	
				'###### gün kutularını sırala	
						Response.Write "<div class=""row fontkucuk"" style=""height:120px"">"'günler satırı başla. bilerek döngünün dışında başladı, döngü sonunda kapanıp açılıyor.
							divSay = 0
							for zi = 1 to aySonGun
								divSay		=	divSay + 1
								gunTarih	=	DateSerial(hangiYil, hangiAy, zi)	'gün kutusunun tarihini bul
								gunSayi		=	weekday(gunTarih,2)					'gün kutusu haftanın kaçıncı günü

						'###### hafta sonunu belirle 5 ten büyük ise cumartesi veya pazardır kırmızı yap.								
								if gunsayi > 5 then
									textClass		=	" text-danger "
								else
									textClass	=	" "
								end if
						'###### /hafta sonunu belirle 5 ten büyük ise cumartesi veya pazardır kırmızı yap.								

						'###### bugünü belirle, bg-warning yap.
								if date() = gunTarih then
									bugunClass	=	" bg-warning "
								else
									bugunClass	=	" "
								end if
						'###### / müşteri siparişi için tarih seçimi yapılacaksa hoverGel
								if siparisKalemID <> "" then
									bugunClass	=	bugunClass & " hoverGel pointer "
								end if
						'###### / müşteri siparişi için tarih seçimi yapılacaksa hoverGel
						
						
							'#### tarih, kayıtlı resmi tatiller arasında kayıtlı mı?
								sorgu = "SELECT aciklama, tatilGunu FROM portal.isGunu WHERE tatilGunu = '" & tarihsql2(gunTarih) & "'"
								fn2.open sorgu,sbsv5,1,3
									kayitSayi	=	fn2.recordcount
									if kayitSayi > 0 then
										resmiTatilClass 	=	" -- <span class=""text-danger"">" & fn2("aciklama") & "</span>"
									else
										resmiTatilClass	=	""
									end if
								fn2.close
							'#### /tarih, kayıtlı resmi tatiller arasında kayıtlı mı?
							
								for gi = 1 to 7
									
								'##### kutunun içini doldur
								'##### kutunun içini doldur
									if gunSayi = gi then
										Response.Write "<div class=""col h-100 border border-dark " & bugunClass & """>"	'kutu çerçevesi
											
											Response.Write "<div class=""row"">" 'kutu içi satırlar
											
											'#### ayın kaçı ve resmi tatil açıklaması
												Response.Write "<div class=""col-10 p-0 pl-1 bold text-left " & textClass & """>"
													Response.Write zi & resmiTatilClass												
												Response.Write "</div>"
											'#### /ayın kaçı ve resmi tatil açıklaması
											
											'#### gün içine kayıt yapmak için buton
												Response.Write "<div class=""col-2 p-0 pr-2 text-right pointer modaldaGizle"" onClick=""modalajax('/ajanda/icerikYaz_modal.asp?hangiYil=" & hangiYil &"&hangiAy=" & hangiAy &"&hangiGun=" & zi &"')"">"
													Response.Write "<i class=""fa fa-search-plus text-success""></i>"
												Response.Write "</div>"
											'#### /gün içine kayıt yapmak için buton
													
											'#### gün içine daha önce kayıt edilmiş olayları yaz.
													sorgu = "SELECT id, kid, hangiYil, hangiAy, hangiGun, icerik"
													sorgu = sorgu & " FROM portal.ajanda"
													sorgu = sorgu & " WHERE silindi = 0 AND kid = " & kid & " AND hangiYil = " & hangiYil & "  AND  hangiAy = " & hangiAy & " AND hangiGun = " & zi
													rs.open sorgu, sbsv5,1,3
													if rs.recordcount > 0 then
														for di = 1 to rs.recordcount
															ajID		=	rs("id")
															icerik		=	rs("icerik")
														Response.Write "<div class=""col-12 text-left fontkucuk2"">"
															Response.Write "- " & icerik
														Response.Write "</div>"											
														rs.movenext
														next
													end if
													rs.close
											'#### /gün içine daha önce kayıt edilmiş olayları yaz.
											
											Response.Write "</div>"'kutu içi satırlar
											
										Response.Write "</div>"'kutu çerçevesi
										exit for
									elseif zi = 1 AND gunSayi <> gi then '####### pazartesi'den başlamayan ay başına boş kutu koy
										Response.Write "<div class=""col h-100 border""></div>"
										divSay		=	divSay + 1
									end if
								'##### /kutunun içini doldur
								'##### /kutunun içini doldur
								next
									if divSay mod 7 = 0 AND zi < aySonGun then '########## ay bitmedi ise pazar gününden sonra yeni satıra geç DIV kapat - AÇ
										Response.Write "</div>"'günler satır kapat
										Response.Write "<div class=""row fontkucuk"" style=""height:120px"">"'günler satır tekrar aç
									elseif zi = aySonGun then 'ay bitti mi?
										'########## ay pazar gününde bitmiyorsa pazar gününe kadar boş kutu koy
											eksikDiv	=	7 - (divSay mod 7)
											if eksikDiv <> 7 then
												for e = 1 to eksikDiv
													Response.Write "<div class=""col h-100 border""></div>"
												next
											end if
										'########## ay pazar gününde bitmiyorsa pazar gününe kadar boş kutu koy
										Response.Write "</div>"'günler satır kapat
									end if
							next
						'Response.Write "</div>"
				'###### /gün kutularını sırala	
				'###### /gün kutularını sırala	
									
				Response.Write "</div>"
			Response.Write "</div>"
	'	############# /1 aylık grid
	
	
	
%>

	<script>
		$(document).ready(function() {
	
		//ileri geri okları ile sorgu
			$('.ayHareket').off().on('click', function () {
				
				sorgulananTarih	=	$('#sabitBilgiler').attr('data-sorgulanantarih');
			
				if($(this).hasClass('ileri')){
					ayHareket = 1;
					}
				else if($(this).hasClass('geri')){
					ayHareket = -1
					}
				else{ayHareket = 0};
				
				$('#ajandaAnaDIV').fadeOut('slow', function () {
					$('#ajandaAnaDIV').load('/ajanda/ajanda.asp #ajandaAnaDIV > *',{ayHareket:ayHareket,sorgulananTarih:sorgulananTarih}).fadeIn('slow');
				});
					
			});
	
	
		});
			
			
		$(document).ajaxSuccess(function() {
		
		//ileri geri okları ile sorgu
			$('.ayHareket').off().on('click', function () {
				
				sorgulananTarih	=	$('#sabitBilgiler').attr('data-sorgulanantarih');
			
				if($(this).hasClass('ileri')){
					ayHareket = 1;
					}
				else if($(this).hasClass('geri')){
					ayHareket = -1
					}
				else{ayHareket = 0};
				
				$('#ajandaAnaDIV').fadeOut('slow', function () {
					$('#ajandaAnaDIV').load('/ajanda/ajanda.asp #ajandaAnaDIV > *',{ayHareket:ayHareket,sorgulananTarih:sorgulananTarih}).fadeIn('slow');
				});
					
			});
			
	// ajSave işlemleri		
			
		$('.ajSave').off().on('change', function() {


			var hamID = $(this).attr('id');

			arr 	= hamID.split('|');
			alan 		=	arr[0];
			id 			=	arr[1];
			tablo 		=	arr[2];

		$.ajax({
			type:'POST',
			url :'/ajanda/hucre_kaydet.asp',
			data :{'alan':alan,'id':id,'tablo':tablo,'deger':$(this).val(),
						},
			beforeSend: function() {

				//$('#but_kaydet').html("<img src='image/loading__.gif' width='20' height='20'/>");
			  },
					success: function(sonuc) {
							//alert(sonuc);
							sonucc = sonuc.split('|');
							
							if(sonucc[0] == "ok"){
								toastr.options.positionClass = 'toast-bottom-right';
								toastr.success('Değişiklik kayıt edildi.','İşlem Yapıldı!');
								//$('#'+yuklenecekDIV).load(yuklenecekDosya+'.asp #'+yuklenecekDIV+' > *', {calisanID:degisken1, parametre2:parametre2});
							}
							else{
								toastr.options.positionClass = 'toast-bottom-right';
								toastr.error(sonucc[0],'İşlem Başarısız!');
							};
									
								
				}
		});
		});
	// ajSave işlemleri		
	
	
	
    $('.kayitSil').off().on('click' ,function() {
		var silinecekID 	=	$(this).attr('id');
		var tablo			=	$(this).attr('data-tablo');

		
			swal({
			title: 'Kayıt silinecek?',
			type: 'warning',
			showCancelButton: true,
			  confirmButtonColor: '#DD6B55',
			  confirmButtonText: 'sil',
			  cancelButtonText: 'hayır'
			}).then(
			  function(result) {
				// handle Confirm button click
				// result is an optional parameter, needed for modals with input
		
					$.ajax({
						type:'POST',
						url :'/ajanda/kayitSil.asp',
						data :{'silinecekID':silinecekID,
								'tablo':tablo,
									},
						beforeSend: function() {
				
							//$('#but_kaydet').html("<img src='image/loading__.gif' width='20' height='20'/>");
						  },
								success: function(sonuc) {
										//alert(sonuc);
										sonucc = sonuc.split('|');
										p_sonuc = sonucc[0];
										
										if(p_sonuc == "ok"){
											toastr.options.positionClass = 'toast-bottom-right';
											toastr.options.progressBar = true;
											toastr.success('Kayıt silindi.','İşlem Yapıldı!');
											$('.modal-content #'+silinecekID).closest('div').html('');
											$('#ajandaAnaDIV').load('/ajanda/ajandaAna.asp #ajandaAnaDIV > *',{ayHareket:0,sorgulananTarih:0});
										}
										else{
											toastr.options.positionClass = 'toast-bottom-right';
											toastr.options.progressBar = true;
											toastr.error('Kayıt silinemedi.','İşlem Başarısız!');
										};
										}
					});//ajax işlemi sonu
					
			  }, //confirm buton yapılanlar
			  function(dismiss) {
				// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			  } //cancel buton yapılanlar		
			);//swal sonu
    });
		
		// kayıt sil
	
			

		});
	</script>


