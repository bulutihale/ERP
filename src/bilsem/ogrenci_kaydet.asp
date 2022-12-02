<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()

	site = Request.ServerVariables("HTTP_HOST")
	site = Replace(site,"www.","")
	site = Replace(site,"b2b.","")

				kid				=	kidbul()
				yetki			=	yetkibul("bilsem")
				ID				=	Request.Form("ID")
				kid64			=	ID
				ogrenciAd		=	Request.Form("ogrenciAd")
				ogrenciNo		=	Request.Form("ogrenciNo")
				ogrenciVeli		=	Request.Form("ogrenciVeli")
				ogrenciAnne		=	Request.Form("ogrenciAnne")
				ogrenciAnneGSM	=	Request.Form("ogrenciAnneGSM")
				ogrenciBaba		=	Request.Form("ogrenciBaba")
				ogrenciBabaGSM	=	Request.Form("ogrenciBabaGSM")
				ogrenciAlan1	=	Request.Form("ogrenciAlan1")
				ogrenciAlan2	=	Request.Form("ogrenciAlan2")
				ogrenciAlan3	=	Request.Form("ogrenciAlan3")
				ogrenciProgram1	=	Request.Form("ogrenciProgram1")
				ogrenciProgram2	=	Request.Form("ogrenciProgram2")
				ogrenciProgram3	=	Request.Form("ogrenciProgram3")
				ogrenciProgram4	=	Request.Form("ogrenciProgram4")
				ogrenciOzelNot	=	Request.Form("ogrenciOzelNot")




	Response.Flush()

	if ogrenciAd = "" then
		hatamesaj = "Lütfen öğrencinin adını yazın"
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if

if yetki > 5 then


	'## çift kayıt engelleme
		' sorgu = "Select top(1) * from bilsem.ogrenci where silindi = 0 and ogrenciAd = '" & ogrenciAd & "' and ogrenciNo = " & ogrenciNo
		' rs.open sorgu,sbsv5,1,3
		' if rs.recordcount > 0 then
		' 	hatamesaj = "Bu kayıt daha önce girilmiş"
		' 	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		' 	Response.End()
		' end if
		' rs.close
	'## çift kayıt engelleme



	if ID = "" then
		rs.open "Select top(1) * from bilsem.ogrenci",sbsv5,1,3
		rs.addnew
		hatamesaj = "Öğrenci Kayıdı Yapıldı"
	else
		ID = base64_decode_tr(ID)
		rs.open "Select top(1) * from bilsem.ogrenci where ogrenciID = " & ID,sbsv5,1,3
		hatamesaj = "Öğrenci Güncellendi"
	end if

		rs("ogrenciAd")			=	ogrenciAd
		rs("ogrenciNo")			=	ogrenciNo
		rs("ogrenciVeli")		=	ogrenciVeli
		rs("ogrenciAnne")		=	ogrenciAnne
		rs("ogrenciAnneGSM")	=	ogrenciAnneGSM
		rs("ogrenciBaba")		=	ogrenciBaba
		rs("ogrenciBabaGSM")	=	ogrenciBabaGSM
		rs("ogrenciAlan1")		=	ogrenciAlan1
		rs("ogrenciAlan2")		=	ogrenciAlan2
		rs("ogrenciAlan3")		=	ogrenciAlan3
		rs("ogrenciProgram1")	=	ogrenciProgram1
		rs("ogrenciProgram2")	=	ogrenciProgram2
		rs("ogrenciProgram3")	=	ogrenciProgram3
		rs("ogrenciProgram4")	=	ogrenciProgram4
		rs("ogrenciOzelNot")	=	ogrenciOzelNot
		rs("firmaID")			=	firmaID
		rs.update
		kid = rs("ogrenciID")
		rs.close
		call logla(hatamesaj)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")

	call jsgit("/bilsem/ogrenci_liste")
end if

%><!--#include virtual="/reg/rs.asp" -->