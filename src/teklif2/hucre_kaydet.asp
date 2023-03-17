<!--#include virtual="/reg/rs.asp" --><%


	'##### request
	'##### request
		kid						=	kidbul()
		ihaleID					=	request.Form("ihaleID")
		ihaleID64				=	ihaleID
		ihaleID64				=	base64_encode_tr(ihaleID64)
		alan					=	Request.Form("alan")
		id						=	Request.Form("id")
		tabloID					=	Request.Form("tabloID")
		modulID					=	Request.Form("modulID")
		tablo					=	Request.Form("tablo")
		deger					=	Request.Form("deger")
		kalemNotTeklifEkle		=	Request.Form("kalemNotTeklifEkle")


		
	if tabloID = "" then
		if ihaleID <> "" then
			tabloID = ihaleID
		elseif id <> "" then
			tabloID = id
		end if
	end if
	'##### request
	'##### request

if len(deger) = 16 then
	if isnumeric(left(deger,2)) = True and isnumeric(right(deger,2)) = True then
		deger = cdate(deger)
	end if
end if

	
	
	
	

'##### HÜCRE EDIT
'##### HÜCRE EDIT
	'## veritabanı
		sorgu = "SELECT * FROM " & tablo & " WHERE id = " & tabloID
		rs.open sorgu, sbsv5,1,3
		
		
		if tablo = "dosya.ihale_urun" then
		'####### fiyat onaylanmış ise teklif kalemi ile ilgili bir şey değiştirilemesin
		'####### fiyat onaylanmış ise teklif kalemi ile ilgili bir şey değiştirilemesin
			if alan <> "fiyatOnay" AND rs("fiyatOnay") = True then
				Response.Write "hata|Fiyatı onaylanmış kalemde değişiklik yapılamaz."
				Response.End()
			end if
		'####### fiyat onaylanmış ise teklif kalemi ile ilgili bir şey değiştirilemesin
		'####### fiyat onaylanmış ise teklif kalemi ile ilgili bir şey değiştirilemesin
			if alan = "firmamFiyat" AND isnull(rs("firmamParaBirim")) then
				rs("firmamParaBirim") = "TL"
			end if
						

		elseif tablo = "fiyatlar" then

			if alan = "fiyat" AND isnull(rs("fiyatPB")) then
				rs("fiyatPB") = "TL"
			end if
		end if
		

		
			if alan = "urunAd" then
				alan = "ad"
			end if
			
			if deger = "null" OR deger = "" then
				deger = null
			end if
			
			if alan = "kalemNot" then
				if kalemNotTeklifEkle = "on" AND len(trim(deger)) > 0 then
					rs("kalemNotTeklifEkle") = 1
				else
					rs("kalemNotTeklifEkle") = null
				end if
			end if
			
			if alan = "kalemNot" AND (deger = "" OR len(trim(deger)) = 0) then
				deger = null
			end if

				rs(alan)		=	deger
								
			rs.update
		rs.close
	'## veritabanı
		

'##### /HÜCRE EDIT
'##### /HÜCRE EDIT

Response.Write "ok|"




			
		


%>
<script>
$.get('/teklif2/detay/<%=ihaleID64%>', function(data){
											var $data = $(data);
											$('#teklif').html($data.find('#teklif').html());
											$('#urunlerTablo').html($data.find('#urunlerTablo').html());
											$('#teklifChck').html($data.find('#teklifChck').html());

								});//tablolar güncellendi
</script>


