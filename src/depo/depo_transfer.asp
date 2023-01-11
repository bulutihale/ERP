<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
	listeTur		=   Request.QueryString("listeTur")
	depoKategori	=	listeTur
    receteAdimID64	=   Request.QueryString("receteAdimID")
	receteAdimID	=	receteAdimID64
	receteAdimID	=	base64_decode_tr(receteAdimID)
    ajandaID64		=   Request.QueryString("ajandaID")
	ajandaID		=	ajandaID64
	ajandaID		=	base64_decode_tr(ajandaID)
	secilenDepoID	=	Request.QueryString("secilenDepoID")
    stokID64		=   Request.QueryString("stokID")
	stokID			=	stokID64
	if not isnumeric(stokID) then
		stokID			=	base64_decode_tr(stokID)
	end if
	girisDepoID		=	Request.Form("girisDepoID")
	if girisDepoID = "" then
		girisDepoID = 0
	end if
	modulAd			=   "Depo"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

Response.Flush()


call rqKontrol(stokID,"Lütfen aktarım yapılacak ürün seçimi yapın.","")

yetkiKontrol = yetkibul(modulAd)

	if ajandaID <> "" then
		'### sipariş miktar ve birimini bul
			sorgu = "SELECT t2.miktar, stok.FN_anaBirimADBul("&stokID&",'kad') as urunAnaBirim"
			sorgu = sorgu & " FROM portal.ajanda t1"
			sorgu = sorgu & " INNER JOIN teklif.siparisKalem t2 ON t2.id = (SELECT siparisKalemID FROM portal.ajanda t3 WHERE t3.id = t1.bagliAjandaID)"
			sorgu = sorgu & " WHERE t1.id = " & ajandaID
			rs.open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				siparisMiktar	=	rs("miktar")
				siparisBirim	=	rs("urunAnaBirim")
			end if
			rs.close
		'### /sipariş miktar ve birimini bul
	end if

	if receteAdimID <> "" then
		'### bileşenin reçetedeki miktarını  bul
			sorgu = "SELECT miktar, receteID FROM recete.receteAdim WHERE receteAdimID = " & receteAdimID
			rs.open sorgu, sbsv5, 1, 3
				receteMiktar	=	rs("miktar")
				receteID		=	rs("receteID")
			rs.close
		'### /bileşenin reçetedeki miktarını  bul

		ihtiyacMiktar	=	siparisMiktar * receteMiktar
	end if

	if stokID <> "" then
		sorgu = "SELECT t1.stokKodu, t1.stokAd FROM stok.stok t1 WHERE stokID = " & stokID
		rs.open sorgu, sbsv5, 1, 3
			stokKodu	=	rs("stokKodu")
			stokAd		=	rs("stokAd")
			defDeger	=	stokID & "###" & stokAd
		rs.close
	end if

	if girisDepoID <> "" then
		sorgu = "SELECT t1.depoAd, t1.id FROM stok.depo t1 WHERE id = " & girisDepoID
		rs.open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				depoID		=	rs("id")
				depoAd		=	rs("depoAd")
				defDeger1	=	depoID & "###" & depoAd
			end if
		rs.close
		call logla("Depolar arası transfer giriş depo seçildi giriş depo:"&depoAd&"")
	else
		call logla("Depolar arası transfer")
	end if
	

	if yetkiKontrol > 2 then

		Response.Write "<div class=""card"">"
			Response.Write "<div class=""card-header text-white bg-info"">Depolar Arası Transfer</div>"
			Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-12"">"
						Response.Write "<div class=""badge badge-secondary rounded-left"">Stok</div>"
						call formselectv2("stokID","","girisDepoSec('" & girisDepoID & "','" & receteAdimID64 & "', '" & ajandaID64 & "',$(this).val()),'" & depoKategori & "'","","formSelect2 stokID border","","stokID","","data-holderyazi=""Stok Adı"" data-jsondosya=""JSON_stoklar"" data-miniput=""3"" data-defdeger="""&defDeger&"""")
					Response.Write "</div>"
				Response.Write "</div>"




				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-lg-2 col-sm-6 bold"">Stok Kodu</div>"
					Response.Write "<div class=""col-lg-10 col-sm-6"">" & stokKodu & "</div>"
				Response.Write "</div>"
				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-lg-2 col-sm-6 bold"">Ürün</div>"
					Response.Write "<div class=""col-lg-10 col-sm-6"">" & stokAd & "</div>"
				Response.Write "</div>"
				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-lg-2 col-sm-6 bold"">Miktar</div>"
					Response.Write "<div class=""col-lg-10 col-sm-6 bold text-danger"">" & ihtiyacMiktar & " " & siparisBirim & "</div>"
				Response.Write "</div>"
				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-lg-2 col-sm-6 bold"">Giriş Depo</div>"
					Response.Write "<div class=""col-lg-10 col-sm-6"">"
						call formselectv2("girisDepoID","","girisDepoSec($(this).val(),'" & receteAdimID64 & "', '" & ajandaID64 & "','" & stokID64 & "','" & depoKategori & "')","","formSelect2 depoSec border","","girisDepoID","","data-holderyazi=""Giriş depo seçimi"" data-jsondosya=""JSON_depolar"" data-miniput=""0"" data-sart=""('uretim','sterilizasyon','kesim')""")
					Response.Write "</div>"
				Response.Write "</div>"

				Response.Write "<div id=""refreshDIV"">"
	'#####seçilen depoda giriş bekleyenleri göster
		if girisDepoID <> "" then
				sorgu = "SELECT"
				sorgu = sorgu & " t1.stokHareketID, t1.stokKodu, t3.stokAd, t1.girisTarih, t1.miktar, t1.miktarBirim, t1.lot, t1.lotSKT, t1.belgeNo, t3.stokID, t1.cariID, t4.depoAd, t1.refHareketID"
				sorgu = sorgu & " FROM stok.stokHareket t1"
				sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
				sorgu = sorgu & " INNER JOIN stok.depo t4 ON t1.depoID = t4.id"
				sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.silindi = 0 AND t1.stokHareketTuru = 'GB' AND t1.depoID = " & girisDepoID
				sorgu = sorgu & " ORDER BY t1.girisTarih DESC"
				rs.open sorgu, sbsv5, 1, 3
					if rs.recordcount > 0 then
						Response.Write "<div class=""my-2 border border-dark bg-warning rounded"">"
							Response.Write "<div class=""row"">"
								Response.Write "<div class=""col-lg-12 bold"">Bu Depo İçin Giriş Bekleyen Ürünler</div>"
							Response.Write "</div>"
							for ti = 1 to rs.recordcount
								Response.Write "<div class=""row m-2"">"
									Response.Write "<div class=""col"">" & rs("stokKodu") & "</div>"
									Response.Write "<div class=""col"">" & rs("stokAd") & "</div>"
									Response.Write "<div class=""col"">" & rs("miktar") & " " & rs("miktarBirim") & "</div>"
									Response.Write "<div class=""col"">"
					uretimYetkiKontrol = yetkibul("Üretim")
					if uretimYetkiKontrol >= 5 then 
						'# transfer red
						Response.Write "<div class=""badge badge-pill badge-danger pointer mr-2"""
							Response.Write " onClick=""urunCevap('red','stokHareketID',"&rs("stokHareketID")&",'silindi','stok.stokHareket','1',"&rs("refHareketID")&",'depoRed','"&depoKategori&"','refreshDIV','depoTransfer','"&receteAdimID64&"','"&ajandaID64&"','"&stokID64&"',"&girisDepoID&","&receteID&","&secilenDepoID&")"">"
							Response.Write "<i class=""mdi mdi-window-close""></i>"
						Response.Write "</div>"
						'# transfer red
						'# giriş onayla
						Response.Write "<div class=""badge badge-pill badge-success pointer"""
							Response.Write " onClick=""urunCevap('kabul','stokHareketID',"&rs("stokHareketID")&",'stokHareketTuru','stok.stokHareket','G','','depoRed','"&depoKategori&"','refreshDIV','depoTransfer','"&receteAdimID64&"','"&ajandaID64&"','"&stokID64&"',"&girisDepoID&","&receteID&","&secilenDepoID&")"">"
							Response.Write "<i class=""mdi mdi-chevron-right""></i>"
						Response.Write "</div>"
						'# /giriş onayla
					end if
									Response.Write "</div>"
								Response.Write "</div>"
							rs.movenext
							next
						Response.Write "</div>"
					elseif girisDepoID > 0 then
						Response.Write "<div class=""row my-4 border border-dark bg-warning rounded"">"
							Response.Write "<div class=""col-lg-12 bold"">Bu depo için giriş bekleyen ürün yok.</div>"
						Response.Write "</div>"
					end if
				rs.close
		end if
	'##### /seçilen depoda giriş bekleyenleri göster
	
'//FIXME - aktarım yapılacak olan depoKategori sorguya manuel yazıldı dinamikleştirilmesi gerekir.
				if stokID <> "" then

					call formhidden("listeTur",listeTur,"","","","","listeTur","")


					sorgu = "SELECT "
					sorgu = sorgu & " stok.FN_stokSayDepoLot(" & firmaID & ", t1.stokID, t1.depoID, t1.lot) as lotMiktar, t2.depoAd, t1.depoID, t1.lot, t1.miktarBirim, t1.lotSKT"
					sorgu = sorgu & " FROM stok.stokHareket t1"
					sorgu = sorgu & " INNER JOIN stok.depo t2 ON t1.depoID = t2.id"
					sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.stokID = " & stokID & " AND t2.silindi = 0 AND t2.depoKategori IN ('malKabul','uretim','kesim')"
					sorgu = sorgu & " AND stok.FN_stokSayDepo(" & firmaID & ", t1.stokID, t1.depoID) > 0"
					sorgu = sorgu & " AND stok.FN_stokSayDepoLot(" & firmaID & ", t1.stokID, t1.depoID, t1.lot) > 0"
					sorgu = sorgu & " AND t1.silindi = 0"
					sorgu = sorgu & " GROUP BY t1.depoID, t1.stokKodu, t1.stokID, t2.depoAd, t1.lot, t1.miktarBirim, t1.lotSKT"
					rs.open sorgu, sbsv5, 1, 3
						Response.Write "<div class=""row mt-1 text-center bold border-bottom mt-3"">"
							Response.Write "<div class=""col-lg-3 col-sm-6"">Lot</div>"
							Response.Write "<div class=""col-lg-3 col-sm-6"">Bulunduğu Depo</div>"
							Response.Write "<div class=""col-lg-3 col-sm-6"">Depodaki Miktar</div>"
							Response.Write "<div class=""col-lg-2 col-sm-6"">Aktarılacak Miktar</div>"
							Response.Write "<div class=""col-lg-1""></div>"				
						Response.Write "</div>"	



						siraNo		=	0
					do until rs.EOF
						siraNo	=	siraNo + 1
						depoID			=	rs("depoID")
						depoAd			=	rs("depoAd")
						lotMiktar		=	rs("lotMiktar")
						miktarBirim		=	rs("miktarBirim")
						lot				=	rs("lot")
						lotSKT			=	rs("lotSKT")
						if int(girisDepoID) = int(depoID) then
							divClass=" border border-success bg-success "
						else
							divClass	=	""
						end if

						Response.Write "<div class=""row mt-1 hoverGel rounded"&divClass&""">"
							Response.Write "<div class=""col-lg-3 col-sm-6"">" & lot & "</div>"
							Response.Write "<div class=""col-lg-3 col-sm-6"">" & depoAd &"</div>"
							Response.Write "<div class=""col-lg-3 col-sm-6 text-right pointer"" onclick=""$('#aktarMiktar_"&siraNo&"').val("&lotMiktar&")"">" & lotMiktar & " " & miktarBirim & "</div>"
							if int(girisDepoID) <> int(depoID) then
							Response.Write "<div class=""col-lg-2 col-sm-6"">"
								call forminput("aktarMiktar","","if(($('#girisDepoID').val())==null){swal('','Ürünün aktarılacağı Giriş depo seçimi yapılmamış.')}","","","autocompleteOFF","aktarMiktar_"&siraNo&"","")
							Response.Write "</div>"
							Response.Write "<div id=""btn_"&siraNo&""" class=""col-lg-1 rounded btn btn-sm btn-warning bold"" onclick=""depoTransfer(" & siraNo & ",'" & lot & "','" & lotSKT & "','" & miktarBirim & "'," & depoID & "," &  stokID & ",'" & stokKodu & "','" & receteAdimID64 & "', '" & ajandaID64 & "','" & stokID64 & "'," & lotMiktar & "," & ajandaID &",'"&depoKategori&"');"">"
								Response.Write "<i class=""mdi mdi-jira pointer bold""></i>"
							Response.Write "</div>"
							end if
						Response.Write "</div>"
					rs.movenext
					loop
					rs.close
				end if
				Response.Write "</div>"

			Response.Write "</div>"
		Response.Write "</div>"
	else
		call yetkisizGiris("","","")
		hata = 1
	end if
 
%><!--#include virtual="/reg/rs.asp" -->

	<script>
	// transfer işlemleri		
		function depoTransfer(siraNo,lot,lotSKT,miktarBirim,depoID,stokID,stokKodu,receteAdimID64,ajandaID64,stokID64,lotMiktar,ajandaID,depoKategori){
			var listeTur	=	$('#listeTur').val();
			var girisDepoID	=	$('#girisDepoID').val();
			var aktarMiktar	=	$('#aktarMiktar_'+siraNo).val();
					swal({
					//title: hangiGun+'.'+hangiAy+'.'+hangiYil+' gününe üretim planı eklensin mi?',
					title: 'Depolar arası ürün transferi yapılsın mı?',
					type: 'warning',
					showCancelButton: true,
					  confirmButtonColor: '#DD6B55',
					  confirmButtonText: 'Devam',
					  cancelButtonText: 'İptal'
					}).then(
					  function(result) {
						// handle Confirm button click
						// result is an optional parameter, needed for modals with input

					$('#ajax').load('/depo/depo_transfer_kaydet.asp',{
						lot:lot, 
						lotSKT:lotSKT, 
						aktarMiktar:aktarMiktar, 
						miktarBirim:miktarBirim, 
						depoID:depoID, 
						stokID:stokID, 
						stokKodu:stokKodu,
						girisDepoID:girisDepoID,
						lotMiktar:lotMiktar,
						ajandaID64:ajandaID64}, function(){
							$('#receteAdim').load('/uretim/uretim.asp?secilenReceteID=<%=receteID%>&secilenDepoID=<%=secilenDepoID%> #receteAdim > *')
							girisDepoSec(girisDepoID,receteAdimID64,ajandaID64,stokID64, depoKategori);
						});
					

					// $('#tr_'+ajandaID).load('/uretim/uretilenListe.asp #tr_'+ajandaID+' >*', {listeTur:listeTur});
					$('#listeTablo').load('/uretim/uretilenListe.asp #listeTablo >*', {listeTur:listeTur});

					  }, //confirm buton yapılanlar
					  function(dismiss) {
						// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
					  } //cancel buton yapılanlar		
					);//swal sonu
		}
	// transfer işlemleri


	// Giriş depo seçildiğinde deponun kendi kendine aktarımını engellemek için sayfayı post et
		function girisDepoSec(girisDepoID,receteAdimID64,ajandaID64,stokID64,depoKategori){
			
			$('#refreshDIV').load('/depo/depo_transfer.asp?listeTur='+depoKategori+'&receteAdimID='+receteAdimID64+'&ajandaID='+ajandaID64+'&stokID='+stokID64+'&secilenDepoID=<%=secilenDepoID%> #refreshDIV > *',{girisDepoID:girisDepoID})
		}
	// Giriş depo seçildiğinde deponun kendi kendine aktarımını engellemek için sayfayı post et

				$(document).ready(function() {
					$('#girisDepoID, #stokID').trigger('mouseenter');
				});
</script>