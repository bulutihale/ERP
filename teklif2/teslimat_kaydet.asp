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
		faturaCari				=	Request.Form("faturaCari")
		faturaNo				=	Request.Form("faturaNo")
		faturaTarih				=	Request.Form("faturaTarih")
		tesKacinciSiparis		=	Request.Form("tesKacinciSiparis")
		
		if isempty(tesKacinciSiparis) OR isnull(tesKacinciSiparis) OR tesKacinciSiparis = "" then
			tesKacinciSiparis = 0
		end if
		
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

	if faturaCari = "" then
		hatamesaj = "Kurum seçimi yapınız."
		call logla("Dosya","error",hatamesaj,modulID)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
	
	if faturaTarih = "" then
		hatamesaj = "Fatura tarihi giriniz."
		call logla("Dosya","error",hatamesaj,modulID)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
	
	
	
	'##### doğrulama
	'##### doğrulama


'##### DOSYA KAYDET
'##### DOSYA KAYDET

'#### KAÇINCI FATURA
		sorgu = "SELECT max(kacinciFatura) as sonFAT FROM teslimat WHERE musteriID = " & musteriID & " AND ihaleID = " & ihaleID
		rs.open sorgu, sbsv5,1,3
		if isnull(rs("sonFAT")) then
			kacinciFatura = 1
		else
			kacinciFatura	=	int(rs("sonFAT")) + 1
		end if
		rs.close
'#### KAÇINCI FATURA

	'## veritabanı
		sorgu = "SELECT * FROM teslimat"
		rs.open sorgu, sbsv5,1,3
			
			for i=6 to Request.Form.Count
				if Request.Form.item(i) <> "" then
					rs.addnew
					rs("musteriID")			=	musteriID
					rs("ihaleID")			=	ihaleID
					rs("carilerID")			=	faturaCari
					rs("faturaNo")			=	faturaNo
					rs("faturaTarih")		=	faturaTarih
					rs("kacinciFatura")		=	kacinciFatura
					rs("kacinciSiparis")	=	tesKacinciSiparis

						iutIDarr = split(Request.Form.key(i),"|")
						ihaleUrunTalepID		=	iutIDarr(1)
						teslimMiktar			=	Request.Form.item(i)
						ihaleUrunID				=	iutIDarr(2)
						
						rs("ihaleUrunTalepID")	= 	ihaleUrunTalepID
						rs("ihaleUrunID")		= 	ihaleUrunID
						rs("miktar")			=	teslimMiktar
						rs("kayitYontem")		=	"M"
						rs("TBLSTHARduzeltmeTarih")	=	Now()
					rs.update
		
					'##### siparişten teslimat yapılmıi ise sipariş tablosuna teslimat miktarları yazılıyor
					'##### siparişten teslimat yapılmıi ise sipariş tablosuna teslimat miktarları yazılıyor
						if tesKacinciSiparis > 0 then
							sorgu = "SELECT teslimEdilen FROM siparis WHERE musteriID = " & musteriID &" AND"_
							&" kacinciSiparis = " & tesKacinciSiparis & " AND siparisVerenCariID = " & faturaCari & " AND ihaleUrunTalepID = " & ihaleUrunTalepID
							rs2.open sorgu, sbsv5,1,3
							
							rs2("teslimEdilen") 	=	rs2("teslimEdilen") + teslimMiktar
							rs2.update
							rs2.close
						end if
					'##### /siparişten teslimat yapılmıi ise sipariş tablosuna teslimat miktarları yazılıyor
					'##### /siparişten teslimat yapılmıi ise sipariş tablosuna teslimat miktarları yazılıyor

				end if
			next
		rs.close

		'#### teslim edilen faturadan sonra dosyaya ait teslimatların tamamı bitmiş mi? bitti ise db "teslimatBitti" alanına kayıt yaz.
			call teslimatBittiKontrol(ihaleID)
		'#### /teslim edilen faturadan sonra dosyaya ait teslimatların tamamı bitmiş mi? bitti ise db "teslimatBitti" alanına kayıt yaz.

			hatamesaj = "Kayıt Başarılı."
			call logla("Dosya","insert",hatamesaj,modulID)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		
	'## veritabanı
'##### /DOSYA KAYDET
'##### /DOSYA KAYDET
if hatamesaj = "Kayıt Başarılı." then
'	call jsrunajax("$(':input').val('');$(':input').prop('checked',false);$('#select2-1').val(null).trigger('change');$('#siparisVeren').val(null).trigger('change');$('#select2-3').val(null).trigger('change');")
	call jsrunajax("$('#tesKacinciSiparis').val(null).trigger('change');$('.ajCariSiparisler, #faturaNo, #faturaTarih').val('');")
end if
%>
<script>
$.get('/dosya/detay/<%=ihaleID64%>', function(data){
											var $data = $(data);
//											$('#rakiplerTablo').html($data.find('#rakiplerTablo').html());
											$('#teslimatTablo').html($data.find('#teslimatTablo').html());
											$('#siparisTablo').html($data.find('#siparisTablo').html());
//											$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
//											$('#topluAlimTablo').html($data.find('#topluAlimTablo').html());
								});//tablolar güncellendi
</script>


