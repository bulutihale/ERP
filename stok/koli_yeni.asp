<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    ID			=	Request.QueryString("ID")
    kid64		=	ID
    opener  	=   Request.Form("opener")
    gorevID 	=   Request.QueryString("gorevID")
    koliID64 	=   Request.QueryString("gorevID")
	koliID		=	base64_decode_tr(koliID64)
	a			=   Request.QueryString("a")
	modulAd 	=   "stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Koli Bilgileri Tanımlama Ekranı Girişi")

yetkiKontrol 	=	yetkibul(modulAd) 


if gorevID <> "" then

            sorgu = "SELECT TOP 1 t1.ad as koliAd, t1.bantMT, t1.silindi, ISNULL(t1.hamKoliStokID,0) as hamKoliStokID, ISNULL(t1.bantStokID,0) as bantStokID,"
			sorgu = sorgu & " t1.hamKoliEn, t1.hamKoliBoy, t1.hamKoliYukseklik,"
			sorgu = sorgu & " ISNULL(t2.stokAd,0) as zhamKoliAd, ISNULL(t3.stokAd,0) as bantStokAd"
			sorgu = sorgu & " FROM stok.koli t1"
			sorgu = sorgu & " LEFT JOIN stok.stok t2 ON t1.hamKoliStokID = t2.stokID"
			sorgu = sorgu & " LEFT JOIN stok.stok t3 ON t1.bantStokID = t3.stokID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.koliID = " & koliID
			rs.open sorgu, sbsv5, 1, 3
				koliAd				=	rs("koliAd")
				bantMT				=	rs("bantMT")
				silindi				=	rs("silindi")
				hamKoliStokID		=	rs("hamKoliStokID")
				zhamKoliAd			=	rs("zhamKoliAd")
				bantStokID			=	rs("bantStokID")
				bantStokAd			=	rs("bantStokAd")
				hamKoliEn			=	rs("hamKoliEn")
				hamKoliBoy			=	rs("hamKoliBoy")
				hamKoliYukseklik	=	rs("hamKoliYukseklik")
            rs.close
				defDeger1			=	hamKoliStokID&"###"&zhamKoliAd
				defDeger2			=	bantStokID&"###"&bantStokAd

end if


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-10 bold h3 text-info "">Koli Ana Kartı</div>"
			Response.Write "<div class=""text-right col-2""><span onclick=""modalkapat()"" class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "</div>"

  Response.Write "<ul class=""nav nav-tabs"" role=""tablist"">"
    Response.Write "<li class=""nav-item"">"
      Response.Write "<a class=""nav-link active"" data-toggle=""tab"" href=""#home"">Ana Kart</a>"
    Response.Write "</li>"
  Response.Write "</ul>"

  Response.Write "<div class=""tab-content"">"
	Response.Write "<div id=""home"" class=""container tab-pane active"">"
  		Response.Write "<form action=""/stok/koli_ekle.asp"" method=""post"" class=""ajaxform"">"

		Response.Write "<div class=""form-row align-items-left"">"
			call formhidden("koliID",koliID,"","","","","koliID","")

			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Koli Ad</span>"
				call forminput("koliAd",koliAd,"","","","","koliAd","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Seçilen Koli</span>"
				call formselectv2("koliSec","","anaBirimKontrol($(this).val(),$(this).attr('id'))","","formSelect2 koliSec border inpReset","","koliSec","","data-holderyazi=""kullanılacak ham koli seçimi"" data-jsondosya=""JSON_stoklar"" data-miniput=""3"" data-defdeger="""&defDeger1&"""")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-4 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">en (cm)</span>"
				call forminput("hamKoliEn",hamKoliEn,"","cm cinsinden","","","hamKoliEn","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-4 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">boy (cm)</span>"
				call forminput("hamKoliBoy",hamKoliBoy,"","cm cinsinden","","","hamKoliBoy","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-4 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">yükseklik (cm)</span>"
				call forminput("hamKoliYukseklik",hamKoliYukseklik,"","cm cinsinden","","","hamKoliYukseklik","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Kullanılan Koli Bandı</span>"
				call formselectv2("bantSec","","anaBirimKontrol($(this).val(),$(this).attr('id'))","","formSelect2 bantSec border inpReset","","bantSec","","data-holderyazi=""kullanılacak bant seçimi"" data-jsondosya=""JSON_stoklar"" data-miniput=""3"" data-defdeger="""&defDeger2&"""")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-4 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Kullanılan Bant Miktarı (metre)</span>"
				call forminput("bantMT",bantMT,"numara(this,true,'yok');","bantMT","","","bantMT","")
			Response.Write "</div>"
		if yetkiKontrol >= 8 then
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Kullanım Dışı</span>"
				call formselectv2("silindi",silindi,"","","silindi","","silindi",HEDegerler,"")
			Response.Write "</div>"
		end if
			Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	Response.Write "</div>"


Response.Write "</div>"

	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%><!--#include virtual="/reg/rs.asp" -->


<script>
	$(document).ready(function() {
		$('#koliSec').trigger('mouseenter');
		$('#bantSec').trigger('mouseenter');
});

</script>

