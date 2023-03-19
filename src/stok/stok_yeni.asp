<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    ID			=	Request.QueryString("ID")
    kid64		=	ID
    opener  	=   Request.Form("opener")
    gorevID 	=   Request.QueryString("gorevID")
	a			=   Request.QueryString("a")
	stokID64	=	gorevID
	gorevID64	=	gorevID
	gorevID		=	base64_decode_tr(gorevID64)
	modulAd 	=   "stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Stok Düzenleme Ekranı Girişi")

yetkiKontrol 	=	yetkibul(modulAd)
inpKontrol		=	""


if gorevID <> "" then

            sorgu = "SELECT t1.stokKodu, t1.stokAd, t1.stokTuru, t1.minStok, t1.stokBarcode, t1.kkDepoGiris, ISNULL(t1.silindi,0) as silindi,"
			sorgu = sorgu & " t1.anaBirimID, t2.uzunBirim, t1.rafOmru, t1.stokAdEn,"
			sorgu = sorgu & " stok.FN_stokHareketKontrol("&firmaID&", "&gorevID&") as hareketKontrol, t1.lotTakip"
			sorgu = sorgu & " FROM stok.stok t1"
			sorgu = sorgu & " LEFT JOIN portal.birimler t2 ON t1.anaBirimID = t2.birimID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.stokID = " & gorevID
			rs.open sorgu, sbsv5, 1, 3
				stokKodu		=	rs("stokKodu")
				stokAd			=	rs("stokAd")
				stokTuru		=	rs("stokTuru")
				minStok			=	rs("minStok")
				stokBarcode		=	rs("stokBarcode")
				kkDepoGiris		=	rs("kkDepoGiris")
				silindi			=	rs("silindi")
				anaBirimID		=	rs("anaBirimID")
				uzunBirim		=	rs("uzunBirim")
				hareketKontrol	=	rs("hareketKontrol")
				rafOmru			=	rs("rafOmru")
				lotTakip		=	rs("lotTakip")
				stokAdEn		=	rs("stokAdEn")
				defDeger		=	anaBirimID & "###" & uzunBirim
            rs.close
			
			inpKontrol	=	""
else
	lotTakip = 1 ' yeni ürün kayıt ediliyorsa LOT Takip default olarak yapılır işaretlesin diye.
end if


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-10 bold h3 text-info "">Ürün Ana Kartı</div>"
			Response.Write "<div class=""text-right col-2""><span onclick=""modalkapat()"" class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "</div>"

		Response.Write "<ul class=""nav nav-tabs"" role=""tablist"">"
			Response.Write "<li class=""nav-item"">"
				Response.Write "<a class=""nav-link active"" data-toggle=""tab"" href=""#home"">Ana Kart</a>"
			Response.Write "</li>"
			Response.Write "<li class=""nav-item"">"
				Response.Write "<a class=""nav-link"" data-toggle=""tab"" href=""#ekTanimlar"">Ek Tanımlar</a>"
			Response.Write "</li>"
			Response.Write "<li class=""nav-item"">"
				Response.Write "<a class=""nav-link"" data-toggle=""tab"" href=""#koliTanimlari"">Koli Tanımları</a>"
			Response.Write "</li>"
		Response.Write "</ul>"

Response.Write "<div class=""tab-content"">"
	Response.Write "<div id=""home"" class=""container tab-pane active"">"
  		Response.Write "<form action=""/stok/stok_ekle.asp?a="&a&""" method=""post"" class=""ajaxform"">"
		Response.Write "<div class=""align-items-left"">"
			call formhidden("stokID64",stokID64,"","","","","stokID64","")
			call formhidden("stokID",gorevID,"","","","","stokID","")
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-lg-6 col-sm-12 my-1"">"
					Response.Write "<span class=""badge badge-secondary rounded-left"">Stok Kodu</span>"
					call forminput("stokKodu",stokKodu,"","","",inpKontrol,"stokKodu","")
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-6 col-sm-12 my-1"">"
					Response.Write "<span class=""badge badge-secondary rounded-left"">Katalog Kodu</span>"
					call forminput("katalogKodu",katalogKodu,"","","",inpKontrol,"katalogKodu","")
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-sm-12 my-1"">"
					Response.Write "<span class=""badge badge-secondary rounded-left"">Ürün Ad</span>"
					call forminput("stokAd",stokAd,"","","",inpKontrol,"stokAd","")
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-sm-12 my-1"">"
					Response.Write "<span class=""badge badge-secondary rounded-left"">Ürün İngilizce Ad</span>"
					call forminput("stokAdEn",stokAdEn,"","","",inpKontrol,"stokAdEn","")
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-sm-4 my-1"">"
					Response.Write "<span class=""badge badge-secondary rounded-left"">Stok Türü</span>"
					call formselectv2("stokTuru",stokTuru,"","","stokTuru","","stokTuru",stokTipDegerler,"")
				Response.Write "</div>"
				Response.Write "<div class=""col-sm-4 my-1"">"
					Response.Write "<span class=""badge badge-secondary rounded-left"">Minumum Stok Miktarı</span>"
					call forminput("minStok",minStok,"","","","","minStok","")
				Response.Write "</div>"
				Response.Write "<div class=""col-sm-4 my-1"">"
					Response.Write "<span class=""badge badge-secondary rounded-left"">Raf Ömrü (Ay)</span>"
					call forminput("rafOmru",rafOmru,"","ay cinsinden","","","rafOmru","")
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-sm-3 my-1"">"
					Response.Write "<span class=""badge badge-secondary rounded-left"">Mal Kabulde Giriş KK Depo</span>"
					call formselectv2("kkDepoGiris",kkDepoGiris,"","","kkDepoGiris","","kkDepoGiris",HEDegerler,"")
				Response.Write "</div>"
				Response.Write "<div class=""col-sm-3 my-1"">"
					Response.Write "<span class=""badge badge-secondary rounded-left"">Ürün ana birim</span>"
					if hareketKontrol > 0 then
						Response.Write "<div class=""mt-2"">" & uzunBirim & "<span class=""text-danger pointer ml-2"" onclick=""swal('Ürün hareket görmüş, birim değiştirilemez.','')""><i class=""mdi mdi-information-outline""></i></span></div>"
						call formhidden("anaBirimID",anaBirimID,"","","","","anaBirimID","")
					else
						call formselectv2("anaBirimID","","","","formSelect2 anaBirimID border inpReset","","anaBirimID","","data-holderyazi=""Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0"" data-idKullan=""evet"" data-defdeger="""&defDeger&"""")
					end if
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""row"">"
				if yetkiKontrol >= 8 then
					Response.Write "<div class=""col-sm-6 my-1"">"
						Response.Write "<span class=""badge badge-secondary rounded-left"">Kullanım Dışı</span>"
						call formselectv2("silindi",silindi,"","","silindi","","silindi",HEDegerler,"")
					Response.Write "</div>"
					Response.Write "<div class=""col-sm-6 my-1"">"
						Response.Write "<span class=""badge badge-secondary rounded-left"">LOT Takibi Yapılsın</span><span class=""text-danger pointer ml-2"" onclick=""swal('','Koli, koli bandı gibi sarf malzemelerde LOT takibi yapılmayacağı için bu tip ürünlerde HAYIR seçilir.')""><i class=""mdi mdi-information-outline""></i></span>"
						call formselectv2("lotTakip",lotTakip,"","","lotTakip","","lotTakip",HEDegerler,"")
					Response.Write "</div>"
				end if
			Response.Write "</div>"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
				if gorevID <> "" then
					Response.Write "<div class=""col-auto my-1""><div class=""btn btn-warning"" onclick=""netsisKayit()"">NETSİS KAYIT</div></div>"
				end if
				Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</form>"
	Response.Write "</div>"

	Response.Write "<div id=""ekTanimlar"" class=""container tab-pane fade mt-4"">"
	if gorevID <> "" then

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-2 text-center"">"
				call forminput("katsayi1Deger","1","","","text-center bold h3","","katsayi1Deger","readonly")
				'Response.Write "<span class=""bold h2"">1</span>"
			Response.Write "</div>"	
			Response.Write "<div class=""col-3"">"
				call formselectv2("birimListe","","","","formSelect2 birimListe border inpReset","","birimListe","","data-holderyazi=""Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0"" data-idKullan=""evet""")
			Response.Write "</div>"	
			Response.Write "<div class=""col-1"">"
				Response.Write "<span class=""bold h2"">=</span>"
			Response.Write "</div>"
			Response.Write "<div class=""col-2"">"
				call forminput("katsayi2Deger",katsayi2Deger,"","","","","katsayi2Deger","")
			Response.Write "</div>"
			Response.Write "<div class=""col-3 bold h3 mt-1"">"
				Response.Write uzunBirim
			Response.Write "</div>"
			if yetkiKontrol >= 8 then
				Response.Write "<div id=""birimKatsayiKayit"" onclick=""birimKatsayiKayit('yeniKayit',0)"" class=""col-1 btn btn-info text-center rounded"">EKLE</div>"
			end if
		Response.Write "</div>"
		Response.Write "<div class=""row mt-5 text-left h3 text-warning border"">"
			Response.Write "<div class=""col-12 "">"
				Response.Write "Birim Karşılıkları"
			Response.Write "</div>"
		Response.Write "</div>"

			sorgu = "SELECT t1.stokBirimID, t2.uzunBirim as birim1Ad, t3.uzunBirim as birim2Ad, t1.birim1Katsayi, t1.birim2Katsayi FROM stok.stokBirim t1"
			sorgu = sorgu & " INNER JOIN portal.birimler t2 ON t1.BirimID1 = t2.birimID"
			sorgu = sorgu & " INNER JOIN portal.birimler t3 ON t1.BirimID2 = t3.birimID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.stokID = " & gorevID & " AND t1.silindi = 0"
			rs.open sorgu, sbsv5, 1, 3
			for zi = 1 to rs.recordcount
				if rs.recordcount > 0 then
					stokBirimID		=	rs("stokBirimID")
					birim1Ad		=	rs("birim1Ad")
					birim2Ad		=	rs("birim2Ad")
					birim1Katsayi	=	rs("birim1Katsayi")
					birim2Katsayi	=	rs("birim2Katsayi")
				end if
				Response.Write "<div class=""row text-center h4"">"

				
					Response.Write "<div class=""col-1 pointer text-danger"">"
					if yetkiKontrol >= 8 then
						Response.Write "<i onclick=""birimKatsayiKayit('silinecek',"&stokBirimID&")"" class=""mdi mdi-delete-forever""></i>"
					end if
					Response.Write "</div>"
					Response.Write "<div class=""col-1"">"
						Response.Write birim1Katsayi
					Response.Write "</div>"
					Response.Write "<div class=""col-3"">"
						Response.Write birim1Ad
					Response.Write "</div>"
					Response.Write "<div class=""col-1"">"
						Response.Write "<span class=""bold h2"">=</span>"
					Response.Write "</div>"
					Response.Write "<div class=""col-3"">"
						Response.Write birim2Katsayi
					Response.Write "</div>"
					Response.Write "<div class=""col-3"">"
						Response.Write birim2Ad
					Response.Write "</div>"
				Response.Write "</div>"
			rs.movenext
			next
			rs.close
	end if
	Response.Write "</div>"

	Response.Write "<div id=""koliTanimlari"" class=""container tab-pane fade mt-4"">"
		Response.Write "<div class=""col-sm-12 my-1"">"
			Response.Write "<span class=""badge badge-secondary rounded-left"">Ürün Ad</span>"
			call forminput("stokAd",stokAd,"","","",inpKontrol,"","")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
			Response.Write "<span class=""badge badge-secondary rounded-left"">Seçilen Koli</span>"
			call formselectv2("koliSec","","","","formSelect2 koliSec border inpReset","","koliSec","","data-holderyazi=""kullanılacak ham koli seçimi"" data-jsondosya=""JSON_koliler"" data-miniput=""3"" data-defdeger=""""")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-4 my-1"">"
			Response.Write "<span class=""badge badge-secondary rounded-left"">Koli İçi Ürün Miktarı</span>"
			call forminput("koliUrunMiktar",koliUrunMiktar,"","Koli içi ürün miktarı","","","koliUrunMiktar","")
		Response.Write "</div>"
		if yetkiKontrol >= 8 then
			Response.Write "<div class=""col-sm-4 my-1"">"
				Response.Write "<div id=""koliTanimKayit"" onclick=""koliTanimKayit('yeniKayit',0)"" class=""col-12 btn btn-info text-center rounded"">EKLE</div>"
			Response.Write "</div>"
		end if

		sorgu = "SELECT t1.koliIndexID, t2.ad as koliAd, t1.koliUrunMiktar, t3.stokAd as kullanilanKoliAd"
		sorgu = sorgu & " FROM stok.koliIndex t1"
		sorgu = sorgu & " INNER JOIN stok.koli t2 ON t1.koliID = t2.koliID"
		sorgu = sorgu & " INNER JOIN stok.stok t3 ON t2.hamKoliStokID = t3.stokID"
		sorgu = sorgu & " WHERE t1.silindi = 0"
		rs.open sorgu, sbsv5, 1, 3

			Response.Write "<table class=""table table-sm table-striped"">"
				Response.Write "<thead class=""thead-dark"">"
					Response.Write "<th scope=""col""></th>"
					Response.Write "<th scope=""col"">Koli Adı</th>"
					Response.Write "<th scope=""col"">Kullanılan Koli Adı</th>"
					Response.Write "<th scope=""col"">Koli içi miktar</th>"
				Response.Write "</thead><tbody>"
		
		for zi = 1 to rs.recordcount
			if rs.recordcount > 0 then
				koliIndexID			=	rs("koliIndexID")
				kullanilanKoliAd	=	rs("kullanilanKoliAd")
				koliAd				=	rs("koliAd")
				koliUrunMiktar		=	rs("koliUrunMiktar")
			end if
				
			Response.Write "<tr>"
				Response.Write "<td scope=""col"">"
				if yetkiKontrol >= 8 then
					Response.Write "<i onclick=""koliTanimKayit('silinecek',"&koliIndexID&")"" class=""mdi mdi-delete-forever pointer""></i>"
				end if
				Response.Write "</td>"
				Response.Write "<td scope=""col"">" & koliAd & "</td>"
				Response.Write "<td scope=""col"">" & kullanilanKoliAd & "</td>"
				Response.Write "<td scope=""col"" class=""text-center"">" & koliUrunMiktar & "</td>"
			Response.Write "</tr>"
		rs.movenext
		next
			Response.Write "</tbody></table>"
		rs.close

	Response.Write "</div>"

Response.Write "</div>"

	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%><!--#include virtual="/reg/rs.asp" -->


<script>
	$(document).ready(function() {
		$('#anaBirimID').trigger('mouseenter');

});


	function birimKatsayiKayit(islem,stokBirimID){
		stokID64		=	$('#stokID64').val();
		stokID			=	$('#stokID').val();
		secilenBirim	=	$('#birimListe').val();
		katsayi1Deger	=	$('#katsayi1Deger').val();
		katsayi2Deger	=	$('#katsayi2Deger').val();
		anaBirimID		=	$('#anaBirimID').val();
		if(islem == 'silinecek'){var baslik = 'Kayıt silinsin mi?'}else{var baslik = 'Birim katsayısı kayıt edilsin mi?'};
	//	alert(secilenReceteID)
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
			
				$.post("/stok/birimKatsayiEkle.asp", {
					islem:islem,
					stokBirimID:stokBirimID,
					anaBirimID:anaBirimID,
					stokID:stokID,
					secilenBirim:secilenBirim,
					katsayi1Deger:katsayi1Deger,
					katsayi2Deger:katsayi2Deger}, function(data){
						$('#ekTanimlar').load('/stok/stok_yeni.asp?gorevID='+stokID64+' #ekTanimlar > *');
						toastr.success(data);
					});
				
				
}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
		}


	function koliTanimKayit(islem,koliIndexID){
		stokID64		=	$('#stokID64').val();
		stokID			=	$('#stokID').val();
		koliID			=	$('#koliSec').val();
		koliUrunMiktar	=	$('#koliUrunMiktar').val();

if(islem == 'silinecek'){var baslik = 'Kayıt silinsin mi?'}else{var baslik = 'Koli bilgileri kayıt edilsin mi?'};
	//	alert(secilenReceteID)
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
			
				$.post("/stok/koliIndexEkle.asp", {
					islem:islem,
					koliIndexID:koliIndexID,
					stokID:stokID,
					koliID:koliID,
					koliUrunMiktar:koliUrunMiktar}, function(data){
						$('#koliTanimlari').load('/stok/stok_yeni.asp?gorevID='+stokID64+' #koliTanimlari > *');
						toastr.success(data);
					});
				
				
}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
		}



	function netsisKayit(){
		var stokKodu		=	$('#stokKodu').val();
		var stokAd			=	$('#stokAd').val();

		$.post("/stok/stok_netsis_ekle.asp", {
			stokKodu:stokKodu,
			stokAd:stokAd
		});

		}
</script>


