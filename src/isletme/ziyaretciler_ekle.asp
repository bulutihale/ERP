<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    adSoyad =   Request.Form("adSoyad")
    hedefBirim =   Request.Form("hedefBirim")
    hedefPersonel =   Request.Form("hedefPersonel")
    ziyaretSebebi =   Request.Form("ziyaretSebebi")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Yeni Ziyaretci Ekranı")

yetkiGuvenlik = yetkibul("guvenlik")




if adSoyad = "" then
	hatamesaj = "Ziyaretcinin adını yazın"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if hedefBirim = "" and hedefPersonel = "" then
	hatamesaj = "Ziyaretci kimi ziyarete geldi?"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if


if yetkiGuvenlik > 5 then

            sorgu = "Select top 1 * from isletme.ziyaretci"
			rs.open sorgu, sbsv5, 1, 3
            rs.addnew
                rs("adSoyad")       =   adSoyad
                if hedefBirim <> "" then
                rs("hedefBirim")    =   hedefBirim
                end if
                if hedefPersonel <> "" then
                rs("hedefPersonel") =   hedefPersonel
                end if
                rs("ziyaretSebebi") =   ziyaretSebebi
                rs("t1")            =   now()
                rs("firmaID")        =   firmaID
                rs("personelID")    =   kid
            rs.update
            rs.close

end if

call jsac("/isletme/ziyaretciler.asp")
modalkapat()


%><!--#include virtual="/reg/rs.asp" -->