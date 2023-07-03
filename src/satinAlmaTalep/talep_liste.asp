<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
		
	cariID			=	Request.Form("cariID")
	stokID			=	Request.Form("stokID")
	t1				=	Request.Form("t1")
	t2				=	Request.Form("t2")
	siparisNo		=	Request.Form("siparisNo")
    modulAd =   "Satın Alma"
    modulID =   "88"
    call sessiontest()
    kid		=	kidbul()

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
		Response.Write "<th class=""col-1"" scope=""col"">Talep Eden</th>"
		Response.Write "<th class=""col-1"" scope=""col"">Kod</th>"
		Response.Write "<th class=""col-3"" scope=""col"">Ürün Adı</th>"
		Response.Write "<th class=""col-1"" scope=""col"">Miktar</th>"
		Response.Write "<th class=""col-1"" scope=""col""></th>"
		Response.Write "<th class=""col-1"" scope=""col""></th>"
		Response.Write "<th class=""col-1"" scope=""col""></th>"
		Response.Write "<th class=""col-4"" scope=""col""></th>"
		Response.Write "</tr></thead><tbody>"
		
		
            sorgu = "SELECT"
			sorgu = sorgu & " t1.id as siparisKalemID, t3.stokID, t1.miktar, t1.mikBirim, t3.stokKodu, t3.stokAd, t1.kalemNot, t2.siparisTarih,"
			sorgu = sorgu & " t4.cariAd, t2.siparisNo, t5.ad as talepEden, t1.acilanSipKalemID, t6.siparisNo as acilanSipNo, t1.SAtalepRed, t1.talepRedAciklama"
			sorgu = sorgu & " FROM teklif.siparisKalem t1"
			sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
			sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
			sorgu = sorgu & " LEFT JOIN cari.cari t4 ON t2.cariID = t4.cariID"
			sorgu = sorgu & " INNER JOIN personel.personel t5 ON t1.kid = t5.id"
			sorgu = sorgu & " LEFT JOIN teklif.siparis t6 ON t6.sipID = (SELECT siparisID FROM teklif.siparisKalem WHERE id = t1.acilanSipKalemID)"
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
			sorgu = sorgu & " AND t2.siparisTur = 'SAT'"
			sorgu = sorgu & " ORDER BY t2.siparisTarih DESC"
			rs.open sorgu, sbsv5, 1, 3
'response.Write sorgu
			
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					talepRedAciklama	=	rs("talepRedAciklama")
					SAtalepRed			=	rs("SAtalepRed")
					siparisKalemID		=	rs("siparisKalemID")
					talepEden			=	rs("talepEden")
					siparisNo			=	rs("siparisNo")
					stokID				=	rs("stokID")
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					cariAd				=	rs("cariAd")
					kalemNot			=	rs("kalemNot")
					miktar				=	rs("miktar")
					mikBirim			=	rs("mikBirim")
					acilanSipKalemID	=	rs("acilanSipKalemID")
					acilanSipNo			=	rs("acilanSipNo")
					
					siparisTarih		=	rs("siparisTarih")
					
					

					teslimDurum	=	""
					satirClass	=	""
					butonDurum	=	""
					Response.Write "<tr class=""" & satirClass & """>"
						Response.Write "<td class=""text-center"">"
							Response.Write siparisTarih
							Response.Write "<hr class=""p-0 m-0"">"
							Response.Write "<div class=""pointer"" onclick=""$('#ortaalan').load('/satinAlmaTalep/talep_liste.asp',{siparisNo:'" & siparisNo & "'})"">"
								Response.Write siparisNo
							Response.Write "</div>"
						Response.Write "</td>"
						Response.Write "<td>" & talepEden & "</td>"
						Response.Write "<td>" & stokKodu & "</td>"
						Response.Write "<td><div>" & stokAd & "</div><div class=""fontkucuk2 ml-3 text-danger""><em>" & kalemNot & "</em></div></td>"
						Response.Write "<td class=""text-right"">" & miktar & " " & mikBirim & "</td>"
						Response.Write "<td class=""text-right""></td>"
						Response.Write "<td class=""text-center bold"" colspan=""2"">"
						if acilanSipKalemID = 0 AND SAtalepRed = False then
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-6 btn btn-warning border rounded bold"""
							if yetkiKontrol >= 5 then
								Response.Write " onclick=""modalajaxfit('/satinAlma/siparis.asp?talep=evet&siparisKalemID="&siparisKalemID&"')"""
							else
								Response.Write " onclick=""swal('Bu alana giriş yetkiniz yok.','')"""
							end if
							Response.Write ">Sipariş Aç</div>"
							Response.Write "<div class=""col-6 bg-danger btn rounded bold"""
							if yetkiKontrol >= 5 then
								Response.Write " onclick=""modalajaxfit('/satinAlmaTalep/talep_red.asp?siparisKalemID="&siparisKalemID&"&redDurum=ilkEkran')"""
							else
								Response.Write " onclick=""swal('Bu alana giriş yetkiniz yok.','')"""
							end if
								Response.Write ">RED"
							Response.Write "</div>"
						Response.Write "</div>"
						elseif SAtalepRed = True then
							Response.Write "<div class=""bg-info border rounded pointer"" onclick=""swal('','" & talepRedAciklama & "')"">"
								Response.Write "--- RED --- <br>" & talepRedAciklama
							Response.Write "</div>"
						else
							'Response.Write "<div class=""bg-success border rounded pointer"" onclick=""$('#ortaalan').load('/satinAlma/siparis_liste.asp',{siparisNo:'" & acilanSipNo & "'})"">"
							Response.Write "<div class=""bg-success border rounded pointer"" onclick=""modalajaxfit('/satinAlma/siparis_liste.asp?siparisNo="&acilanSipNo&"')"">"
								Response.Write "Sipariş Verilmiş"
							Response.Write "</div>"
						end if
						Response.Write "</td>"
						Response.Write "<td class=""text-center"">"
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












