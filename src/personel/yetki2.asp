<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    yetkiParametre   =   Request.QueryString("y")
    yetkiAd   =   Request.QueryString("yetkiAd")
    gorevID64 = gorevID
    hata    =   ""
    modulAd =   "personel"
    hastaID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Personel Yetkileri Kaydediliyor")

yetkiPersonel = yetkibul("personel")


'###### 64 DÖNÜŞÜM
'###### 64 DÖNÜŞÜM
    if gorevID = "" then
    else
        gorevID = base64_decode_tr(gorevID)
        yetkiAd = base64_decode_tr(yetkiAd)
    end if
'###### 64 DÖNÜŞÜM
'###### 64 DÖNÜŞÜM



'####### INSERT - UPDATE
'####### INSERT - UPDATE
    sorgu = "Select top 1 * from personel.personel_yetki where kid = " & gorevID & " and yetkiAd = N'" & yetkiAd & "'"
    Response.Write sorgu
	rs.Open sorgu, sbsv5, 1, 3
    if rs.recordcount = 0 then
        rs.addnew
    end if
    rs("yetkiAd")               =   yetkiAd
    rs("yetkiParametre")        =   yetkiParametre
    rs("kid")                   =    gorevID
    rs.update
    gorevID = rs("yetkiID")
    rs.close
'####### INSERT - UPDATE
'####### INSERT - UPDATE


    call logla("Yetki Güncellendi : " & yetkiAd)
    hatamesaj = translate("Yetki Güncellendi","","")
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")

%><!--#include virtual="/reg/rs.asp" -->