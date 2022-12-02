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
            sorgu = "SELECT t1.stokHareketID, t1.girisTarih, t1.belgeNo, t1.miktar, t1.miktarBirim, t1.lot, t1.lotSKT, t2.stokKodu, t2.stokAd"
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
				else
					hata = 1
				end if
            rs.close
			

		if hata = "" then
'		'############ son atananLOT belirle sadece 4 id ye sahip mal kabul depoya olan girişlere göre hesap yapıldı
'			sorgu = "SELECT TOP(1) lot FROM stok.stokHareket t1"
'			sorgu = sorgu & " INNER JOIN stok.depo t2 ON t1.depoID = t2.id AND t2.silindi = 0"
'			sorgu = sorgu & " WHERE t2.id = 4 AND t1.stokHareketTuru = 'G' AND t1.stokHareketTipi = 'T' AND t1.silindi = 0"
'			sorgu = sorgu & " ORDER BY t1.stokHareketID DESC"
'			rs.open sorgu, sbsv5, 1, 3
'
'
'			bugunTarihT		=	tarihjp(date())
'			bugunTarihT		=	replace(bugunTarihT,"-","")
'				if rs.recordcount > 0 then
'					sonGirisLot		=	rs("lot")
'
'					lotArr			=	split(sonGirisLot,"-")
'					lotBolum0		=	lotArr(0)
'					lotBolum1		=	lotArr(1)
'					if bugunTarihT = lotBolum0 then
'						lotBolum1	=	cint(lotBolum1) + 1
'						if lotBolum1 < 10 then
'							lotBolum1	=	"0"&lotBolum1
'						end if
'						atananLot	=	bugunTarihT & "-" & lotBolum1
'					else
'						atananLot	=	bugunTarihT & "-01"
'					end if
'				else
'					atananLot	=	bugunTarihT & "-01"
'				end if
'			rs.close
'		'############ /son atananLOT belirle sadece 4 id ye sahip mal kabul depoya olan girişlere göre hesap yapıldı
		end if
end if


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<form action=""/kaliteKontrol/urun_gir.asp"" method=""post"" class=""ajaxform"">"
				call formhidden("stokHareketID",stokHareketID,"","","","","stokHareketID","")
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
				Response.Write "<span class=""badge badge-success rounded-left"">Atanan LOT</span>"
				call forminput("atananLot",atananLot,"","Atanan LOT","","autocompleteOFF","atananLot","readonly")
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
			Response.Write "<div class=""col-12 my-1""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%>
<!--#include virtual="/reg/rs.asp" -->



<script>
	$(document).ready(function() {
		$('#girisDepoID').on('change', function(){
			var depoID	=	$('#girisDepoID').val();
			$.ajax({
				url:"/depo/lotolustur.asp",
				type:'post',
				data: {depoID: depoID},
				success:function(result){
					$('#atananLot').val(result);
				}
			});
		});
   });
   
</script>





