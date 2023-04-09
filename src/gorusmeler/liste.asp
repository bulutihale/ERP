<!--#include virtual="/reg/rs.asp" --><%

	kid						=	kidbul()
	arama					=	Request.Form("arama")


'##### YETKİ BUL
'##### YETKİ BUL
	sorgu		=	""
	sayfaadi	=	"Görüşme Kayıtları"
'##### YETKİ BUL
'##### YETKİ BUL

'### değerleri al
	dosyaKayitTip	=	Request.Querystring("dosyaKayitTip")
	ihaleID64		=	Request.Querystring("ihaleID")
	ihaleID			=	ihaleID64
	ihaleID			=	base64_decode_tr(ihaleID)
'### değerleri al

sorgu = "SELECT c.cariAd as cariAD FROM teklifv2.ihale i"_
	&" INNER JOIN cari.cari c ON i.cariID = c.cariID"_
	&" WHERE i.id = " & ihaleID
	rs.open sorgu,sbsv5,1,3
if rs.recordcount > 0 then
	kurumAd	=	rs("cariAD")
end if
	rs.close


Response.Write "<div class=""card card-primary"">"
Response.Write "<div class=""card-header""><i class=""fa fa-bullhorn"" aria-hidden=""true""></i>" & sayfaadi & " "& kurumAd &"</div>"
Response.Write "<div class=""card-deck m-1"">"
	
	Response.Write "<div class=""card col-lg-4 col-md-4 col-sm-4"">"
			Response.Write "<div id=""divYeniKayit"" class=""card-body m-0 p-0"">"
				Response.Write "<input id=""dosyaKayitTip"" type=""hidden"" value="""&dosyaKayitTip&""">"
				Response.Write "<input id=""ihaleID64"" type=""hidden"" value="""&ihaleID64&""">"
				Response.Write "<input id=""oncekiGorusmeID"" type=""hidden"" value="""">"
				
				Response.Write "<label class=""badge"">Görüşme Tarihi</label>"
				call forminput("gorusmeTarihi",now(),"","Görüşme Tarihi","tarih cell","","gorusmeTarihi","")
					
				Response.Write "<label class=""badge"">Görüşülen Kişi</label>"
				Response.Write "<input id=""gorusulenKisi"" type=""text"" class=""form-control""></input>"
				
				Response.Write "<label class=""badge"">Görüşme İçeriği</label>"
				Response.Write "<textarea id=""gorusmeIcerik"" class=""form-control"" rows=""5"" cols=""60""></textarea>"
				
				Response.Write "<label class=""badge"">Sonraki Arama Tarihi</label>"
				call forminput("sonrakiAramaTarihi","","","Sonraki Arama Tarihi","tarihSaat cell","","sonrakiAramaTarihi","")
	Response.Write "<button id=""butonKayit"" class=""btn btn-sm rounded btn-success"">kaydet</button>"
			Response.Write "</div>"'card_body
			
			Response.Write "<div id=""butonYeniGorusme"" class=""btn bg-info"" onclick=""$('#divYeniKayit').show('slow');$(this).hide('slow');"">Yeni Görüşme</div>"

			Response.Write "<div class=""card-footer"">"
			Response.Write "</div>"
	Response.Write "</div>"'card
		
	
	Response.Write "<div class=""card col-lg-8"">"
		Response.Write "<div class=""card-header"">"
		Response.Write "Görüşme Tarihçesi"
		Response.Write "</div>"'card-header
	Response.Write "<div class=""card-body m-0 p-0"">"
	
		Response.Write "<div id=""divTarihce"" class=""scroll-ekle""></div>"
	
	Response.Write "</div>"'card-body
	Response.Write "</div>"'card
	
	
	

Response.Write "</div>"'card-deck
Response.Write "</div>"
%>
<script>//kayıt işlemleri
	$(document).ready(function() {
			var ihaleID64			=	$('#ihaleID64').val();
		
		$(document).off('click', '#butonKayit').on('click','#butonKayit',function() {

			var dosyaKayitTip		=	$('#dosyaKayitTip').val();
			var gorusmeTarihi 		= 	$('#gorusmeTarihi').val();
			var ihaleID64			=	$('#ihaleID64').val();
			var gorusmeIcerik		=	$('#gorusmeIcerik').val();
			var gorusulenKisi		=	$('#gorusulenKisi').val();
			var sonrakiAramaTarihi	=	$('#sonrakiAramaTarihi').val();
			var oncekiGorusmeID		=	$('#oncekiGorusmeID').val();

		$.ajax({
			type:'POST',
			url :'/gorusmeler/kaydet.asp',
			data :{'gorusmeTarihi':gorusmeTarihi,'ihaleID64':ihaleID64,'gorusmeIcerik':gorusmeIcerik,'gorusulenKisi':gorusulenKisi,'sonrakiAramaTarihi':sonrakiAramaTarihi,'oncekiGorusmeID':oncekiGorusmeID,
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
								toastr.success('Değişiklik kayıt edildi.','İşlem Yapıldı!');
								$('#sonrakiAramaTarihi').val('');$('#gorusulenKisi').val('');$('#gorusmeIcerik').val('');//inputları boşalt.
								tarihceYukle(ihaleID64);
								$('#divYeniKayit').hide('slow');
								$('#butonYeniGorusme').show('slow');
								$.get('/teklif2/liste/'+dosyaKayitTip, function(data){
											var $data = $(data);
											$('#divGorusme_'+ihaleID64).html($data.find('#divGorusme_'+ihaleID64).html());
								});//tablolar güncellendi
								
							}
							else{
								toastr.options.positionClass = 'toast-bottom-right';
								toastr.error('Kayıt yapılmadı.','İşlem Başarısız!');
							};
									
								
				}
		});
		});//kayıt işlemleri sonu
		
		//görüşme göster butonuna tıklandığında yapılan yeni görüşmeye scroll
			$(document).off('click', '.gorusmeGoster').on('click','.gorusmeGoster',function() {
				var sonrakiAramaID	=	$(this).data('sonrakiaramaid');
					 $('#modal-dialogfit .modal-body #divTarihce').animate({
						  scrollTop: $('#table_'+sonrakiAramaID).offset().top
					}, 1000);
					$('.tableGorusme').removeClass('bg-warning');$('#table_'+sonrakiAramaID).addClass('bg-warning');
				});		
		//görüşme göster butonuna tıklandığında yapılan yeni görüşmeye scroll

		tarihceYukle(ihaleID64);
		$('#divYeniKayit').hide();
    });
	
			function tarihceYukle(ihaleID64){
				$('#divTarihce').load('/gorusmeler/gorusmeTarihce.asp?ihaleID='+ihaleID64);
			};
			
			

    </script><!--kayıt işlemleri-->
