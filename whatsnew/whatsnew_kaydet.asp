<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

				
				kid				=	kidbul()
				ID				=	Request.Form("ID")
				kid64			=	ID
				ad				=	Request.Form("ad")
				tarih			=	Request.Form("tarih")
				aciklama		=	Request.Form("aciklama")
				modul			=	Request.Form("modul")
				ayrinti			=	Request.Form("ayrinti")
				yetkiIT			=	yetkibul("IT")

Response.Flush()

	if ad = "" then
		hatamesaj = "Lütfen güncellemenin adını yazın"
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		Response.End()
	end if


if yetkiIT = 9 then
		if ID = "" then
			rs.open "Select top(1) * from portal.whatsnew",sbsv5,1,3
			rs.addnew
			hatamesaj = "Güncelleme Kayıdı Yapıldı"
		else
			ID = base64_decode_tr(ID)
			rs.open "Select top(1) * from portal.whatsnew where id = " & ID,sbsv5,1,3
			hatamesaj = "Güncelleme Güncellendi"
		end if

		rs("ad")		=	ad
		rs("tarih")		=	tarih
		rs("modul")		=	modul
		rs("aciklama")	=	aciklama
		rs("ayrinti")	=	ayrinti
		rs("firmaID")	=	firmaID
		rs.update
		rs.close
		call logla(hatamesaj)
		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	'#### YETKİ
	'#### YETKİ
	'#### YETKİ
	call jsgit("/whatsnew/whatsnew_liste")
end if

%><!--#include virtual="/reg/rs.asp" -->