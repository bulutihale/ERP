<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
	depoKategori	=	session("sayfa5")
    hata    		=   ""
	If depoKategori = "uretim" Then
		modulAd 		=   "Üretim"
	Else
		' false
	End if
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("" & modulAd & " Depo Girişi Bekleyen Ürünler Ekranı")

yetkiKontrol = yetkibul(modulAd)



'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" and yetkiKontrol > 0 then
            sorgu = "SELECT"
			sorgu = sorgu & " t1.stokHareketID, t1.stokKodu, t3.stokAd, t1.girisTarih, t1.miktar, t1.miktarBirim, t1.lot, t1.lotSKT, t1.belgeNo, t3.stokID, t1.cariID, t4.depoAd, t1.refHareketID"
			sorgu = sorgu & " FROM stok.stokHareket t1"
			sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
			sorgu = sorgu & " INNER JOIN stok.depo t4 ON t1.depoID = t4.id"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.silindi = 0 AND t1.stokHareketTuru = 'GB'"
			sorgu = sorgu & " ORDER BY t1.girisTarih DESC"
			rs.open sorgu, sbsv5, 1, 3
			if rs.recordcount = 0 then
				call yetkisizGiris("Onay Bekleyen Kayıt Bulunamadı","Bilgi","")
			else


		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"

		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark text-center""><tr>"
		Response.Write "<th scope=""col"">Depo Ad</th>"
		Response.Write "<th scope=""col"">Giriş Tarih</th>"
		Response.Write "<th scope=""col"">Stok Kodu</th>"
		Response.Write "<th scope=""col"">Ürün Adı</th>"
		Response.Write "<th scope=""col"">Miktar</th>"
		Response.Write "<th scope=""col"">LOT</th>"
		Response.Write "<th scope=""col"">SKT</th>"
		if yetkiKontrol >= 5 then
			Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
		end if
		Response.Write "</tr></thead><tbody>"

			
			

				for i = 1 to rs.recordcount
					stokHareketID		=	rs("stokHareketID")
					refHareketID		=	rs("refHareketID")
					stokHareketID64	 	=	stokHareketID
					stokHareketID64		=	base64_encode_tr(stokHareketID64)
					girisTarih			=	rs("girisTarih")
					depoAd				=	rs("depoAd")
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					miktar				=	rs("miktar")
					miktarBirim			=	rs("miktarBirim")
					lot					=	rs("lot")
					lotSKT				=	rs("lotSKT")
					stokID				=	rs("stokID")
					stokID64		 	=	stokID
					stokID64			=	base64_encode_tr(stokID64)
					cariID				=	rs("cariID")
					cariID64		 	=	cariID
					cariID64			=	base64_encode_tr(cariID64)
					Response.Write "<tr>"
						Response.Write "<td>" & depoAd & "</td>"
						Response.Write "<td>" & girisTarih & "</td>"
						Response.Write "<td>" & stokKodu & "</td>"
						Response.Write "<td>" & stokAd & "</td>"
						Response.Write "<td class=""text-right"">" & miktar & " " & miktarBirim & "</td>"
						Response.Write "<td class=""text-center"">" & lot & "</td>"
						Response.Write "<td class=""text-center"">" & lotSKT & "</td>"
					if yetkiKontrol >= 5 then
						Response.Write "<td class=""text-right"">"
						'# transfer red
						Response.Write "<div class=""badge badge-pill badge-danger pointer mr-2"""
							Response.Write " onClick=""urunCevap('red','stokHareketID',"&stokHareketID&",'silindi','stok.stokHareket','1',"&refHareketID&")"">"
							Response.Write "<i class=""mdi mdi-window-close""></i>"
						Response.Write "</div>"
						'# transfer red
						'# giriş onayla
						Response.Write "<div class=""badge badge-pill badge-success pointer"""
							Response.Write " onClick=""urunCevap('kabul','stokHareketID',"&stokHareketID&",'stokHareketTuru','stok.stokHareket','G','')"">"
							Response.Write "<i class=""mdi mdi-chevron-right""></i>"
						Response.Write "</div>"
						'# /giriş onayla
						Response.Write "</td>"
					end if
					Response.Write "</tr>"
					Response.Flush()
				rs.movenext
				next
				Response.Write "</tbody>"
				Response.Write "</table>"
				Response.Write "</div>"

						Response.Write "</div>"
						Response.Write "</div>"
						Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			end if
			rs.close

	else
		call yetkisizGiris("Bu bölüme girmeye yetkiniz bulunmamaktadır","","")
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU


%>
	<script>

	// Bekleyen girişi onayla ve depoya giriş kaydet
		function urunCevap(cevap,idAlan,stokHareketID,alan,tablo,deger,refHareketID){

			if(cevap == 'kabul'){
				var baslik = 'Ürünün kesin kabulü yapılsın mı?'
				var durum = 'success'
			}else if(cevap == 'red'){
				var baslik= 'Ürün trasferi red edilsin mi?'
				var durum = 'error'
			}
					swal({
					title: baslik,
					type: durum,
					showCancelButton: true,
					  confirmButtonColor: '#DD6B55',
					  confirmButtonText: 'Devam',
					  cancelButtonText: 'İptal'
					}).then(
					  function(result) {
						// handle Confirm button click
						// result is an optional parameter, needed for modals with input
						
						$('#ajax').load('/portal/hucre_kaydet.asp',{idAlan:idAlan,id:stokHareketID,alan:alan,tablo:tablo,deger:deger})

				//eğer transfer kabul edilmeyecekse diğer depodan çıkış işlemi iptal edilsin
					if(cevap == 'red'){$('#ajax').load('/portal/hucre_kaydet.asp',{idAlan:idAlan,id:refHareketID,alan:alan,tablo:tablo,deger:deger})}
				//eğer transfer kabul edilmeyecekse diğer depodan çıkış işlemi iptal edilsin

						document.location = ('/depo/bekleyen_liste/uretim');

					  }, //confirm buton yapılanlar
					  function(dismiss) {
						// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
					  } //cancel buton yapılanlar		
					);//swal sonu
			
		}
	// Bekleyen girişi onayla ve depoya giriş kaydet
	</script>
