<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    receteAdimID64	=   Request.QueryString("receteAdimID")
	receteAdimID	=	receteAdimID64
	receteAdimID	=	base64_decode_tr(receteAdimID)
    ajandaID64		=   Request.QueryString("ajandaID")
	ajandaID		=	ajandaID64
	ajandaID		=	base64_decode_tr(ajandaID)
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


yetkiKontrol = yetkibul(modulAd)


	if stokID <> "" then
		sorgu = "SELECT t1.stokKodu, t1.stokAd FROM stok.stok t1 WHERE stokID = " & stokID
		rs.open sorgu, sbsv5, 1, 3
			stokKodu	=	rs("stokKodu")
			stokAd		=	rs("stokAd")
			defDeger	=	stokID & "###" & stokAd
		rs.close
	end if

	

	if yetkiKontrol > 2 then

		Response.Write "<div class=""card"">"
			Response.Write "<div class=""card-header text-white bg-info"">Depolar Arası Transfer</div>"
			Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-10"">"
						Response.Write "<div class=""badge badge-secondary rounded-left"">Stok</div>"
						call formselectv2("stokID","","transModalAc()","","formSelect2 stokID border","","stokID","","data-holderyazi=""Stok Adı"" data-jsondosya=""JSON_stoklar"" data-miniput=""3"" data-defdeger="""&defDeger&"""")
					Response.Write "</div>"
					Response.Write "<div class=""col-2"">"
						Response.Write "<button class=""btn btn-success mt-4"" onclick=""transModalAc()"">Transfer</button>"
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"

		Response.Write "</div>"
	else
		call yetkisizGiris("","","")
	end if

%><!--#include virtual="/reg/rs.asp" -->


	<script>
		function transModalAc(){
			var stokID	=	$('#stokID').val();
			if(stokID == null){swal('','Ürün seçimi yapınız'); return false};
			modalajax('/depo/depo_transfer.asp?stokID='+stokID)
		}
	</script>