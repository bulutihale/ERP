<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    call sessiontest()
    kid         =	kidbul()
    hata        =   ""
    modulAd =   "Personel"
    call logla("Personel Grup Bilgileri Yetki İşlemi")
    yetkiPersonel = yetkibul("Personel")
    Response.Flush()
'###### ANA TANIMLAMALAR


'##### GELEN DATA
	personelGrupID	=	Request.Form("personelGrupID")
	gorevID			=	Request.Form("gorevID")
	islem			=	Request.Form("islem")
'##### GELEN DATA


'##### HÜCRE EDIT
	if islem = "false" then
		sorgu = "delete personel.personelGrupIndex WHERE personelGrupID = " & personelGrupID & " and personelID = " & gorevID
		rs.open sorgu, sbsv5,3,3
	else
		sorgu = "insert into personel.personelGrupIndex (personelGrupID,personelID) values (" & personelGrupID & "," & gorevID & ")"
		rs.open sorgu, sbsv5,3,3
	end if
'##### HÜCRE EDIT 

%><!--#include virtual="/reg/rs.asp" -->