<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    modul = modulAd
    Response.Flush()
    gorevID = Request.QueryString("gorevID")
    islem = Request.QueryString("islem")
'###### ANA TANIMLAMALAR

	Set Upload		=	Server.CreateObject("Persits.Upload")
	Upload.CodePage	=	65001
	Upload.SetMaxSize 10000000, True'10.000.000 byte = 10.000 kb = 10 mb
	Upload.Save
	Set resim1      =   Upload.Files("resim1")
	gorevID         =	Upload.Form("gorevID")
	sablonBaslik    =	Upload.Form("sablonBaslik")
	sablonIcerik    =	Upload.Form("sablonIcerik")

    Response.Flush()

yetkiTM = yetkibul(modulAd)

if sablonBaslik = "" or sablonIcerik = "" then
	hatamesaj = "Lütfen eksik alanları doldurun" & icerik
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

call logla("Yeni Şablon Eklendi")

if yetkiTM >= 3 then
    if gorevID = "" then
        gorevID = 0
    end if
    sorgu = "Select top 1 * from toplumail.sablon where sablonID = " & gorevID
    rs.open sorgu, sbsv5, 1, 3
        if rs.recordcount = 0 then
            rs.addnew
        end if
        rs("sablonIcerik")  =   sablonIcerik
        rs("sablonBaslik")  =   sablonBaslik
        rs("kid")           =   kid
        rs("firmaID")       =   firmaID
    rs.update
    sablonID = rs("sablonID")
    modulID = sablonID
    rs.close
end if


if yetkiTM >= 3 then
    for ri = 1 to 1
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

call jsac("/toplumail/sablon.asp")
modalkapat()


%><!--#include virtual="/reg/rs.asp" -->