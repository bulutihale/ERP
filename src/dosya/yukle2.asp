<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ' modul	=	Request.QueryString("modul")
    ' gorevID =   Request.QueryString("gorevID")
    hata    =   ""
    modulAd =   "Dosya"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	Set Upload		=	Server.CreateObject("Persits.Upload")
	Upload.CodePage	=	65001
	Upload.SetMaxSize 10000000, True'10.000.000 byte = 10.000 kb = 10 mb
	Upload.Save
	Set dosya = Upload.Files("resim")

	dosyaAciklama		=	Upload.Form("aciklama")
	modul				=	Upload.Form("modul")
	gorevID				=	Upload.Form("gorevID")
    modulID             =   gorevID


	If Not Upload.Files("resim") Is Nothing Then
		dosyavar = True
        set dosya	=	Upload.Files("resim")
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


if dosyavar = True then
    if modul = "etiket" then
        sorgu = "Select top 1 * from agrobest.etiket where etiketID = " & modulID
        rs.Open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            rs("dosyaSayi") = 1
            rs.update
        end if
        rs.update
        rs.close
    end if
    if modul = "hasta" then
        sorgu = "Select top 1 * from yabancihasta.hasta where hastaID = " & modulID
        rs.Open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            rs("dosyaSayi") = 1
            rs.update
        end if
        rs.update
        rs.close
    end if
end if







if dosyavar = True then
	hatamesaj = translate("Dosya başarıyla yüklendi","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
end if


%><!--#include virtual="/reg/rs.asp" -->