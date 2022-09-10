<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()


'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr = Split(kidarr,"#")
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
	kid				=	kidbul()

	hangiYil			=	Request.Form("hangiYil")
	hangiAy				=	Request.Form("hangiAy")
	hangiGun			=	Request.Form("hangiGun")
	inpicerik			=	Request.Form("inpicerik")
	
	
	'##### request
	'##### request


	'##### doğrulama
	'##### doğrulama
		if inpicerik = "" then
			mesaj = "İçerik girişi yapılmamış."
			call toastrCagir(mesaj, "HATA", "right", "error", "otomatik", "")
			Response.End()
		end if
	
	'##### doğrulama
	'##### doğrulama


'##### DOSYA KAYDET
'##### DOSYA KAYDET

	'## veritabanı
		

	sorgu = "SELECT * FROM portal.ajanda"
	rs.open sorgu, sbsv5,1,3
	
	rs.addnew
		rs("firmaID")			=	firmaID
		rs("kid")				=	kid
		rs("hangiGun")			=	hangiGun
		rs("hangiAy")			=	hangiAy
		rs("hangiYil")			=	hangiYil
		rs("icerik")			=	inpicerik
	rs.update
	rs.close




		
		call logla("Ajandaya etkinmlik kaydu yapıldı")

			call toastrCagir("Kayıt başarılı", "OK", "right", "success", "otomatik", "")
			
			call jsrun("$('#ajandaAnaDIV').load('/ajanda/ajanda.asp #ajandaAnaDIV > *',{ayHareket:0,sorgulananTarih:0})")























	


%>



