<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    modulAd 			=   "Üretim"

	siparisKalemID		=	Request.QueryString("siparisKalemID")
	ajandaID			=	Request.QueryString("ajandaID")
	islemDurum			=	Request.QueryString("islemDurum")
	teminDepoID			=	Request.QueryString("teminDepoID")
	secilenReceteID		=	Request.QueryString("secilenReceteID")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


	yetkiKontrol	 = yetkibul(modulAd)

	call logla("Üretilen ürün depo transferi yapılacak (siparisKalemID = "&siparisKalemID&")")


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
		Response.Write "<div class=""text-right""><span onclick=""modalkapat()"" class=""mdi mdi-close-circle pointer d-none""></span></div>"

	Response.Write "<div class=""card rounded-top"">"
		Response.Write "<div class=""card-header h5"">Üretimi Biten Mamul Hareketi</div>"
	
		Response.Write "<div class=""card-body"">"
			Response.Write "<input id=""siparisKalemID"" type=""hidden"" value=""" & siparisKalemID & """>"
			Response.Write "<input id=""ajandaID"" type=""hidden"" value=""" & ajandaID & """>"
			Response.Write "<input id=""islemDurum"" type=""hidden"" value=""" & islemDurum & """>"
			Response.Write "<input id=""teminDepoID"" type=""hidden"" value=""" & teminDepoID & """>"
			Response.Write "<input id=""secilenReceteID"" type=""hidden"" value=""" & secilenReceteID & """>"

			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-6"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Üretimi Biten Miktar</div>"
					call forminput("uretilenMiktar","","","Üretimi Biten Miktar","","autocompleteOFF","uretilenMiktar","")
				Response.Write "</div>"
			Response.Write "</div>"

			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-12 mt-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Üretilen Ürün Giriş Depo</div>"
						call formselectv2("uretilenUrunGirisDepoID","","","","formSelect2 depoSec border","","uretilenUrunGirisDepoID","","data-holderyazi=""Üretilen ürün için giriş depo seçimi"" data-jsondosya=""JSON_depolar"" data-miniput=""0"" data-sartOzel=""""")
				Response.Write "</div>"
			Response.Write "</div>"

			
			
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-lg-2 col-sm-6 mt-4"">"
					Response.Write "<div class=""btn btn-primary"" onclick=""uretimMiktarBitir()"">ÜRETİM BİTİR</button>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"'card-body
	Response.Write "</div>"'card
	



'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU






%>
<script>

	function uretimMiktarBitir(){
		var siparisKalemID			=	$('#siparisKalemID').val();
		var ajandaID				=	$('#ajandaID').val();
		var islemDurum				=	$('#islemDurum').val();
		var teminDepoID				=	$('#teminDepoID').val();
		var uretilenUrunGirisDepoID	=	$('#uretilenUrunGirisDepoID').val();
		var uretilenMiktar			=	$('#uretilenMiktar').val();
		var secilenReceteID			=	$('#secilenReceteID').val();


		swal({
			title: 'Üretilen Miktar seçilen depoya aktarılsın mı?',
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#DD6B55',
			confirmButtonText: 'evet',
			cancelButtonText: 'hayır'
		}).then(
			function(result) {
			// handle Confirm button click
			// result is an optional parameter, needed for modals with input
			
				$('#ajax').load('/uretim/uretimBaslat.asp', {
					uretilenUrunGirisDepoID:uretilenUrunGirisDepoID,
					ajandaID:ajandaID,
					siparisKalemID:siparisKalemID,
					islemDurum:islemDurum,
					uretilenMiktar:uretilenMiktar,
					teminDepoID:teminDepoID},
						function(){
							$('#receteAdim').load('/uretim/uretim.asp?secilenReceteID='+secilenReceteID+'&secilenDepoID='+teminDepoID+' #receteAdim > *');
							//$('#btnDIV').load('/uretim/uretim.asp?secilenReceteID='+secilenReceteID+'&secilenDepoID='+teminDepoID+' #btnDIV > *');
							$('#btnDIV2').load('/uretim/uretim.asp?secilenReceteID='+secilenReceteID+'&secilenDepoID='+teminDepoID+' #btnDIV2 > *');
							$('#btnDIV').removeClass('d-none');
							$('#btnDIV2').removeClass('d-none');
							modalkapat();
						});
			}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
		}

</script>



