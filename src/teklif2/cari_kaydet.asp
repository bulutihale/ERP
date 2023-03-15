
<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()

'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr 				= 	Split(kidarr,"#")
		musteriID			=	kidarr(0)
		mtimeout			=	kidarr(1)
		kad					=	kidarr(2)
		sayfaKayitSayisi	=	int(kidarr(3))
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr


	'##### request
	'##### request
		kid						=	kidbul()
		ihaleID					=	Request.Form("ihaleID")
		modulID					=	ihaleID
		carilerID				=	Request.Form("deger")
		ihaleUrunID				=	Request.Form("ihaleUrunID")
		kayitTip				=	Request.Form("kayitTip")
		ihaleID64				=	ihaleID
		ihaleID64				=	base64_encode_tr(ihaleID64)
	'##### request
	'##### request
	
	hatamesaj = "Kayıt Başlıyor"
	call logla("Dosya","insert",hatamesaj,modulID)

'##### HÜCRE EDIT
'##### HÜCRE EDIT

	'## veritabanı
	
	if kayitTip = "rakipCari" then
	
	for zi = 1 to Request.Form("iuID").Count	'birden fazla kaleme işlenecek rakip cari için checkboxlardan kalem bilgilerini al.
	
		ihaleUrunID = 	Request.Form("iuID")(zi)
		rakipFiyat	=	Request.Form("inputRakipFiyat_"&ihaleUrunID)
		rakipMarka	=	Request.Form("inputRakipMarka_"&ihaleUrunID)
		yerliMali	=	Request.Form("yerliMali_"&ihaleUrunID)

	
		sorgu = "SELECT * FROM fiyatlar WHERE musteriID = " & musteriID & " AND ihaleID = " & ihaleID & " AND ihaleUrunID = " & ihaleUrunID & " AND carilerID = " & carilerID
		rs.open sorgu, sbsv5,1,3
			if rs.recordcount = 0 then
				rs.addnew
				rs("musteriID")		=	musteriID
				rs("ihaleID")		=	ihaleID
				rs("ihaleUrunID")	=	ihaleUrunID
				rs("carilerID")		=	carilerID
				rs("fiyat")			=	rakipFiyat
				rs("marka")			=	rakipMarka
				rs("fiyatPB")		=	"TL"
				if yerliMali = "evet" then
					rs("yerliMali") = 1
				end if

				rs.update
				response.Write "<script>$(document).ready(function() {toastr.options.positionClass = 'toast-bottom-right';toastr.success('Cari Ekleme tamamlandı','İşlem Tamam!');});</script>"
			else
				response.Write "<script>$(document).ready(function() {toastr.options.positionClass = 'toast-bottom-right';toastr.error('Cari zaten kayıtlı','İşlem Yapılmadı!');});</script>"
			end if
		rs.close
	next

'#### rakip firma kaydı yapıldığında ihale tablosunda mukayese "GELDİ" olarak değişsin
	sorgu = "UPDATE ihale SET mukayeseDurum = 'geldi' WHERE id = " & ihaleID & " AND musteriID = " & musteriID
	rs.open sorgu, sbsv5,1,3
'#### rakip firma kaydı yapıldığında ihale tablosunda mukayese "GELDİ" olarak değişsin

			hatamesaj = "Rakip Cari Kaydı Başarılı."
			call logla("Dosya","insert",hatamesaj,modulID)

	elseif kayitTip = "topluAlim" then
	
		sorgu = "SELECT * FROM ihale_urun_talep WHERE musteriID = " & musteriID & " AND ihaleID = " & ihaleID & " AND ihaleUrunID = " & ihaleUrunID & " AND carilerID = " & carilerID
		rs.open sorgu, sbsv5,1,3
			if rs.recordcount = 0 then
				rs.addnew
				rs("musteriID")		=	musteriID
				rs("ihaleID")		=	ihaleID
				rs("ihaleUrunID")	=	ihaleUrunID
				rs("carilerID")		=	carilerID
									
				rs.update
				response.Write "<script>$(document).ready(function() {toastr.options.positionClass = 'toast-bottom-right';toastr.success('Cari Ekleme tamamlandı','İşlem Tamam!');});</script>"
			else
				response.Write "<script>$(document).ready(function() {toastr.options.positionClass = 'toast-bottom-right';toastr.error('Cari zaten kayıtlı','İşlem Yapılmadı!');});</script>"
			end if
		rs.close
			hatamesaj = "Toplu Alım Cari Kaydı Başarılı."
			call logla("Dosya","insert",hatamesaj,modulID)
	end if
		

	'## veritabanı
'##### HÜCRE EDIT
'##### HÜCRE EDIT

%>

<script>
$.get('/dosya/detay/<%=ihaleID64%>', function(data){
											var $data = $(data);
											$('#rakiplerTablo').html($data.find('#rakiplerTablo').html());
//											$('#urunlerTablo').html($data.find('#urunlerTablo').html());
//											$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
											$('#topluAlimTablo').html($data.find('#topluAlimTablo').html());
								});//tablolar güncellendi
</script>





