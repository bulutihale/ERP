<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
    koliIndexID			=	Request.Form("koliIndexID")
	stokID				=	Request.Form("stokID")
	lot					=	Request.Form("lot")
	mamulMiktar			=	Request.Form("miktar")
	ajandaID			=	Request.Form("ajandaID")
	mamulCikisDepoID	=	Request.Form("mamulCikisDepoID")
    hata    =   ""
    modulAd =   "Sterilizasyon"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Sterilizasyon Planlama") 

yetkiKontrol = yetkibul(modulAd)

sarfMalzemeDepoKategori	=	"sterilizasyonSarf"


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" and yetkiKontrol > 0 then

			sorgu = "SELECT t1.koliUrunMiktar, t2.stokKodu as urunStokKod, t2.stokAd as urunAd, t3.ad as koliAd, t4.stokAd as bantStokAd, t5.stokAd as hamKoliStokAd, "
			sorgu = sorgu & " t4.stokKodu as bantStokKod, t5.stokKodu as koliStokKod, CEILING("&mamulMiktar&" * 1.00 /t1.koliUrunMiktar) as ihtiyacKoliSayi,"
			sorgu = sorgu & " t3.bantMT * CEILING("&mamulMiktar&" * 1.00 /t1.koliUrunMiktar) as ihtiyacBantMt, t3.bantMT,"
			sorgu = sorgu & " stok.FN_stokSayDepo("&firmaID&", t5.stokID, (SELECT id FROM stok.depo WHERE depoKategori = '"&sarfMalzemeDepoKategori&"')) as hamKoliHazirMiktar,"
			sorgu = sorgu & " stok.FN_stokSayDepo("&firmaID&", t4.stokID, (SELECT id FROM stok.depo WHERE depoKategori = '"&sarfMalzemeDepoKategori&"')) as bantHazirMiktar, "
			sorgu = sorgu & " (SELECT id FROM stok.depo WHERE depoKategori = '"&sarfMalzemeDepoKategori&"') as sarfDepoID"
			sorgu = sorgu & " FROM stok.koliIndex t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " INNER JOIN stok.koli t3 ON t1.koliID = t3.koliID"
			sorgu = sorgu & " INNER JOIN stok.stok t4 ON t3.bantStokID = t4.stokID"
			sorgu = sorgu & " INNER JOIN stok.stok t5 ON t3.hamKoliStokID = t5.stokID"
			sorgu = sorgu & " WHERE t1.koliIndexID = " & koliIndexID
			rs.open sorgu, sbsv5, 1, 3
				urunStokKod			=	rs("urunStokKod")
				urunAd				=	rs("urunAd")
				koliUrunMiktar		=	rs("koliUrunMiktar")
				koliAd				=	rs("koliAd")
				bantStokAd			=	rs("bantStokAd")
				hamKoliStokAd		=	rs("hamKoliStokAd")
				bantStokKod			=	rs("bantStokKod")
				koliStokKod			=	rs("koliStokKod")
				ihtiyacKoliSayi		=	rs("ihtiyacKoliSayi")
				ihtiyacBantMt		=	rs("ihtiyacBantMt")
				hamKoliHazirMiktar	=	rs("hamKoliHazirMiktar")
				bantHazirMiktar		=	rs("bantHazirMiktar")
				bantMT				=	rs("bantMT")
				sarfDepoID			=	rs("sarfDepoID")
			rs.close



		Response.Write "<div class=""card-deck"">"
			Response.Write "<div class=""card"" id=""sterPlanDIV1"">"
				Response.Write "<div class=""card-body"">"
				Response.Write "<h5 class=""card-title"">Sterilizasyon Planlama</h5>"
					Response.Write "<div class=""row bold bg-light mt-2"">"
						Response.Write "<div class=""col-3"">Ürün Kodu:</div>"
						Response.Write "<div class=""col-9"">" & urunStokKod & "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""row bold bg-light mt-2"">"
						Response.Write "<div class=""col-3"">Ürün Adı:</div>"
						Response.Write "<div class=""col-9"">" & urunAd & "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""row bold bg-light mt-2"">"
						Response.Write "<div class=""col-3"">Koli Ad:</div>"
						Response.Write "<div class=""col-9"">" & koliAd & "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""row bold bg-light mt-2"">"
						Response.Write "<div class=""col-3"">Koli İçi Miktar:</div>"
						Response.Write "<div class=""col-9"">" & koliUrunMiktar & "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""row bold bg-light mt-2"">"
						Response.Write "<div class=""col-3"">Kullanılan Koli:</div>"
						Response.Write "<div class=""col-9"">" & koliStokKod & " - " & hamKoliStokAd & "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""row bold bg-light mt-2"">"
						Response.Write "<div class=""col-3"">Kullanılan Bant:</div>"
						Response.Write "<div class=""col-9"">" & bantStokKod & " - " & bantStokAd & "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""row bold bg-light mt-2"">"
						Response.Write "<div class=""col-3"">LOT:</div>"
						Response.Write "<div class=""col-9"">" & lot & "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""row bold bg-light mt-2"">"
						Response.Write "<div class=""col-2"">Ürün Miktar:</div>"
						Response.Write "<div class=""col-2"">"
							Response.Write "<input class=""form-control"" id=""inpMamulMiktar"" type=""text"" value=""" & mamulMiktar & """ oninput=""numara(this,true,false);bantHesap('inpMamulMiktar')"">"
						Response.Write "</div>"
						Response.Write "<div class=""col-7 text-success bold"">" & mamulMiktar & "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""row bold bg-light mt-2"">"
						Response.Write "<div class=""col-2"">Gerekli Koli Sayısı:</div>"
						Response.Write "<div class=""col-2"">"
							call formhidden("koliUrunMiktar",koliUrunMiktar,"","","","","koliUrunMiktar","")
							Response.Write "<input class=""form-control"" id=""ihtiyacKoliSayi"" type=""text"" value=""" & ihtiyacKoliSayi & """ onchange=""bantHesap('ihtiyacKoliSayi')"">"
						Response.Write "</div>"
						Response.Write "<div id=""koliHazirDIV"" class=""col-2 text-success bold"" data-deger=""" & hamKoliHazirMiktar & """>" & hamKoliHazirMiktar & "</div>"
						Response.Write "<div class=""col-2"">Gerekli Bant Mt:</div>"
						Response.Write "<div class=""col-2"">"
							Response.Write "<input class=""form-control"" id=""ihtiyacBantMt"" type=""text"" data-birimbantmt="""&bantMT&""" value=""" & ihtiyacBantMt & """ readonly=""readonly"">"
						Response.Write "</div>"
						Response.Write "<div id=""bantHazirDIV"" class=""col-2 text-success bold"" data-deger=""" & bantHazirMiktar & """>" & bantHazirMiktar & "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""row bold bg-light mt-2 justify-content-around"">"
						Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4"">"
							Response.Write "<div id="""" class=""row h-100"">"
								Response.Write "<div class=""btn h3 bold text-center bg-success rounded col-lg-12 col-sm-12 pointer"" onclick=""urunHareket('steril','" & lot & "'," & koliIndexID & "," & sarfDepoID & ", " & ajandaID & ", " & mamulCikisDepoID & ")"">Kolileri Oluştur<br>Sterilizasyon Bekle</div>"
							Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4"">"
							Response.Write "<div id="""" class=""row h-100"">"
								Response.Write "<div class=""btn h3 bold text-center bg-warning rounded col-lg-12 col-sm-12 pointer"" onclick=""urunHareket('nonSteril','" & lot & "'," & koliIndexID & "," & sarfDepoID & ", " & ajandaID & ", " & mamulCikisDepoID & ")"">Kolileri Oluştur<br>Non-Steril Ürün</div>"
							Response.Write "</div>"
						Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"

		Response.Write "</div>"
	else
		call yetkisizGiris("","","")
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU


%>

<script>
	function bantHesap(hangiInput){
		var koliUrunMiktar	=	$('#koliUrunMiktar').val();
		var inpMamulMiktar	=	$('#inpMamulMiktar').val();
		var ihtiyacKoliHesap = 1;

		if(inpMamulMiktar > koliUrunMiktar){
			var ihtiyacKoliHesap	=	Math.ceil(parseFloat(inpMamulMiktar) / parseFloat(koliUrunMiktar));
		}		

		if(hangiInput == 'ihtiyacKoliSayi'){
			var ihtiyacKoliHesap= $('#ihtiyacKoliSayi').val();
		}

		$('#ihtiyacKoliSayi').val(ihtiyacKoliHesap);
		var birimbantmt		=	$('#ihtiyacBantMt').attr('data-birimbantmt');
		birimbantmtA		=	birimbantmt.replace(",",".");
		hesapSonuc			=	birimbantmtA * ihtiyacKoliHesap
		hesapSonuc			=	hesapSonuc.toFixed(2)
		hesapSonucA			=	hesapSonuc.toString()
		hesapSonucA			=	hesapSonucA.replace(".",",");
		$('#ihtiyacBantMt').val(hesapSonucA);
	}

	function urunHareket(urunTip, lot, koliIndexID, sarfDepoID, ajandaID, mamulCikisDepoID){
		var mamulMiktar			=	$('#inpMamulMiktar').val();
		var ihtiyacKoliSayi		=	$('#ihtiyacKoliSayi').val();
		var ihtiyacBantMt		=	$('#ihtiyacBantMt').val();
		var bantHazirMiktar		=	$('#bantHazirDIV').attr('data-deger');
		var koliHazirMiktar		=	$('#koliHazirDIV').attr('data-deger');
		var bantA =	parseFloat(ihtiyacBantMt.replace(",","."));
		var bantB =	parseFloat(bantHazirMiktar.replace(",","."));
		var koliA = parseFloat(ihtiyacKoliSayi.replace(",","."));
		var koliB = parseFloat(koliHazirMiktar.replace(",","."));

		if(koliB < koliA){
			swal('Koli Miktarı Yetersiz','');
			return false;
		}else if(bantB < bantA){
			swal('Yeterli bant yok!','');
			return false;
		}

		if(urunTip == 'nonSteril')
			{	var baslik 		=	'Non-Steril Ürün\n\n sterilizasyon sürecine girmeden satış deposuna aktarılsın mı?'
				var backBilgi	=	'<span class="h3 m-3 text-success">Non-Steril ürünler <b>MAMUL DEPO</b>\'ya aktarıldı.</span>'
			}
		else if(urunTip == 'steril')
			{	var baslik 		=	'Steril edilecek ürünler seçildi\n\n sterilizasyon sürecine aktarılsın mı?'
				var backBilgi	=	'<span class="h3 m-3 text-danger">Ürünler, <b>STERİLİZASYON SÜRECİ</b>\'ne aktarıldı.</span>'
			};

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
			
			$.post("/sterilizasyon/sterilizasyon_baslat.asp", {
				urunTip:urunTip,
				lot:lot,
				mamulMiktar:mamulMiktar,
				koliIndexID:koliIndexID,
				sarfDepoID:sarfDepoID,
				ihtiyacKoliSayi:ihtiyacKoliSayi,
				ihtiyacBantMt:ihtiyacBantMt,
				ajandaID:ajandaID,
				mamulCikisDepoID:mamulCikisDepoID
				}, function(){
					$('#sterilizasyonDIV1').load('/sterilizasyon/sterilizasyon_liste.asp #sterilizasyonDIV1 > *');
					$('#sterilizasyonDIV2').html(backBilgi);
				});

			}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
		

		}
		
</script>