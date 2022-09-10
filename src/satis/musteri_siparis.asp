<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modulAd =   "satis"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Doğrudan Müşteri Siparişi Oluşturma Ekranı")

yetkiKontrol = yetkibul(modulAd)



	if hata = "" and opener = "" and yetkiKontrol > 0 then

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
					Response.Write "<div class=""row"">"
						Response.Write "<div class=""col-12 h2 text-center"">Daha önce TEKLİF olan sayfaları müşteri siparişi yaptım, buralar çalışıyor bozma</div>"
						Response.Write "<div class=""col-12 h4 text-center"">Yeni Müşteri Siparişi</div>"
					Response.Write "</div>"
					Response.Write "<form action=""/satis/musteri_siparis_kalem_ekle.asp"" method=""post"" id=""siparisForm"">"
					Response.Write "<div class=""card-body pt-0"">"
					
						Response.Write "<div class=""row"">"
							'Response.Write "<div class=""col-lg-1 col-sm-2 col-md-2 mt-3"">"
								Response.Write "<div class=""btn btn-warning col-lg-1 col-sm-2 col-md-2 mt-3"""
								Response.Write " onclick=""$('#divCariSec').addClass('d-none');"
								Response.Write " $('#divYeniCari').removeClass('d-none');"
								Response.Write " $('#cariSec').val(null).trigger('change');"
								Response.Write " $('.btn').removeClass('bg-primary');"
								Response.Write " $(this).addClass('bg-primary');"
								Response.Write """>Yeni Cari</div>"
							'Response.Write "</div>"
							'Response.Write "<div class=""col-lg-1 col-sm-2 col-md-2 mt-3"">"
								Response.Write "<div id=""kayitliCari"" class=""btn btn-warning bg-primary col-lg-1 col-sm-2 col-md-2 mt-3"""
								Response.Write " onclick=""$('#divYeniCari').addClass('d-none');"
								Response.Write " $('#divCariSec').removeClass('d-none');"
								Response.Write " $('#utsNoListe').html('');"
								Response.Write " $('#yeniCariAd').val('');"
								Response.Write " $('#yeniCariVergiNo').val('');"
								Response.Write " $('.btn').removeClass('bg-primary');"
								Response.Write " $(this).addClass('bg-primary');"
								Response.Write """>Kayıtlı Cari</div>"
							'Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-lg-5 col-sm-6"">"
								Response.Write "<div for="""" class=""badge badge-secondary rounded-left"">Sipariş açıklaması</div>"
								call forminput("siparisAd",siparisAd,"","Sipariş açıklaması","","autocompleteOFF","siparisAd","")
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-1 col-sm-6"">"
								Response.Write "<div for="""" class=""badge badge-secondary rounded-left"">Sipariş Tarihi</div>"
								call forminput("siparisTarih",date(),"","Sipariş tarihi","tarih","autocompleteOFF","siparisTarih","")
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row"">"
						Response.Write "</div>"
						
						Response.Write "<div class=""row"">"
								Response.Write "<div id=""divCariSec"" class=""col-8"">"
									Response.Write "<div for="""" class=""badge badge-secondary rounded-left"">Cari Seçimi</div>"
									call formselectv2("cariSec","","$('#tempUrunListesi').load('/satis/musteri_siparis_kalem_ekle.asp?islem=kontrol&siphash='+this.value);","","formSelect2 cariSec border","","cariSec","","data-holderyazi=""Cari adı, cari kodu, vergi no"" data-jsondosya=""JSON_cariler"" data-miniput=""3""")
								Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row"">"
							Response.Write "<div id=""divYeniCari"" class=""d-none col-6"">"
								Response.Write "<div for="""" class=""badge badge-secondary rounded-left"">Yeni cariye ait vergi numarası</div>"
									call forminput("yeniCariVergiNo","","","sorgulanacak vergi no","bold bg-secondary text-white","autocompleteOFF","yeniCariVergiNo","")
								Response.Write "<div for="""" class=""badge badge-secondary rounded-left"">Yeni cari ad</div>"
									call formtextarea("yeniCariAd","","","","","","yeniCariAd","")
								Response.Write "</div>"
							Response.Write "<div id=""utsNoListe"" class=""col-5""></div>"
						Response.Write "</div>"
						
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div id=""divCariSec"" class=""col-4"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Ürün Seçimi</div>"
								call formselectv2("stokSec","","","","formSelect2 stokSec","","stokSec","","data-holderyazi=""Ürün adı, stok kodu, barkod"" data-jsondosya=""JSON_stoklar"" data-miniput=""3""")
							Response.Write "</div>"
							Response.Write "<div class=""col-4"">"
								Response.Write "<div for="""" class=""badge badge-secondary rounded-left"">Ürüne Özel Not</div>"
								call forminput("kalemNot","","","Ürüne özel not","","autocompleteOFF","kalemNot","")
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-2"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Miktar</div>"
								call forminput("miktar",miktar,"numara(this,true,false)","Miktar","","autocompleteOFF","miktar","")
							Response.Write "</div>"
							Response.Write "<div class=""col-2"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Birim</div>"
								call formselectv2("birimSec","","","","formSelect2 birimSec border","","birimSec","","data-holderyazi=""Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0""")
							Response.Write "</div>"
							Response.Write "<div class=""col-2"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Fiyat</div>"
								call forminput("birimfiyat",birimfiyat,"numara(this,true,false)","Birim Fiyat","","autocompleteOFF","birimfiyat","")
							Response.Write "</div>"
							Response.Write "<div class=""col-2"">"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Para Birim</div>"
								call formselectv2("pBirimSec","","","","formSelect2 pBirimSec border","","pBirimSec","","data-holderyazi=""Para Birim"" data-jsondosya=""JSON_paraBirimler"" data-miniput=""0""")
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-6"">"
								Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
							Response.Write "</div>"
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "</form>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		
		
		Response.Write "</div>"

	else
		call yetkisizGiris("","","")
	end if

            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-body"">"
						Response.Write "<div id=""tempUrunListesi""></div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"



'ekli ürün listesi

Response.Write "<scr" & "ipt>"
Response.Write "$(document).ready(function() {"
Response.Write "$('#siparisForm').ajaxForm({target:'#tempUrunListesi'});"
Response.Write "});"
Response.Write "</scr" & "ipt>"


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
			
		
			var vergiNo			=	$.trim($('#yeniCariVergiNo').val());
			var bildirim		=	'vergiNoSorgula';
			
			if(vergiNo.length < 10){return false};
			//vergi numarası sistemde kayıtlı mı kontrol et değil ise ÜTS sistemini sorgula
				$.ajax({
					type:'GET',
					url :'/temp/JSON_cariler.asp',
					data :{'q':vergiNo,
								},
							success: function(sonuc) {//succ1
							
							if(sonuc!='yok'){
								swal('Vergi No Zaten Kayıtlı','Kayıtlı Cari işlemleri ile devam ediniz.')
								$('#kayitliCari').trigger('click');
								$('.formSelect2').trigger('mouseenter');
								$('#cariSec').val(vergiNo).trigger('change');
							}else{//else 3
					//ÜTS sistemini sorgula
					//ÜTS sistemini sorgula
							$.ajax({
								type:'POST',
								url :'/uts/uts_islem_yap.asp',
								data :{'bildirim':bildirim,'vergiNo':vergiNo,
											},
								beforeSend: function() {
			
									//$('#vergiNoSorgula').html("<img src='/image/working2.gif' width='20' height='20'/>");
								  },
										success: function(sonuc) {//succ2
			
											var data = JSON.parse(sonuc);
			
											if(data.length == 0){swal('','Vergi No ile ilişkili ÜTS No yok','error');
												$('#vergiNoSorgula').text('sorgula');
											} else{
												$('#utsNoListe').html('');
												$("#yeniCariAd").val('');
												for (var key in data)
													{
														$('#utsNoListe').append('<div class="form-check yeniCariDIV"><input\
														 id="radio'+key+'" class="form-check-input" type="radio" name="utsKurumNo" value="'+data[key].KRN+'"><span class="form-check-div pointer" for="radio'+key+'" onclick="">'+data[key].GAD+'</span></div>\
																				<hr class="pt-2 m-0">\
																				').show('slow');
														$('#vergiNoSorgula').addClass('d-none');
													}// döngü bitti
												}
										}//succ2
							});//ajax2 bitti
					//ÜTS sistemini sorgula
					//ÜTS sistemini sorgula
			
							}//else 3
							
					}//succ1
				});//ajax1 bitti
					
		});
	//vergi numarasından ÜTS tanımlayıcı no sorgula
		});
		
		
</script>

