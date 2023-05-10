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
		tur						=	Request.Form("teminatTurSec")
		bankaNakit				=	Request.Form("bankaNakitSec")
		bankalarID				=	Request.Form("bankasec")
		tarih_teminat			=	Request.Form("tarih_teminat")
		tarih_exp				=	Request.Form("tarih_exp")
		no						=	Request.Form("no")
		tutar					=	Request.Form("tutar")
		teminatPB				=	Request.Form("teminatPB")
		tarih_iade				=	Request.Form("tarih_iade")
		ihaleID64				=	ihaleID
		ihaleID64				=	base64_encode_tr(ihaleID64)
		
	'##### request
	'##### request
	hatamesaj = "Kayıt Başlıyor"
	call logla("Dosya","insert",hatamesaj,modulID)
	
	'##### doğrulama
	'##### doğrulama
		if no = "" then
			no = 0
		end if
		
		if bankaNakit = 1 then
			bankalarID 		= 	0
			nakitTeminat	=	1
		end if
		
		if tarih_exp = "" then
			tarih_exp = null
		end if
		
		if tarih_iade = "" then
			tarih_iade = null
		end if

	if tur = "" then
		hatamesaj = "Teminat türünü seçiniz."
		call logla("Dosya","error",hatamesaj,modulID)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
	
	if bankaNakit = "" then
		hatamesaj = "Banka/Nakit seçimi yapınız."
		call logla("Dosya","error",hatamesaj,modulID)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
	
	if bankaNakit = 0 AND bankalarID = "" then
		hatamesaj = "Banka seçimi yapınız."
		call logla("Dosya","error",hatamesaj,modulID)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
	
	if tarih_teminat = "" then
		hatamesaj = "Teminat tarihi girilmedi."
		call logla("Dosya","error",hatamesaj,modulID)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
	
	if tutar = "" then
		hatamesaj = "Teminat tutarını giriniz."
		call logla("Dosya","error",hatamesaj,modulID)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
	
	'##### doğrulama
	'##### doğrulama


'##### DOSYA KAYDET
'##### DOSYA KAYDET


	'## veritabanı
		sorgu = "SELECT * FROM teminat WHERE musteriID = " & musteriID & " order by id DESC"
		rs.open sorgu, sbsv5,1,3
			rs.addnew
				rs("musteriID")			=	musteriID
				rs("ihaleID")			=	ihaleID
				rs("tur")				=	tur
				rs("bankalarID")		=	bankalarID
				rs("tarih_teminat") 	=	tarih_teminat
				rs("tarih_exp")			=	tarih_exp
				rs("no")				=	no
				rs("tutar") 			=	tutar
				rs("tarih_iade")		=	tarih_iade
				rs("teminatPB")			=	teminatPB
				rs("nakitTeminat")		=	nakitTeminat
				
			rs.update
		rs.close
		
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
											$('#teminatTablo').html($data.find('#teminatTablo').html());
//											$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
//											$('#topluAlimTablo').html($data.find('#topluAlimTablo').html());
								});//tablolar güncellendi
</script>
