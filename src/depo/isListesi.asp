<!--#include virtual="/reg/rs.asp" --><%

	Response.Flush()
	kid						=	kidbul()
	gunHareket				=	cint(Request.QueryString("gunHareket"))
	sorgulananTarih			=	Request.QueryString("sorgulananTarih")
	siparisKalemID			=	Request.QueryString("siparisKalemID")
	silAjandaID				=	Request.QueryString("silAjandaID")
	yer						=	Request.QueryString("yer")

	if silAjandaID = "" then
		silAjandaID = 0
	end if

	If yer = "modal" Then
		kisaSayi	=	20
	Else
		kisaSayi	=	40
	End if
	
	
	call sessiontest()
	
    modulAd 		=   "Depo"


'##### YETKİ BUL
'##### YETKİ BUL
	yetkiKontrol	 = yetkibul(modulAd)
'##### YETKİ BUL
'##### YETKİ BUL

call logla("Depo Günlük İş Listesi")

	
			Response.Write "<div id=""ajandaAnaDIV"" class=""animated fadein"">"
				Response.Write "<div class=""card-deck"">"
					for fi = 1 to 3

						DIVTarih = date()
						if sorgulananTarih <> "" then
							DIVTarih = sorgulananTarih
						end if
						
						
						
						if fi = 1 then
							yGunHareket = gunHareket - 1							
						elseif fi = 2 then
							yGunHareket =  gunHareket + 0	
							ortaDIVTarih		=	DateAdd("d",yGunHareket,DIVTarih)				
						elseif fi = 3 then
							yGunHareket =  gunHareket + 1						
						end if
						

						yeniTarih		=	DateAdd("d",yGunHareket,DIVTarih)
						hangiYil		=	datepart("yyyy",yeniTarih)
						hangiAy			=	datepart("m",yeniTarih)
						hangiGun		=	datepart("d",yeniTarih)
						gunAd			=	WeekdayName(weekday(yeniTarih))



					
					Response.Write "<div class=""card"">"
						Response.Write "<div class=""text-left card-body"">"
						

							'#### tarih, kayıtlı resmi tatiller arasında kayıtlı mı?
								sorgu = "SELECT aciklama, tatilGunu FROM portal.isGunu WHERE tatilGunu = '" & tarihsql2(yeniTarih) & "'"
								fn2.open sorgu,sbsv5,1,3
									kayitSayi	=	fn2.recordcount
									if kayitSayi > 0 then
										resmiTatil 	=	" Resmi Tatil : <span class=""text-danger"">" & fn2("aciklama") & "</span>"
									else
										resmiTatil	=	""
									end if
								fn2.close
							'#### /tarih, kayıtlı resmi tatiller arasında kayıtlı mı?
							
							
							'##### gün - ay - yıl göster
								Response.Write "<div class=""card-title bold text-center border-bottom"">"
									if fi = 2 then
										Response.Write "<div id=""sabitBilgiler"""
											Response.Write " class=""d-none"""
											Response.Write " data-silajandaid=""" & silAjandaID & """"
											Response.Write " data-sorgulanantarih=""" & ortaDIVTarih & """"
											Response.Write " data-sipariskalemid=""" & siparisKalemID & """"
											Response.Write " data-yer=""" & yer & """"
										Response.Write "></div>"
										Response.Write "<div class=""row"">"
											Response.Write "<div class=""col-1"">"
												Response.Write "<i class=""fa fa-chevron-circle-left fa-2x text-success pointer gunHareket geri mr-2""></i>"
											Response.Write "</div>"
									end if
											Response.Write "<div class=""col-10"">"
												Response.Write hangiGun & " - " & MonthName(hangiAy) & " -" & hangiYil & " - " & gunAd
											Response.Write "</div>"
									if fi = 2 then
											Response.Write "<div class=""col-1"">"
												Response.Write "<i class=""fa fa-chevron-circle-right fa-2x text-success pointer gunHareket ileri ml-2""></i>"
											Response.Write "</div>"
										Response.Write "</div>"
									end if
								Response.Write "</div>"
								Response.Write "<div class=""h5 bold text-center"">"
									Response.Write resmiTatil
								Response.Write "</div>"
							'##### gün - ay - yıl göster
							
							'#### gün içine daha önce kayıt edilmiş olayları yaz.
									sorgu = "SELECT id, kid, hangiYil, hangiAy, hangiGun, siparisKalemID, icerik"
									sorgu = sorgu & " FROM portal.ajanda"
									sorgu = sorgu & " WHERE silindi = 0 AND kid = " & kid & " AND hangiYil = " & hangiYil & "  AND  hangiAy = " & hangiAy & " AND hangiGun = " & hangiGun
									rs.open sorgu, sbsv5,1,3
									if rs.recordcount > 0 then
										for di = 1 to rs.recordcount
											sipKalemID		=	rs("siparisKalemID")
											sipKalemID64 	=	sipKalemID
											sipKalemID64	=	base64_encode_tr(sipKalemID64)
											ajID			=	rs("id")
											icerikHam		=	rs("icerik")
											icerik			=	Replace(icerikHam,"|","<br>")
											'icerik			=	Replace(icerikHam,"<br>","")
											'icerik			=	Replace(icerik,"<b>","")
											'icerik			=	Replace(icerik,"</b>","")
											icerikKisa		=	LEFT(icerik,kisaSayi)
											if LEN(icerik) >  kisaSayi then
												icerikKisa 	= icerikKisa & "..."
											end if
									Response.Write "<div class=""row border border-dark rounded mt-2"">" 'kutu içi satırlar
										Response.Write "<div class=""col-12 text-left fontkucuk pointer hoverGel"""
										Response.Write " title=""" & icerik & """"
										Response.Write " onclick=""bootmodal('"&icerikHam&"','custom','/uretim/uretim/"&sipKalemID64&"','','Üretime Başla','Tamam','','btn-danger','','','','','')"">"
											Response.Write icerik
										Response.Write "</div>"
									Response.Write "</div>"'kutu içi satırlar
										rs.movenext
										next
									end if
									rs.close
							'#### /gün içine daha önce kayıt edilmiş olayları yaz.
						Response.Write "</div>"
					Response.Write "</div>"
					next
				Response.Write "</div>"






			Response.Write "</div>"
								
									
	
	
	
%>

	<script>
	// plan Ekleme işlemleri		
		function planEkle(silAjandaID,hangiYil,hangiAy,hangiGun,siparisKalemID,yer){
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
						
						$('#ajax').load('/planlama/plan_kaydet.asp',{hangiGun:hangiGun, hangiAy:hangiAy, hangiYil:hangiYil, siparisKalemID:siparisKalemID,yer:yer,silAjandaID:silAjandaID});

						
					  }, //confirm buton yapılanlar
					  function(dismiss) {
						// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
					  } //cancel buton yapılanlar		
					);//swal sonu
		}
	// plan Ekleme işlemleri

	// kayıt sil
		function kayitSil(silinecekID, tablo, yer) {
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
											$('#ajandaAnaDIV').load('/ajanda/ajanda.asp?yer='+yer+'&ayHareket=0&sorgulananTarih='+sonuc2+' #ajandaAnaDIV > *');
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
			$('.gunHareket').off().on('click', function () {
				
				sorgulananTarih	=	$('#sabitBilgiler').attr('data-sorgulanantarih');
				siparisKalemID	=	$('#sabitBilgiler').attr('data-sipariskalemid');
				silAjandaID		=	$('#sabitBilgiler').attr('data-silajandaid');
				yer				=	$('#sabitBilgiler').attr('data-yer');
			
				if($(this).hasClass('ileri')){
					gunHareket = 1;
					}
				else if($(this).hasClass('geri')){
					gunHareket = -1
					}
				else{gunHareket = 0};
				
				$('#ajandaAnaDIV').fadeOut('slow', function () {
					$('#ajandaAnaDIV').load('/depo/isListesi.asp?yer='+yer+'&silAjandaID='+silAjandaID+'&siparisKalemID='+siparisKalemID+'&gunHareket='+gunHareket+'&sorgulananTarih='+sorgulananTarih+' #ajandaAnaDIV > *').fadeIn('slow');
				});
					
			});
			
			
			
	
	
		});//ready
			
			
		$(document).ajaxSuccess(function() {
		
		//ileri geri okları ile sorgu
			$('.gunHareket').off().on('click', function () {
				
				sorgulananTarih	=	$('#sabitBilgiler').attr('data-sorgulanantarih');
				siparisKalemID	=	$('#sabitBilgiler').attr('data-sipariskalemid');
				silAjandaID		=	$('#sabitBilgiler').attr('data-silajandaid');
				yer				=	$('#sabitBilgiler').attr('data-yer');

				if($(this).hasClass('ileri')){
					gunHareket = 1;
					}
				else if($(this).hasClass('geri')){
					gunHareket = -1
					}
				else{gunHareket = 0};
				
				$('#ajandaAnaDIV').fadeOut('slow', function () {
					$('#ajandaAnaDIV').load('/depo/isListesi.asp?yer='+yer+'&silAjandaID='+silAjandaID+'&siparisKalemID='+siparisKalemID+'&gunHareket='+gunHareket+'&sorgulananTarih='+sorgulananTarih+' #ajandaAnaDIV > *').fadeIn('slow');
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


