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
		ihaleID					=	request.Form("ihaleID")
		ihaleID64				=	base64_encode_tr(ihaleID64)
		id						=	Request.Form("id")
		modulID					=	Request.Form("modulID")
		stoklarID				=	Request.Form("stoklarID")
		ihaleUrunID				=	Request.Form("ihaleUrunID")
	'##### request
	'##### request


	
	hatamesaj = "Kayıt Başlıyor"
	call logla("Dosya","update",hatamesaj,modulID)
	
	
	

'##### HÜCRE EDIT
'##### HÜCRE EDIT
	'## veritabanı
		sorgu = "SELECT stoklarID FROM ihale_urun WHERE id = " & ihaleUrunID
		rs.open sorgu, sbsv5,1,3
		iu_stoklarID = rs("stoklarID")
		rs.close
		
		sorgu = "SELECT * FROM ihale_urun_ek WHERE ihaleID = " & ihaleID &" AND stoklarID = " & stoklarID & " AND ihaleUrunID = " & ihaleUrunID
		rs.open sorgu, sbsv5,1,3
		
		if rs.recordcount = 0 AND int(iu_stoklarID) <> int(stoklarID) AND iu_stoklarID > 0 then
			rs.addnew
				rs("musteriID")		=	musteriID
				rs("ihaleID")		=	ihaleID
				rs("ihaleUrunID")	=	ihaleUrunID
				rs("stoklarID")		=	stoklarID
			rs.update

			response.Write "ok|"
		elseif isnull(iu_stoklarID) OR iu_stoklarID = 0 then
			Response.Write "onceStokSec|"
		else
			response.Write "mevcut|"
		end if						
		rs.close
	'## veritabanı

'##### /HÜCRE EDIT
'##### /HÜCRE EDIT




			
			
			
			
			hatamesaj = "Kayıt Başarılı."
			call logla("Dosya","update",hatamesaj,modulID)
			'call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		


%>
<script>
$.get('/dosya/detay/<%=ihaleID64%>', function(data){
											var $data = $(data);
//											$('#rakiplerTablo').html($data.find('#rakiplerTablo').html());
											$('#urunlerTablo').html($data.find('#urunlerTablo').html());
//											$('#sozlesmeTablo').html($data.find('#sozlesmeTablo').html());
//											$('#topluAlimTablo').html($data.find('#topluAlimTablo').html());
								});//tablolar güncellendi
</script>


