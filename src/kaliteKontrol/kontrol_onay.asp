<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    ID			=	Request.QueryString("ID")
    kid64		=	ID
    opener  	=   Request.Form("opener")
    gorevID 	=   Request.QueryString("gorevID")
	gorevID64	=	gorevID
	gorevID		=	base64_decode_tr(gorevID64)
	modulAd 	=   "Kalite Kontrol"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Stok girişi kalite kontrol onayı")

yetkiKontrol = yetkibul(modulAd)
		Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"

if gorevID <> "" then
            sorgu = "SELECT t1.stokHareketID, t1.girisTarih, t1.belgeNo, t1.miktar, t1.miktarBirim, t1.lot, t1.lotSKT, t2.stokKodu, t2.stokAd, t2.lotTakip"
			sorgu = sorgu & " FROM stok.stokHareket t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.stokHareketID = " & gorevID & " AND t1.silindi = 0"
			rs.open sorgu, sbsv5, 1, 3
				if rs.recordcount > 0 then
					stokHareketID	=	rs("stokHareketID")
					stokKodu		=	rs("stokKodu")
					stokAd			=	rs("stokAd")
					girisTarih		=	rs("girisTarih")
					belgeNo			=	rs("belgeNo")
					miktar			=	rs("miktar")
					miktarBirim		=	rs("miktarBirim")
					gelenLot		=	rs("lot")
					lotSKT			=	rs("lotSKT")
					lotTakip		=	rs("lotTakip")
				else
					hata = 1
				end if
            rs.close
			

end if


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<form action=""/kaliteKontrol/urun_gir.asp"" method=""post"" class=""ajaxform"">"
				call formhidden("stokHareketID",stokHareketID,"","","","","stokHareketID","")
				call formhidden("lotTakip",lotTakip,"","","","","lotTakip","")
		Response.Write "<div class=""form-row align-items-left"">"
			Response.Write "<div class=""col-lg-3 col-sm-6 col-xs-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Giriş Tarihi</span>"
				call forminput("girisTarih",girisTarih,"","","","","girisTarih","disabled")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-9 col-sm-6 col-xs-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Belge No</span>"
				call forminput("belgeNo",belgeNo,"","","","","belgeNo","disabled")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""form-row align-items-left"">"
			Response.Write "<div class=""col-lg-3 col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Stok Kodu</span>"
				call forminput("stokKodu",stokKodu,"","","","","stokKodu","disabled")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-9 col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Stok Ad</span>"
				call forminput("stokAd",stokAd,"","","","","stokAd","disabled")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""form-row align-items-left"">"
			Response.Write "<div class=""col-lg-3 col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Gelen Miktar</span>"
				call forminput("miktar", miktar & " " & miktarBirim,"$('#onayMiktar').val("&miktar&")","","pointer","","miktar","readonly")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-3 col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Gelen LOT</span>"
				call forminput("gelenLot",gelenLot,"","","","","gelenLot","disabled")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-3 col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">SKT</span>"
				call forminput("lotSKT",lotSKT,"","","","","lotSKT","disabled")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""form-row align-items-left"">"
			Response.Write "<div class=""w-100""></div>"
			Response.Write "<div class=""col-lg-3 col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-success rounded-left"">Onaylanan Miktar</span>"
				call forminput("onayMiktar","","numara(this,true,false)","Onay Miktar","","autocompleteOFF","onayMiktar","")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-6 col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-success rounded-left"">Giriş Depo</span>"
				call formselectv2("girisDepoID","","","","formSelect2 depoSec border","","girisDepoID","","data-holderyazi=""Giriş depo seçimi"" data-jsondosya=""JSON_depolar"" data-miniput=""0"" data-sart=""('malKabul','iade')""")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-3 col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-success rounded-left"">Atanan LOT</span> <span class=""icon brick-edit ml-3 pointer"" id=""lotGetir"" title=""LOT hesapla""></span> "
				call forminput("atananLot",atananLot,"karakterFiltre(this.id)","Atanan LOT","","autocompleteOFF","atananLot","")
			Response.Write "</div>"
			Response.Write "<div class=""w-100""></div>"
			Response.Write "<div class=""col-lg-3 col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-danger rounded-left"">Red Miktar</span>"
				call forminput("redMiktar","","numara(this,true,false)","Red Miktar","","autocompleteOFF","redMiktar","")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-6 col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-danger rounded-left"">Red Ürün Depo</span>"
				call formselectv2("redDepoID","","","","formSelect2 depoSec border","","redDepoID","","data-holderyazi=""Red depo seçimi"" data-jsondosya=""JSON_depolar"" data-miniput=""0"" data-sart=""redGirisizin""")
			Response.Write "</div>"
			Response.Write "<div id=""btnDIV"" class=""col-12 my-1"">"
				Response.Write "<button id=""btn11"" type=""submit"" onclick=""formSubmitKontrol($(this).attr('id'))"" class=""btn btn-primary"">KAYDET</button>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%>
<!--#include virtual="/reg/rs.asp" -->



<script>
	$(document).ready(function() {
		$('#lotGetir').on('click', function(){
			var depoID		=	$('#girisDepoID').val();
			var lotTakip	=	$('#lotTakip').val();
			if(lotTakip == 1){
			$.ajax({
				url:"/depo/lotolustur.asp",
				type:'post',
				data: {depoID: depoID},
				success:function(result){
					$('#atananLot').val(result);
				}
			});
			}else{
					$('#atananLot').val('lotTakibiYok');
				}
		});
   });
   
</script>





