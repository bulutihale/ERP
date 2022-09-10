<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.Form("gorevID")
    hastaID =   Request.Form("hastaID")
    hata    =   ""
    modulAd =   "Personel"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Personel Bilgileri Güncelleniyor")

yetkiKontrol = yetkibul(modulAd)
yetkiIT = yetkibul("IT")

'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL
    ad              =   Request.Form("ad")
    ceptelefon      =   Request.Form("ceptelefon")
    password        =   Request.Form("password")
    email           =   Request.Form("email")
    gorev           =   Request.Form("gorev")
    expiration      =   Request.Form("expiration")
'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL


'#### VERİ KONTROL
'#### VERİ KONTROL
if email = "" then
	hatamesaj = "Lütfen email adresini yazın"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if gorevID = "" then
    if yetkiKontrol < 5 then
        hatamesaj = "Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır."
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
end if

if emailkontrol(email) = "hata" then
        hatamesaj = "Hatalı email adresi yazdınız"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
end if
'#### VERİ KONTROL
'#### VERİ KONTROL






'####### INSERT - UPDATE
'####### INSERT - UPDATE
    sorgu = "Select top 1 * from personel.personel"
    if personelID <> "" then
	    sorgu = sorgu & " where personel.personel.id = " & personelID
    end if
	rs.Open sorgu, sbsv5, 1, 3
		if personelID = "" then
            rs.addnew
            SSOID   =   null
            rs("firmaID") = firmaID
        else
            SSOID = rs("SSOID")
        end if
        if yetkiKontrol > 5 or yetkiIT > 5 then
            rs("ad")                =   ad
        end if
        ceptelefon              =   Replace(ceptelefon," ","")
        rs("ceptelefon")        =   ceptelefon
        if isnull(SSOID) = True then
            if password <> "" then
                password	=	sqltemizle(password)
                rs("password")          =   password
                rs("passwordChangeDate")    =   date()
            end if
        end if
        if yetkiKontrol > 5 or yetkiIT > 5 then
            rs("email")          =   email
        end if
        if yetkiKontrol > 5 or yetkiIT > 5 then
            rs("gorev")         =   gorev
        end if
        if expiration = "" then
            rs("expiration") = null
        else
            rs("expiration") = expiration
        end if
    rs.update
    gorevID = rs("id")
    rs.close
'####### INSERT - UPDATE
'####### INSERT - UPDATE

' call jsacmodal("/personel/personel_yeni.asp?gorevID=" & hastaID)

call logla("Personel Bilgileri Güncellendi")


if yetkiKontrol > 5 then
    call jsac("/personel/personel_liste.asp")
    call modalkapat()
else
	hatamesaj = translate("Bilgiler Güncellendi","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
end if

%><!--#include virtual="/reg/rs.asp" -->