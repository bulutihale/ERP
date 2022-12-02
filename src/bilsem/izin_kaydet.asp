<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()

	site = Request.ServerVariables("HTTP_HOST")
	site = Replace(site,"www.","")
	site = Replace(site,"b2b.","")

				kid				=	kidbul()
				yetki			=	yetkibul("bilsem")
				ID				=	Request.Form("ID")
				kid64			=	ID
                buton           =   Request.Form("buton")
				tarih			=	Request.Form("tarih")
				tarih2			=	Request.Form("tarih2")
				ogretmenID		=	Request.Form("ogretmenID")
				dersSaatleriID	=	Request.Form("dersSaatleriID")
				izinAciklama	=	Request.Form("izinAciklama")

	Response.Flush()

	if ogretmenID = "" then
		hatamesaj = "Lütfen Öğretmen Seçin"
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if

	if tarih = "" then
		hatamesaj = "Lütfen Tarih Seçin"
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if

	if dersSaatleriID = "" then
		hatamesaj = "Lütfen Ders Saatini Seçin"
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if









if yetki > 5 then

' tarih2 boş ise

	tarih = cdate(tarih)
	dersGun = weekday(tarih-1)




	'## çift kayıt engelleme
		sorgu = "Select top(1) * from bilsem.ogretmenIzinler where silindi = 0 and ogretmenID = " & ogretmenID & " and tarih = '" & tarihsql(tarih) & "' and dersSaatleriID = " & dersSaatleriID
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount > 0 then
			hatamesaj = "Bu kayıt daha önce girilmiş"
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
			Response.End()
		end if
		rs.close
	'## çift kayıt engelleme





	if ID = "" then
		rs.open "Select top(1) * from bilsem.ogretmenIzinler",sbsv5,1,3
		rs.addnew
		hatamesaj = "İzin Kayıdı Yapıldı"
	else
		ID = base64_decode_tr(ID)
		rs.open "Select top(1) * from bilsem.ogretmenIzinler where izinID = " & ID,sbsv5,1,3
		hatamesaj = "İzin Güncellendi"
	end if

        rs("ogretmenID")		=	ogretmenID
        rs("tarih")	   			=	tarih
        rs("dersGun")	    	=	dersGun
        rs("dersSaatleriID")	=	dersSaatleriID
        rs("izinAciklama")	    =	izinAciklama
		rs("firmaID")			=	firmaID
		rs.update
		kid = rs("izinID")
		rs.close
		call logla(hatamesaj)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")






'########## TARİH2 DOLUYSA

'günleri > dersleribul













        if buton = "devam" then
			call jsac("/bilsem/izin_liste.asp")
        else
			call jsac("/bilsem/izin_liste.asp")
        	call modalkapat()
        end if
end if

%><!--#include virtual="/reg/rs.asp" -->