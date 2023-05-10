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
		ihaleID64				=	ihaleID
		ihaleID64				=	base64_encode_tr(ihaleID64)
		siparisVeren			=	Request.Form("siparisVeren")
		sipNo					=	Request.Form("sipNo")
		tarih_sip				=	Request.Form("tarih_sip")
		tarih_son_teslim		=	Request.Form("tarih_son_teslim")
		
	'##### request
	'##### request
	hatamesaj = "Kayıt Başlıyor"
	call logla("Dosya","insert",hatamesaj,modulID)
	
	'##### doğrulama
	'##### doğrulama
		
		if tarih_exp = "" then
			tarih_exp = null
		end if
		
		if tarih_iade = "" then
			tarih_iade = null
		end if

	if siparisVeren = "" then
		hatamesaj = "Kurum seçimi yapınız."
		call logla("Dosya","error",hatamesaj,modulID)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
	
	if tarih_sip = "" then
		hatamesaj = "Sipariş tarihi giriniz."
		call logla("Dosya","error",hatamesaj,modulID)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
	
	if tarih_son_teslim = "" then
		hatamesaj = "Son Teslimat tarihi girilmedi."
		call logla("Dosya","error",hatamesaj,modulID)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
	
	
	'##### doğrulama
	'##### doğrulama


'##### DOSYA KAYDET
'##### DOSYA KAYDET

'#### KAÇINCI SİPARİŞ
		sorgu = "SELECT max(kacinciSiparis) as sonSIP FROM siparis WHERE musteriID = " & musteriID & " AND ihaleID = " & ihaleID
		rs.open sorgu, sbsv5,1,3
		if isnull(rs("sonSIP")) then
			kacinciSiparis = 1
		else
			kacinciSiparis	=	int(rs("sonSIP")) + 1
		end if
		rs.close
'#### KAÇINCI SİPARİŞ

	'## veritabanı
		sorgu = "SELECT * FROM siparis"
		rs.open sorgu, sbsv5,1,3
			
			for i=6 to Request.Form.Count
				if Request.Form.item(i) <> "" then
					rs.addnew
					rs("musteriID")			=	musteriID
					rs("ihaleID")			=	ihaleID
					rs("siparisVerenCariID")=	siparisVeren
					rs("sipNo")				=	sipNo
					rs("tarih_sip")			=	tarih_sip
					rs("tarih_son_teslim")	=	tarih_son_teslim
					rs("kacinciSiparis")	=	kacinciSiparis
					rs("kayitYontem")		=	"M"
					
						iutIDarr = split(Request.Form.key(i),"|")
						rs("ihaleUrunTalepID")	= 	iutIDarr(1)
						rs("miktar")			=	Request.Form.item(i)
						miktarKontrol = i
					rs.update
				end if
			next
		rs.close
		
		if miktarKontrol >=6 then 'miktar boş gelmişse başarılı yazmasın.
			hatamesaj = "Kayıt Başarılı."
			call logla("Dosya","insert",hatamesaj,modulID)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		else
			hatamesaj = "Miktar alanlarından en az bir tanesi doldurulmalıdır.."
			call logla("Dosya","insert",hatamesaj,modulID)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		end if
		
	'## veritabanı
'##### /DOSYA KAYDET
'##### /DOSYA KAYDET
if hatamesaj = "Kayıt Başarılı." then
'	call jsrunajax("$(':input').val('');$(':input').prop('checked',false);$('#select2-1').val(null).trigger('change');$('#siparisVeren').val(null).trigger('change');$('#select2-3').val(null).trigger('change');")
	call jsrunajax("$('#sipNo, #tarih_sip, #tarih_son_teslim, .sipMiktarCl').val('');")
end if
%>
<script>
$.get('/dosya/detay/<%=ihaleID64%>', function(data){
											var $data = $(data);
//											$('#rakiplerTablo').html($data.find('#rakiplerTablo').html());
											$('#siparisTablo').html($data.find('#siparisTablo').html());
//											$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
//											$('#topluAlimTablo').html($data.find('#topluAlimTablo').html());
								});//tablolar güncellendi
</script>


