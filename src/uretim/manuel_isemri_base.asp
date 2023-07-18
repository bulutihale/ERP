<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
	stokID			=	Request("stokID")
	listeTur		=	Request("listeTur")
	modulAd			=   "Depo"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

Response.Flush()

yetkiKontrol = yetkibul(modulAd)


	if stokID <> "" then
		sorgu = "SELECT t1.stokKodu, t1.stokAd, stok.FN_anaBirimADBul(t1.stokID,'uAd') as anaBirimAD FROM stok.stok t1 WHERE stokID = " & stokID
		rs.open sorgu, sbsv5, 1, 3
			anaBirimAD	=	rs("anaBirimAD")
			stokKodu	=	rs("stokKodu")
			stokAd		=	rs("stokAd")
			defDeger	=	stokID & "###" & stokAd
		rs.close
	end if

	if listeTur = "kesimPlan" then
		baslik	=	"Kesim İş Emri Tanımlama"
	end if

	if yetkiKontrol > 2 then

	Response.Write "<div id=""ustDIV"" class=""row"">"
		Response.Write "<div id=""DIV1"" class=""col-6"">"
			Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-secondary"">" & baslik & "</div>"
				Response.Write "<div class=""card-body"">"
				 call formhidden("listeTur",listeTur,"","","","","listeTur","")
					Response.Write "<div class=""row mt-2"">"
						Response.Write "<div class=""col-12"">"
							Response.Write "<div class=""badge badge-secondary rounded-left"">Stok</div>"
							call formselectv2("stokID","","","","formSelect2 stokID border","","stokID","","data-holderyazi=""Stok Adı"" data-jsondosya=""JSON_stoklar"" data-miniput=""3"" data-defdeger="""&defDeger&""" onchange=""urunDegistir()""")
						Response.Write "</div>"
					Response.Write "</div>"

					Response.Write "<div id=""birimDIV"">"
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-12"">"
								Response.Write "<div class=""badge badge-secondary rounded"">Reçete</div>"
								call formselectv2("receteID","","","","formSelect2 receteID border","","receteID","","data-holderyazi=""Reçete"" data-jsondosya=""JSON_recete"" data-miniput=""0"" data-sartozel=""(stokID="& stokID & ")"" onchange=""$('#anaDIV').load('/satis/recete_maliyet.asp #anaDIV >*',{siparisKalemID:"&siparisKalemID&",stokID:"&anastokID&",cariID:"&cariID&",receteID:$(this).val()})""")
							Response.Write "</div>"
						Response.Write "</div>"

						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-lg-12"">"
								Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Açıklama</div>"
								Response.Write "<input style="""" class=""form-control bold"" name=""talepAciklama"" id=""talepAciklama"" autocomplete=""off"">"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-12"">"
								Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Miktar</div>"
									Response.Write "<input style=""font-size:26px;"" class=""form-control bold"" name=""talepMiktar"" id=""talepMiktar"" autocomplete=""off"">"
								Response.Write "<div class=""badge badge-secondary rounded-left mt-2"">Birim</div>"
									Response.Write "<div class=""ml-5""><span style=""font-size:26px;"" class=""bold"">" & anaBirimAD & "</span> (sipariş, ANA BİRİM cinsinden yazılmak zorundadır.)</div>"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-12"">"
							Response.Write "<button onclick=""talepGonder()"" class=""btn btn-success"" >Kaydet</button>"
								call clearfix()
							Response.Write "</div>"
						Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div id=""bekleyenIsemri"" class=""col-6 scroll-ekle3"">"
			Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-warning sticky-top"">Planlanmış İş Emirleri</div>"
				Response.Write "<div class=""card-body"">"
					if stokID <> "" then

					sorgu = "SELECT"
					sorgu = sorgu & " DATEFROMPARTS(t1.hangiYil, t1.hangiAy, t1.hangiGun) as planTarih, t2.stokID, t2.stokKodu, t2.stokAd, t1.icerik,"
					sorgu = sorgu & " t1.id as ajandaID, t1.miktar"
					sorgu = sorgu & " FROM portal.ajanda t1"
					sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
					sorgu = sorgu & " WHERE t1.firmaID = " & firmaID
					sorgu = sorgu & " AND t1.isTur = '" & listeTur & "'" 
					sorgu = sorgu & " AND t2.stokID = " & stokID & ""
					sorgu = sorgu & " AND t1.silindi = 0 AND t1.tamamlandi = 0"
					sorgu = sorgu & " ORDER BY DATEFROMPARTS(t1.hangiYil, t1.hangiAy, t1.hangiGun) DESC"
					rs.open sorgu, sbsv5, 1, 3

					if rs.recordcount > 0 then
						Response.Write "<div class=""bold"">" & rs("stokkodu") & " " & rs("stokAd") & "</div>"
						Response.Write "<table class=""table table-sm mt-2 table-striped"">"
							Response.Write "<thead><tr class=""text-center"">"
								Response.Write "<th>Talep Tarihi</th>"
								Response.Write "<th>Talep Açıklama</th>"
								Response.Write "<th>Talep Miktar</th>"
							Response.Write "</tr></thead>"
						for zi = 1 to rs.recordcount
							Response.Write "<tr style=""height:75px"">"
								Response.Write "<td>" & tarihtr(rs("planTarih")) & "</td>"
								Response.Write "<td class=""text-left"">" & rs("icerik") & "</td>"
								Response.Write "<td class=""text-right"">" & rs("miktar") & "</td>"
							Response.Write "</tr>"
						rs.movenext
						next
						Response.Write "</table>"
					else
						Response.Write "<div class=""bold"">Bu ürün için bekleyen manuel talep yok.</div>"
					end if
					rs.close
					end if
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
	Response.Write "</div>"
	else
		call yetkisizGiris("","","")
	end if

%><!--#include virtual="/reg/rs.asp" -->


<script>
	$(document).ready(function() {
		$('#stokID').trigger('mouseenter');
	
	});	

function urunDegistir(){
		var stokID			=	$('#stokID').val();
		var listeTur		=	$('#listeTur').val();
		$('#birimDIV').load('/uretim/manuel_isemri_base.asp #birimDIV > *', {stokID:stokID, listeTur:listeTur})
		$('#bekleyenIsemri').load('/uretim/manuel_isemri_base.asp #bekleyenIsemri > *', {stokID:stokID, listeTur:listeTur})
	}


	function talepGonder(){
		var stokID			=	$('#stokID').val();
		var talepMiktar		=	$('#talepMiktar').val();
		var talepAciklama	=	$('#talepAciklama').val();
		var listeTur		=	$('#listeTur').val();
		var receteID		=	$('#receteID').val();

		$.post('/uretim/manuel_isemri_ekle.asp', {stokID:stokID, talepMiktar:talepMiktar, talepAciklama:talepAciklama, listeTur:listeTur, receteID:receteID}, function(){
			toastr.options.positionClass = 'toast-bottom-right';
			toastr.options.progressBar = true;
			toastr.success('Ürün kayıt edildi.','İşlem Yapıldı!');
			$('#DIV1').load('/uretim/manuel_isemri_base.asp #DIV1 > *')
			$('#bekleyenIsemri').load('/uretim/manuel_isemri_base.asp #bekleyenIsemri > *', {stokID:stokID})

//			location.reload();
		});
		}
</script>