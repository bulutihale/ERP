<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()



	'##### request
	'##### request
		kid						=	kidbul()
		idAlan					=	Request.Form("idAlan")
		alan					=	Request.Form("alan")
		id						=	Request.Form("id")
		tablo					=	Request.Form("tablo")
		deger					=	Request.Form("deger")
		ntfDeger				=	Request.Form("ntfDeger")
	'##### request
	'##### request






	

'##### HÜCRE EDIT
'##### HÜCRE EDIT
	'## veritabanı
		sorgu = "SELECT * FROM " & tablo & " WHERE " & idAlan & " = " & id 
		rs.open sorgu, sbsv5,1,3
		
			
			if deger = "null" OR deger = "" then
				deger = null
			end if
			
				rs(alan)		=	deger
								
			rs.update
		rs.close
	'## veritabanı

'##### HÜCRE EDIT
'##### HÜCRE EDIT 

	SELECT CASE ntfDeger
		CASE "depoKabul", "depoRed"
			sorgu = "SELECT t1.stokKodu, t2.depoAd FROM stok.stokHareket t1 INNER JOIN stok.depo t2 ON t1.depoID = t2.id WHERE stokHareketID = " & id
			rs.open sorgu, sbsv5,1,3
				depoAd 		=	rs("depoAd")
				stokKodu	=	rs("stokKodu")
			rs.close
	END SELECT

		if ntfDeger = "depoKabul" then
			call bildirim(2,"Ürün Bildirimi",stokKodu & " ürün  " & depoAd & " kabulu yapıldı",1,kid,"","","","","")
		elseif ntfDeger =	"depoRed" then
			call bildirim(2,"Ürün Bildirimi",stokKodu & " " & depoAd & " girişi RED edildi",1,kid,"","","","","")
		end if

			
			mesaj = "Kayıt Başarılı."
			call logla("Hücre Kaydet işlemi başarılı (tablo:"&tablo&") (alan:"&alan&") (id:"&id&") (deger:"&deger&")")
		
			response.Write "ok|"&mesaj&""

%>



