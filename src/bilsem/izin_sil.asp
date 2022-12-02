<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

kid		=	kidbul()
ID		=	Request.QueryString("ID")
kid64	=	ID

Response.Flush()

yetki = yetkibul("bilsem")

if yetki > 1 then
	if ID <> "" then
		ID = base64_decode_tr(ID)

        '##### SİL
        if toplamders = 0 then
            rs.open "Update bilsem.ogretmenIzinler set silindi = 1 where izinID = " & ID,sbsv5,3,3
            hatamesaj = "İzin Silindi"
            call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
            hatamesaj = hatamesaj & " ID=" & ID
            call logla(hatamesaj)
            call jsac("/bilsem/izin_liste.asp")
        end if
        '##### SİL

	end if
end if

%><!--#include virtual="/reg/rs.asp" -->