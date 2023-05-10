<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ziyaretID")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Ziyaretci Çıkışı Yapıldı")

yetkiGuvenlik = yetkibul("guvenlik")

if ID = "" then
	hatamesaj = "Bir sorun oluştu"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if yetkiGuvenlik > 5 then

            sorgu = "Select top 1 * from isletme.ziyaretci where ziyaretID = " & ID
			rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount > 0 then
                rs("t2")       =   now()
                rs.update
            end if
            rs.close

end if

call jsac("/isletme/ziyaretciler.asp")

%><!--#include virtual="/reg/rs.asp" -->