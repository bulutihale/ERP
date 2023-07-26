<!--#include virtual="/reg/rs.asp" --><%

sessiontest()

'eklemek için

taslakDurum		=	Request("taslakDurum")
cariID			=	Request("siphash")


kid				=	kidbul()
'eklemek için






sorgu = "SELECT t1.id as sipID, t1.stokHareketID, t1.siparisTarih, t2.stokID, t2.stokKodu, t2.stokAd, t1.miktar, t1.mikBirim, t1.birimFiyat, t1.paraBirim, t1.kalemNot, t1.lot"
sorgu = sorgu & " FROM teklif.siparisKalemTemp t1"
sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.cariID =  " & cariID & " AND t1.siparisTur = 'IRS'  AND (t1.sipno = '' or t1.sipno is null)"
rs.open sorgu,sbsv5,1,3

	if rs.recordcount = 0 then
		Response.Write "<div class=""bold"">Sevk bekleyen ürün yok.</div>"
	else
		Response.Write "<div class=""row"">"
		Response.Write "<div class=""col-lg-12 col-xs-12 mt10 mb10"">"
			Response.Write "<table class=""table table-sm table-striped table-bordered table-hover table-dark"">"
			Response.Write "<tr class=""text-center"">"
				Response.Write "<th width=""4%"">Tarih</th>"
				Response.Write "<th width=""7%"">Stok Kodu</th>"
				Response.Write "<th width=""35%"">Stok Adı / Sipariş Notu</th>"
				Response.Write "<th width=""10%"">Miktar</th>"
				Response.Write "<th width=""10%"">Fiyat (kdvsiz)</th>"
				Response.Write "<th width=""14%"">Lot</th>"
				Response.Write "<th width=""7%"">Seçim <input type=""checkbox"" name=""tumunuSec"" class=""form-contrl"" onchange=""$('input[name=\'lotChck\']').prop('checked', this.checked);""></th>"
				Response.Write "<th width=""10%"">İşlem</th>"
			Response.Write "</tr>"
			toplamfiyat = 0
			for ri = 1 to rs.recordcount
				sipID			=	rs("sipID")
				stokHareketID	=	rs("stokHareketID")
				stokID			=	rs("stokID")
				stokID64		=	stokID
				stokID64		=	base64_encode_tr(stokID64)
				miktar			=	rs("miktar")
				mikBirim		=	rs("mikBirim")
				birimFiyat		=	rs("birimFiyat")
				stokAd			=	rs("stokAd")
				kalemNot		=	rs("kalemNot")
			if not isnull(birimFiyat) then
				birimFiyat		=	formatnumber(birimFiyat,2)
				paraBirim		=	rs("paraBirim")
				lot				=	rs("lot")
			end if
			Response.Write "<tr>"
				Response.Write "<td class=""text-center"">"
				Response.Write rs("siparisTarih")
				Response.Write "</td>"
				Response.Write "<td>"
				Response.Write rs("stokKodu")
				Response.Write "</td>"
				Response.Write "<td>"
				Response.Write "<div>" & stokAd & "</div><div class=""fontkucuk2 ml-3 text-danger""><em>" & kalemNot & "</em></div>" 
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
				Response.Write miktar & " " & mikBirim
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
				Response.Write birimFiyat & " " & paraBirim
				Response.Write "</td>"
				Response.Write "<td class=""text-center"">" & lot & "</td>"
				Response.Write "<td class=""text-center"">"
					Response.Write "<input type=""checkbox"" name=""lotChck"" class=""form-control"" value=""" & stokHareketID & """>"
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
						Response.Write "<div title=""Depolara göre stok sayıları"" class=""badge badge-pill badge-warning pointer mr-2"""
							Response.Write " onClick=""modalajaxfit('/stok/stok_depo_miktar.asp?gorevID=" & stokID64 & "');"">"
							Response.Write "<i class=""mdi mdi-numeric-9-plus-box-multiple-outline""></i>"
						Response.Write "</div>"
						
							Response.Write "<span title=""kayıt sil"""
						Response.Write " onClick=""bootmodal('Silinsin mi?','custom','/satis/musteri_siparis_kalem_sil.asp?taslakDurum=sevkirsaliye&siphash=" & cariID & "&id=" & rs("sipID") & "&stokHareketID="&stokHareketID&"','','SİL','İPTAL','','','','ajax','','','')"""
							Response.Write " class=""badge badge-pill badge-danger pointer mr-2"">"
								Response.Write "<i class=""mdi mdi-delete-forever""></i>"
							Response.Write "</span>"
						
						
						
				Response.Write "</td>"
			Response.Write "</tr>"
			toplamfiyat = formatnumber((toplamfiyat + kalemTotal),2)
			rs.movenext
			next
			if pbSayi > 1 then
				toplamfiyat	=	"-"
				paraBirim	=	""
			end if	
			Response.Write "<tr>"
				Response.Write "<td class=""text-right"" colspan=""4"">"
				Response.Write "<strong>Toplam Tutar</strong>"
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
				Response.Write "<strong>"
				Response.Write toplamfiyat
				Response.Write "&nbsp;" & paraBirim & "</strong>"
				Response.Write "</td>"
				Response.Write "<td class=""text-right"" colspan=""2"">"
					call forminput("irsaliyeNo","","","İrsaliye Numarası","bold text-center","autocompleteOFF","irsaliyeNo","")
				Response.Write "</td>"
				Response.Write "<td class=""text-center"">"
				Response.Write "<button class=""btn btn-danger"" onClick=""irsaliyeKaydet("&cariID&")"">İrsaliye Kaydet</button>"
				Response.Write "</td>"
			Response.Write "</tr>"
			Response.Write "</table>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
rs.close

%><!--#include virtual="/reg/rs.asp" -->




<script>

function irsaliyeKaydet(cariID) {

	var satirDegerleri 	= [];
	var irsaliyeNo		=	$('#irsaliyeNo').val();
	if(irsaliyeNo == ''){swal('irsaliye no girilmemiş','','warning');return false} 


	  swal({
		title: 'İşaretli ürünler için irsaliye numarası kayıt edilecek ve sevk edilmiş olarak işaretlenecek.',
		type: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#DD6B55',
		confirmButtonText: 'evet',
		cancelButtonText: 'hayır'
	  }).then(function(result) {
		// handle Confirm button click
		// result is an optional parameter, needed for modals with input




    // İşaretli checkbox'ları seç ve değerlerini diziye ekle
    $('input[name="lotChck"]:checked').each(function() {
      satirDegerleri.push($(this).val());
    });

	if(satirDegerleri.length === 0){swal('ürün seçimi yapılmamış','','warning');return false}

	$('#ajax').load('/satis/irsaliye_no_kaydet.asp', {tempIDliste: satirDegerleri, irsaliyeNo: irsaliyeNo}, function(){
			$('#tempUrunListesi').load('/satis/musteri_sevk_liste.asp?taslakDurum=sevkirsaliye&islem=kontrol&siphash=' + cariID);
	});	



	  }).catch(function(dismiss) {
		// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
	  });
    
};
</script>






