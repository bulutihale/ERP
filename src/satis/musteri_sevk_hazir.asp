<!--#include virtual="/reg/rs.asp" --><%

sessiontest()

satisDepoID		=	Request("satisDepoID")


kid				=	kidbul()


	Response.Write "<div class=""card"">"
		Response.Write "<div class=""card-body"">"
			Response.Write "<div id=""saticDepoSec"" class=""form-row align-items-center"">"
				Response.Write "<div class=""col-sm-6 my-1"">"
					Response.Write "<span class=""badge badge-secondary rounded-left"">Satış deposu seçimi</span>"
					call formselectv2("satisDepoID",cint(satisDepoID),"$('#listeDIV').load('/satis/musteri_sevk_hazir.asp #listeDIV > *',{satisDepoID:$(this).val()})","","formSelect2 satisDepo border","","satisDepo","","data-holderyazi=""Satış deposu"" data-jsondosya=""JSON_depolar"" data-miniput=""0"" data-sart=""('satis')""")
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
	Response.Write "</div>"

		


	Response.Write "<div id=""listeDIV"" class=""card card-secondary mt-3"">"
		Response.Write "<div class=""card-body"">"
	if satisDepoID = "" then
		Response.Write "<div class=""bold"">Depo Seçimi yapılmadı.</div>"
	else

		sorgu = "SELECT"
			sorgu = sorgu & " ISNULL(t1.siparisKalemID,0) as siparisKalemID,"
			sorgu = sorgu & " t1.lot,"
			sorgu = sorgu & " t2.stokKodu,"
			sorgu = sorgu & " t1.stokID,"
			sorgu = sorgu & " t2.stokAd,"
			sorgu = sorgu & " ISNULL(t1.ajandaID,0) as ajandaID,"
			'sorgu = sorgu & " t1.miktar,"
			sorgu = sorgu & " stok.FN_anaBirimADBul ( t1.stokID, 'kAd' ) AS kisaBirim,"
			sorgu = sorgu & " ISNULL([portal].[FN_sipariscariAdbul] (" & firmaID & ", t1.ajandaID),'Stok için') as cariAd,"
			sorgu = sorgu & " [stok].[FN_stokSayDepoLot] (5, t1.stokID, t1.depoID, t1.lot) as miktar"
			sorgu = sorgu & " FROM stok.stokHareket t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
		sorgu = sorgu & " WHERE"
			sorgu = sorgu & " t1.silindi = 0"
			sorgu = sorgu & " AND t1.depoID = 8"
			sorgu = sorgu & " AND [stok].[FN_stokSayDepoLot] (" & firmaID & ", t1.stokID, t1.depoID, t1.lot) > 0"
			sorgu = sorgu & " AND t1.stokHareketTipi <> 'S'" 'satılmış olan ürünleri dahil etme
			sorgu = sorgu & " GROUP BY t1.siparisKalemID, t1.lot, t2.stokKodu, t1.cariID, t1.stokID, t1.depoID, t2.stokAd,t1.ajandaID"
			rs.open sorgu,sbsv5,1,3

			if rs.EOF then
				Response.Write "<div class=""bold"">Sevk bekleyen ürün yok.</div>"
			else

				Response.Write "<table class=""table table-sm"">"
					Response.Write "<thead>"
						Response.Write "<th class="" text-center bold"">Stok Kodu</th>"
						Response.Write "<th class="" text-center bold"">Ürün Adı</th>"
						Response.Write "<th class="" text-center bold"">LOT</th>"
						Response.Write "<th class="" text-center bold"">Miktar</th>"
						Response.Write "<th class="" text-center bold"">Sipariş Veren</th>"
						Response.Write "<th class="" text-center bold"">Sevk Miktar</th>"
						Response.Write "<th class="" text-center bold"">İşlem</th>"
					Response.Write "</thead>"
				'for di = 1 to rs.recordcount
				di = 0
				do until rs.EOF
				di				=	di + 1
				stokAd			=	rs("stokAd")
				miktar			=	rs("miktar")
				kisaBirim		=	rs("kisaBirim")
				cariAd			=	rs("cariAd")
				stokKodu		=	rs("stokKodu")
				lot				=	rs("lot")
				ajandaID		=	rs("ajandaID")
				siparisKalemID	=	rs("siparisKalemID")
				'stokHareketID	=	rs("stokHareketID")

				if siparisKalemID = 0 then
					sevkTip = "stoktanSevk"
				else
					sevkTip = "siparisSevk"
				end if	
					Response.Write "<tbody>"
						Response.Write "<td class="""">" & stokKodu & "</td>"
						Response.Write "<td class="""">" & stokAd & "</td>"
						Response.Write "<td class="""">" & lot & "</td>"
						Response.Write "<td class="""">" & miktar & " " & kisaBirim & "</td>"
						Response.Write "<td class="""">"
							Response.Write cariAd
							if sevkTip = "stoktanSevk" then
								Response.Write "<br>"
								Response.Write "<div class=""badge badge-secondary rounded-left"">Cari Seçimi</div>"
								call formselectv2("cariID","","","","formSelect2 cariID","","cariID","","data-holderyazi=""Cari adı, cari kodu, vergi no"" data-jsondosya=""JSON_cariler"" data-miniput=""3""")
							end if
						Response.Write "</td>"
						Response.Write "<td class="""">"
							call forminput("sevkMiktar",miktar,"","","bold text-center","autocompleteOFF","sevkMiktar_" & di & "","")
						Response.Write "</td>"
						Response.Write "<td class=""text-center bg-success rounded pointer"" data-miktarinputid=""sevkMiktar_" & di & """ onclick=""sevkKaydet('sevkMiktar_" & di & "','"&kisaBirim&"','"&siparisKalemID&"',"&satisDepoID&",'"&lot&"',"&ajandaID&","&satisDepoID&",$('#cariID').val(),'"&sevkTip&"',"&stokHareketID&")""><i class=""icon bullet-go""></i></td>"
					Response.Write "</tbody>"
				rs.movenext
				loop
				Response.Write "</table>"
			end if
rs.close
		end if
		Response.Write "</div>"
	Response.Write "</div>"
			

%><!--#include virtual="/reg/rs.asp" -->




<script>

function sevkKaydet(miktarInputID,kisaBirim,siparisKalemID,satisDepoID,lot,ajandaID,satisDepoID,sevkcariID,sevkTip,stokHareketID) {

var sevkMiktar			=	$('#'+miktarInputID).val();
	if(sevkTip == 'stoktanSevk' && sevkcariID == null){swal('','Stoktan sevk edilen ürünlerde cari seçimi yapılmalıdır.','warning');return false} 
	if(sevkMiktar == ''){swal('Miktar girilmemiş','','warning');return false} 


	  swal({
		title: sevkMiktar + ' ' + kisaBirim + ' sevk için irsaliye girişi tablosuna kayıt edilecek.',
		type: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#DD6B55',
		confirmButtonText: 'evet',
		cancelButtonText: 'hayır'
	  }).then(function(result) {
		// handle Confirm button click
		// result is an optional parameter, needed for modals with input




		$.post('/satis/sevk_miktar_kaydet.asp',{
			sevkMiktar:sevkMiktar,
			siparisKalemID:siparisKalemID,
			depoID:satisDepoID,
			lot:lot,
			ajandaID:ajandaID,
			sevkcariID:sevkcariID,
			sevkTip:sevkTip,
			stokHareketID:stokHareketID
		},function(){
				$('#listeDIV').load('/satis/musteri_sevk_hazir.asp #listeDIV > *',{satisDepoID:satisDepoID})
			})


	  }).catch(function(dismiss) {
		// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
	  });
    
};
</script>






