<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

    call sessiontest()
    kid		=	kidbul()

	modulAd 		=   "Fason" 

	'##### YETKİ BUL
	'##### YETKİ BUL
	yetkiKontrol	 = yetkibul(modulAd)
	'##### YETKİ BUL
	'##### YETKİ BUL

	siparisKalemID			=	Request("id")
	mamulStokID				=	Request("stokID")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	if yetkiKontrol = 0 then
		call yetkisizGiris("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
	else

Response.Flush()

Response.Write "<div class=""card-deck"">"

	Response.Write "<div class=""card col-3"">"
		Response.Write "<div class=""card-header"">"	
			Response.Write "<div class=""btn btn-sm rounded btn-info"" onclick=""working('DIV1','30px','30px');$('#DIV1').load('/fason/fason_firmalar.asp', {islem:'gidecekUrun'})"">Gönderim Bekleyen</div>"
			Response.Write "<div class=""btn btn-sm rounded btn-info ml-2"">Ürünler</div>"
		Response.Write "</div>"	
		Response.Write "<div id=""DIV1"" class=""card-body""></div>"
	Response.Write "</div>"

	Response.Write "<div class=""card col-4"">"
		Response.Write "<div id=""DIV2""></div>"
	Response.Write "</div>"

	Response.Write "<div class=""card col-5"">"
		Response.Write "<div id=""DIV3"" ></div>"
	Response.Write "</div>"



Response.Write "</div>"

end if
%>


<!--#include virtual="/reg/rs.asp" -->


<script>
	function listeOnayla(formAdi, fasonAnaID){

		var formVerileri = $("#"+formAdi).serializeArray();
		if(formVerileri==''){
			swal('UYARI','onaylanan ürün seçimi yapılmadı!');
			return false;
		}
		formVerileri.push({name:'fasonAnaID', value:fasonAnaID});


	//	alert(secilenReceteID)
		swal({
			title: 'Seçili ürünlerin fason depoya kabul işlemi yapılsın mı?',
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#DD6B55',
			confirmButtonText: 'evet',
			cancelButtonText: 'hayır'
		}).then(
			function(result) {
			// handle Confirm button click
			// result is an optional parameter, needed for modals with input
			

		$.post('/fason/cikis_onay.asp',formVerileri, function(){
			working('DIV3', '30px', '30px');
			$('#DIV3').load('/fason/urun_detay.asp',{fasonAnaID:fasonAnaID});
		})

			}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
	}


	function gelenUrunKayit() {
		var gelisTarih			=	$('#gelisTarih').val();
		var gelenMiktar			=	$('#gelenMiktar').val();
		var gelenLot			=	$('#gelenLot').val();
		var gelenLotSKT			=	$('#gelenLotSKT').val();
		var gelenUrunAciklama	=	$('#gelenUrunAciklama').val();
		var fasonAnaID			=	$('#fasonAnaID').val();

        var errorMessage = '';

        if (!gelisTarih) {
            errorMessage += 'Geliş Tarihi boş.<br>';
        }
        if (!gelenMiktar) {
            errorMessage += 'Gelen Miktar boş.<br>';
        }
        if (!gelenLot) {
            errorMessage += 'Gelen Lot boş.<br>';
        }
        if (!gelenLotSKT) {
            errorMessage += 'LOT Son Kullanma Tarihi boş.';
        }

        if (errorMessage) {
            swal('HATA!',errorMessage);
			return false;
        }


		$.post('/fason/gelen_urunKayit.asp',{
			gelisTarih:gelisTarih,
			gelenMiktar:gelenMiktar,
			gelenLot:gelenLot,
			gelenLotSKT:gelenLotSKT,
			gelenUrunAciklama:gelenUrunAciklama,
			fasonAnaID:fasonAnaID}, function(){
				working('divGelenUrunAna', '30px', '30px');
				$('#divGelenUrunAna').load('/fason/modal_gelen_mamul.asp?fasonAnaID='+fasonAnaID);
			})


	}


</script>



