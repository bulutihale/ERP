<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()

	site = Request.ServerVariables("HTTP_HOST")
	site = Replace(site,"www.","")
	site = Replace(site,"b2b.","")

				kid				=	kidbul()
				yetki			=	yetkibul("bilsem")
				ID				=	Request.Form("ID")
				kid64			=	ID
				ogretmenID		=	Request.Form("ogretmenID")
                ogrenciID		=	Request.Form("ogrenciID")
                dersGun		    =	Request.Form("dersGun")
                dersSaatiID		=	Request.Form("dersSaatiID")
                dersAd		    =	Request.Form("dersAd")
                buton           =   Request.Form("buton")
				ogrenciNoIN		=	Request.Form("ogrenciNoIN")
				ogrenciNoIN		=	trim(ogrenciNoIN)



	Response.Flush()

	if ogretmenID = "" then
		hatamesaj = "Lütfen Öğretmen Seçin"
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if

	if ogrenciID = "" and ogrenciNoIN = "" then
		hatamesaj = "Lütfen Öğrenci Seçin"
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if

	if dersGun = "" then
		hatamesaj = "Lütfen Ders Gününü Seçin"
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if

	if dersSaatiID = "" then
		hatamesaj = "Lütfen Ders Saatini Seçin"
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if

	if dersAd = "" then
		hatamesaj = "Lütfen Dersin Adını Yazın"
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if

if yetki > 5 then

	if ogrenciNoIN = "" then
		'## çift kayıt engelleme
			sorgu = "Select top(1) * from bilsem.ders where silindi = 0 and ogretmenID = " & ogretmenID & " and ogrenciID = " & ogrenciID & " and dersGun = " & dersGun & " and dersSaatiID = " & dersSaatiID
			rs.open sorgu,sbsv5,1,3
			if rs.recordcount > 0 then
				hatamesaj = "Bu kayıt daha önce girilmiş"
				call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
				Response.End()
			end if
			rs.close
		'## çift kayıt engelleme

		if ID = "" then
			rs.open "Select top(1) * from bilsem.ders",sbsv5,1,3
			rs.addnew
			hatamesaj = "Ders Kayıdı Yapıldı"
		else
			ID = base64_decode_tr(ID)
			rs.open "Select top(1) * from bilsem.ders where dersID = " & ID,sbsv5,1,3
			hatamesaj = "Ders Güncellendi"
		end if

			rs("ogretmenID")	=	ogretmenID
			rs("ogrenciID")	    =	ogrenciID
			rs("dersGun")	    =	dersGun
			rs("dersSaatiID")	=	dersSaatiID
			rs("dersAd")	    =	dersAd
			rs("dersAd")	    =	dersAd
			rs("firmaID")		=	firmaID
			rs.update
			kid = rs("dersID")
			rs.close
			call logla(hatamesaj)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")

			if buton = "devam" then
				call jsac("/bilsem/ders_liste.asp")
			else
				call modalkapat()
			end if
	else
		ogrenciNoIN		=	Replace(ogrenciNoIN,","," ")
		ogrenciNoINArr	=	Split(ogrenciNoIN," ")
		for i = 0 to ubound(ogrenciNoINArr)
			ogrenciNo	=	ogrenciNoINArr(i)
			call jsconsole(ogrenciNo)
			'## öğrenci gerçek mi
			sorgu = "Select top(1) ogrenciID from bilsem.ogrenci where silindi = 0 and ogrenciNo = " & ogrenciNo
			rs.open sorgu,sbsv5,1,3
			if rs.recordcount > 0 then
				ogrenciID	=	rs("ogrenciID")
			else
				ogrenciID	=	""
				hatamesaj	=	ogrenciNo & " numaralı öğrenci bulunamadı. Lütfen kontrol edip yeniden deneyin."
				call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
				Response.End()
			end if
			rs.close
			'## öğrenci gerçek mi
			'## çift kayıt engelleme
			sorgu = "Select top(1) * from bilsem.ders where silindi = 0 and ogretmenID = " & ogretmenID & " and ogrenciID = " & ogrenciID & " and dersGun = " & dersGun & " and dersSaatiID = " & dersSaatiID
			rs.open sorgu,sbsv5,1,3
			if rs.recordcount > 0 then
				hatamesaj = "Bu kayıt daha önce girilmiş"
				call jsconsole(hatamesaj)
				' call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
				' Response.End()
			else
				hatamesaj = ""
			end if
			rs.close
			'## çift kayıt engelleme
			if hatamesaj = "" then
				rs.open "Select top(1) * from bilsem.ders",sbsv5,1,3
				rs.addnew
				hatamesaj = "Ders Kayıdı Yapıldı"
				rs("ogretmenID")	=	ogretmenID
				rs("ogrenciID")	    =	ogrenciID
				rs("dersGun")	    =	dersGun
				rs("dersSaatiID")	=	dersSaatiID
				rs("dersAd")	    =	dersAd
				rs("dersAd")	    =	dersAd
				rs("firmaID")		=	firmaID
				rs.update
				kid = rs("dersID")
				rs.close
				call logla(hatamesaj & " ogrenciID : " & ogrenciID & " ogretmenID : " & ogretmenID)
			end if
		next
				call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")

				if buton = "devam" then
					call jsac("/bilsem/ders_liste.asp")
				else
					call jsac("/bilsem/ders_liste.asp")
					call modalkapat()
				end if
	end if
end if

%><!--#include virtual="/reg/rs.asp" -->