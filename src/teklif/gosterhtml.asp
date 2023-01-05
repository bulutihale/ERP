<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
    teklifID = Request.QueryString("teklifID")
'###### ANA TANIMLAMALAR

'### TEKLİF DATASINI ÇEK
    if teklifID = "" then
        hata = "Teklif PDF oluşturulamıyor. ID boş geldi"
        call logla(hata)
    else
        call logla("Teklif PDF oluşturmaya başlanıyor ID : " & teklifID)
        sorgu = "Select top 1 * from teklif.teklif where teklifID = " & teklifID
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount = 1 then
          cariAd              =   rs("cariAd")
          cariKodu            =   rs("cariKodu")
          teklifsayi          =   rs("teklifsayi")
          tekliftarih         =   rs("tekliftarih")
          teklifFirmaId       =   rs("teklifFirmaId")
          teklifTuru          =   rs("teklifTuru")
          teklifDili          =   rs("teklifDili")
          teklifParaBirimi    =   rs("teklifParaBirimi")
          onUstYazi           =   rs("onUstYazi")
          ustyazi             =   rs("ustyazi")
          ozelNot             =   rs("ozelNot")
          ozelkosultur1       =   rs("ozelkosultur1")
          ozelkosulicerik1    =   rs("ozelkosulicerik1")
          onAltYazi           =   rs("onAltYazi")
          altYazi             =   rs("altYazi")
          teklifKosul         =   rs("teklifKosul")
        else
            hata = "Kritik Hata Oluştu. Bahsi geçen ID ye ait teklif bulunamadı"
            call logla(hata)
        end if
        rs.close
    end if
'### TEKLİF DATASINI ÇEK






'//FIXME - alternatif firmaya göre ayrı teklif formatı getirilecek buradan... sonra ekle


'### RAPOR FORMATINI ÇEK
    if hata = "" then
        sorgu = "Select raporIcerik from rapor.raporFormat where modul = 'Teklif' and firmaID = " & firmaID & " and silindi = 0 order by raporFormatID DESC"
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount = 1 then
            raporIcerik = rs("raporIcerik")
        else
            hata = "Kritik Hata Oluştu. Teklif PDF için uygun rapor formatı bulunamadı"
            call logla(hata)
        end if
        rs.close
    end if
'### RAPOR FORMATINI ÇEK

'### ÜRÜNLERİ ÇEK
'### ÜRÜNLERİ ÇEK







'###### OPERASYON ZAMANI
    call raporHead()
        if hata = "" then
            call raporBody()
        else
            Response.Write hata
        end if
    call raporFoot()
'###### OPERASYON ZAMANI





function raporHead()
    font = "'Open Sans', sans-serif"
    Response.Write "<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Transitional//EN"" ""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"">"
    Response.Write "<html xmlns=""http://www.w3.org/1999/xhtml"">"
    Response.Write "<head>"
    Response.Write "<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" />"
    Response.Write "<meta http-equiv=""Content-Language"" content=""tr"">"
    Response.Write "<meta name=""Language"" CONTENT=""tr"" />"
    Response.Write "<link href=""http://fonts.googleapis.com/css?family=Open+Sans&subset=latin,latin-ext"" rel=""stylesheet"" type=""text/css"">"
    Response.Write "<style type=""text/css"">"
    Response.Write "*{font-family:" & font & ";}body {font-family: " & font & ";font-size:11px;margin-top: 0px;}table {font-family: " & font & ";font-size:11px;}"
    Response.Write "</style>"
    Response.Write "</head>"
    Response.Write "<body>"
end function


function raporFoot()
    Response.Write "</body>"
    Response.Write "</html>"
end function


function raporBody()
    if raporIcerik = "" then
        hata = "Teklif raporu formatu bulunamadı"
        call logla(hata)
    else
        yeniIcerik = raporIcerik
        yeniIcerik = Replace(yeniIcerik,"[cariAd]",cariAd)
        yeniIcerik = Replace(yeniIcerik,"[cariKodu]",cariKodu)
        yeniIcerik = Replace(yeniIcerik,"[teklifsayi]",teklifsayi)
        yeniIcerik = Replace(yeniIcerik,"[tekliftarih]",tekliftarih)
        yeniIcerik = Replace(yeniIcerik,"[teklifTuru]",teklifTuru)
        yeniIcerik = Replace(yeniIcerik,"[teklifDili]",teklifDili)
        yeniIcerik = Replace(yeniIcerik,"[teklifParaBirimi]",teklifParaBirimi)
        yeniIcerik = Replace(yeniIcerik,"[ustyazi]",ustyazi)
        yeniIcerik = Replace(yeniIcerik,"[ozelNot]",ozelNot)
        yeniIcerik = Replace(yeniIcerik,"[ozelkosultur1]",ozelkosultur1)
        yeniIcerik = Replace(yeniIcerik,"[ozelkosulicerik1]",ozelkosulicerik1)
        yeniIcerik = Replace(yeniIcerik,"[altYazi]",altYazi)
        yeniIcerik = Replace(yeniIcerik,"[teklifKosul]",teklifKosul)
    end if


Response.Write yeniIcerik


    '## ALANLAR
        ' [cariAd]
        ' [cariKodu]
        ' [teklifsayi]
        ' [tekliftarih]
        ' [teklifFirmaId]
        ' [teklifTuru]
        ' [teklifDili]
        ' [teklifParaBirimi]
        ' [ustyazi]
        ' [ozelNot]
        ' [ozelkosultur1]
        ' [ozelkosulicerik1]
        ' [altYazi]
        ' [teklifKosul]
        ' [teklifsayi]
        ' [teklifsayi]
    '## ALANLAR
end function




%><!--#include virtual="/reg/rs.asp" -->