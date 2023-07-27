<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    ID			=	Request.QueryString("ID")
    kid64		=	ID
    opener  	=   Request.Form("opener")
    stokID64 	=   Request.QueryString("gorevID")
	gorevID64	=	stokID64
	gorevID		=	base64_decode_tr(gorevID64)
	modulAd 	=   "stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Koli Bilgileri Tanımlama Ekranı Girişi")

yetkiKontrol 	=	yetkibul(modulAd) 


if gorevID <> "" then

		sorgu = "SELECT" & vbcrlf
		sorgu = sorgu & "stok.stok.*" & vbcrlf
		sorgu = sorgu & ",portal.birimler.uzunBirim as seciliBirim" & vbcrlf
		sorgu = sorgu & ",stok.FN_stokHareketKontrol(" & firmaID & ", " & gorevID & ") as hareketKontrol" & vbcrlf
		sorgu = sorgu & " FROM stok.stok"
		sorgu = sorgu & " LEFT JOIN portal.birimler ON stok.stok.anaBirimID = portal.birimler.birimID"
		sorgu = sorgu & " WHERE stok.stok.firmaID = " & firmaID & " AND stok.stok.stokID = " & gorevID
		rs.open sorgu, sbsv5, 1, 3
			stokKodu		=	rs("stokKodu")
			katalogKodu		=	rs("katalogKodu")
			stokAd			=	rs("stokAd")
			stokTuru		=	rs("stokTuru")
			minStok			=	rs("minStok")
			stokBarcode		=	rs("stokBarcode")
			kkDepoGiris		=	rs("kkDepoGiris")
			silindi			=	rs("silindi")
			anaBirimID		=	rs("anaBirimID")
			seciliBirim		=	rs("seciliBirim")
			hareketKontrol	=	rs("hareketKontrol")
			rafOmru			=	rs("rafOmru")
			lotTakip		=	rs("lotTakip")
			stokAdEn		=	rs("stokAdEn")
			kdv				=	rs("kdv")
			manuelKayit		=	rs("manuelKayit")
			paraBirimID		=	rs("paraBirimID")
			stokfirmaID		=	rs("firmaID")
			fiyat1			=	rs("fiyat1")
			fiyat2			=	rs("fiyat2")
			fiyat3			=	rs("fiyat3")
			fiyat4			=	rs("fiyat4")
			defDeger		=	anaBirimID & "###" & uzunBirim
		rs.close
		inpKontrol	=	""
	else
		lotTakip = 1 ' yeni ürün kayıt ediliyorsa LOT Takip default olarak yapılır işaretlesin diye.
	end if



	Response.Write "<div class=""bold h3"">Ürün - Koli Eşleme (" & stokAd & ")</div>"

	Response.Write "<div id=""koliTanimlari"" class=""container mt-4"">"
			call formhidden("stokID64",stokID64,"","","","","stokID64","")
			call formhidden("stokID",gorevID,"","","","","stokID","")

		Response.Write "<div class=""col-sm-12 my-1"">"
			Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Ürün Adı","","") & "</span>"
			call forminput("stokAd",stokAd,"","","",inpKontrol,"","disabled")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
			Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Seçilen Koli","","") & "</span>"
			call formselectv2("koliSec","","","","formSelect2 koliSec border inpReset","","koliSec","","data-holderyazi=""" & translate("Kullanılacak ham koli seçimi","","") & """ data-jsondosya=""JSON_koliler"" data-miniput=""3"" data-defdeger=""""")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-4 my-1"">"
			Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Koli İçi Ürün Miktarı","","") & "</span>"
			call forminput("koliUrunMiktar",koliUrunMiktar,"",translate("Koli İçi Ürün Miktarı","",""),"","","koliUrunMiktar","")
		Response.Write "</div>"
		if yetkiKontrol >= 8 then
			Response.Write "<div class=""col-sm-4 my-1"">"
				Response.Write "<div id=""koliTanimKayit"" onclick=""koliTanimKayit('yeniKayit',0)"" class=""col-12 btn btn-info text-center rounded"">" & translate("Ekle","","") & "</div>"
			Response.Write "</div>"
		end if

		sorgu = "SELECT t1.koliIndexID, t2.ad as koliAd, t1.koliUrunMiktar, t3.stokAd as kullanilanKoliAd"
		sorgu = sorgu & " FROM stok.koliIndex t1"
		sorgu = sorgu & " INNER JOIN stok.koli t2 ON t1.koliID = t2.koliID"
		sorgu = sorgu & " INNER JOIN stok.stok t3 ON t2.hamKoliStokID = t3.stokID"
		sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.stokID = " & gorevID
		rs.open sorgu, sbsv5, 1, 3

			Response.Write "<table class=""table table-sm table-striped"">"
				Response.Write "<thead class=""thead-dark"">"
					Response.Write "<th scope=""col""></th>"
					Response.Write "<th scope=""col"">" & translate("Koli Adı","","") & "</th>"
					Response.Write "<th scope=""col"">" & translate("Kullanılan Koli Adı","","") & "</th>"
					Response.Write "<th scope=""col"">" & translate("Koli İçi Ürün Miktarı","","") & "</th>"
				Response.Write "</thead><tbody>"
		
		for zi = 1 to rs.recordcount
			if rs.recordcount > 0 then
				koliIndexID			=	rs("koliIndexID")
				kullanilanKoliAd	=	rs("kullanilanKoliAd")
				koliAd				=	rs("koliAd")
				koliUrunMiktar		=	rs("koliUrunMiktar")
			else
				koliIndexID			=	0
			end if
				
			Response.Write "<tr>"
				Response.Write "<td scope=""col"">"
				if yetkiKontrol >= 8 then
					Response.Write "<i onclick=""koliTanimKayit('silinecek',"&koliIndexID&")"" class=""icon delete pointer""></i>"
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






%><!--#include virtual="/reg/rs.asp" -->


<script>
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
								$('#koliTanimlari').load('/stok/urun_koli_esle.asp?gorevID='+stokID64+' #koliTanimlari > *');
								toastr.success(data);
							});
						
						
		}, //confirm buton yapılanlar
				function(dismiss) {
				// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
				} //cancel buton yapılanlar		
		);//swal sonu
		}
</script>

