<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modul =   "portal.duyuru"
    modulAd = modul
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	Set Upload		=	Server.CreateObject("Persits.Upload")
	Upload.CodePage	=	65001
	Upload.SetMaxSize 10000000, True'10.000.000 byte = 10.000 kb = 10 mb
	Upload.Save
	Set resim1 = Upload.Files("resim1")
	gorevID		=	Upload.Form("gorevID")
	t1		=	Upload.Form("t1")
	t2		=	Upload.Form("t2")
	baslik		=	Upload.Form("baslik")
	durum		=	Upload.Form("durum")
	icerik		=	Upload.Form("icerik")
	tur		=	Upload.Form("tur")


Response.Flush()

yetkiIT = yetkibul("IT")
yetkiPersonel = yetkibul("personel")



if t1 = "" or baslik = "" or durum = "" then
	hatamesaj = "Lütfen eksik alanları doldurun" & icerik
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

call logla("Yeni Duyuru Eklendi")

if yetkiPersonel > 0 or yetkiIT > 0 then
    if gorevID = "" then
        gorevID = 0
    end if
            sorgu = "Select top 1 * from portal.duyuru where duyuruID = " & gorevID
			rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount = 0 then
                rs.addnew
            end if
                rs("t1")       =   t1
                if t2 = "" then
                    rs("t2")    =   null
                else
                    rs("t2")      =  t2
                end if
                rs("durum")      =  durum
                rs("baslik")      =  baslik
                rs("icerik")      =  icerik
                rs("firmaID")        =   firmaID
                rs("kid")    =   kid
                rs("tur")    =   tur
            rs.update
            modulID = rs("duyuruID")
            rs.close



for ri = 1 to 5
	If Not Upload.Files("resim" & ri) Is Nothing Then
		dosyavar = True
        set dosya	=	Upload.Files("resim" & ri)
        dosyaAd     =   dosya.FileName
        dosyaAdArr  =   split(right(dosyaAd,5),".")
        dosyaUzanti =   dosyaAdArr(1)
        ' #### DB KAYDI OLUŞTUR
        ' #### DB KAYDI OLUŞTUR
            sorgu = "Select top 1 * from portal.dosya"
            rs.Open sorgu, sbsv5, 1, 3
            rs.addnew
                rs("dosyaAd")       =   dosyaAd
                rs("dosyaUzanti")   =   dosyaUzanti
                rs("dosyaAciklama") =   dosyaAciklama
                rs("modul")         =   modul
                rs("modulID")       =   modulID
            rs.update
            dosyaID = rs("dosyaID")
            rs.close
        ' #### DB KAYDI OLUŞTUR
        ' #### DB KAYDI OLUŞTUR
		dosyaadres	=	"/temp/dosya/" & dosyaID & "." & dosyaUzanti
		dosya.SaveAs Server.MapPath(dosyaadres)
	End if
	set dosya = Nothing
next








end if

call jsac("/duyuru/duyuru.asp")
modalkapat()


%><!--#include virtual="/reg/rs.asp" -->