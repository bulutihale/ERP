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

        '##### İLİŞKİ KONTROLÜ
            ' 'ders kontrolü
            ' sorgu = "Select count(*) from bilsem.ders where silindi = 0 and ogretmenID = " & ID
            ' rs.open sorgu,sbsv5,1,3
            '     toplamders = rs(0)
            ' rs.close
            ' 'öğrenci kontrolü
            ' sorgu = "Select count(*) from bilsem.ogrenci where silindi = 0 and ogrenciDanismanOgretmenID = " & ID
            ' rs.open sorgu,sbsv5,1,3
            '     toplamogrenci = rs(0)
            ' rs.close
        '##### İLİŞKİ KONTROLÜ

        'UYARILAR
        ' if toplamders > 0 then
        '     hatamesaj = "Öğretmen ile ilişkili " &  toplamders & " ders bulundu. Öğretmeni silmek için önce bu derslerdeki ilişkileri değiştirmelisiniz."
        '     call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        '     Response.End()
        ' end if
        ' if toplamogrenci > 0 then
        '     hatamesaj = "Öğretmen ile ilişkili " &  toplamogrenci & " öğrenci bulundu. Öğretmeni silmek için önce bu öğrencilerdeki ilişkileri değiştirmelisiniz."
        '     call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        '     Response.End()
        ' end if
        'UYARILAR

        '##### SİL
        if toplamders = 0 then
            rs.open "Update bilsem.ogrenci set silindi = 1 where ogrenciID = " & ID,sbsv5,3,3
            hatamesaj = "Öğrenci Silindi"
            call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
            hatamesaj = hatamesaj & " ID=" & ID
            call logla(hatamesaj)
            call jsac("/bilsem/ogrenci_liste.asp")
        end if
        '##### SİL

	end if
end if

%><!--#include virtual="/reg/rs.asp" -->