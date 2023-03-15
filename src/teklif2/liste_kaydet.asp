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


	hatamesaj = "Kayıt Başlıyor"
	call logla("Dosya","update",hatamesaj,modulID)

	'##### request
	'##### request
		kid						=	kidbul()
		ihaleID64				=	request.Form("ihaleID")
		ihaleID					=	base64_decode_tr(ihaleID64)
		veri					=	Request.Form("veri")
		modulID					=	Request.Form("modulID")
	'##### request
	'##### request


'##### bayiDosyaTipi tespit et stok alımı ise "uhde" otomatik işaretlenecek.
'##### bayiDosyaTipi tespit et stok alımı ise "uhde" otomatik işaretlenecek.
	sorgu = "SELECT bayiDosyaTipi FROM ihale WHERE musteriID = " & musteriID & " AND id = " & ihaleID
	rs.open sorgu, sbsv5,1,3
	
	bayiDosyaTipi = rs("bayiDosyaTipi")
	rs.close
'##### /bayiDosyaTipi tespit et stok alımı ise "uhde" otomatik işaretlenecek.
'##### /bayiDosyaTipi tespit et stok alımı ise "uhde" otomatik işaretlenecek.

	
'	hatamesaj = "Kayıt başlıyor."
'	call logla("Dosya","update",hatamesaj,modulID)

'##### EXCEL'DEN ALINAN LİSTE KAYIT
'##### EXCEL'DEN ALINAN LİSTE KAYIT

'### gelen veri ayır
	gelenVeri	=	split(veri,"|")
	kisimNo		=	gelenVeri(0)
	siraNo		=	gelenVeri(1)
	cinsi		=	gelenVeri(2)
	miktar		=	gelenVeri(3)
	birim		=	gelenVeri(4)
	
'### gelen veri ayır

	'## veritabanı
		
		if isnull(kisimNo) OR kisimNo = "" then
			kisimNo = 0
		end if
			sorgu = "SELECT * FROM ihale_urun WHERE musteriID = " & musteriID & " AND ihaleID = " & ihaleID & " AND grupNo = " & kisimNo & " AND siraNo = " & siraNo
			rs.open sorgu, sbsv5,1,3
			
			if rs.recordcount = 0 then
				rs.addnew
				rs("musteriID") 	=	musteriID
				rs("ihaleID") 		=	ihaleID
				rs("grupNo")		=	kisimNo
				rs("siraNo")		=	siraNo
				rs("ad")			=	cinsi
				rs("miktar")		=	miktar
				rs("birim")			=	birim
				
				if bayiDosyaTipi = "stok" then
					rs("uhde") = "True"
				end if
				
			rs.update
			
			end if
				ihaleUrunID			=	rs("id") 
			rs.close
			
			sorgu = "SELECT cariID FROM ihale WHERE id = " & ihaleID
			rs.open sorgu, sbsv5,1,3
			
			cariID = rs("cariID")
			rs.close
			
			sorgu = "SELECT * FROM ihale_urun_talep WHERE ihaleUrunID = " & ihaleUrunID & " AND carilerID = " & cariID
			rs.open sorgu, sbsv5,1,3
			
			if rs.recordcount = 0 then
					rs.addnew
					rs("musteriID") 	=	musteriID
					rs("ihaleID") 		=	ihaleID
					rs("ihaleUrunID") 	=	ihaleUrunID
					rs("carilerID") 	=	cariID
					rs("miktar")		=	miktar
					rs.update
					rs.close
				response.Write "ok|"
			else
				response.Write "kayitli|"
			end if	

			
			hatamesaj = "Kayıt Başarılı."
			call logla("Dosya","update",hatamesaj,modulID)
			'call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		


%>
<script>
$.get('/dosya/detay/<%=ihaleID64%>', function(data){
											var $data = $(data);
											$('#rakiplerTablo').html($data.find('#rakiplerTablo').html());
											$('#urunlerTablo').html($data.find('#urunlerTablo').html());
											$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
											$('#topluAlimTablo').html($data.find('#topluAlimTablo').html());
											$('#siparisInput').html($data.find('#siparisInput').html());
											$('#siparisTablo').html($data.find('#siparisTablo').html());
											$('#teslimatTablo').html($data.find('#teslimatTablo').html());
								});//tablolar güncellendi
</script>

