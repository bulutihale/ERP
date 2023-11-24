<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
    ID				=	Request.QueryString("ID")
    kid64			=	ID
    opener  		=   Request.Form("opener")
    gorevID 		=   Request.QueryString("gorevID")
	taslakDurum		=	Request.QueryString("taslakDurum")
	sayfa5Kontrol	=	Session("sayfa5")
	if taslakDurum = "evet" OR sayfa5Kontrol = "taslak" then
		taslakKontrol 	=	"taslak"
		sayfaBaslik		=	"Müşteri Siparişi Oluşturma"
		taslakDurum		=	"evet"
		sayfaAdres		=	"musteri_siparis_kalem_ekle"
	elseif taslakDurum = "sevkirsaliye" OR sayfa5Kontrol = "sevkirsaliye" then
		taslakKontrol 	=	"sevkirsaliye"
		sayfaBaslik		=	"Müşteri Sevk İrsaliyesi Kayıt"
		taslakDurum		=	"sevkirsaliye"
		sayfaAdres		=	"musteri_sevk_liste"
	else
		taslakKontrol = ""
	end if
	aramaad			=	Request.Form("aramaad")
    hata    		=   ""
    modulAd 		=   "Satış"
    personelID 		=   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Doğrudan Müşteri Siparişi Oluşturma Ekranı")

yetkiKontrol = yetkibul(modulAd)



	if hata = "" and opener = "" and yetkiKontrol > 0 then

		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card container scroll-ekle2"">"
					Response.Write "<div class=""card-header"">"
							Response.Write "<div class=""col-lg-9 col-md-6 col-sm-6 h4 text-left sticky-top"">" & sayfaBaslik & "</div>"
						Response.Write "<div class=""row"">"
					if taslakKontrol <> "taslak" AND taslakKontrol <> "sevkirsaliye" then
							Response.Write "<div class=""btn btn-warning col-lg-1 col-sm-12 col-md-12 mr-3"""
							Response.Write " onclick=""$('#divCariSec').addClass('d-none');"
							Response.Write " $('#divYeniCari').removeClass('d-none');"
							Response.Write " $('#cariSec').val(null).trigger('change');"
							Response.Write " $('.btn').removeClass('bg-primary');"
							Response.Write " $(this).addClass('bg-primary');"
							Response.Write """>Yeni Cari</div>"

							Response.Write "<div id=""kayitliCari"" class=""btn btn-secondary col-lg-1 col-sm-12 col-md-12 mr-3"""
							Response.Write " onclick=""$('#divYeniCari').addClass('d-none');"
							Response.Write " $('#divCariSec').removeClass('d-none');"
							Response.Write " $('#utsNoListe').html('');"
							Response.Write " $('#yeniCariAd').val('');"
							Response.Write " $('#yeniCariVergiNo').val('');"
							Response.Write " $('.btn').removeClass('bg-primary');"
							Response.Write " $(this).addClass('bg-primary');"
							Response.Write """>Kayıtlı Cari</div>"
					end if
						Response.Write "</div>"
					Response.Write "</div>"

			'###### TASLAK SİPARİŞLERİ LİSTELEMEK İÇİN
			'###### TASLAK SİPARİŞLERİ LİSTELEMEK İÇİN
				if taslakKontrol <> "" then
					sorgu = "SELECT DISTINCT t1.cariID, t2.cariAd"
					sorgu = sorgu & " FROM teklif.siparisKalemTemp t1"
					sorgu = sorgu & " INNER JOIN cari.cari t2 ON t1.cariID = t2.cariID"
					sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & ""
					if taslakKontrol = "taslak" then
						sorgu = sorgu & " AND t1.siparisTur ='S'"
					elseif taslakKontrol = "sevkirsaliye" then
						sorgu = sorgu & " AND t1.siparisTur ='IRS'"
					end if
					rs.open sorgu, sbsv5, 1, 3
					if not rs.EOF then
						do until rs.EOF
							cariID		=	rs("cariID")
							cariAd		=	rs("cariAd")
							Response.Write "<div class=""row mt-3 hoverGel pointer sipRow rounded container"" onclick=""$('#tempUrunListesi').load('/satis/"&sayfaAdres&".asp?taslakDurum="&taslakDurum&"&islem=kontrol&siphash=" & cariID & "');$('.sipRow').removeClass('bg-warning');$(this).addClass('bg-warning')"">"
								Response.Write "<div class=""col-7 bold"">" & cariAd & "</div>"
							Response.Write "</div>"
						rs.movenext
						loop
					end if
				else
					Response.Write "<form action=""/satis/musteri_siparis_kalem_ekle.asp"" method=""post"" id=""siparisForm"">"

					Response.Write "<div class=""card-body"">"
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-lg-6 col-sm-12 col-md-12 border border-dark rounded mt-2"">"

								Response.Write "<div class=""row mt-2"">"
									Response.Write "<div id=""divCariSec"" class=""col-lg-10 col-sm-12 mt-2"">"
										Response.Write "<div for="""" class=""badge badge-secondary rounded-left"">Cari Seçimi</div>"
										call formselectv2("cariSec","","if(this.value != ''){$('#tempUrunListesi').load('/satis/musteri_siparis_kalem_ekle.asp?islem=kontrol&siphash='+this.value)};","","formSelect2 cariSec border","","cariSec","","data-holderyazi=""Cari adı, cari kodu, vergi no"" data-jsondosya=""JSON_cariler"" data-miniput=""3""")
									Response.Write "</div>"
									Response.Write "<div class=""col-lg-2 col-sm-12 mt-2"">"
										Response.Write "<div for="""" class=""badge badge-secondary rounded-left"">Sipariş Tarihi</div>"
										call forminput("siparisTarih",date(),"","Sipariş tarihi","tarih","autocompleteOFF","siparisTarih","")
									Response.Write "</div>"
								Response.Write "</div>"
								
								Response.Write "<div class=""row mt-2"">"
									Response.Write "<div class=""col-lg-12 col-sm-12"">"
										Response.Write "<div for="""" class=""badge badge-secondary rounded-left"">Sipariş açıklaması</div>"
										call forminput("siparisAd",siparisAd,"","Sipariş açıklaması","","autocompleteOFF","siparisAd","")
									Response.Write "</div>"
								Response.Write "</div>"

								Response.Write "<div class=""row mt-2"">"
									Response.Write "<div id=""divYeniCari"" class=""d-none col-12"">"
										Response.Write "<div for="""" class=""badge badge-secondary rounded-left"">Yeni cariye ait vergi numarası</div>"
											call forminput("yeniCariVergiNo","","","sorgulanacak vergi no","bold bg-secondary text-white","autocompleteOFF","yeniCariVergiNo","")
										Response.Write "<div for="""" class=""badge badge-secondary rounded-left mt-2"">Yeni cari ad</div>"
											call formtextarea("yeniCariAd","","","","","","yeniCariAd","")
										Response.Write "<div id=""utsNoListe"" class=""col-12 mb-2"">utsNoListe</div>"
									Response.Write "</div>"
									
								Response.Write "</div>"

							Response.Write "</div>"
							
							Response.Write "<div class=""col-lg-6 col-sm-12 col-md-12 mt-2 border border-dark rounded"">"
								
								Response.Write "<div class=""row mt-2"">"
									Response.Write "<div id=""divUrunSec"" class=""col-lg-6 col-sm-6 mt-2"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Ürün Seçimi</div>"
										call formselectv2("stokSec","","anaBirimKontrol($(this).val(),$(this).attr('id'))","","formSelect2 stokSec","","stokSec","","data-holderyazi=""Ürün adı, stok kodu, barkod"" data-jsondosya=""JSON_stoklar"" data-miniput=""3""")
									Response.Write "</div>"
									Response.Write "<div class=""col-lg-6 col-sm-6 mt-2"">"
										Response.Write "<div for="""" class=""badge badge-secondary rounded-left"">Ürüne Özel Not</div>"
										call forminput("kalemNot","","","Ürüne özel not","","autocompleteOFF","kalemNot","")
									Response.Write "</div>"
								Response.Write "</div>"

								Response.Write "<div class=""row mb-2"">"
									Response.Write "<div class=""col-lg-3 col-sm-6 col-md-6 mt-2"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Miktar</div>"
										call forminput("miktar",miktar,"numara(this,true,false)","Miktar","","autocompleteOFF","miktar","")
									Response.Write "</div>"
									Response.Write "<div class=""col-lg-3 col-sm-6 col-md-6 mt-2"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Birim</div>"
										call formselectv2("birimSec","","","","formSelect2 birimSec border anaBirimFiltre","","birimSec","","data-holderyazi=""Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0""")
									Response.Write "</div>"
									Response.Write "<div class=""col-lg-3 col-sm-6 col-md-6 mt-2"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Fiyat</div>"
										call forminput("birimfiyat",birimfiyat,"numara(this,true,false)","Birim Fiyat","","autocompleteOFF","birimfiyat","")
									Response.Write "</div>"
									Response.Write "<div class=""col-lg-3 col-sm-6 col-md-6 mt-2"">"
										Response.Write "<div class=""badge badge-secondary rounded-left"">Para Birim</div>"
										call formselectv2("pBirimSec","","","","formSelect2 pBirimSec border","","pBirimSec","","data-holderyazi=""Para Birim"" data-jsondosya=""JSON_paraBirimler"" data-miniput=""0""")
									Response.Write "</div>"
								Response.Write "</div>"

							Response.Write "</div>" 

						Response.Write "</div>"

								Response.Write "<div class=""row text-center mt-4"">"
									Response.Write "<div class=""col-lg-12"">"
										Response.Write "<div class=""col-12""><button type=""submit"" class=""btn btn-primary col-lg-6 col-md-12 col-sm-12"">KAYDET</button></div>"
									Response.Write "</div>"
								Response.Write "</div>"


					Response.Write "</div>"
					Response.Write "</form>"
				end if
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
		
			working('utsNoListe','30px','30px')

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

