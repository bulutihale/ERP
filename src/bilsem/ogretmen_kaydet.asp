<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()

	site = Request.ServerVariables("HTTP_HOST")
	site = Replace(site,"www.","")
	site = Replace(site,"b2b.","")

				kid				=	kidbul()
				yetki			=	yetkibul("bilsem")
				ID				=	Request.Form("ID")
				kid64			=	ID
				ogretmenAd		=	Request.Form("ogretmenAd")

	Response.Flush()

	if ogretmenAd = "" then
		hatamesaj = "Lütfen öğretmenin adını yazın"
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if

if yetki > 5 then


	'## çift kayıt engelleme
		sorgu = "Select top(1) * from bilsem.ogretmen where silindi = 0 and ogretmenAd = '" & ogretmenAd & "'"
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount > 0 then
			hatamesaj = "Bu kayıt daha önce girilmiş"
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
			Response.End()
		end if
		rs.close
	'## çift kayıt engelleme


	if ID = "" then
		rs.open "Select top(1) * from bilsem.ogretmen",sbsv5,1,3
		rs.addnew
		hatamesaj = ogretmenAd & " Öğretmen Kayıdı Yapıldı"
	else
		ID = base64_decode_tr(ID)
		rs.open "Select top(1) * from bilsem.ogretmen where ogretmenID = " & ID,sbsv5,1,3
		hatamesaj = ogretmenAd & " Öğretmen Güncellendi"
	end if

		rs("ogretmenAd")	=	ogretmenAd
		rs("firmaID")		=	firmaID
		rs.update
		kid = rs("ogretmenID")
		rs.close
		call logla(hatamesaj)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")

	call jsgit("/bilsem/ogretmen_liste")
end if

%><!--#include virtual="/reg/rs.asp" -->