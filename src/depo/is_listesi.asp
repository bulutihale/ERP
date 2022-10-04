<!--#include virtual="/reg/rs.asp" --><%



	Response.Flush()
	kid						=	kidbul()
	gunHareket				=	cint(Request.QueryString("gunHareket"))
	ajandaSorguTarih		=	Session("sayfa5")
	if ajandaSorguTarih <> "" then
		sorgulananTarih	=	ajandaSorguTarih
	else
		sorgulananTarih			=	Request.QueryString("sorgulananTarih")
	end if
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
										if tarihsql2(yeniTarih) = tarihsql2(date()) AND fi = 2 then
											tarihClass = " bg-warning col-10 "
										elseif tarihsql2(yeniTarih) <> tarihsql2(date()) AND fi = 2 then
											tarihClass = " col-10 "
										elseif tarihsql2(yeniTarih) = tarihsql2(date()) AND fi <> 2 then
											tarihClass = " bg-warning col-12 "
										else
											tarihClass = " rounded col-12 "
										end if
											Response.Write "<div class=""text-center rounded" & tarihClass & """>"
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
									sorgu = "SELECT id, kid, hangiYil, hangiAy, hangiGun, siparisKalemID, icerik, isTur, stokID, receteAdimID, tamamlandi"
									sorgu = sorgu & " FROM portal.ajanda"
									sorgu = sorgu & " WHERE silindi = 0 AND kid = " & kid & " AND hangiYil = " & hangiYil & "  AND  hangiAy = " & hangiAy & " AND hangiGun = " & hangiGun
									rs.open sorgu, sbsv5,1,3
									if rs.recordcount > 0 then
										for di = 1 to rs.recordcount
											sipKalemID		=	rs("siparisKalemID")
											sipKalemID64 	=	sipKalemID
											sipKalemID64	=	base64_encode_tr(sipKalemID64)
											stokID			=	rs("stokID")
											stokID64 		=	stokID
											stokID64		=	base64_encode_tr(stokID64)
											isTur			=	rs("isTur")
											receteAdimID	=	rs("receteAdimID")
											receteAdimID64	=	receteAdimID
											receteAdimID64	=	base64_encode_tr(receteAdimID64)
											ajandaID		=	rs("id")
											ajandaID64		=	ajandaID
											ajandaID64		=	base64_encode_tr(ajandaID64)
											tamamlandi		=	rs("tamamlandi")
											icerikHam		=	rs("icerik")
											icerik			=	Replace(icerikHam,"|","<br>")
											'icerik			=	Replace(icerikHam,"<br>","")
											'icerik			=	Replace(icerik,"<b>","")
											'icerik			=	Replace(icerik,"</b>","")
											icerikKisa		=	LEFT(icerik,kisaSayi)
											if LEN(icerik) >  kisaSayi then
												icerikKisa 	= icerikKisa & "..."
											end if
											if isTur = "uretimPlan" then
												kutuClass	=	" border-info" 
											elseif isTur = "transfer" then
												kutuClass	=	" border-warning " 
											end if
											if tamamlandi = 1 then
												deger 	=	0
												divBG	=	" bg-success "
												ikon	=	" mdi mdi-calendar-check "
											else
												deger 	=	1
												divBG	=	" bg-danger "
												ikon	=	" mdi mdi-timer-sand "
											end if
									Response.Write "<div class=""row border  rounded mt-2"&kutuClass&""">" 'kutu içi satırlar
										Response.Write "<div class=""col-11 text-left fontkucuk pointer hoverGel"""
										Response.Write " title=""" & icerik & """"
											if isTur = "uretimPlan" then
												Response.Write " onclick=""bootmodal('"&icerik&"','custom','/uretim/uretim/"&sipKalemID64&"','','Üretime Başla','Kapat','','btn-danger','','','','','')"">"
											elseif isTur = "transfer" then
												Response.Write " onclick=""modalajax('/depo/depo_transfer.asp?receteAdimID="&receteAdimID64&"&ajandaID=" & ajandaID64 & "&stokID=" & stokID64 & "')"">"
											end if
											Response.Write icerik
										Response.Write "</div>"
										if yetkiKontrol > 5 then
										if isTur = "transfer" then
											Response.Write "<div class=""col-1 text-center pointer hoverGel "&divBG&""" onclick=""hucreKaydet('id',"&ajandaID&",'tamamlandi','portal.ajanda',"&deger&")""><div class=""mt-3 align-middle""><i class="""&ikon&"""></i></div></div>"
										end if
										end if
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
	// hucreKaydet işlemleri		
		function hucreKaydet(idAlan,id,alan,tablo,deger,refHareketID,yer,sorgulananTarih){
				sorgulananTarih	=	$('#sabitBilgiler').attr('data-sorgulanantarih');
				yer				=	$('#sabitBilgiler').attr('data-yer');
				if(deger == 1){var baslik = 'İşlem tamamlandı olarak işaretlensin mi?'
				}else
				{var baslik = 'İşlem tamamlandı kaydı kaldırılsın mı?'};
			swal({
			title: baslik,
			type: 'warning',
			showCancelButton: true,
				confirmButtonColor: '#DD6B55',
				confirmButtonText: 'evet',
				cancelButtonText: 'hayır'
			}).then(
				function(result) {
				// handle Confirm button click
				// result is an optional parameter, needed for modals with input
					$('#ajax').load('/portal/hucre_kaydet.asp',{idAlan:idAlan,id:id,alan:alan,tablo:tablo,deger:deger})
					$('#ajandaAnaDIV').load('/depo/is_listesi.asp?yer='+yer+'&ayHareket=0&sorgulananTarih='+sorgulananTarih+' #ajandaAnaDIV > *');
				}, //confirm buton yapılanlar
				function(dismiss) {
				// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
				} //cancel buton yapılanlar		
			);//swal sonu
		}
	// hucreKaydet işlemleri		


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
					$('#ajandaAnaDIV').load('/depo/is_listesi.asp?yer='+yer+'&silAjandaID='+silAjandaID+'&siparisKalemID='+siparisKalemID+'&gunHareket='+gunHareket+'&sorgulananTarih='+sorgulananTarih+' #ajandaAnaDIV > *').fadeIn('slow');
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
					$('#ajandaAnaDIV').load('/depo/is_listesi.asp?yer='+yer+'&silAjandaID='+silAjandaID+'&siparisKalemID='+siparisKalemID+'&gunHareket='+gunHareket+'&sorgulananTarih='+sorgulananTarih+' #ajandaAnaDIV > *').fadeIn('slow');
				});
					
			});


		});
	</script>


