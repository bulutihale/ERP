<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    tarih   =   Request.Form("tarih")
    yemek1 =   Request.Form("yemek1")
    yemek2 =   Request.Form("yemek2")
    yemek3 =   Request.Form("yemek3")
    yemek4 =   Request.Form("yemek4")
    yemek5 =   Request.Form("yemek5")
    gorevID =   Request.Form("gorevID")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Yeni Yemek Eklendi")

yetkiManager = yetkibul("manager")




if tarih = "" or yemek1 = "" or yemek2 = "" or yemek3 = "" then
	hatamesaj = "Yemek Adını Yazın"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if


if yetkiManager > 2 then

if gorevID = "" then
    gorevID = 0
end if

            sorgu = "Select top 1 * from isletme.yemekListe where yemekListeID = " & gorevID
			rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount = 0 then
                rs.addnew
            end if
                rs("tarih")       =   tarih
                rs("yemek1")      =  yemek1
                rs("yemek2")      =  yemek2
                rs("yemek3")      =  yemek3
                rs("yemek4")      =  yemek4
                rs("yemek5")      =  yemek5
                rs("firmaID")        =   firmaID
                rs("kid")    =   kid
            rs.update
            rs.close

end if

call jsac("/isletme/yemek.asp")
modalkapat()


Server.execute "/isletme/yemek_excel.asp"


%><!--#include virtual="/reg/rs.asp" -->