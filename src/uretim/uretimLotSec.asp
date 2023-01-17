<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
	isTur			=	Request.QueryString("isTur")
	ihtiyacMiktar	=	Request.QueryString("ihtiyacMiktar")
	gorevID64		=	Request.QueryString("gorevID")
	gorevID			=	gorevID64
	ajandaID		=	base64_decode_tr(gorevID)
	stokID			=	Request.QueryString("stokID")
	secilenDepoID	=	Request.QueryString("secilenDepoID")
	if secilenDepoID = "" or isnull(secilenDepoID) then
		secilenDepoID = 0
	end if
	surecDepoID		=	Request.QueryString("surecDepoID")
	if surecDepoID = "" or isnull(surecDepoID) then
		surecDepoID = 0
	end if
	secilenReceteID	=	Request.QueryString("secilenReceteID")
	if secilenReceteID = "" then
		secilenReceteID = 0
	end if
	modulAd =   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Üretim Lot Seçimi Ekranı")


yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then


	sorgu = "SELECT t1.stokID, t2.stokKodu, t2.stokAd, portal.siparisKalemIDbul(" & firmaID  & ", " & ajandaID & ") as siparisKalemID"
	sorgu = sorgu & " FROM recete.receteAdim t1"
	sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
	sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.receteID = " & secilenReceteID & " AND t1.stokID = " & stokID
	rs.open sorgu, sbsv5, 1, 3

		if rs.recordcount = 0 then
			Response.Write "Depoda ürün yok."
		else
		Response.Write "<div class=""text-right""><span onclick=""modalkapat()"" class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<div class=""h4 text-center"">Üretimde Kullanılacak LOT Seçimi</div>"
		Response.Write "<div class=""table-responsive"">"
			Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark"">"
			Response.Write "<tr class=""text-center"">"
			Response.Write "<th scope=""col"">Stok Kodu</th>"
			Response.Write "<th scope=""col"">Ürün Adı</th>"
			Response.Write "<th scope=""col"">Lot Miktar</th>"
			Response.Write "<th scope=""col"">Kullanılacak Miktar</th>"
			Response.Write "</tr></thead><tbody>"
			
				for zi = 1 to rs.recordcount
					siparisKalemID	=	rs("siparisKalemID")
					stokID			=	rs("stokID")
					stokKodu		=	rs("stokKodu")
					stokAd			=	rs("stokAd")

					sorgu = "SELECT t1.lot, t1.miktarBirim, stok.FN_stokSayDepoLot(" & firmaID & ", " & stokID & ", " & secilenDepoID & ", t1.lot) as lotMiktar,"
					sorgu = sorgu & " t1.lotSKT"
					sorgu = sorgu & " FROM stok.stokHareket t1"
					sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.stokID = " & stokID & " AND t1.depoID = " & secilenDepoID & ""
					sorgu = sorgu & " AND stok.FN_stokSayDepoLot(" & firmaID & ", " & stokID & ", " & secilenDepoID & ", t1.lot) > 0"
					sorgu = sorgu & " GROUP BY t1.lot, t1.miktarBirim, t1.lotSKT"
					rs1.open sorgu, sbsv5, 1, 3
					

						Response.Write "<tr class=""bold"">"
							Response.Write "<td>" & stokKodu & "</td>"
							Response.Write "<td>" & stokAd & "</td>"
							Response.Write "<td></td>"
							Response.Write "<td>İhtiyaç: " & ihtiyacMiktar & "</td>"
							
						Response.Write "</tr>"
					if rs1.EOF then
						Response.Write "<tr><td></td><td class=""text-danger font-weight-light font-italic"" colspan=""5"">Seçilen depoda bu ürün yok</td></tr>"
					else
						divSayi		=	0
						do until rs1.EOF
						divSayi		=	divSayi + 1
						lot			=	rs1("lot")
						lotMiktar	=	rs1("lotMiktar")
						miktarBirim	=	rs1("miktarBirim")
						lotSKT		=	rs1("lotSKT")
						
							Response.Write "<tr>"
								Response.Write "<td></td>"
								Response.Write "<td class=""text-right"">" & lot & "</td>"
								Response.Write "<td class=""text-right"">" & lotMiktar & " " & miktarBirim & "</td>"
								Response.Write "<td class=""text-right col-2"">"
									call forminput("kullanimMiktar","","","","","autocompleteOFF","kullanimMiktar"&divSayi&"","")
								Response.Write "</td>"
								Response.Write "<td class=""text-center"">"
									Response.Write "<div onclick=""lotKullan('"&isTur&"',"&divSayi&",'"&stokKodu&"','C','"&surecDepoID&"',"&stokID&","&siparisKalemID&",'"&lot&"','T','"&miktarBirim&"',"&secilenDepoID&","&secilenReceteID&",'"&lotSKT&"',"&ajandaID&","&ihtiyacMiktar&","&surecDepoID&");"" class=""btn btn-info"">kullan</div>"
								Response.Write "</td>"
							Response.Write "</tr>"
						rs1.movenext
						loop
					end if
						rs1.close
				rs.movenext
				next
			Response.Write "</tbody>"
			Response.Write "</table>"
		Response.Write "</div>"
		end if
		rs.close
	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>
<script>
	function lotKullan(isTur,divSayi,stokKodu,stokHareketTuru,surecDepoID,stokID,siparisKalemID,lot,stokHareketTipi,miktarBirim,secilenDepoID,secilenReceteID,lotSKT,ajandaID,ihtiyacMiktar,surecDepoID){

		var kullanimMiktar		=	$('#kullanimMiktar'+divSayi).val();
		if(kullanimMiktar == undefined){swal('miktar girişi yapılmalı',''); return false};

	//	alert(secilenReceteID)
		swal({
			title: 'LOT kayıtları yapılsın mı?',
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#DD6B55',
			confirmButtonText: 'evet',
			cancelButtonText: 'hayır'
		}).then(
			function(result) {
			// handle Confirm button click
			// result is an optional parameter, needed for modals with input
			
				$('#ajax').load('/uretim/uretimLotKaydet.asp', {
					ajandaID:ajandaID,
					secilenDepoID:secilenDepoID,
					miktarBirim:miktarBirim,
					isTur:isTur, 
					stokKodu:stokKodu, 
					stokHareketTuru:stokHareketTuru, 
					kullanimMiktar:kullanimMiktar, 
					surecDepoID:surecDepoID, 
					stokID:stokID, 
					siparisKalemID:siparisKalemID, 
					lot:lot, 
					stokHareketTipi:stokHareketTipi, 
					lotSKT:lotSKT,
					ihtiyacMiktar:ihtiyacMiktar
					}, function(){
				$('#receteAdim').load('/uretim/uretim.asp?secilenReceteID='+secilenReceteID+'&secilenDepoID='+secilenDepoID+'&surecDepoID='+surecDepoID+' #receteAdim > *')
				});
				modalkapat();
			}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
		}

</script>