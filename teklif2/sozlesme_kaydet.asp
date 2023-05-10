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
		modulID					= 	ihaleID
		tarih_karar				=	Request.Form("tarih_karar")
		tarih_sozlesme_teblig	=	Request.Form("tarih_sozlesme_teblig")
		tarih_sozlesme			=	Request.Form("tarih_sozlesme")
		tarih_sozlesme_bitis	=	Request.Form("tarih_sozlesme_bitis")
		tarih_teslimat_bitis	=	Request.Form("tarih_teslimat_bitis")
		tekSozlesme				=	Request.Form("tekSozlesme")
		ihaleID64				=	ihaleID
		ihaleID64				=	base64_encode_tr(ihaleID64)

	if tarih_karar = "" then
		tarih_karar = null
	end if
	if tarih_sozlesme_teblig = "" then
		tarih_sozlesme_teblig = null
	end if
	if tarih_sozlesme = "" then
		tarih_sozlesme 			= null
		tarih_sozlesme_bitis	= null
		tarih_teslimat_bitis	= null
	end if
	if tarih_sozlesme_bitis = "" then
		tarih_sozlesme_bitis = null
	end if
	if tarih_teslimat_bitis = "" then
		tarih_teslimat_bitis = null
	end if
	
	
	'##### request
	'##### request

	hatamesaj = "Kayıt Başlıyor"
	call logla("Dosya","insert",hatamesaj,modulID)


	'##### doğrulama
	'##### doğrulama
'	if miktar = "" OR birim = "" then
'		hatamesaj = "Ürün Miktarı ve Birim alanları doldurulmalıdır. "
'		call logla("Dosya","error",hatamesaj,modulID)
'		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
'		Response.End()
'	end if

	'##### doğrulama
	'##### doğrulama



'##### DOSYA KAYDET
'##### DOSYA KAYDET

	'## veritabanı
		sorgu = "SELECT * FROM sozlesmeler WHERE musteriID = " & musteriID & " AND ihaleID = " & ihaleID
		rs.open sorgu, sbsv5,1,3
		
		mevcutSozlesmeSayisi	=	rs.recordcount
		kacinciSozlesme			=	mevcutSozlesmeSayisi + 1
		
		rs.addnew
				rs("musteriID")				=	musteriID
				rs("ihaleID")				=	ihaleID
				rs("tarih_karar")			=	tarih_karar
				rs("kacinciSozlesme")		=	kacinciSozlesme
				rs("tarih_sozlesme_teblig")	=	tarih_sozlesme_teblig
				rs("tarih_sozlesme")		=	tarih_sozlesme
				rs("tarih_sozlesme_bitis")	=	tarih_sozlesme_bitis
				rs("tarih_teslimat_bitis")	=	tarih_teslimat_bitis
			rs.update
			sozlesmelerID = rs("id")
		rs.close
		
'###### SÖZLEŞME İMZALANMIŞ İSE MUHASEBEYE GEÇİCİ TEMİŞNAT İADE UYARI EPOSTA GİTSİN
'###### SÖZLEŞME İMZALANMIŞ İSE MUHASEBEYE GEÇİCİ TEMİŞNAT İADE UYARI EPOSTA GİTSİN
	if  isdate(tarih_sozlesme) then
		call geciciIadeMail(sozlesmelerID)
	end if
'###### /SÖZLEŞME İMZALANMIŞ İSE MUHASEBEYE GEÇİCİ TEMİŞNAT İADE UYARI EPOSTA GİTSİN
'###### /SÖZLEŞME İMZALANMIŞ İSE MUHASEBEYE GEÇİCİ TEMİŞNAT İADE UYARI EPOSTA GİTSİN


'###### TEK SÖZLEŞME TARİHİ TÜM ÜRÜNLERE
'###### TEK SÖZLEŞME TARİHİ TÜM ÜRÜNLERE

	if tekSozlesme = "evet" then
		sorgu = "SELECT * FROM ihale_urun WHERE musteriID = " & musteriID & " AND ihaleID = " & ihaleID & " order by id DESC"
		rs.open sorgu, sbsv5,1,3

		for i = 1 to rs.recordcount
			rs("sozlesmelerID") = sozlesmelerID
			rs.update
		rs.movenext
		next
		rs.close
	end if
'###### / TEK SÖZLEŞME TARİHİ TÜM ÜRÜNLERE
'###### / TEK SÖZLEŞME TARİHİ TÜM ÜRÜNLERE



			hatamesaj = "Kayıt Başarılı."
			call logla("Dosya","insert",hatamesaj,modulID)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		
	'## veritabanı
'##### /DOSYA KAYDET
'##### /DOSYA KAYDET

'call jsrunajax("$(':input').val('');$(':input').prop('checked',false);$('#select2-1').val(null).trigger('change');$('#select2-2').val(null).trigger('change');$('#select2-3').val(null).trigger('change');")

%>
<script>
$.get('/dosya/detay/<%=ihaleID64%>', function(data){
											var $data = $(data);
//											$('#rakiplerTablo').html($data.find('#rakiplerTablo').html());
//											$('#urunlerTablo').html($data.find('#urunlerTablo').html());
											$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
											$('#sozlesmeInput').html($data.find('#sozlesmeInput').html());
//											$('#topluAlimTablo').html($data.find('#topluAlimTablo').html());
								});//tablolar güncellendi
</script>
