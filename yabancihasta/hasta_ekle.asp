<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.Form("gorevID")
    hata    =   ""
    modulAd =   "YHBilgiler"
    hastaID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Hasta Bilgileri Güncelleniyor")

yetkiYabanciHasta = yetkibul("yabancihasta")

'###### FORM BİLGİLERİ
'###### FORM BİLGİLERİ
    hastaAd             =   Request.Form("hastaAd")
    hastaTelefon        =   Request.Form("hastaTelefon")
    hastaEmail          =   Request.Form("hastaEmail")
    hastaPasaport       =   Request.Form("hastaPasaport")
    hastaCagriKaynak    =   Request.Form("hastaCagriKaynak")
    hastaAcenta         =   Request.Form("hastaAcenta")
    hastaUlke           =   Request.Form("hastaUlke")
    hastaParaBirim      =   Request.Form("hastaParaBirim")
    hastaNot            =   Request.Form("hastaNot")
    personelOperasyoncuID   =   Request.Form("personelOperasyoncuID")
'###### FORM BİLGİLERİ
'###### FORM BİLGİLERİ


if hastaAd = "" then
	hatamesaj = translate("Lütfen hasta adını yazın","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if hastaTelefon = "" and hastaEmail = "" then
	hatamesaj = translate("Lütfen hasta iletişim bilgilerini yazın","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if hastaAcenta = ""  then
	hatamesaj = translate("Lütfen acenta seçin","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if hastaParaBirim = ""  then
	hatamesaj = translate("Lütfen para birimi seçin","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if hastaCagriKaynak = ""  then
	hatamesaj = translate("Lütfen çağrı kaynağını seçin","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if hastaUlke = ""  then
	hatamesaj = translate("Lütfen hastanın geleceği ülkeyi seçin","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if



'####### INSERT - UPDATE
'####### INSERT - UPDATE
    sorgu = "Select top 1 * from yabancihasta.hasta"
    if gorevID <> "" then
	    sorgu = sorgu & " where yabancihasta.hasta.hastaID = " & gorevID
    end if
	rs.Open sorgu, sbsv5, 1, 3
        if gorevID = "" then
            rs.addnew
            rs("personelSatisciID")     =   kid
        end if
        rs("hastaAd")               =   hastaAd
        rs("hastaTelefon")          =   hastaTelefon
        rs("hastaEmail")            =   hastaEmail
        rs("hastaPasaport")         =   hastaPasaport
        rs("hastaCagriKaynak")      =   hastaCagriKaynak
        rs("hastaAcenta")           =   hastaAcenta
        rs("hastaUlke")             =   hastaUlke
        rs("hastaParaBirim")        =   hastaParaBirim
        rs("tarih")                 =   now()
        rs("firmaID")               =   firmaID
        rs("hastaNot")              =   hastaNot
        if yetkiYabanciHasta >= 7 then
            rs("personelOperasyoncuID") = personelOperasyoncuID
        end if
    rs.update
    gorevID = rs("hastaID")
    rs.close
'####### INSERT - UPDATE
'####### INSERT - UPDATE

call logla("Hasta Bilgileri Güncellendi")

call jsac("/yabancihasta/hasta_liste.asp")
modalkapat()


%><!--#include virtual="/reg/rs.asp" -->