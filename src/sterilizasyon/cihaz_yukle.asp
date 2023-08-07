<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
	stokHareketID  	=   Request.Form("stokHareketID")
	techizatID  	=   Request.Form("techizatID")
	sterilCevrimID	=	Request.Form("sterilCevrimID")
    hata    	=   ""
    modulAd 	=   "Sterilizasyon"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Sterilizatör yükleniyor cihaz ID:"&techizatID&" - StokHareket ID: " & stokHareketID&"") 

yetkiKontrol = yetkibul(modulAd)

	sorgu = "SELECT techizatAd FROM isletme.techizat WHERE techizatID = " & techizatID
	rs.open sorgu,sbsv5,1,3
		techizatAd	=	rs("techizatAd")
	rs.close

		


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" and yetkiKontrol > 0 then

		'#### yeni çevrim başlat
			sorgu = "SELECT *"
			sorgu = sorgu & " FROM stok.sterilCevrim t1"
			sorgu = sorgu & " WHERE t1.sterilCevrimID is not null"
			if sterilCevrimID > 0 then
				sorgu = sorgu & " AND t1.sterilCevrimID = " & sterilCevrimID
			elseif techizatID <> "" then
				sorgu = sorgu & " AND t1.techizatID = " & techizatID & ""
			end if
			sorgu = sorgu & " AND t1.cevrimBitis is null"
			rs.open sorgu, sbsv5, 1, 3

			if rs.recordcount = 0 then
			call logla("Yeni Sterilizasyon çevrimi tanımlanıyor cihaz ID:"&techizatID&" - oluşturan kid: " & kid &"") 
				rs.addnew
					rs("firmaID")				=	firmaID
					rs("techizatID")			=	techizatID
				rs.update
			end if

				sterilCevrimID		=	rs("sterilCevrimID")
				cevrimBaslangic		=	rs("cevrimBaslangic")
				cevrimBitis			=	rs("cevrimBitis")
			
			rs.close

		Response.Write "<div class=""row container-fluid"">"
			'Response.Write "<div class=""card"">"
				Response.Write "<div class=""h4 text-danger bold col-6"">" & techizatAd & " Ürün Listesi</div>"
				if isnull(cevrimBaslangic) then
					Response.Write "<div class=""btn btn-success text-danger bold col-3"" onclick=""sterCevrimBaslat(" & sterilCevrimID & ", " & techizatID & ", 'baslat')"">BAŞLAT</div>"
				else
					Response.Write "<div class=""btn text-danger bold col-3 border border-dark""><span class=""text-success"">Başlangıç<br>" & cevrimBaslangic & "</span></div>"
				end if
				if not isnull(cevrimBaslangic) AND isnull(cevrimBitis) then
					Response.Write "<div class=""btn btn-success text-danger bold col-3"" onclick=""modalajax('/sterilizasyon/cevrim_bitir_modal.asp?sterilCevrimID="&sterilCevrimID&"');"">BİTİR</div>"
				else
					Response.Write "<div class=""btn text-danger bold col-3 border border-dark""><span class=""text-danger"">BİTİŞ<br>" & cevrimBitis & "</span></div>"
				end if
			'Response.Write "</div>"
		Response.Write "</div>"

		'##### tespit edilen sterilCevrimID değerini stokHareket tablosuna kaydet
		if stokHareketID > 0 then
			sorgu = "UPDATE stok.stokHareket SET sterilCevrimID = " & sterilCevrimID & " WHERE stokHareketID = "  & stokHareketID
			rs.open sorgu, sbsv5, 3, 3
		end if
		'##### tespit edilen sterilCevrimID değerini stokHareket tablosuna kaydet

			sorgu = "SELECT t1.stokHareketID, t1.lot, t2.stokKodu, t1.stokID, t2.stokAd, t1.miktar, stok.FN_anaBirimADBul(t1.stokID, 'kAd') as kisaBirim, t1.koliSayi,"
			sorgu = sorgu & " stok.FN_koliHacimHesapla(t1.koliIndexID,'m3') as koliHacim"
			sorgu = sorgu & " FROM stok.stokHareket t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.sterilCevrimID = " & sterilCevrimID
			rs.open sorgu, sbsv5, 1, 3

		Response.Write "<div class=""card-deck"">"
			Response.Write "<div class=""card" & class1 & """ id=""surecDIV1"">"
				Response.Write "<div class=""card-body"">"
				'Response.Write "<h5 class=""card-title"">Ürün Listesi</h5>"
				Response.Write "<table class=""table table-sm"">"	
					Response.Write "<thead class=""thead-dark"">"
						Response.Write "<th></th>"
						Response.Write "<th>LOT</th>"
						Response.Write "<th>Ürün</th>"
						Response.Write "<th>Miktar</th>"
						Response.Write "<th>Koli</th>"
						Response.Write "<th>Hacim</th>"
					Response.Write "</thead>"
					do until rs.EOF
					stokHareketID		=	rs("stokHareketID")
					stokID				=	rs("stokID")
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					lot					=	rs("lot")
					miktar				=	rs("miktar")
					kisaBirim			=	rs("kisaBirim")
					koliSayi			=	rs("koliSayi")
					toplamkoliHacim		=	rs("koliHacim") * koliSayi


					Response.Write "<tbody class=""hoverGel pointer fontkucuk2"">"
					if isnull(cevrimBaslangic) then
						Response.Write "<td onclick=""sterUrunCikar(" & stokHareketID & ", " & techizatID & ")""><i class=""icon server-delete""></i></td>"
					else
						Response.Write "<td onclick=""swal('','çevrim başlamış, ürün çıkarılamaz!')""><i class=""icon server-delete""></i></td>"
					end if
						Response.Write "<td>" & lot & "</td>"
						Response.Write "<td>" & stokKodu & " " & stokAd & "</td>"
						Response.Write "<td>" & miktar & " " & kisaBirim & "</td>"
						Response.Write "<td>" & koliSayi & "</td>"
						Response.Write "<td>" & toplamkoliHacim & " m<sup>3</sup></td>"
					Response.Write "</tbody>"
					rs.movenext
					loop
					rs.close
				Response.Write "</table>"
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
	function sterUrunCikar(stokHareketID,techizatID){
	//	alert(secilenReceteID)
		swal({
			title: 'Ürün, Sterilizasyon sürecinden çıkarılsın mı?',
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#DD6B55',
			confirmButtonText: 'evet',
			cancelButtonText: 'hayır'
		}).then(
			function(result) {
			// handle Confirm button click
			// result is an optional parameter, needed for modals with input
			
				working('surecDIV1','30px','30px')
				$('#ajax').load('/sterilizasyon/sterilizasyonUrunSil.asp', {stokHareketID:stokHareketID}, function(){
					$('#surecDIV2').load('/sterilizasyon/cihaz_yukle.asp', {techizatID:techizatID});
					$('#surecDIV1').load('/sterilizasyon/sterilizasyon_surec.asp #surecDIV1 > *')		
				});
			}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
		}


	function sterCevrimBaslat(sterilCevrimID, techizatID, islem){
	//	alert(secilenReceteID)
	if(islem == 'baslat'){var baslik = 'Sterilizasyon çevrimi başlatılsın mı?'}else if(islem=='bitir'){var baslik = 'Çevrim sonlandırılsın mı?'}
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
			
				$('#ajax').load('/sterilizasyon/cevrim_baslat.asp', {sterilCevrimID:sterilCevrimID,islem:islem}, function(){
					$('#surecDIV2').load('/sterilizasyon/cihaz_yukle.asp', {techizatID:techizatID});
					//$('#surecDIV1').load('/sterilizasyon/sterilizasyon_surec.asp #surecDIV1 > *')		
				});
			}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
		}
		
</script>