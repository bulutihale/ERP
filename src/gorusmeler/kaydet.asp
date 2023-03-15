<!--#include virtual="/reg/rs.asp" --><%





	'##### request 
	'##### request
	kid					=	kidbul()
	gorusmeTarihi		=	Request.Form("gorusmeTarihi")
	ihaleID64			=	Request.Form("ihaleID64")
	gorusmeIcerik		=	Request.Form("gorusmeIcerik")
	gorusulenKisi		=	Request.Form("gorusulenKisi")
	sonrakiAramaTarihi	=	Request.Form("sonrakiAramaTarihi")
	oncekiGorusmeID		=	Request.Form("oncekiGorusmeID")
	ihaleID				=	ihaleID64
	ihaleID				=	base64_decode_tr(ihaleID)
	'##### request
	'##### request



	'##### doğrulama
	'##### doğrulama
	if gorusmeTarihi = "" then
		hatamesaj = "Lütfen Görüşme Tarihi Alanını doldurunuz."
		call logla("Görüşme","error",hatamesaj,modulID)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if
	
	if sonrakiAramaTarihi = "" then sonrakiAramaTarihi = null
	
	if oncekiGorusmeID = "" then oncekiGorusmeID = 0
	'##### doğrulama
	'##### doğrulama


'##### DOSYA KAYDET
'##### DOSYA KAYDET

	'## veritabanı
		sorgu = "SELECT * FROM dosya.gorusmeler WHERE firmaID = " & firmaID & " order by id DESC"
		rs.open sorgu, sbsv5,1,3

			rs.addnew
				rs("musteriID")				=	musteriID
				rs("gorusmeTarihi")			=	gorusmeTarihi
				rs("ihaleID")				=	ihaleID
				rs("kid") 					=	kid
				rs("musteriID")				=	musteriID
				rs("gorusmeIcerik")			=	gorusmeIcerik
				rs("gorusulenKisi")			=	gorusulenKisi
				rs("sonrakiAramaTarihi")	=	sonrakiAramaTarihi
			rs.update
			gorusmelerIDsonKayit = rs("id")
		rs.close
		
	'##### yapılan yeni görüşme ile bağlantılı olan önceki görüşmeye takip görüşmesinin yapıldığı ID yazılsın.
	if oncekiGorusmeID > 0 then
		sorgu = "UPDATE dosya.gorusmeler SET sonrakiAramaID = " & gorusmelerIDsonKayit & " WHERE id = " & oncekiGorusmeID
		rs.open sorgu, sbsv5,1,3
	end if
	'##### yapılan yeni görüşme ile bağlantılı olan önceki görüşmeye takip görüşmesinin yapıldığı ID yazılsın.
		
			hatamesaj = "Kayıt Başarılı."
			call logla("Görüşme","insert",hatamesaj,modulID)
		
	'## veritabanı
'##### /DOSYA KAYDET
'##### /DOSYA KAYDET
Response.Write "ok|"



%>


