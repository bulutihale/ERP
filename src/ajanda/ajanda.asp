<!--#include virtual="/reg/rs.asp" --><%

	Response.Flush()
	kid						=	kidbul()
	ayHareket				=	cint(Request.QueryString("ayHareket"))
	sorgulananTarih			=	cdate(Request.QueryString("sorgulananTarih"))
	siparisKalemID			=	Request.QueryString("siparisKalemID")
	silAjandaID				=	Request.QueryString("silAjandaID")
	yer						=	Request.QueryString("yer")
	isTur					=	Request.QueryString("isTur")

	if silAjandaID = "" then
		silAjandaID = 0
	end if

	If yer = "modal" Then
		kisaSayi	=	20
	Else
		kisaSayi	=	40
	End if
	
	
	call sessiontest()
	
    modulAd 		=   "Planlama"


'##### YETKİ BUL
'##### YETKİ BUL
	yetkiKontrol	 = yetkibul(modulAd)
'##### YETKİ BUL
'##### YETKİ BUL

call logla("Planlama ajanda sayfası girişi")

if yetkiKontrol > 0 then
	
	if ayHareket = 0 AND sorgulananTarih = 0 then
		hangiYil		=	datepart("yyyy",date())
		hangiAy			=	datepart("m",date())
		sorgulananTarih	=	DateSerial(hangiYil, hangiAy, 1)
	elseif ayHareket <> 0 OR sorgulananTarih <> 0 then
		sorgulananTarih	=	DateAdd("m",ayHareket,sorgulananTarih)
		hangiYil		=	datepart("yyyy",sorgulananTarih)
		hangiAy			=	datepart("m",sorgulananTarih)
	end if
	
	yilDeger	=	hangiYil
	ayDeger		=	hangiAy



	'	############# 1 aylık grid
		
	
		aySonGun		=	ayingunleri(hangiAy, hangiYil)
			Response.Write "<div id=""ajandaAnaDIV"" class=""animated fadein card"">"
				Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
				Response.Write "<div class=""text-left card-body"">"
				
					Response.Write "<div id=""sabitBilgiler"""
						Response.Write " class=""d-none"""
						Response.Write " data-silajandaid=""" & silAjandaID & """"
						Response.Write " data-sorgulanantarih=""" & sorgulananTarih & """"
						Response.Write " data-sipariskalemid=""" & siparisKalemID & """"
						Response.Write " data-yer=""" & yer & """"
						Response.Write " data-istur=""" & isTur & """"
					Response.Write "></div>"
				
				
				'##### yıl ve ay göster
					Response.Write "<div class=""h3 bold text-center"">"
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
						Response.Write "<div class=""row fontkucuk "" style=""height:120px"">"'günler satırı başla. bilerek döngünün dışında başladı, döngü sonunda kapanıp açılıyor.
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
										'kutu çerçevesi
										

										Response.Write "<div class=""col h-100 border border-dark  scroll-ekle3 " & bugunClass & """"
										if siparisKalemID <> "" then
										 	Response.Write " onclick=""planEkle("&silAjandaID&","&yilDeger&","&ayDeger&","&zi&","&siparisKalemID&",'"&yer&"','"&isTur&"')"""
										end if
										 Response.Write ">"
											
											Response.Write "<div class=""row p-0"">" 'kutu içi satırlar
											
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

											Response.Write "</div>"'kutu içi satırlar
											
											'#### gün içine daha önce kayıt edilmiş olayları yaz.
													sorgu = "SELECT id, kid, hangiYil, hangiAy, hangiGun, siparisKalemID, icerik, isTur, bagliAjandaID"
													sorgu = sorgu & " FROM portal.ajanda"
													sorgu = sorgu & " WHERE silindi = 0 AND kid = " & kid & " AND hangiYil = " & hangiYil & "  AND  hangiAy = " & hangiAy & " AND hangiGun = " & zi
													rs.open sorgu, sbsv5,1,3
													if rs.recordcount > 0 then
														for di = 1 to rs.recordcount
															sipKalemID		=	rs("siparisKalemID")
															sipKalemID64 	=	sipKalemID
															sipKalemID64	=	base64_encode_tr(sipKalemID64)
															ajID			=	rs("id")
															icerikHam		=	rs("icerik")
															isTur			=	rs("isTur")
															bagliAjandaID	=	rs("bagliAjandaID")
															icerikHam		=	Replace(icerikHam,"|","<br>")
															icerik			=	Replace(icerikHam,"<br>","")
															icerik			=	Replace(icerik,"<b>","")
															icerik			=	Replace(icerik,"</b>","")
															icerikKisa		=	LEFT(icerik,kisaSayi)
															if LEN(icerik) >  kisaSayi then
																icerikKisa 	= icerikKisa & "..."
															end if
													Response.Write "<div class=""row border border-dark rounded mt-1 p-0"">" 'kutu içi satırlar
												'####### ajanda kaydı silme
													if yetkiKontrol > 7 then
														Response.Write "<div id=""" & ajID & """ class=""pointer col-1 text-left hoverGel p-0 m-0"""
														if sipKalemID = 0 AND isTur = "plan" AND not isnull(bagliAjandaID) then
															Response.Write " onclick=""swal('Bağlı işlem silinemez','')"""
														else
															Response.Write " onclick=""kayitSil(" & ajID & ",'portal.ajanda','" & yer & "', '" & isTur & "')"""
														end if
														Response.Write ">"
															Response.Write "<i class=""fa fa-minus-circle text-danger""></i>"
														Response.Write "</div>"
													end if
												'####### /ajanda kaydı silme
														Response.Write "<div class=""col-10 text-left fontkucuk2 pointer hoverGel p-0 m-0"""
														Response.Write " title=""" & icerik & """"
														Response.Write " onclick=""bootmodal('"&icerikHam&"','custom','/uretim/uretim/"&sipKalemID64&"','','Üretime Başla','Tamam','','btn-danger','','','','','')"">"
															Response.Write icerikKisa
														Response.Write "</div>"
												'####### ajanda kaydının tarihini değiştirme
													if yetkiKontrol > 2 then
														Response.Write "<div id=""" & ajID & """"
														if sipKalemID = 0 AND isTur = "plan" AND not isnull(bagliAjandaID) then
															Response.Write " onclick=""swal('Bağlı işlem değiştirilemez','')"""
														else
															Response.Write " onclick=""planDegistir(" & ajID & "," & yilDeger & "," & ayDeger & "," & zi & "," & sipKalemID & ",'" & yer & "','" & isTur & "')"""
														end if	
															Response.Write " class=""pointer col-1 text-center hoverGel p-0 m-0"">"
															Response.Write "<i class=""mdi mdi-arrow-all text-danger""></i>"
														Response.Write "</div>"
													end if
												'####### /ajanda kaydının tarihini değiştirme
													Response.Write "</div>"'kutu içi satırlar
														rs.movenext
														next
													end if
													rs.close
											'#### /gün içine daha önce kayıt edilmiş olayları yaz.
											
											
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
		else
			'call yetkisizGiris("","","")
			call jsrun("swal('Yetkisiz İşlem','')")
		end if
	
	
%>

	<script>
	// plan Değiştirme işlemleri		
		function planDegistir(silAjandaID,hangiYil,hangiAy,hangiGun,siparisKalemID,yer,isTur){
				sorgulananTarih	=	$('#sabitBilgiler').attr('data-sorgulanantarih');
					swal({
					//title: hangiGun+'.'+hangiAy+'.'+hangiYil+' gününe üretim planı eklensin mi?',
					title: 'Plan tarihini değiştirmek istediğiniz güne tıklayınız.',
					type: 'warning',
					showCancelButton: true,
					  confirmButtonColor: '#DD6B55',
					  confirmButtonText: 'devam',
					  cancelButtonText: 'iptal'
					}).then(
					  function(result) {
						// handle Confirm button click
						// result is an optional parameter, needed for modals with input
					if(yer == 'modal'){
						yuklenecekDIV = 'ajandaAnaDIV'
						}else{
						yuklenecekDIV = 'ortaalan'
							}
						$('#'+yuklenecekDIV).load('/ajanda/ajanda.asp?silAjandaID='+silAjandaID+'&sorgulananTarih='+sorgulananTarih+'&siparisKalemID='+siparisKalemID+'&yer='+yer+'&isTur='+isTur);

						
					  }, //confirm buton yapılanlar
					  function(dismiss) {
						// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
					  } //cancel buton yapılanlar		
					);//swal sonu
		}
	// plan Değiştirme işlemleri		
	
	// plan Ekleme işlemleri		
		function planEkle(silAjandaID,hangiYil,hangiAy,hangiGun,siparisKalemID,yer,isTur){
					swal({
					title: hangiGun+'.'+hangiAy+'.'+hangiYil+' gününe üretim planı eklensin mi?',
					type: 'warning',
					showCancelButton: true,
					  confirmButtonColor: '#DD6B55',
					  confirmButtonText: 'evet',
					  cancelButtonText: 'hayır'
					}).then(
					  function(result) {
						// handle Confirm button click
						// result is an optional parameter, needed for modals with input
						
						$('#ajax').load('/planlama/plan_kaydet.asp',{hangiGun:hangiGun, hangiAy:hangiAy, hangiYil:hangiYil, siparisKalemID:siparisKalemID,yer:yer,silAjandaID:silAjandaID,isTur:isTur});

						
					  }, //confirm buton yapılanlar
					  function(dismiss) {
						// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
					  } //cancel buton yapılanlar		
					);//swal sonu
		}
	// plan Ekleme işlemleri

	// kayıt sil
		function kayitSil(silinecekID, tablo, yer, isTur) {
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
										sonuc2	= sonucc[1];
										
										if(p_sonuc == "ok"){
											toastr.options.positionClass = 'toast-bottom-right';
											toastr.options.progressBar = true;
											toastr.success('Kayıt silindi.','İşlem Yapıldı!');
											$('.modal-content #'+silinecekID).closest('div').html('');
											$('#ajandaAnaDIV').load('/ajanda/ajanda.asp?isTur='+isTur+'&yer='+yer+'&ayHareket=0&sorgulananTarih='+sonuc2+' #ajandaAnaDIV > *');
											if(yer == 'modal'){
												$('#ortaalan').load('/satis/siparis_liste.asp');
											}
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
		}
	// kayıt sil



		$(document).ready(function() {
	
		//ileri geri okları ile sorgu
			$('.ayHareket').off().on('click', function () {
				
				sorgulananTarih	=	$('#sabitBilgiler').attr('data-sorgulanantarih');
				siparisKalemID	=	$('#sabitBilgiler').attr('data-sipariskalemid');
				silAjandaID		=	$('#sabitBilgiler').attr('data-silajandaid');
				yer				=	$('#sabitBilgiler').attr('data-yer');
				isTur			=	$('#sabitBilgiler').attr('data-istur');
				
				if($(this).hasClass('ileri')){
					ayHareket = 1;
					}
				else if($(this).hasClass('geri')){
					ayHareket = -1
					}
				else{ayHareket = 0};
				
				$('#ajandaAnaDIV').fadeOut('slow', function () {
					$('#ajandaAnaDIV').load('/ajanda/ajanda.asp?isTur='+isTur+'&yer='+yer+'&silAjandaID='+silAjandaID+'&siparisKalemID='+siparisKalemID+'&ayHareket='+ayHareket+'&sorgulananTarih='+sorgulananTarih+' #ajandaAnaDIV > *').fadeIn('slow');
				});
					
			});
			
			
			
	
	
		});//ready
			
			
		$(document).ajaxSuccess(function() {
		
		//ileri geri okları ile sorgu
			$('.ayHareket').off().on('click', function () {
				
				sorgulananTarih	=	$('#sabitBilgiler').attr('data-sorgulanantarih');
				siparisKalemID	=	$('#sabitBilgiler').attr('data-sipariskalemid');
				silAjandaID		=	$('#sabitBilgiler').attr('data-silajandaid');
				yer				=	$('#sabitBilgiler').attr('data-yer');
				isTur			=	$('#sabitBilgiler').attr('data-istur');

				if($(this).hasClass('ileri')){
					ayHareket = 1;
					}
				else if($(this).hasClass('geri')){
					ayHareket = -1
					}
				else{ayHareket = 0};
				
				$('#ajandaAnaDIV').fadeOut('slow', function () {
					$('#ajandaAnaDIV').load('/ajanda/ajanda.asp?isTur='+isTur+'&yer='+yer+'&silAjandaID='+silAjandaID+'&siparisKalemID='+siparisKalemID+'&ayHareket='+ayHareket+'&sorgulananTarih='+sorgulananTarih+' #ajandaAnaDIV > *').fadeIn('slow');
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
	


		});
	</script>


