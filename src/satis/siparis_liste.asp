<!--#include virtual="/reg/rs.asp" --><%


'###### FİLTRELER
'###### FİLTRELER
		
	cariID			=	Request.Form("cariID")
	stokID			=	Request.Form("stokID")
	t1				=	Request.Form("t1")
	t2				=	Request.Form("t2")
	t3				=	Request.Form("t3")
	t4				=	Request.Form("t4")
	siparisNo		=	Request.Form("siparisNo")
    modulAd 		=   "Satış"


	
	'####### varsayılan tarih sınırları
		if t1 = "" then t1 = date() - 60 end if
		if t2 = "" then t2 = date() end if
	'####### /varsayılan tarih sınırları
	

'###### FİLTRELER
'###### FİLTRELER

	yetkiKontrol	 = yetkibul(modulAd)

'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU

call logla("Müşteri Siparişleri Listelendi")

Response.Write "<div class=""card rounded-top"">"
Response.Write "<div class=""card-header h5"">Müşterilerden Gelen Sipariş Listesi</div>"

Response.Write "<div class=""card-body"">"
		Response.Write "<div class=""col-1 pointer"" onclick=""modalajax('/satis/filtre.asp')""><i class=""mdi mdi-filter table-success rounded""></i></div>"
		Response.Write "<div class=""table-responsive mt-3"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr class=""text-center"">"
		Response.Write "<th class="""" >Sipariş Tarih</th>"
		Response.Write "<th class="""" >Müşteri</th>"
		Response.Write "<th class="""" >Teslim Tarih</th>"
		Response.Write "<th class="""" >Kod</th>"
		Response.Write "<th class="""" >Ürün Adı</th>"
		Response.Write "<th class="""" >Depo</th>"
		Response.Write "<th class="""" >Miktar</th>"
		Response.Write "<th class="""" >Üretim</th>"
		Response.Write "<th class="""" ><span>Giden</span> / <span class=""text-danger"">İptal</span></th>"
		Response.Write "<th class="""" ></th>"
		Response.Write "</tr></thead><tbody>"
		
		
		'//FIXME - miktar hesaplaması yanlış, düzeltilmeli!!!
            sorgu = "SELECT"
			sorgu = sorgu & " t1.id as siparisKalemID, t3.stokID, t1.miktar, t1.mikBirim, ISNULL(t1.birimFiyat,0) as birimFiyat, t1.paraBirim,"
			sorgu = sorgu & " t3.stokKodu, t3.stokAd, t1.kalemNot, t2.siparisTarih, t2.teslimTarih, t2.cariID,"
			sorgu = sorgu & " stok.FN_satilanMiktarBul(t1.id, t3.stokID, "&firmaID&") as teslimEdilen,"
			sorgu = sorgu & " (SELECT DISTINCT(miktarBirim) FROM stok.stokHareket WHERE siparisKalemID = t1.id AND silindi = 0 AND stokID = t3.stokID) as teslimBirim, t4.cariAd, t2.siparisNo,"
			sorgu = sorgu & " ISNULL(t1.eksikMiktarKapat,0) as eksikMiktarKapat, DATEFROMPARTS(t5.hangiYil, t5.hangiAy, t5.hangiGun) as planTarih,"
			sorgu = sorgu & " t5.baslangicZaman, t5.bitisZaman, t6.ad as teklifUrunAd, t6.kalemNot, t1.iuID"
			sorgu = sorgu & " FROM teklif.siparisKalem t1"
			sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
			sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
			sorgu = sorgu & " INNER JOIN cari.cari t4 ON t2.cariID = t4.cariID"
			sorgu = sorgu & " LEFT JOIN portal.ajanda t5 ON t1.id = t5.sipariskalemID AND t5.silindi = 0"
			sorgu = sorgu & " LEFT JOIN teklifv2.ihale_urun t6 ON t1.iuID = t6.id"
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
			if t3 <> "" then
				sorgu = sorgu & " AND t2.teslimTarih >= '" & tarihsql2(t3) &"'"	
			end if
			if t4 <> "" then
				sorgu = sorgu & " AND t2.teslimTarih <= '" & tarihsql2(t4) &"'"	
			end if
			sorgu = sorgu & " AND t2.siparisTarih >= '" & tarihsql2(t1) &"' AND t2.siparisTarih <= '" & tarihsql2(t2) &"'"
			sorgu = sorgu & " AND t2.siparisTur = 'S'"
			sorgu = sorgu & " ORDER BY t2.siparisNo DESC"
			rs.open sorgu, sbsv5, 1, 3


			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					siparisKalemID		=	rs("siparisKalemID")
					siparisNo			=	rs("siparisNo")
					stokID				=	rs("stokID")
					stokID64	 		=	stokID
					stokID64			=	base64_encode_tr(stokID64)
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					cariAd				=	rs("cariAd")
					cariID				=	rs("cariID")
					kalemNot			=	rs("kalemNot")
					miktar				=	rs("miktar")
					mikBirim			=	rs("mikBirim")
					teslimEdilen		=	rs("teslimEdilen")
					teslimBirim			=	rs("teslimBirim")
					birimFiyat			=	formatNumber(rs("birimFiyat"),2)
					paraBirim			=	rs("paraBirim")
					siparisTarih		=	rs("siparisTarih")
					teslimTarih			=	rs("teslimTarih")
					eksikMiktarKapat	=	rs("eksikMiktarKapat")
					bakiye				=	cdbl(teslimEdilen) + cdbl(eksikMiktarKapat)
					planTarih			=	tarihtr(rs("planTarih"))
					baslangicZaman		=	rs("baslangicZaman")
					bitisZaman			=	rs("bitisZaman")
					teklifUrunAd		=	rs("teklifUrunAd")
					iuID				=	rs("iuID")

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
							Response.Write "<div class=""pointer"" onclick=""$('#ortaalan').load('/satis/siparis_liste.asp',{siparisNo:'" & siparisNo & "'})"">"
								Response.Write siparisNo
							Response.Write "</div>"
						Response.Write "</td>"
						Response.Write "<td>" & cariAd & "</td>"
						Response.Write "<td class=""text-center"">" & teslimTarih & "</td>"
						Response.Write "<td>" & stokKodu & "</td>"
						Response.Write "<td>"
							Response.Write "<div>" & stokAd & "</div>"
							if not isnull(teklifUrunAd) then
								Response.Write "<div class=""ml-4 text-info fontkucuk2 font-italic""><i class=""icon information pointer"" onclick=""modalajax('/satis/modal_kalem_not.asp?iuID="&iuID&"')""></i> " & teklifUrunAd & "</div>"
							end if
						Response.Write "</td>"
						Response.Write "<td class=""text-center"">"
							Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-6"">"
								Response.Write "<div title=""Depolara göre stok sayıları"" class=""badge badge-pill badge-warning pointer mr-2"""
									Response.Write " onClick=""modalajaxfit('/stok/stok_depo_miktar.asp?gorevID=" & stokID64 & "&siparisKalemID="&siparisKalemID&"');"">"
									Response.Write "<i class=""mdi mdi-numeric-9-plus-box-multiple-outline""></i>"
								Response.Write "</div>"
							Response.Write "</div>"
							Response.Write "<div class=""col-6"">"
								if yetkibul("Admin") = 9 then
								Response.Write "<div title=""Reçete maliyeti hesaplama"" class=""badge badge-pill badge-success pointer mr-2"""
									Response.Write " onClick=""modalajaxfit('/satis/recete_maliyet.asp?siparisKalemID="&siparisKalemID&"&cariID=" & cariID & "&stokID=" & stokID & "');"">"
									Response.Write "<i class=""mdi mdi-calculator""></i>"
								Response.Write "</div>"
								end if
							Response.Write "</div>"
							Response.Write "</div>"
						Response.Write "</td>"
						Response.Write "<td class=""text-right"">" & miktar & " " & mikBirim & "</td>"
						Response.Write "<td class=""text-center"">"
							if isnull(bitisZaman) AND not isnull(baslangicZaman) then
								Response.Write "<div onclick=""swal('Üretim Başlangıç','" & baslangicZaman & "')"" title=""Üretim Başlangıç: " & baslangicZaman & """><i class=""help text-danger fa fa-hourglass-start""></i></div>"
							elseif not isnull(bitisZaman) then
								Response.Write "<div onclick=""swal('Üretim Bitiş','" & bitisZaman & "')"" title=""Üretim Bitiş: " & bitisZaman & """><i class=""help text-success fa fa-hourglass-end""></i></div>"
							end if
						Response.Write "</td>"
						Response.Write "<td class=""text-center bold"">"
							Response.Write  "<span>" & teslimEdilen & " " & teslimBirim & "</span>"
							Response.Write  "<span class=""text-danger""> / " & eksikMiktarKapat & " " & mikBirim & "</span>"
							Response.Write  "<div class=""w-100 p-0""></div>"
							if teslimDurum = "eksik" then
								Response.Write  "<span class=""btn btn-sm border p-0 bg-warning rounded fontkucuk2 btnEksikKapat"" data-islem=""kapama"" data-deger="""&siparisKalemID&""">bakiye kapat</span>"
							end if
						Response.Write "</td>"
						Response.Write "<td class=""text-center"">"
							Response.Write "<div class=""btn btn-sm btn-warning border rounded"" onclick=""modalajax('/malKabul/mal_giris_detay.asp?stokID="&stokID&"&siparisKalemID="&siparisKalemID&"')"">detay</div>"
							If not isdate(planTarih) Then
								'Response.Write "<div class=""btn btn-sm btn-info border rounded"" onclick=""modalajaxfit('/ajanda/ajanda.asp?yer=modal&isTur=uretimPlan&siparisKalemID=" & siparisKalemID & "')"">planla</div>"
								Response.Write "<div class=""btn btn-sm btn-info border rounded"" onclick=""modalajaxfit('/recete/recete_sec.asp?cariID=" & cariID & "&stokID="&stokID&"&yer=modal&isTur=uretimPlan&siparisKalemID=" & siparisKalemID & "')"">planla</div>"
							Else
								Response.Write "<div class=""btn btn-sm btn-success border rounded"" onclick=""modalajaxfit('/ajanda/ajanda.asp?yer=modal&isTur=uretimPlan&sorgulananTarih=" & planTarih & "')"">" & planTarih & "</div>"
							End if
						Response.Write "</td>"
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
						
						$('#ajax').load('/satis/bakiye_kapat.asp',{gitDeger:gitDeger, islem:islem});

						
					  }, //confirm buton yapılanlar
					  function(dismiss) {
						// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
					  } //cancel buton yapılanlar		
					);//swal sonu
					
				});//btnEksikKapat
		}
	//eksik bakiyeleri kapat fonkisyonu
	
	
</script>












