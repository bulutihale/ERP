<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    ID			=	Request.QueryString("ID")
    kid64		=	ID
    opener  	=	Request.Form("opener")
    gorevID 	=	Request.QueryString("gorevID")
	gorevID64	=	gorevID
	gorevID		=	base64_decode_tr(gorevID64)
	modulAd 	=   "Depo"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Yeni Depo Ekleme Ekranı Girişi")

yetkiKontrol = yetkibul(modulAd)

inpDurum	=	""
if gorevID <> "" then
            sorgu = "SELECT t1.silindi, t1.depoKod, t1.depoAd, t1.depoEksiBakiye, t1.depoTuru, t1.ozelDepo, t1.depoKategori, t1.malKabulizin, t1.surecSonuDepoID,"
			sorgu = sorgu & " t1.redGirisizin, t2.cariAd, t1.cariID, t3.id as sonDepoID, t3.depoAd as sonDepoAd"
			sorgu = sorgu & " FROM stok.depo t1"
			sorgu = sorgu & " LEFT JOIN cari.cari t2 ON t1.cariID = t2.cariID"
			sorgu = sorgu & " LEFT JOIN stok.depo t3 ON t1.surecSonuDepoID = t3.id"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.id = " & gorevID
			rs.open sorgu, sbsv5, 1, 3
                depoKod				=  	rs("depoKod")
                depoAd				=  	rs("depoAd")
				depoEksiBakiye		=	rs("depoEksiBakiye")
				depoTuru			=	rs("depoTuru")
				surecSonuDepoID		=	rs("surecSonuDepoID")
				ozelDepo			=	rs("ozelDepo")
				depoKategori		=	rs("depoKategori")
				malKabulizin		=	rs("malKabulizin")
				redGirisizin		=	rs("redGirisizin")
				cariAd				=	rs("cariAd")
				cariID				=	rs("cariID")
				silindi				=	rs("silindi")
				sonDepoID			=	rs("sonDepoID")
				sonDepoAd			=	rs("sonDepoAd")
				defDeger			=	cariID&"###"&cariAd
				defDeger2			=	sonDepoID&"###"&sonDepoAd
            rs.close
			
			
			inpDurum		=	"readonly"
			chckDurum		=	chckKontrol(ozelDepo,1)
end if

			ozelDepoClass	=	" d-none "
			if ozelDepo = 1 then
				ozelDepoClass = ""
			end if			


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<div class=""text-right""><span onclick=""modalkapat()"" class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<form action=""/depo/depo_ekle.asp"" method=""post"" class=""ajaxform"">"
			call formhidden("depoID",gorevID,"","","","autocompleteOFF","depoID","")
			'call formhidden("cariID",cariID,"","","","autocompleteOFF","cariID","")
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Depo Kodu</span>"
				call forminput("depoKod",depoKod,"","","","autocompleteOFF","depoKod",inpDurum)
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row"">"	
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Depo Ad</span>"
				call forminput("depoAd",depoAd,"","","","autocompleteOFF","depoAd",inpDurum)
			Response.Write "</div>"
		Response.Write "</div>"
		
		Response.Write "<div class=""bg-warning rounded"">"
			Response.Write "<div class=""row py-2"">"	
				Response.Write "<div class=""text-left col-lg-2"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Müşteriye Özel Depo</div>"
					Response.Write "<input type=""checkbox"" name=""ozelDepo"" value=""1"" class=""chck30 form-control"" " & chckDurum & " onclick=""$('#divCariSecim').toggleClass('d-none');"">"
				Response.Write "</div>"
				Response.Write "<div id=""divCariSecim"" class=""col-lg-10" & ozelDepoClass & """>"
				'if ozelDepo = 1 then
					Response.Write "<div class=""badge badge-secondary rounded-left"">Cari Seçimi</div>"
						call formselectv2("cariID","","","","formSelect2 cariID pb-2","","cariID","","data-holderyazi=""Cari adı, cari kodu, vergi no"" data-jsondosya=""JSON_cariler"" data-miniput=""3"" data-defdeger="""&defDeger&"""")
					Response.Write "</div>"
				'end if
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		
		Response.Write "<div class=""form-row align-items-center"">"
			Response.Write "<div class=""col-sm-3 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Mal Kabul İzni Var</span>"
				call formselectv2("malKabulizin",malKabulizin,"","","malKabulizin","","malKabulizin",HEDegerler,"")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-3 my-1"">"
				Response.Write "<span class=""badge badge-danger rounded-left"">Red Ürün Giriş İzni Var</span>"
				call formselectv2("redGirisizin",redGirisizin,"","","redGirisizin","","redGirisizin",HEDegerler,"")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""form-row align-items-center"">"
			Response.Write "<div class=""col-sm-3 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Eksi Bakiye İzni Var</span>"
				call formselectv2("depoEksiBakiye",cint(depoEksiBakiye),"","","depoEksiBakiye","","depoEksiBakiye",HEDegerler,"")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-3 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Kategori</span>"
				call formselectv2("depoTuru",depoTuru,"","","depoTuru","","depoTuru",depoTipDegerler,"")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-3 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Depo Türü</span>"
				call formselectv2("depoKategori",depoKategori,"","","depoKategori","","depoKategori",depoKategoriDegerler,"")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-3 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Kullanım Dışı</span>"
				call formselectv2("silindi",int(silindi),"","","silindi","","silindi",HEDegerler,"")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div id=""surecSonuRow"" class=""form-row align-items-center"">"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Süreç Sonu Giriş depo seçimi</span>"
				call formselectv2("surecSonuDepoSec",cint(surecSonuDepoID),"","","formSelect2 surecSonuDepoSec border","","surecSonuDepoSec","","data-holderyazi=""Süreç Sonu Giriş depo seçimi"" data-jsondosya=""JSON_depolar"" data-miniput=""0"" data-defdeger="""&defDeger2&"""")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""form-row align-items-center"">"
			Response.Write "<div class=""col-auto mt-4""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%><!--#include virtual="/reg/rs.asp" -->


<script>
	$(document).ready(function() {
		$('#cariID, #surecSonuDepoSec').trigger('mouseenter');
	});
	 
</script>


