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
		if t1 = "" then t1 = date() - 30 end if
		if t2 = "" then t2 = date() end if
	'####### /varsayılan tarih sınırları
	

'###### FİLTRELER
'###### FİLTRELER

	yetkiKontrol	 = yetkibul(modulAd)

'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU

call logla("Fason İşler Listelendi")

Response.Write "<div class=""card rounded-top"">"
Response.Write "<div class=""card-header h5"">Fason Listesi</div>"

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
		Response.Write "<th class="""" >Sipariş Miktar</th>"
		Response.Write "<th class="""" >Fason Miktar</th>"
		Response.Write "<th class="""" >Üretim Miktar</th>"
		Response.Write "<th class="""" >Üretim</th>"
		Response.Write "<th class="""" ><span>Giden</span> / <span class=""text-danger"">İptal</span></th>"
		Response.Write "<th class="""" ></th>"
		Response.Write "</tr></thead><tbody>"
		
		
            sorgu = "SELECT"
			sorgu = sorgu & "*"
			sorgu = sorgu & "FROM teklif.siparisKalem t1"
			sorgu = sorgu & "INNER stok.stok t2 ON t1.stokID = t2.stokID"
			'sorgu = sorgu & "WHERE t1.s"
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
					siparisKalemNot		=	rs("siparisKalemNot")
					siparisAD			=	rs("siparisAD")
					miktar				=	rs("miktar")
					miktarFason			=	rs("miktarFason")
					sipMiktar			=	rs("sipMiktar")
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
						Response.Write "<td>"
							Response.Write  "<div>" & cariAd & "</div>"
							Response.Write "<div class=""font-italic fontkucuk2 text-danger ml-3"">" & siparisAD & "</div>"
						Response.Write "</td>"
						Response.Write "<td class=""text-center"">" & teslimTarih & "</td>"
						Response.Write "<td>" & stokKodu & "</td>"
						Response.Write "<td>"
							Response.Write "<div>" & stokAd & "</div>"
							if not isnull(teklifUrunAd) then
								Response.Write "<div class=""ml-4 text-info fontkucuk2 font-italic""><i class=""icon information pointer"" onclick=""modalajax('/satis/modal_kalem_not.asp?iuID="&iuID&"')""></i> " & teklifUrunAd & "</div>"
							end if
							Response.Write "<div class=""font-italic fontkucuk2 text-danger ml-3"">" & siparisKalemNot & "</div>"
						Response.Write "</td>"
						Response.Write "<td class=""text-center"">"
							Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-6"">"
								Response.Write "<div title=""Depolara göre stok sayıları"" class=""pointer mr-2"""
									Response.Write " onClick=""modalajaxfit('/stok/stok_depo_miktar.asp?gorevID=" & stokID64 & "&siparisKalemID="&siparisKalemID&"');"">"
									Response.Write "<i class=""icon report-magnify""></i>"
								Response.Write "</div>"
							Response.Write "</div>"
							Response.Write "<div class=""col-6"">"
								if yetkibul("Admin") = 9 then
								Response.Write "<div title=""Reçete maliyeti hesaplama"" class=""pointer mr-2"""
									Response.Write " onClick=""modalajaxfit('/satis/recete_maliyet.asp?siparisKalemID="&siparisKalemID&"&cariID=" & cariID & "&stokID=" & stokID & "');"">"
									Response.Write "<i class=""icon money""></i>"
								Response.Write "</div>"
								end if
							Response.Write "</div>"
							Response.Write "</div>"
						Response.Write "</td>"
						Response.Write "<td class=""text-right"">"
							Response.Write "<div>" & sipMiktar & " " & mikBirim & "</div>"'gelen siparişin toplam miktarı
							If not isdate(planTarih) Then
								Response.Write "<div class=""btn btn-sm btn-info"" onclick=""modalajax('/satis/modal_fason_miktar.asp?sipKalemID="&siparisKalemID&"')"">FASON</div>"
							end if
						Response.Write "</td>"
						Response.Write "<td id=""divFasonMiktar"&siparisKalemID&""" class=""text-right"">"
							if miktarFason > 0 then fClass = " bg-danger rounded p-2 bold " else fClass="" end if
							Response.Write "<div class=""" & fClass & """>" & miktarFason & " " & mikBirim & "</div>"'fasona girecek olan miktar
						Response.Write "</td>"
						Response.Write "<td id=""divMiktar"&siparisKalemID&""" class=""text-right"">"
							Response.Write "<div>" & miktar & " " & mikBirim & "</div>"'üretime girecek olan miktar
						Response.Write "</td>"

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
								Response.Write  "<span class=""btn btn-sm border p-0 bg-warning rounded fontkucuk2 btnEksikKapat"" data-islem=""kapama"" data-deger="""&siparisKalemID&""" data-stokid=""" & stokID & """>bakiye kapat</span>"
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
					var stokID		= $(this).attr('data-stokid');

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
						
						$('#ajax').load('/satis/bakiye_kapat.asp',{gitDeger:gitDeger, islem:islem, stokID:stokID});

						
					  }, //confirm buton yapılanlar
					  function(dismiss) {
						// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
					  } //cancel buton yapılanlar		
					);//swal sonu
					
				});//btnEksikKapat
		}
	//eksik bakiyeleri kapat fonkisyonu
	
	
</script>












