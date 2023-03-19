<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()




	'##### request
	'##### request
		kid						=	kidbul()
		iuID					=	request.Form("iuID")
		birimID					=	request.Form("birimID")
		sipMiktar				=	request.Form("sipMiktar")
	'##### request
	'##### request
	
	call logla("Teklif dosyasından sipariş yazılıyor")

	sorgu = "SELECT t2.cariID, t1.stoklarID, t1.kalemNot, t1.firmamFiyat, t1.firmamParaBirim, t2.ad as siparisAd, t1.ihaleID,"
	sorgu = sorgu & " (SELECT kisaBirim FROM portal.birimler WHERE birimID = "& birimID & ") as mikBirim"
	sorgu = sorgu & " FROM dosya.ihale_urun t1"
	sorgu = sorgu & " INNER JOIN dosya.ihale t2 ON t1.ihaleID = t2.id"
	sorgu = sorgu & " WHERE t1.id = " & iuID
	rs.open sorgu, sbsv5,1,3
		cariID			=	rs("cariID")
		stokID			=	rs("stoklarID")
		kalemNot		=	rs("kalemNot")
		firmamFiyat		=	rs("firmamFiyat")
		firmamParaBirim	=	rs("firmamParaBirim")
		siparisAd		=	rs("siparisAd")
		mikBirim		=	rs("mikBirim")
		ihaleID			=	rs("ihaleID")
		ihaleID64		=	ihaleID
		ihaleID64		=	base64_encode_tr(ihaleID64)
	rs.close

	sorgu = "SELECT * FROM teklif.siparisKalemTemp WHERE iuID = " & iuID
	rs.open sorgu, sbsv5,1,3


		if rs.recordcount = 0 then
			rs.addnew
				rs("kid")				=	kid
				rs("firmaID")			=	firmaID
				rs("cariID")			=	cariID
				rs("stokID")			=	stokID
				rs("kalemNot")			=	kalemNot
				rs("miktar")			=	sipMiktar
				rs("birimFiyat")		=	firmamFiyat
				rs("paraBirim")			=	firmamParaBirim
				rs("siparisTur")		=	"S"
				rs("mikBirim")			=	mikBirim
				rs("mikBirimID")		=	birimID
				rs("siparisTarih")		=	date()
				rs("siparisAd")			=	siparisAd
				rs("iuID")				=	iuID
			rs.update
			call logla("Kayıt Başarılı.")
		else
			hatamesaj = "Zaten Kayıtlı."
			call logla("Zaten Kayıtlı.")
		end if
	rs.close
'### gelen veri ayır


			
		


%>
<script>
$.get('/teklif2/detay/<%=ihaleID64%>', function(data){
											var $data = $(data);
											$('#siparisInput').html($data.find('#siparisInput').html());
											$('#siparisTablo').html($data.find('#siparisTablo').html());
								});//tablolar güncellendi
</script>

