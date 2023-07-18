<!--#include virtual="/reg/rs.asp" --><%

Response.Flush()

id64 = Request.QueryString("id")

			kid						=	kidbul()
			id						=	id64
			ihaleID					=	base64_decode_tr(id)


'###### yetki bul
    modulAd		=   "Teklif"
	yetkiKontrol = 	yetkibul(modulAd)
'###### yetki bul

if yetkiKontrol  >= 3 then


	sorgu = "SELECT t1.ad as teklifAd, t1.cariID, t2.cariAd"
	sorgu = sorgu & " FROM teklifv2.ihale t1"
	sorgu = sorgu & " INNER JOIN cari.cari t2 ON t1.cariID = t2.cariID"
	sorgu = sorgu & " WHERE t1.id = " &ihaleID
	rs.open sorgu,sbsv5,1,3

		teklifAd		=	rs("teklifAd")
		eskicariID		=	rs("cariID")
		cariAd			=	rs("cariAd")

	rs.close

Response.Write "<div class=""container-fluid"">"
Response.Write "<div class=""bold mb-4""><i class=""fa fa-align-justify""></i> Dosya Klonlama</div>"

Response.Write "<div class=""mb-2 ml-2""><b>" & cariAd & "</b> için oluşturulmuş <b>""" & teklifAd & """</b> teklifi kopyalanacak.</div>"
			'##### DOSYA NO OLUŞTUR
			'##### DOSYA NO OLUŞTUR
				dosyaNo		=	dosyaNoOlustur()
			'##### /DOSYA NO OLUŞTUR
			'##### /DOSYA NO OLUŞTUR
Response.Write "<div class=""mb-4 ml-2"">Yeni Dosya Numarası <b>""" & dosyaNo & """</b> olacak.</div>"

Response.Write "<div class=""col-lg-12 mb10"">"

			call formhidden("ihaleID",ihaleID,"","","","","ihaleID","")
			call formhidden("eskicariID",eskicariID,"","","","","eskicariID","")
			call formhidden("dosyaNo",dosyaNo,"","","","","dosyaNo","")


	Response.Write "<div class=""badge badge-secondary rounded-left"">Cari Seçimi</div><span class=""fontkucuk2 text-danger"">** Teklif farklı bir cari için kayıt edilecekse seçilir.</span>"
		call formselectv2("yeniCariID","","","","formSelect2 yeniCariID pb-2","","yeniCariID","","data-holderyazi=""Cari adı, cari kodu, vergi no"" data-jsondosya=""JSON_cariler"" data-miniput=""3""")

		Response.Write "<div class=""mt-2 btn btn-info form-control"" onclick=""teklifKlonla()"">KLONLA</div>"
	Response.Write "</div>"


Response.Write "</div>"
Response.Write "</div>"


	else
		call yetkisizGiris("","","")
	end if

%>

<script>

	function teklifKlonla() {
		
		var yeniCariID	=	$('#yeniCariID').val();
		var ihaleID		=	$('#ihaleID').val();
		var eskicariID	=	$('#eskicariID').val();
		var dosyaNo		=	$('#dosyaNo').val();

		$.post('/teklif2/teklif_klon_ekle.asp', {yeniCariID:yeniCariID, ihaleID:ihaleID, eskicariID:eskicariID, dosyaNo:dosyaNo}, function(){
			toastr.options.positionClass = 'toast-bottom-right';
			toastr.options.progressBar = true;
			toastr.success('Teklif klonlandı.','İşlem Yapıldı!');
			//$('#DIV1').load('/depo/urun_talep_base.asp #DIV1 > *')
			//$('#bekleyenTalep').load('/depo/urun_talep_base.asp #bekleyenTalep > *', {stokID:stokID})

			location.reload();
		});
	}


	 
</script>
