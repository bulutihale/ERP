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
    modulID =   "84"
    personelID =   kid
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Şifre Güncelleniyor")


'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL
    password        =   Request.Form("password")
'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL


'#### VERİ KONTROL
'#### VERİ KONTROL
if password = "" or len(password) < 6 then
	hatamesaj = translate("Lütfen şifrenizi yazın","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if
'#### VERİ KONTROL
'#### VERİ KONTROL


'####### INSERT - UPDATE
'####### INSERT - UPDATE
    sorgu = "Select top 1 * from personel.personel"
    sorgu = sorgu & " where personel.personel.id = " & personelID
	rs.Open sorgu, sbsv5, 1, 3
    password	=	sqltemizle(password)
    rs("password")          =   password
    rs("passwordChangeDate")    =   date()
    rs("passwordChangeFirstLogin") = False
    rs.update
    gorevID = rs("id")
    rs.close
'####### INSERT - UPDATE
'####### INSERT - UPDATE


call logla("Şifre Güncellendi")

call jsgit("/")

%><!--#include virtual="/reg/rs.asp" -->