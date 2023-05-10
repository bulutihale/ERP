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
		
		
		
		sorgu = "SELECT bankalar FROM " & tablo & " WHERE id = " & tabloID
		rs.open sorgu, sbsv5,1,3
			
			bankalar	=	rs("bankalar")


		if instr(bankalar,","&deger&",") > 0 then
			yeniBankalar = replace(bankalar,","&deger&",",",")
		else
			yeniBankalar = bankalar & "," & deger & ","
		end if
			yeniBankalar = replace(yeniBankalar,",,",",")
		rs("bankalar") = yeniBankalar
		rs.update
		rs.close
		
		

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


