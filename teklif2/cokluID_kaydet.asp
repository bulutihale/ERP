<!--#include virtual="/reg/rs.asp" --><%


	'##### request
	'##### request
		kid						=	kidbul()
		alan					=	Request.Form("alan")
		tabloID					=	Request.Form("tabloID")
		tablo					=	Request.Form("tablo")
		deger					=	Request.Form("deger")



		
	
	
	
	

'##### HÜCRE EDIT
'##### HÜCRE EDIT
	'## veritabanı
		sorgu = "SELECT * FROM " & tablo & " WHERE id = " & tabloID
		rs.open sorgu, sbsv5,1,3
		
		

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


