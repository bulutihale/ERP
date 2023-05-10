<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
    sterilCevrimID		=	Request.QueryString("sterilCevrimID")
	modulAd 			=   "Sterilizasyon"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Sterilizasyon çevrim süreci sonlandırılıyor cevrimID: " & sterilCevrimID)

yetkiKontrol = yetkibul(modulAd)


		Response.Write "<div class=""text-right""><span onclick=""modalkapat()"" class=""mdi mdi-close-circle pointer d-none""></span></div>"

	Response.Write "<div class=""card rounded-top"">"
		Response.Write "<div class=""card-header h5"">Sterilizasyonu Biten Mamul Hareketi</div>"
	
		Response.Write "<div class=""card-body"">"
			Response.Write "<input id=""sterilCevrimID"" type=""hidden"" value=""" & sterilCevrimID & """>"
			Response.Write "<input id=""ajandaID"" type=""hidden"" value=""" & ajandaID & """>"
			Response.Write "<input id=""islemDurum"" type=""hidden"" value=""" & islemDurum & """>"
			Response.Write "<input id=""teminDepoID"" type=""hidden"" value=""" & teminDepoID & """>"
			Response.Write "<input id=""secilenReceteID"" type=""hidden"" value=""" & secilenReceteID & """>"

			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-6"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Kullanılan EO Gaz Miktarı (kg)</div>"
					call forminput("EOgazMiktar","","","Kullanılan EO Gaz Miktarı","","autocompleteOFF","EOgazMiktar","")
				Response.Write "</div>"
			Response.Write "</div>"

			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-12 mt-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Sterilizasyon Cihazı Rapor Numarası</div>"
					call forminput("cevrimRaporNo","","","Sterilizasyon Cihazı Rapor Numarası","","autocompleteOFF","cevrimRaporNo","")
				Response.Write "</div>"
			Response.Write "</div>"

			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-12"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Açıklama</div>"
					call forminput("aciklama","","","Çevrime ilişkin açıklama","","autocompleteOFF","aciklama","")
				Response.Write "</div>"
			Response.Write "</div>"


			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-lg-6 col-sm-12 mt-4"">"
					Response.Write "<div class=""btn btn-primary"" onclick=""sterilizasyonBitir(); modalkapat()"">STERİLİZASYON BİTİR</button>"
				Response.Write "</div>"
			Response.Write "</div>"
			'Response.Write "</form>"
		Response.Write "</div>"'card-body
	Response.Write "</div>"'card
	





%><!--#include virtual="/reg/rs.asp" -->



<script>
	function sterilizasyonBitir(){
		var sterilCevrimID			=	$('#sterilCevrimID').val();
		var cevrimRaporNo			=	$('#cevrimRaporNo').val();
		var EOgazMiktar				=	$('#EOgazMiktar').val();
		var aciklama				=	$('#aciklama').val();


		swal({
			title: 'Steril edilen ürünler mamul depoya aktarılsın mı?',
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#DD6B55',
			confirmButtonText: 'evet',
			cancelButtonText: 'hayır'
		}).then(
			function(result) {
			// handle Confirm button click
			// result is an optional parameter, needed for modals with input
			
				$('#ajax').load('/sterilizasyon/cevrim_bitir.asp', {sterilCevrimID:sterilCevrimID, cevrimRaporNo:cevrimRaporNo, EOgazMiktar:EOgazMiktar, aciklama:aciklama}, function(){
					$('#surecDIV1').load('/sterilizasyon/sterilizasyon_surec.asp #surecDIV1 > *')		
					$('#surecDIV2').html('Çevrim bitti. Ürünler Steril depoya aktarıldı.');
				});
			}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
		}

</script>


