<!--#include virtual="/reg/rs.asp" --><%

	Response.Flush()
	kid						=	kidbul()
	arama					=	Request.Form("arama")
	call sessiontest()

'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr = Split(kidarr,"#")
		musteriID			=	kidarr(0)
		mtimeout			=	kidarr(1)
		kad					=	kidarr(2)
		sayfaKayitSayisi	=	int(kidarr(3))
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr


'##### YETKİ BUL
'##### YETKİ BUL
	sorgu		=	""
	sayfaadi	=	"ÜTS İşlemleri"
	yetki		=	yetkibul("","","")
'##### YETKİ BUL
'##### YETKİ BUL


if arama <> "" then
	arama = sqlinj(arama)
end if

'######## degerleri al
'######## degerleri al
t1			=	Request.Form("t1")
	if t1 = "" then
		t1	=	date()-5
	end if
t2			=	Request.Form("t2")
	if t2 = "" then
		t2	=	date()
	end if
NETSISfirma	=	Request.Form("NETSISfirma")
'######## degerleri al
'######## degerleri al

	'##### NETSİS FİRMALARI ÇEK
	'##### NETSİS FİRMALARI ÇEK
			sorgu = "SELECT * FROM master.dbo.sysdatabases WHERE"_
			&" dbid NOT IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24)"_
			&" ORDER BY name"
			rs.open sorgu,NETSIS_master,1,3
					degerler = "=|"
					do while not rs.eof
						degerler = degerler & rs("name")
						degerler = degerler & "="
						degerler = degerler & rs("name")
						degerler = degerler & "|"
					rs.movenext
					loop
					if degerler = "" then
					else
						degerler = left(degerler,len(degerler)-1)
					end if
				rs.close
				NETSISfirdegerler = degerler
	'##### /NETSİS FİRMALARI ÇEK
	'##### /NETSİS FİRMALARI ÇEK



Response.Write "<div class=""card card-primary"">"
Response.Write "<div class=""card-header""><i class=""fa fa-bullhorn"" aria-hidden=""true""></i>" & sayfaadi & "</div>"
Response.Write "<div class=""card-deck m-1"">"
	
	Response.Write "<div class=""card col-lg-3"">"
	Response.Write "<form action=""/utsN/utsNana"" method=""post"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-6"">"
					call formselectv2("NETSISfirma",NETSISfirma,"","","NETSISfirma text-center rounded","","",NETSISfirdegerler,"")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row mt-3"">"
			Response.Write "<div class=""col-lg-5"">"
				call forminput("t1",t1,"","Başlangıç Tarihi","tarih rounded","","","AutCompOff")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-5"">"
				call forminput("t2",t2,"","Bitiş Tarihi","tarih rounded","","","AutCompOff")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row mt-3"">"
			Response.Write "<button class=""btn btn-sm rounded btn-success form-control col-lg-3"">FİLTRELE</button>"
		Response.Write "</div>"

	Response.Write "</form>"
	
	Response.Write "<h5 class=""text-center"">"&t1 &" - " & t2&"</h3>" 
	
if NETSISfirma = "" then
else

	Response.Write "<div class=""card-body scroll-ekle3"">"
	
	sorgu = ""
	sorgu = "SELECT  fatAna.FATIRS_NO as faturaNo, fatAna.GIB_FATIRS_NO as GIBfaturaNo, fatAna.TARIH as faturaTarih, c.CARI_ISIM as cariAD"
	sorgu = sorgu &" FROM [" & NETSISfirma & "].[dbo].TBLFATUIRS fatAna"
	sorgu = sorgu &" INNER JOIN [" & NETSISfirma & "].[dbo].TBLCASABIT c ON fatAna.CARI_KODU = c.CARI_KOD"
	sorgu = sorgu &" WHERE"
	sorgu = sorgu &" fatAna.FTIRSIP = 1"
	 if t1 <> "" then
		 sorgu = sorgu & " AND fatAna.TARIH >= '" & tarihsql(t1) & "'"
	 end if
	 if t2 <> "" then
		 sorgu = sorgu & " and fatAna.TARIH <= '" & tarihsql(t2) & "'"
	 end if
	sorgu = sorgu & " ORDER BY fatAna.TARIH"
	rs.open sorgu,NETSIS_master,1,3


	


		'Response.Write "</div>"'card_body
		'Response.Write "</div>"'card
		
	
	'Response.Write "<div class=""card col-lg-3 p-0"">"
		'Response.Write "<div class=""card-header"">"
			'Response.Write "Seçilen aralıktaki faturalar."
		'Response.Write "</div>"'card-header
		
	'Response.Write "<div class=""card-body pl-1 scroll-ekle3"">"
	if rs.recordcount = 0 then
		Response.Write "Seçilen kritelerlere uygun fatura yok."
	else
		for gi = 1 to rs.recordcount
			faturaNo	=	rs("faturaNo")
			GIBfaturaNo	=	rs("GIBfaturaNo")
			faturaTarih	=	rs("faturaTarih")
			cariAD		=	rs("cariAD")
			
		Response.Write "<div id=""id_" & faturaNo & """"
		Response.Write " data-faturano=""" & faturaNo & """"
		Response.Write " data-netsisfirma=""" & NETSISfirma & """"
		Response.Write " class=""row fontkucuk2 pointer faturaSatir hoverGel"">"
			Response.Write "<div class=""col-4"">" & faturaNo & "</div>"
			Response.Write "<div class=""col-3"">" & faturaTarih & "</div>"
			Response.Write "<div class=""col-5"">" & cariAD & "</div>"
		Response.Write "</div>"
		Response.Write "<hr class=""p-0 m-0 bg-danger"">"
		rs.movenext
		next
	end if
		rs.close
	Response.Write "</div>"'card-body
	
	Response.Write "</div>"'card
	
	
	Response.Write "<div class=""card col-8 p-0"">"
		'Response.Write "<div class=""card-header"">"
			
			'Response.Write "<div id=""fiyatDetay"" class=""bg-info""></div>"
			
		'Response.Write "</div>"'card-header
	'Response.Write "<div class=""card-body m-0 p-0"">"
	
		Response.Write "<div id=""faturaDetay"" class=""fontkucuk2 pl-0""></div>"
	
	'Response.Write "</div>"'card-body
	
	Response.Write "</div>"'card

end if 'NETSISfirma seçimi

Response.Write "</div>"'card-deck
Response.Write "</div>"
%>

<script>
	function butonRenk(id,renk,sinif){
			$('.'+sinif).removeClass('bg-'+renk);
			$('#'+id).addClass('bg-'+renk);
	}
	
	
	$(document).ready(function() {

		$('.faturaSatir').on('click', function () {
			//$('#faturaDetay').html('');
			
			var satirID 	= 	$(this).attr('id');
			var faturaNo	=	$(this).attr('data-faturaNo');
			var NETSISfirma	=	$(this).attr('data-netsisfirma');
			
			butonRenk(satirID,'info','faturaSatir');
			
					$('#faturaDetay').html("<img src='/image/working2.gif' width='20' height='20'/>");
					
					$('#faturaDetay').load('/utsN/utsNdetay_ajax.asp',{NETSISfirma:NETSISfirma,faturaNo:faturaNo});
			
		});

	});
	
	
	$(document).ajaxSuccess(function(){
	
	
	
		
		
	//vergi numarasından ÜTS tanımlayıcı no sorgula
		$('#vergiNoSorgula').one('click', function () {
		
			var firmamID		=	$('#DIVsabitBilgiler').attr('data-firmamid');
			var vergiNo			=	$('#vergiNo').text();
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
									for (var key in data)
										{
											//console.log(data);
											
											$('#utsNoListe').append('<div class="form-check">\
																	<input id="radio'+key+'" class="form-check-input" type="radio" name="utsKurumNo" value="'+data[key].KRN+'">\
																	<label class="form-check-label" for="radio'+key+'">'+data[key].GAD+'</label>\
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
	
	
	//fatura ÜTS bildirimini yap butona tıklandığında
		$('#tumFaturaBildir').off().on('click', function () {
		
			var bildirim		=	$('#tumFaturaBildir').attr('data-bildirim');
			var bildirimTip		=	$('#tumFaturaBildir').attr('data-bildirimtip');
			var firmamID		=	$('#DIVsabitBilgiler').attr('data-firmamid');
			var NETSISfirma		=	$('#DIVsabitBilgiler').attr('data-netsisfirma');
			var NETSIScariKod	=	$('#DIVsabitBilgiler').attr('data-netsiscarikod');
			var belgeTarih		=	$('#faturaTarih').text();
			var belgeNo			=	$('#faturaNo').text();
			var alanKurumUtsNo	=	$("input[name='utsKurumNo']:checked").val();
			
			if(alanKurumUtsNo == undefined){swal('','Kurum ÜTS No seçimi yapılmamış');return false};
			
			$('.utsYap').each(function(){

				var mevcutID	=	$(this).attr('id');
				
				$(this).children().each(function(){

					if($(this).hasClass('utsKod')){
						urunUtsKod	=	$(this).text();
						inckeyno	=	$(this).attr('data-inckeyno');
					};
					if($(this).hasClass('faturaMiktar')){faturaMiktar = $(this).text()};
					if($(this).hasClass('urunLot')){urunLot = $(this).text()};

				});//each func children
				
					$.ajax({
						type:'POST',
						url :'/utsN/utsNislemYap.asp',
						data :{'bildirim':bildirim,
								'bildirimTip':bildirimTip,
								'firmamID':firmamID,
								'NETSISfirma':NETSISfirma,
								'NETSIScariKod':NETSIScariKod,
								'NETSISinckeyno':inckeyno,
								'belgeTarih':belgeTarih,
								'belgeNo':belgeNo,
								'alanKurumUtsNo':alanKurumUtsNo,
								'urunUtsKod':urunUtsKod,
								'faturaMiktar':faturaMiktar,
								'urunLot':urunLot,
								
									},
						beforeSend: function() {

							$('#vergiNoSorgula').html("<img src='/image/working2.gif' width='20' height='20'/>");
						  },
						
						success: function(sonuc) {

									$('#'+mevcutID).children('.utsSonuc').text(sonuc);
									//console.log(urunUtsKod);
									
						}
					});

			});//each func
		});
	//fatura ÜTS bildirimini yap butona tıklandığında
	
	
	
	//ÜTS iptal
		$('.utsIptal').one('click', function () {

			var firmamID	=	$('#DIVsabitBilgiler').attr('data-firmamid');
			var utsNID		=	$(this).attr('data-utsnid');
			var bildirimTip	=	$(this).attr('data-bildirimtip');
			
			
				$.ajax({
					type:'POST',
					url :'/utsN/utsNislemYap.asp',
					data :{'bildirimTip':bildirimTip,'utsNID':utsNID,'firmamID':firmamID,
								},
					beforeSend: function() {

						$(this).html("<img src='/image/working2.gif' width='20' height='20'/>");
					  },
							success: function(sonuc) {
								

								swal('',sonuc);
									}
							
				});
					
		});
	//ÜTS iptal
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	});//ajaxSuccess	
</script>























