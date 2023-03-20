<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
    islem			=	Request.QueryString("islem")
	eskiReceteID	=	0
    opener  		=	Request.Form("opener")
    gorevID 		=	Request.QueryString("gorevID")
	gorevID64		=	gorevID
	gorevID			=	base64_decode_tr(gorevID64)
    modulAd =   "Reçete"
    modulID =   "97"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()



yetkiKontrol = yetkibul(modulAd)

if gorevID <> "" then
            sorgu = "SELECT t1.receteAd, t1.ozelRecete, t1.receteTipi, t1.silindi, t2.cariID, t2. cariAd, t3.stokID, t3.stokAd,"
			sorgu = sorgu & " ISNULL(t1.istasyonID,0) as istasyonID, t4.istasyonAd, t5.uzunBirim"
			sorgu = sorgu & " FROM recete.recete t1"
			sorgu = sorgu & " LEFT JOIN cari.cari t2 ON t1.cariID = t2.cariID"
			sorgu = sorgu & " LEFT JOIN stok.stok t3 ON t1.stokID = t3.stokID"
			sorgu = sorgu & " LEFT JOIN isletme.istasyon t4 ON t1.istasyonID = t4.istasyonID"
			sorgu = sorgu & " LEFT JOIN portal.birimler t5 ON t3.anaBirimID = t5.birimID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND receteID = " & gorevID
			rs.open sorgu, sbsv5, 1, 3
                receteAd		=  	rs("receteAd")
				ozelRecete		=	rs("ozelRecete")
				receteTipi		=	rs("receteTipi")
				cariAd			=	rs("cariAd")
				cariID			=	rs("cariID")
				stokID			=	rs("stokID")
				stokAd			=	rs("stokAd")
				istasyonID		=	rs("istasyonID")
				istasyonAd		=	rs("istasyonAd")
				silindi			=	rs("silindi")
				uzunBirim		=	rs("uzunBirim")
				defDeger		=	cariID&"###"&cariAd
				defDeger1		=	stokID&"###"&stokAd
				defDeger2		=	istasyonID&"###"&istasyonAd
            rs.close
			
			chckDurum		=	chckKontrol(ozelRecete,1)
			
end if

			ozelReceteClass	=	" d-none "
			if ozelRecete = 1 then
				ozelReceteClass = ""
			end if
			
			if islem = "kopyala" then
				eskiReceteID	=	gorevID
				receteAd		=	receteAd & " - KOPYA"
				gorevID			=	""
				divAd			=	"Reçete Klonlama"
			else
				divAd			=	"Yeni Reçete Oluşturma"
			end if

call logla(divAd & " Ekranı Girişi")

	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<div class=""row rounded justify-content-between card-header p-0 border-secondary mb-2"">"
			Response.Write "<div class=""h5 p-2"">" & divAd & "</div>"
			Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "</div>"
		Response.Write "<form action=""/recete/recete_ekle.asp"" method=""post"" class=""ajaxform"">"
			call formhidden("receteID",gorevID,"","","","","receteID","")
			call formhidden("islem",islem,"","","","","islem","")
			call formhidden("eskiReceteID",eskiReceteID,"","","","","eskiReceteID","")

		Response.Write "<div class=""row mt-2"">"
			Response.Write "<div class=""col-lg-12"">"
				Response.Write "<div class=""badge badge-secondary rounded-left"">Ürün Seçimi</div>"
				if gorevID = "" then
					call formselectv2("stokSec","","anaBirimKontrol($(this).val(),$(this).attr('id'))","","formSelect2 stokSec border inpReset","","stokSec","","data-holderyazi=""Ürün adı, stok kodu, barkod"" data-jsondosya=""JSON_stoklar"" data-miniput=""3"" data-defdeger="""&defDeger1&"""")
				else
					call formhidden("stokSec",stokID,"","","","","stokSec","")
					call forminput("stokAd",stokAd,"","","","autocompleteOFF","stokAd","disabled")
				end if
			Response.Write "</div>"
		Response.Write "</div>"
			
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Reçete Ad</span>"
				call forminput("receteAd",receteAd,"","","","autocompleteOFF","receteAd","")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">İşlem İstasyonu</span>"
				call formselectv2("istasyonSec",cint(istasyonID),"","","formSelect2 istasyonID border","","istasyonSec","","data-holderyazi=""İşlem İstasyonu"" data-jsondosya=""JSON_istasyon"" data-miniput=""0"" data-defdeger="""&defDeger2&"""")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-3 col-sm-4 text-center my-1"">"
				Response.Write "<div class=""badge badge-secondary rounded"">Ana Birim</div><span class=""pointer text-info"" onclick=""swal('','Ürünün stok kartında tanımlanır ve ürün hareket gördükten sonra değiştirilemez!')""><i class=""mdi mdi-information""></i></span>"
				Response.Write "<div class=""mt-2 bold text-danger"">" & uzunBirim & "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
				
		Response.Write "<div class=""bg-warning rounded mt-2"">"
			Response.Write "<div class=""row"">"	
				Response.Write "<div class=""col-lg-3 my-1 rounded"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Müşteriye Özel Reçete</div>"
					Response.Write "<div class=""text-left"">"
						Response.Write "<input type=""checkbox"" name=""ozelRecete"" value=""1"" class=""chck30 form-control"" " & chckDurum & " onclick=""$('#divCariSecim').toggleClass('d-none');"">"
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "<div id=""divCariSecim"" class=""col-lg-9" & ozelReceteClass & " my-1"">"
					Response.Write "<div class=""badge badge-secondary rounded-left"">Cari Seçimi</div>"
						call formselectv2("cariID","","","","formSelect2 cariID pb-2","","cariID","","data-holderyazi=""Cari adı, cari kodu, vergi no"" data-jsondosya=""JSON_cariler"" data-miniput=""3"" data-defdeger="""&defDeger&"""")
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""form-row align-items-center"">"
			Response.Write "<div class=""col-sm-3 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Ürün Tipi</span>"
				call formselectv2("receteTipi",int(receteTipi),"","","receteTipi","","receteTipi",stokTipDegerler,"")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-3 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Kullanım Dışı</span>"
				call formselectv2("silindi",silindi,"","","silindi","","silindi",HEDegerler,"")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""form-row align-items-center"">"
			Response.Write "<div class=""col-auto mt-4""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if






%><!--#include virtual="/reg/rs.asp" -->

<script>
	$(document).ready(function() {
		$('#cariID, #stokSec, #istasyonSec').trigger('mouseenter');
	});
	 
</script>
