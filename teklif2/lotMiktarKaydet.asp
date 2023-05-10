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
		ihaleID					=	request.Form("ihaleID")
		ihaleID64				=	ihaleID
		ihaleID64				=	base64_encode_tr(ihaleID64)
		sipID					=	request.Form("sipID")
		iutID					=	request.Form("iutID")
		lot						=	trim(request.Form("lot"))
		lotMiktar				=	request.Form("lotMiktar")
	'##### request
	'##### request


	sorgu = "SELECT * FROM siparisLot WHERE siparisID = " & sipID & " AND lot = '" & lot & "'"
	rs.open sorgu, sbsv5,1,3

		if rs.recordcount = 0 then
			rs.addnew
				rs("musteriID")			=	musteriID
				rs("ihaleID")			=	ihaleID
				rs("siparisID")			=	sipID
				rs("ihaleurunTalepID")	=	iutID
				rs("lot")				=	lot
				rs("lotMiktar")			=	lotMiktar
			rs.update
			hatamesaj = "Kayıt Başarılı."
			call logla("Dosya","update",hatamesaj,modulID)
		else
			hatamesaj = "Zaten Kayıtlı."
			call logla("Dosya","update",hatamesaj,modulID)
		end if
	rs.close
'### gelen veri ayır


			
		


%>
<script>
$.get('/dosya/detay/<%=ihaleID64%>', function(data){
											var $data = $(data);
											$('#siparisInput').html($data.find('#siparisInput').html());
											$('#siparisTablo').html($data.find('#siparisTablo').html());
								});//tablolar güncellendi
</script>

