<!--#include virtual="/reg/rs.asp" --><%




	'##### request
	'##### request
		kid						=	kidbul()
		ihaleID					=	Request.Form("ihaleID")
		modulID					=	ihaleID
		cariID					=	Request.Form("cariID")
		if cariID = "/" then
			cariID = 0
		end if
		urunsec					=	Request.Form("urunsec")
		refSec					=	Request.Form("refSec")
		grupNo					=	Request.Form("grupNo")
		siraNo					=	Request.Form("siraNo")
		ad						=	Request.Form("urunAd")
		miktar					=	Request.Form("miktar")
		birim					=	Request.Form("birim")
		'firmamMarka			=	Request.Form("markasec")
		firmamFiyat				=	Request.Form("firmamFiyat")
		firmamParaBirim			=	Request.Form("firmamParaBirim")
		firmamYerliMali			=	0
		yerliOran				=	Request.Form("yerliOran")
		yaklasikMaliyet			=	Request.Form("yaklasikMaliyet")
		yaklasikMaliyetPB		=	Request.Form("yaklasikMaliyetPB")
		ihaleID64				=	ihaleID
		ihaleID64				=	base64_encode_tr(ihaleID64)
		
		
		if grupNo = "" then
			grupNo = 0
		end if
		if urunsec = "" then
			urunsec = 0
		end if
		if refSec = "" then
			refSec = 0
		end if
		
		if firmamFiyat = "" then
			firmamFiyat = 0
		end if
		if yerliOran = "" then
			yerliOran = 0
		end if
		if yaklasikMaliyet = "" then
			yaklasikMaliyet = 0
		end if
		if siraNo = "" then
			hatamesaj = "Sıra No alanı doldurulmalıdır. "
			call logla("Dosya","error",hatamesaj,modulID)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
			Response.End()
		else
			siraNo = int(siraNo)
		end if
	'##### request
	'##### request

	call logla("Teklif kalemi kayıt ediliyor")


	'##### doğrulama
	'##### doğrulama
	if miktar = "" OR birim = "" then
		hatamesaj = "Ürün Miktarı ve Birim alanları doldurulmalıdır. "
		call logla("Dosya","error",hatamesaj,modulID)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
'	
'	if cariID = "" or firmaID = "" then
'		hatamesaj = "Lütfen firmanızı ve carinizi seçin"
'		call logla("Dosya","error",hatamesaj,modulID)
'		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
'		Response.End()
'	end if
'	
'	if ikn = "" and tip <> "yaklasik_mal" and tip <> "dog_temin" and tip <> "ozel_hast" and tip <> "bayi" then
'		hatamesaj = "İKN girilmemiş."
'		call logla("Dosya","error",hatamesaj,modulID)
'		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
'		Response.End()
'	end if
'	
'	if ad = "" then
'		hatamesaj = "Dosya Adı girilmemiş."
'		call logla("Dosya","error",hatamesaj,modulID)
'		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
'		Response.End()
'	end if
'	
'	if tarih = "" then
'		hatamesaj = "Tarih girilmemiş."
'		call logla("Dosya","error",hatamesaj,modulID)
'		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
'		Response.End()
'	end if
'	
'	if saat = "" then
'	else
'		if instr(saat,":") = 0 then
'			hatamesaj = "Saat formatınız hatalı. 00:00 şeklinde yazmalısınız."
'			call logla("Dosya","error",hatamesaj,modulID)
'			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
'			Response.End()
'		end if
'	end if
	
	'##### doğrulama
	'##### doğrulama








'##### DOSYA KAYDET
'##### DOSYA KAYDET

	'## veritabanı
		sorgu = "SELECT * FROM teklifv2.ihale_urun"
		rs.open sorgu, sbsv5,1,3
			rs.addnew
				rs("ihaleID")				=	ihaleID
				rs("stoklarID")				=	urunsec
				rs("stokRefID")				=	refSec
				rs("grupNo")				=	grupNo
				rs("siraNo") 				=	siraNo
				rs("ad")					=	ad
				rs("miktar")				=	miktar
				rs("birim") 				=	birim
				rs("yerliOran")				=	yerliOran
				'rs("firmamMarka")			=	firmamMarka
				rs("firmamFiyat")			=	firmamFiyat
				rs("firmamParaBirim")		=	firmamParaBirim
				rs("firmamYerliMali")		=	firmamYerliMali
				rs("yaklasikMaliyet")		=	yaklasikMaliyet
				rs("yaklasikMaliyetPB")		=	yaklasikMaliyetPB
				rs("stoklarListeFiyat")		=	listeFiyat
				rs("stoklarListeFiyatPB")	=	listeBirim
				rs("listeFiyatTarih")		=	listeFiyatTarih
				
			rs.update
				ihaleUrunID 			= 	rs("id")
		rs.close
		
		' sorgu = "SELECT * FROM ihale_urun_talep WHERE musteriID = " & musteriID & " order by id DESC"
		' rs.open sorgu, sbsv5,1,3
		' 	rs.addnew
		' 		rs("musteriID")			=	musteriID
		' 		rs("ihaleID")			=	ihaleID
		' 		rs("carilerID")			=	cariID
		' 		rs("ihaleUrunID")		=	ihaleUrunID
		' 		rs("miktar")			=	miktar
				
		' 	rs.update
		' rs.close
		


%>
<script>
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.options.progressBar = true;
							toastr.success('Ürün kayıt edildi.','İşlem Yapıldı!');
$.get('/teklif2/detay/<%=ihaleID64%>', function(data){
	var $data = $(data);
											$('#urunlerTablo').html($data.find('#urunlerTablo').html());
											$('#urunlerInput').html($data.find('#urunlerInput').html());
											var sonSira = <%=siraNo+1%>
											$('#siraNo').val(sonSira);
								});//tablolar güncellendi
</script>
<%


	'## veritabanı
'##### /DOSYA KAYDET
'##### /DOSYA KAYDET

'call jsrunajax("$(':input').val('');$(':input').prop('checked',false);$('#select2-1').val(null).trigger('change');$('#select2-2').val(null).trigger('change');$('#select2-3').val(null).trigger('change');")
'call jsrunajax("$('#grupNo, #siraNo, #urunAd, #miktar, #birim').val('');$('#urunsec').val(null).trigger('change');")
%>

