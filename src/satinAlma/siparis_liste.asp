<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
		
	cariID			=	Request.Form("cariID")
	stokID			=	Request.Form("stokID")
	t1				=	Request.Form("t1")
	t2				=	Request.Form("t2")
	siparisNo		=	Request.Form("siparisNo")
    modulAd 		=   "Satın alma"
	
	'####### varsayılan tarih sınırları
		if t1 = "" then t1 = date() - 30 end if
		if t2 = "" then t2 = date() end if
	'####### /varsayılan tarih sınırları
	

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	yetkiKontrol	 = yetkibul(modulAd)
	

'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU

call logla("Mal Kabul Siparişleri Listelendi")

Response.Write "<div class=""card rounded-top"">"
Response.Write "<div class=""card-header h5"">Satınalma Sipariş Listesi</div>"

Response.Write "<div class=""card-body"">"
		Response.Write "<div class=""col-1 pointer"" onclick=""modalajax('/satinAlma/filtre.asp')""><i class=""mdi mdi-filter table-success rounded""></i></div>"
		Response.Write "<div class=""table-responsive mt-3"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr class=""text-center"">"
		Response.Write "<th class=""col-1"" scope=""col"">Sipariş Tarih</th>"
		Response.Write "<th class=""col-1"" scope=""col"">Kod</th>"
		Response.Write "<th class=""col-3"" scope=""col"">Ürün Adı</th>"
		Response.Write "<th class=""col-1"" scope=""col"">Miktar</th>"
		Response.Write "<th class=""col-1"" scope=""col"">Fiyat</th>"
		Response.Write "<th class=""col-1"" scope=""col""><span>Gelen</span> / <span class=""text-danger"">İptal</span></th>"
		Response.Write "<th class=""col-1"" scope=""col""></th>"
		Response.Write "<th class=""col-4"" scope=""col"">Tedarikçi</th>"
		Response.Write "</tr></thead><tbody>"
		
		
            sorgu = "SELECT"
			sorgu = sorgu & " t1.id as siparisKalemID, t3.stokID, t1.miktar, t1.mikBirim, ISNULL(t1.birimFiyat,0) as birimFiyat, t1.paraBirim, t3.stokKodu, t3.stokAd, t1.kalemNot, t2.siparisTarih,"
			sorgu = sorgu & " ISNULL((SELECT SUM(t4.miktar) FROM stok.stokHareket t4 WHERE t4.siparisKalemID = t1.id AND t4.silindi = 0),0) as teslimEdilen,"
			sorgu = sorgu & " (SELECT DISTINCT(miktarBirim) FROM stok.stokHareket WHERE siparisKalemID = t1.id) as teslimBirim, t4.cariAd, t2.siparisNo,"
			sorgu = sorgu & " ISNULL(t1.eksikMiktarKapat,0) as eksikMiktarKapat"
			sorgu = sorgu & " FROM teklif.siparisKalem t1"
			sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
			sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
			sorgu = sorgu & " INNER JOIN cari.cari t4 ON t2.cariID = t4.cariID"
			sorgu = sorgu & " WHERE t2.firmaID = " & firmaID
			if stokID <> "" then
				sorgu = sorgu & " AND t3.stokID = " & stokID & ""
			end if
			if cariID <> "" then
				sorgu = sorgu & " AND t2.cariID = " & cariID & ""
			end if
			if siparisNo <> "" then
				sorgu = sorgu & " AND t2.siparisNo = '" & siparisNo & "'"
			end if
			sorgu = sorgu & " AND t2.siparisTarih >= '" & tarihsql2(t1) &"' AND t2.siparisTarih <= '" & tarihsql2(t2) &"'"
			sorgu = sorgu & " AND t2.siparisTur = 'SA'"
			sorgu = sorgu & " ORDER BY t2.siparisTarih DESC"
			rs.open sorgu, sbsv5, 1, 3
'response.Write sorgu
			
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					siparisKalemID		=	rs("siparisKalemID")
					siparisNo			=	rs("siparisNo")
					stokID				=	rs("stokID")
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					cariAd				=	rs("cariAd")
					kalemNot			=	rs("kalemNot")
					miktar				=	rs("miktar")
					mikBirim			=	rs("mikBirim")
					teslimEdilen		=	rs("teslimEdilen")
					teslimBirim			=	rs("teslimBirim")
					birimFiyat			=	formatNumber(rs("birimFiyat"),2)
					paraBirim			=	rs("paraBirim")
					siparisTarih		=	rs("siparisTarih")
					eksikMiktarKapat	=	rs("eksikMiktarKapat")
					bakiye				=	cdbl(teslimEdilen) + cdbl(eksikMiktarKapat)

					teslimDurum	=	""
					satirClass	=	""
					butonDurum	=	""
					if cdbl(miktar) = cdbl(bakiye) then
						teslimDurum	=	"tam"
						satirClass 	= 	" table-success "
						butonDurum	=	"gizli"
					elseif cdbl(miktar) > cdbl(bakiye) then
						teslimDurum	=	"eksik"
					end if
					
					Response.Write "<tr class=""" & satirClass & """>"
						Response.Write "<td class=""text-center"">"
							Response.Write siparisTarih
							Response.Write "<hr class=""p-0 m-0"">"
							Response.Write "<div class=""pointer"" onclick=""$('#ortaalan').load('/satinAlma/siparis_liste.asp',{siparisNo:'" & siparisNo & "'})"">"
								Response.Write siparisNo
							Response.Write "</div>"
						Response.Write "</td>"
						Response.Write "<td>" & stokKodu & "</td>"
						Response.Write "<td>" & stokAd & "</td>"
						Response.Write "<td class=""text-right"">" & miktar & " " & mikBirim & "</td>"
						Response.Write "<td class=""text-right"">" & birimFiyat & " " & paraBirim & "</td>"
						Response.Write "<td class=""text-center bold"">"
							Response.Write  "<span>" & teslimEdilen & " " & teslimBirim & "</span>"
							Response.Write  "<span class=""text-danger""> / " & eksikMiktarKapat & " " & mikBirim & "</span>"
							Response.Write  "<div class=""w-100 p-0""></div>"
							if yetkiKontrol >= 8 then
							if teslimDurum = "eksik" then
								Response.Write  "<span class=""btn btn-sm border p-0 bg-warning rounded fontkucuk2 btnEksikKapat"" data-islem=""kapama"" data-deger="""&siparisKalemID&""">bakiye kapat</span>"
							end if
							end if
						Response.Write "</td>"
						Response.Write "<td class=""text-center"">"
							Response.Write "<div class=""btn btn-warning border rounded"" onclick=""modalajax('/malKabul/mal_giris_detay.asp?siparisKalemID="&siparisKalemID&"')"">detay</div>"
						Response.Write "</td>"
						Response.Write "<td>" & cariAd & "</td>"
					Response.Write "</tr>"
					Response.Flush()
				rs.movenext
				next
			end if
			rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"
	Response.Write "</div>"'card-body
	Response.Write "</div>"'card
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU







%>

<script>
	$(document).ready(function() {
		
		
		
		
		
		
	//eksik bakiyeleri kapat	
		bakiyeKapat()
	//eksik bakiyeleri kapat		
		
	})//ready
	
	
	
jQuery(document).ajaxSuccess(function(){
	
	bakiyeKapat()

})//success


	
	//eksik bakiyeleri kapat fonkisyonu
		function bakiyeKapat(){	
				$('.btnEksikKapat').on('click', function() {
					
					var islem		= $(this).attr('data-islem');
					var gitDeger	= $(this).attr('data-deger');
					
					if(islem == 'kapamaiptal'){
						var baslik = 'Bakiye kapama işlemi iptal edilsin mi?'
					}else{
						var baslik = 'Bakiye kapatılsın mı?'
					}
					
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
						
						$('#ajax').load('/satinAlma/bakiye_kapat.asp',{gitDeger:gitDeger, islem:islem});

						
					  }, //confirm buton yapılanlar
					  function(dismiss) {
						// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
					  } //cancel buton yapılanlar		
					);//swal sonu
					
				});//btnEksikKapat
		}
	//eksik bakiyeleri kapat fonkisyonu
	
	
</script>












