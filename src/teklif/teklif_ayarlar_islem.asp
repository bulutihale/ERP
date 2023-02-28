<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
'###### ANA TANIMLAMALAR


'#### gelenler
    teklifID64 = Request.QueryString("gorevID")
    kosul = Request.Form("kosul")
    icerik = Request.Form("icerik")

    islem = Request.QueryString("islem")
    formname = Request.Form("formname")
    formicerik = Request.Form("formicerik")
    gorevID = Request.Form("gorevID")
    formtur = Request.Form("formtur")
    yaziYeri = Request.Form("yaziYeri")
    onYazi = Request.Form("onYazi")
'#### gelenler


'##### HATA ÖNLEME
    if (formname = "" or formicerik = "") and islem = "" and (kosul = "" or icerik = "") and (yaziYeri = "" or onYazi = "") then
        hatamesaj = "1 Bir hata oluştu. Form verileri alınamadı. Lütfen yeniden deneyin!"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    call rqKontrol(formtur,"Bir hata oluştu. Form verileri alınamadı. Lütfen yeniden deneyin!","")
'##### HATA ÖNLEME

if formtur = "teklifKosul" then
    if formname = "kosul" or formname = "icerik" then
      sorgu = "Select " & formname & " from teklif.teklifKosul where teklifKosulID = " & gorevID
      rs.open sorgu,sbsv5,1,3
      if rs.recordcount > 0 then
        rs(formname) = formicerik
        rs.update
      else
        hatamesaj = "Teklif Koşul bilgisi alınamadı. Lütfen yeniden deneyin!"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
      end if
      rs.close
    end if
    if islem = "sil" then
        '##### ID ÇÖZ
            if hata = "" then
                teklifID = base64_decode_tr(teklifID64)
            end if
        '##### ID ÇÖZ
        sorgu = "Select silindi from teklif.teklifKosul where teklifKosulID = " & teklifID
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount > 0 then
            rs("silindi") = 1
            rs.update
            hatamesaj = "Teklif Koşulu Silindi"
            call logla(hatamesaj)
            call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        end if
        rs.close
        call jsac("/teklif/teklif_ayarlar.asp")
    end if
    if kosul <> "" and icerik <> "" then
        sorgu = "Select top 1 * from teklif.teklifKosul"
        rs.open sorgu,sbsv5,1,3
            rs.addnew
            rs("firmaID")   =   firmaID
            rs("kid")   =   kid
            rs("kosul")   =   kosul
            rs("icerik")   =   icerik
        rs.update
        rs.close
        hatamesaj = "Teklif Koşulu Eklendi : " & icerik
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        ' call jsac("/teklif/teklif_ayarlar.asp")
        call jsgit("/teklif/teklif_ayarlar")
    end if
end if






if formtur = "teklifOnYazi" then
    if formname = "yaziYeri" or formname = "onYazi" then
      sorgu = "Select " & formname & " from teklif.teklifOnYazi where onYaziID = " & gorevID
      rs.open sorgu,sbsv5,1,3
      if rs.recordcount > 0 then
        rs(formname) = formicerik
        rs.update
      else
        hatamesaj = "Teklif Ön Yazı bilgisi alınamadı. Lütfen yeniden deneyin!"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
      end if
      rs.close
    end if
    ' if islem = "sil" then
    '     '##### ID ÇÖZ
    '         if hata = "" then
    '             teklifID = base64_decode_tr(teklifID64)
    '         end if
    '     '##### ID ÇÖZ
    '     sorgu = "Select silindi from teklif.teklifOnYazi where onYaziID = " & teklifID
    '     rs.open sorgu,sbsv5,1,3
    '     if rs.recordcount > 0 then
    '         rs("silindi") = 1
    '         rs.update
    '         hatamesaj = "Teklif Koşulu Silindi"
    '         call logla(hatamesaj)
    '         call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
    '     end if
    '     rs.close
    '     call jsac("/teklif/teklif_ayarlar.asp")
    ' end if
    if yaziYeri <> "" and onYazi <> "" then
        sorgu = "Select top 1 * from teklif.teklifOnYazi"
        rs.open sorgu,sbsv5,1,3
            rs.addnew
            rs("firmaID")   =   firmaID
            rs("kid")   =   kid
            rs("yaziYeri")   =   yaziYeri
            rs("onYazi")   =   onYazi
        rs.update
        rs.close
        hatamesaj = "Teklif Ön Yazı Eklendi : " & icerik
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        call jsgit("/teklif/teklif_ayarlar")
    end if
end if








%><!--#include virtual="/reg/rs.asp" -->