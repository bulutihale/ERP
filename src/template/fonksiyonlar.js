$(document).ready(function() {
	$.ajaxSetup({timeout: 30000});
	var ajaxform = {target:'#ajax',type:'POST'};$('.ajaxform').ajaxForm(ajaxform);
	var modalform = {target:'#modalform',type:'POST'};$('.modalform').ajaxForm(modalform);
	var ortaform = {target:'#ortaalan',type:'POST'};$('.ortaform').ajaxForm(ortaform);
	$('.tarih').datepicker({format: "dd.mm.yyyy",weekStart: 1,maxViewMode: 2,language: "tr",keyboardNavigation: false,daysOfWeekHighlighted: "0,6",autoclose: true,todayHighlight: true});
	$('.summernote').summernote({height: 300});
	

	//popover aktifleştimrk için 
	$(function () {
		//"html: true" popover içindeki html kodlarının çalışması için 
		//"trigger:'focus'" popover dışında bir yere tıklandığında kapanması için
	$('[data-toggle="popover"]').popover({html:true,trigger: 'focus',container: 'body'});


	//modal içinde mouseenter ile popover görüntülemek için
			// Document nesnesine mouseenter olayını bağla ve hedef öğeyi belirle
			$(document).on("mouseenter", "[data-toggle='popoverModal']", function() {
				// Popover içeriğini göster
				$(this).popover({
					html: true,
					trigger: "focus",
					container: "body",
				}).popover("show");
			});
			
			// Mouseleave olayı olduğunda popover'ı gizle
			$(document).on("mouseleave", "[data-toggle='popoverModal']", function() {
				$(this).popover("hide");
			});
	//modal içinde mouseenter ile popover görüntülemek için
	
	
	
//popover içine tıklanabilir link koyulduğunda aşağıdakinin kullanılması gerekli --data-toggle="popoverH"-- kullan
	$('[data-toggle="popoverH"]').popover({
		html: true,
		trigger: 'manual'
	  }).on('mouseenter', function () {
		var _this = this;
		$(this).popover('show');
		 idAlan 	=	$(this).attr('data-idalan');
		 idDeger 	=	$(this).attr('data-iddeger');
		 alan	 	=	$(this).attr('data-alan');
		 tablo	 	=	$(this).attr('data-tablo');
		 deger	 	=	$(this).attr('data-deger');
		$('.popover').on('mouseleave', function () {
			$(_this).popover('hide');});
	  		}).on('shown.bs.popover', function () {
				$('.sayfaKes').off().on('click', function () {

				  // jQuery ile tetiklenecek olayları burada gerçekleştirin
				  $('#ajax').load('/portal/hucre_kaydet.asp',{idAlan:idAlan,id:idDeger,alan:alan,tablo:tablo,deger:deger}, function(){location.reload();})
				});
			  }).on('mouseleave', function () {
		var _this = this;
		setTimeout(function () {
		  if (!$('.popover:hover').length) {
			$(_this).popover('hide');
		  }
		}, 30);
	  });
//popover içine tıklanabilir link koyulduğunda yukarındakinin kullanılması gerekli --data-toggle="popoverH"-- kullan
	})
	
	$(document).ajaxComplete(function() {
		$('[data-toggle="popover"]').popover({html:true,trigger: 'focus',placement:'bottom',container: 'body'});

//popover içine tıklanabilir link koyulduğunda aşağıdakinin kullanılması gerekli --data-toggle="popoverH"-- kullan
		$('[data-toggle="popoverH"]').popover({
			html: true,
			trigger: 'manual'
		}).on('mouseenter', function () {
			var _this = this;
			$(this).popover('show');
			 idAlan 	=	$(this).attr('data-idalan');
			 idDeger 	=	$(this).attr('data-iddeger');
			 alan	 	=	$(this).attr('data-alan');
			 tablo	 	=	$(this).attr('data-tablo');
			 deger	 	=	$(this).attr('data-deger');
			$('.popover').on('mouseleave', function () {
				$(_this).popover('hide');});
				}).on('shown.bs.popover', function () {
					$('.sayfaKes').off().on('click', function () {

						// jQuery ile tetiklenecek olayları burada gerçekleştirin
						$('#ajax').load('/portal/hucre_kaydet.asp',{idAlan:idAlan,id:idDeger,alan:alan,tablo:tablo,deger:deger}, function(){location.reload();})
					});
				}).on('mouseleave', function () {
			var _this = this;
			setTimeout(function () {
			if (!$('.popover:hover').length) {
				$(_this).popover('hide');
			}
			}, 30);
		});
//popover içine tıklanabilir link koyulduğunda yukarındakinin kullanılması gerekli --data-toggle="popoverH"-- kullan
	
});
	//popover aktifleştimrk için 


	
		/////////////////////////// select2 
			$('.formSelect2').on('mouseenter',function() {

				var inputID			=	$(this).attr('id');
				var holderYazi		=	$(this).attr('data-holderyazi');
				var jsonDosya		=	$(this).attr('data-jsondosya');
				var sart			=	$(this).attr('data-sart');//özellikle birim seçiminde sadece belirli bir birimi çağırmak için
				var sartOzel		=	$(this).attr('data-sartozel');//WHERE sorgusunu olduğu gibi yazmak için
				var anaBirimFiltre	=	$(this).attr('data-anabirimfiltre');//select2 sadece ürüne ait anabirim görüntülensin, birime ait select2 class ında "anaBirimFiltre" olmalı.
				var idKullan		=	$(this).attr('data-idkullan');
				var minInput		=	$(this).attr('data-miniput');
				var defDeger		=	$(this).attr('data-defdeger');

				$(this).select2({
					
				  ajax: {
					url: '/temp/' + jsonDosya + '.asp',
					dataType: 'json',
					delay: 250,
					data: function (params) {
					  return {
						 sart:sart,
						 sartOzel:sartOzel,
						 anaBirimFiltre:anaBirimFiltre,
						 idKullan:idKullan,
						q: params.term, // search term
						page: params.page
					  };
					},
					processResults: function (data, params) {
					  // parse the results into the format expected by Select2
					  // since we are using custom formatting functions we do not need to
					  // alter the remote JSON data, except to indicate that infinite
					  // scrolling can be used
					  
					  params.page = params.page || 1;
				
					  return {
						results: data.items,
				//        pagination: {
				//          more: (params.page * 30) < data.total_count
				//        }
					  };
					},
					cache: true
				  },
				  language: "tr",
				  width: '100%',
				  minimumInputLength: minInput,
				  theme: 'bootstrap4',
				  placeholder: holderYazi,
				  allowClear: true,
				  selectOnClose: false,
				  
				});
			///// default seçilecek olan veri için
				if(defDeger != undefined){

					var a = defDeger.split("###");
					var defID = a[0];
					var defText = a[1];
					if(defID != 0){
						var defSecim = new Option(defText, defID, true, true);
						$(this).append(defSecim).trigger('change');
					}
				}
			///// default seçilecek olan veri için
				});	
		//////////////////////// select2 
	
	//////modal içinde modal açılmasını sağlayan kodlar	
	//////modal içinde modal açılmasını sağlayan kodlar	
		//'//NOTE modalları kapatırken sadece 2.modalın kapanması için kapatmak için tıkladığın elemente "data-dismiss="modal"  kullan

		$(document).on('show.bs.modal', '.modal', function() {
			const zIndex = 1040 + 10 * $('.modal:visible').length;
			$(this).css('z-index', zIndex);
			setTimeout(() => $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack'));
		  });	
	//////modal içinde modal açılmasını sağlayan kodlar
	//////modal içinde modal açılmasını sağlayan kodlar	

});


jQuery(document).ajaxSuccess(
	function(){
		var ajaxform = {target:'#ajax',type:'POST'};$('.ajaxform').ajaxForm(ajaxform);
		var modalform = {target:'#modalform',type:'POST'};$('.modalform').ajaxForm(modalform);
		var ortaform = {target:'#ortaalan',type:'POST'};$('.ortaform').ajaxForm(ortaform);
		$('.tarih').datepicker({format: "dd.mm.yyyy",weekStart: 1,maxViewMode: 2,language: "tr",keyboardNavigation: false,daysOfWeekHighlighted: "0,6",autoclose: true,todayHighlight: true});
		if($("div").hasClass('cycle_s1')){$('.cycle_s1').cycle({fx:'blindX'});}
		if($("textarea").hasClass('summernote')){$('.summernote').summernote({height: 200,spellCheck: false,
		
			toolbar: [
				// [groupName, [list of button]]
				['style', ['bold', 'italic', 'underline', 'clear']],
				['font', ['strikethrough', 'superscript', 'subscript']],
				['fontname', ['fontname']],
				['fontsize', ['fontsize']],
				['color', ['color']],
				['para', ['ul', 'ol', 'paragraph']],
				['height', ['height']]
				['table', ['table']],
				['insert', ['link', 'picture', 'video']],
				['view', ['fullscreen', 'codeview', 'help']],
			]
		
		});}

	// hem normal #ortalan'da hem de modal içinde kullanılan sayfalar için modalkapat butonu göster/gizle (ör:/ajanda/ajanda.asp)
		// ortak sayfanın en üstüne koyulacak kapat butonunu gösteren kod
			/////////"<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
		// ortak sayfanın en üstüne koyulacak kapat butonunu gösteren kod
		if($('body').hasClass('modal-open')){$('.mdi-close-circle').removeClass('d-none');}//kapat butonunu sadece modalda göster
		if($('body').hasClass('modal-open')){$('.modaldaGoster').removeClass('d-none');}//.modaldaGoster class olan divleri göster
		if($('body').hasClass('modal-open')){$('#modal-dialog .modaldaGizle, #modal-dialogfit .modaldaGizle').addClass('d-none');}//.modaldaGizle class olan divleri gizle
	// hem normal #ortalan' da hem de modal içinde kullanılan sayfalar için modalkapat butonu göster / gizle









		/////////////////////////// select2 
		if($("select").hasClass('formSelect2')){
			$('.formSelect2').on('mouseenter',function() {

				var inputID			=	$(this).attr('id');
				var holderYazi		=	$(this).attr('data-holderyazi');
				var jsonDosya		=	$(this).attr('data-jsondosya');
				var sart			=	$(this).attr('data-sart');//özellikle birim seçiminde sadece belirli bir birimi çağırmak için
				var sartOzel		=	$(this).attr('data-sartozel');//WHERE sorgusunu olduğu gibi yazmak için
				var anaBirimFiltre	=	$(this).attr('data-anabirimfiltre');//select2 sadece ürüne ait anabirim görüntülensin, birime ait select2 class ında "anaBirimFiltre" olmalı.
				var idKullan		=	$(this).attr('data-idkullan');
				var minInput		=	$(this).attr('data-miniput');
				var defDeger		=	$(this).attr('data-defdeger');

				$(this).select2({
					
				  ajax: {
					url: '/temp/' + jsonDosya + '.asp',
					dataType: 'json',
					delay: 250,
					data: function (params) {
					  return {
						 sart:sart,
						 sartOzel:sartOzel,
						 anaBirimFiltre:anaBirimFiltre,
						 idKullan:idKullan,
						q: params.term, // search term
						page: params.page
					  };

					},
					processResults: function (data, params) {
					  // parse the results into the format expected by Select2
					  // since we are using custom formatting functions we do not need to
					  // alter the remote JSON data, except to indicate that infinite
					  // scrolling can be used
					  
					  params.page = params.page || 1;
				
					  return {
						results: data.items,
				//        pagination: {
				//          more: (params.page * 30) < data.total_count
				//        }
					  };

					},
					cache: true
				  },
				  language: "tr",
				  width: '100%',
				  minimumInputLength: minInput,
				  theme: 'bootstrap4',
				  placeholder: holderYazi,
				  allowClear: true,
				  selectOnClose: false,
				  
				});
			///// default seçilecek olan veri için
				if(defDeger != undefined){
					var a = defDeger.split("###");
					var defID = a[0];
					var defText = a[1];
					if(defID != 0){
						var defSecim = new Option(defText, defID, true, true);
						$(this).append(defSecim).trigger('change');
					}
					
				}
			///// default seçilecek olan veri için
			});	
		}
		//////////////////////// select2 






	}
);


//bekleme animasyonu için ID gönder 
	function working(id,deger1,deger2){$('#'+id).html('<img src="/arayuz/working2.gif" width="'+deger1+'" height="'+deger2+'"/>');}
//bekleme animasyonu için ID gönder 

function divackapa(id){if ($(id).hasClass('hide')){$(id).removeClass('hide');}else{$(id).addClass('hide');}}

function bootmodal(mesaj,tur,okhedef,cancelhedef,okbaslik,cancelbaslik,okstyle,cancelstyle,callbackFocusOl,veriyollamaturu,closedelay,formverileri,ek5)
// örnek bootmodal('Lütfen Sadece Sayısal Değer Giriniz','custom','','','','','','','','','','','')
{
	if(tur=='confirm'){
		bootbox.confirm(mesaj, function(result){
			if(okhedef||''){if(result==true){document.location=okhedef}}
			if(cancelhedef||''){if(result==false){document.location=cancelhedef}}
		})
	}
	if(tur=='alert'){
		bootbox.alert(mesaj,function(){
			if(callbackfonksiyon||''){callbackfonksiyon}
		});
	}
	if(tur=='custom'){
		if(okstyle==''){okstyle='btn-success'}
		if(cancelstyle==''){cancelstyle='btn-primary'}
		if(cancelbaslik==''){cancelbaslik='OK'}
		if(okbaslik||''){
			bootbox.dialog({
				message: mesaj,
				title: '',
				onEscape: function() {},
				backdrop: true,
				// value:'xx',
				// container:'body',
				// inputType:'text',
				buttons: {
					success: {
						label:okbaslik,
						className: okstyle,
						callback: function() {
							if(okhedef||''){
								if(veriyollamaturu=='ajax'){
									if(formverileri.length==0){
									//if($('#'+formverileri).length==0){
										//form verisi kullanılmadıysa
										$('#ajax').load(okhedef)
									}else{
										//form verisi kullanıldıysa
										formverileri=$('#'+formverileri).val();
										formverileri = formverileri.replaceAll(' ','%27');
										$('#ajax').load(okhedef + '&customformverileri=' + formverileri)
									}
								}else{
									document.location=okhedef
								}
							}
						}
					},
					main: {
						label:cancelbaslik,
						className: cancelstyle,
						callback: function() {
							// if(cancelhedef||''){document.location=cancelhedef}
							if(cancelhedef||''){
								if(veriyollamaturu=='ajax'){
									if(formverileri.length==0){
										//if($('#'+formverileri).length==0){
											//form verisi kullanılmadıysa
										$('#ajax').load(cancelhedef)
									}else{
										//form verisi kullanıldıysa
										formverileri=$('#'+formverileri).val();
										formverileri = formverileri.replaceAll(' ','%27');
										$('#ajax').load(cancelhedef + '&customformverileri=' + formverileri)
									}
								}else{
									document.location=cancelhedef
								}
							}
						}
					}
				}
			});
		}else{
			bootbox.dialog({
				message: mesaj,
				title: '',
				onEscape: function() {},
				backdrop: true,
				buttons: {
					main: {
						label:cancelbaslik,
						className: cancelstyle,
						callback: function() {
							if(callbackFocusOl||''){
//								$(callbackFocusOl).focus();
//								$('#geposta').focus();
//								alert(callbackFocusOl);
							}
							if(cancelhedef||''){document.location=cancelhedef}
						}
					}
				}
			});
		}
	}

	if(tur=='prompt'){
		bootbox.prompt(mesaj, function(result){
			if(result==null||result==''){}else{
				$.post(okhedef,{cevap:result,id:formverileri});
				if(cancelhedef==''){}else{document.location=cancelhedef}
			}
		});
	}


	if(closedelay==''){}else{
		window.setTimeout(function(){
			bootbox.hideAll();
		}, closedelay)
	}
}




function modalajax(t){$('#modal-dialog .modal-body').load(t);$('#modal-dialog').modal('show')}
function modalajaxfit(t){$('#modal-dialogfit .modal-body').load(t);$('#modal-dialogfit').modal('show')}
function modalajaxfitozelKapat(t){$('#modal-dialogfit .modal-body').load(t);$('#modal-dialogfit').modal({ backdrop: 'static', keyboard: false });$('#modal-dialogfit').modal('show')}
function modalkapat(){$('.modal').modal('hide');}


function otomatikbuyut(id){$('#'+id).keyup(function(){this.value = this.value.toUpperCase();});}





// cycle
	if($("div").hasClass('cycle_s1')){$('.cycle_s1').cycle({fx:'blindX'});}
	if($("div").hasClass('cycle_s2')){$('.cycle_s2').cycle({fx:'blindY'});}
	if($("div").hasClass('cycle_s3')){$('.cycle_s3').cycle({fx:'blindZ'});}
	if($("div").hasClass('cycle_s4')){$('.cycle_s4').cycle({fx:'cover'});}
	$('.slide').cycle({ 
		fx:      'turnDown', 
		delay:   -4000 
	});
// cycle






function numara(nesne,para,uyari) 
//Kullanımı : numara(this,true,true)
//Kullanımı : numara(this,false,'Bu alana sadece rakam yazılabilir')
{
	if(para==true){var ValidChars = "0123456789,.";}else{var ValidChars = "0123456789+";}
	var IsNumber=true;
	var Char;
		for (i = 0; i < nesne.value.length && IsNumber == true; i++)
		{
			Char = nesne.value.charAt(i);
			if (ValidChars.indexOf(Char) == -1)
			{
				if(uyari==true){
					bootmodal('Lütfen Sadece Sayısal Değer Giriniz','custom','','','','','','','','','','','')

				}
				else if(uyari=='yok'){}
				else if(uyari||''){
					bootmodal(uyari,'custom','','','','','','','','','','','')
				}
				nesne.value = nesne.value.substring(0,i);
				
				break;
			}
		}
	return IsNumber;
}


//'//NOTE - sistemde seçilen bir ürünün anaBirimi tanımlı mı? tanımlı değil ise modal aç seçtir.
	function anaBirimKontrol(stokID,inputID){
	//anaBirimKontrol($(this).val(),$(this).attr('id')) --> kullanım
		if(stokID == null){return false};
		$.post("/portal/stokHareketKontrol.asp", {stokID: stokID}, function(data, status){
			gelenSonuc	=	data.split('|');
			sonuc0		=	gelenSonuc[0];
			sonuc1		=	gelenSonuc[1];
			sonuc2		=	gelenSonuc[2];
			//if(data != 'tanimlanamaz')
			if(!$.isNumeric(sonuc0))
			{
				$('#'+inputID).val(null).trigger('change');
				swal('Ana birim tanımlı değil','açılan pencerden ürüne ait ana birim tanımlaması yapınız.');
				modalajax(sonuc0)
			}else{
			//select2 sadece ürüne ait anabirim görüntülensin, birime ait select2 class ında "anaBirimFiltre" olmalı.
				if($('.anaBirimFiltre').hasClass('select2-hidden-accessible')){
					$('.anaBirimFiltre').val(null).select2('destroy');
				}
				$('#'+inputID).attr('data-secilenstokid',sonuc2);
				$('.anaBirimFiltre').removeAttr('data-anabirimfiltre');
				$('.anaBirimFiltre').attr('data-anabirimfiltre',sonuc1);
				toastr.info('birim listesine ana birim kuralı uygulandı','BİLGİ');
			//select2 sadece ürüne ait anabirim görüntülensin, birime ait select2 class ında "anaBirimFiltre" olmalı.
			};
		});
	}
// sistemde seçilen bir ürürnün anaBirimi tanımlı mı? tanımlı değil ise modal aç seçtir.

//stok ana kartını aç
	function stokKartAc(stokID64){
		if(stokID64 != undefined){
			modalkapat();
			modalajax('/stok/stok_yeni.asp?gorevID='+stokID64);
		}else{swal('ürün seçimi yapmadınız.','');}
	}
//stok ana kartını aç

//farklı birim miktarlarını anaBirim miktarına çevir
	function anaBirimMiktarHesap(inputID, stokID){

		if(stokID != undefined){
			modalajax("/portal/birimMiktarHesap.asp?stokID="+stokID+"&inputID="+inputID);
		}else{swal('ürün seçimi yapmadınız.','');}
	}
//stok ana kartını aç

	// DEPO girişi Bekleyen ürünü, reddet veya onayla ve depoya giriş kaydet
	function urunCevap(cevap,idAlan,stokHareketID,alan,tablo,deger,refHareketID,ntfDeger,depoKategori,refreshDIV,refreshFile,receteAdimID64,ajandaID64,stokID64,girisDepoID,secilenReceteID,secilenDepoID,surecDepoID){

	if(cevap == 'kabul'){
		var baslik = 'Ürünün kesin kabulü yapılsın mı?'
		var durum = 'success'
	}else if(cevap == 'red'){
		var baslik= 'Ürün trasferi red edilsin mi?'
		var durum = 'error'
	}
		swal({
		title: baslik,
		type: durum,
		showCancelButton: true,
			confirmButtonColor: '#DD6B55',
			confirmButtonText: 'Devam',
			cancelButtonText: 'İptal'
		}).then(
			function(result) {
			// handle Confirm button click
			// result is an optional parameter, needed for modals with input
			
			$('#ajax').load('/portal/hucre_kaydet.asp',{
				idAlan:idAlan,
				id:stokHareketID,
				alan:alan,
				tablo:tablo,
				deger:deger,
				ntfDeger:ntfDeger}, function(){
			if(cevap == 'red'){
				$('#ajax').load('/portal/hucre_kaydet.asp',{
					idAlan:idAlan,
					id:refHareketID,
					alan:alan,
					tablo:tablo,
					deger:deger})} //kabul edilmeyecekse ise çıkışı iptal et
				if(refreshFile == 'bekleyenListe'){
					$('#'+refreshDIV).load('/depo/bekleyen_liste/'+depoKategori+' #'+refreshDIV+' >*');
				}else if(refreshFile == 'depoTransfer'){
					$('#'+refreshDIV).load('/depo/depo_transfer.asp?listeTur='+depoKategori+'&receteAdimID='+receteAdimID64+'&ajandaID='+ajandaID64+'&stokID='+stokID64+'&secilenDepoID='+secilenDepoID+'&surecDepoID='+surecDepoID+' #'+refreshDIV+' >*', {girisDepoID:girisDepoID});
					$('#receteAdim').load('/uretim/uretim.asp?secilenReceteID='+secilenReceteID+'&secilenDepoID='+secilenDepoID+'&surecDepoID='+surecDepoID+' #receteAdim > *')
				}
			});
		}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
	}
// DEPO girişi Bekleyen ürünü, reddet veya onayla ve depoya giriş kaydet


//alan hesapla
	//function alanHesap(enUzunluk,boyUzunluk,enBoyBirimID,sonucBirim){
		function alanHesap(enUzunlukID,boyUzunlukID,enBoyBirimAlanID,sonucBirimAlanID,sonucAlanID){
		
		var enUzunluk	= 	$('#'+enUzunlukID).val().replace(',','.');
		var boyUzunluk	= 	$('#'+boyUzunlukID).val().replace(',','.');
		var enBoyBirim	=	$('#'+enBoyBirimAlanID).val();
		var sonucBirim	=	$('#'+sonucBirimAlanID).val();

		if($.isNumeric(enUzunluk) && $.isNumeric(boyUzunluk)){
			if(enBoyBirim == 'MT' && sonucBirim == 'M2' ){
				var hamHesap		=	enUzunluk * boyUzunluk
			}else if(enBoyBirim == 'CM' && sonucBirim == 'M2' ){
				var hamHesap = (enUzunluk * boyUzunluk) / 10000
			}
			var hamHesap = hamHesap.toString().replace('.',',')
			$('#'+sonucAlanID).val(hamHesap);
		}
		
	}
//alan hesapla

// tooltip çalışsabilsin
	//elementte, "data-toggle="tooltip" ve "title="açıklama içerik" olmalı."
$(function () {
	$('[data-toggle="tooltip"]').tooltip()
  })
// tooltip çalışsabilsin


// contenteditable div leri değiştirmek için "blur" ile tetiklenen ajSave
	function ajSaveBlur(inputID, tabloID, tablo, alan, updateDosya, deger, ek1, ek2, ek3){

		$.ajax({
			type:'POST',
			url :'/teklif2/hucre_kaydet.asp',
			data :{'alan':alan,'id':tabloID,'tablo':tablo,'deger':deger,
						},
			beforeSend: function() {

				//$(this).parent().html("<img src='image/working2.gif' width='20' height='20'/>");
			},
					success: function(sonuc) {
							//alert(sonuc);
							sonucc = sonuc.split('|');
							p_sonuc = sonucc[0];
							
							if(p_sonuc == "ok"){
								toastr.options.positionClass = 'toast-bottom-right';
								toastr.success('Değişiklik kayıt edildi.','İşlem Yapıldı!');
								
								// $.post('/teklif2/'+updateDosya+'.asp',{}, function(data){
								// 	var $data = $(data);
								// 	$('#'+inputID).parent().html($data.find('#'+inputID).parent().html());
								// });
								
							}
							else{
								toastr.options.positionClass = 'toast-bottom-right';
								toastr.error('Kayıt yapılmadı.','İşlem Başarısız!');
							};
				}
		});
		};
// contenteditable div leri değiştirmek için "blur" ile tetiklenen ajSave


function teklifPDFmail(id64,mailDurum,divID){
	//	alert(secilenReceteID)
		swal({
			title:'ONAY',
			text: 'Teklifin PDF formatına dönüştürülmesini ve e-posta olarak gönderilmesini onaylıyor musunuz?',
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#DD6B55',
			confirmButtonText: 'evet',
			cancelButtonText: 'hayır'
		}).then(
			function(result) {
			// handle Confirm button click
			// result is an optional parameter, needed for modals with input
			working(divID,30,30);
			$('#ajax').load('/teklif2/teklif_firma_pdf/'+id64+'|'+mailDurum)

		}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
		}



// hucreKaydet işlemleri		
function hucreKaydetGenel(idAlan, id, alan, tablo, deger, baslik, updateDIV, updateURL, postDeger, ek4) {
	
		/* idAlan 		: 	tablonun id değerinin olduğu alanın adı
			id			: 	id değeri
			updateDIV	:	update edilecek div in ID değeri
			updateURL	:	update edilecek DIV in bulunduğu URL
			postDeger	:	güncellenecek DIV için post edilmesi gereken parametreler (örnek kullanım: "cariID_8**stokID_954")
			baslik		:	swal uyarısında görüntülenecek metin
		*/

		//eğer ondalıklı sayı kayıt ediliyorsa "." ve "," sorunu çıkmasın
			
			var decimalSeparator = (1.1).toLocaleString().substring(1, 2); // Ondalık ayırıcısını alır

			if (decimalSeparator === '.' ) {
				if (deger.toString().includes(',')){
						deger = deger.toString().replace(',','.');
					}
			}else{
				if (deger.toString().includes('.')){
						deger = deger.toString().replace('.',',');
					}
			}
				
		//eğer ondalıklı sayı kayıt ediliyorsa "." ve "," sorunu çıkmasın

		var postDegerBol = postDeger.split("**");
		var postData = {};
	for (var i = 0; i < postDegerBol.length; i++) {
	  var postData1 = postDegerBol[i].split("_")[0];
	  var postData2 = postDegerBol[i].split("_")[1];

	  postData[postData1] = postData2;
	}
  
	function executeCodeBlock() {
	  $('#ajax').load('/portal/hucre_kaydet.asp', {idAlan: idAlan, id: id, alan: alan, tablo: tablo, deger: deger}, function(response, status, xhr) {
		if(updateDIV !== ''){

		$('#' + updateDIV).load(updateURL + ' #' + updateDIV + ' > *', postData, function(response, status, xhr) {
		  if (status == "error") {
			toastr.options.positionClass = 'toast-bottom-right';
			toastr.error('İşlem başarısız (' + xhr.statusText + xhr.status + ')', 'HATA!');
		  } else if (status == "success") {
			toastr.options.positionClass = 'toast-bottom-right';
			toastr.success('İşlem tamamlandı', 'OK');
		  }
		});
	}else{
		if (status == "error") {
			toastr.options.positionClass = 'toast-bottom-right';
			toastr.error('İşlem başarısız (' + xhr.statusText + xhr.status + ')', 'HATA!');
		  } else if (status == "success") {
			toastr.options.positionClass = 'toast-bottom-right';
			toastr.success('İşlem tamamlandı', 'OK');
		  }
	}
	  });
	}
  
	if (baslik !== '') {
	  swal({
		title: baslik,
		type: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#DD6B55',
		confirmButtonText: 'evet',
		cancelButtonText: 'hayır'
	  }).then(function(result) {
		// handle Confirm button click
		// result is an optional parameter, needed for modals with input
		executeCodeBlock();
	  }).catch(function(dismiss) {
		// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
	  });
	} else {
	  executeCodeBlock();
	}
  }


// hucreKaydet işlemleri		

