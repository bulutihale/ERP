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
    islem = Request.QueryString("islem")
    formname = Request.Form("formname")
    formicerik = Request.Form("formicerik")
    gorevID = Request.Form("gorevID")
    kosul = Request.Form("kosul")
    icerik = Request.Form("icerik")
'#### gelenler


'##### HATA ÖNLEME
    if (formname = "" or formicerik = "" or gorevID = "") and islem = "" and (kosul = "" or icerik = "") then
        hatamesaj = "Bir hata oluştu. Form verileri alınamadı. Lütfen yeniden deneyin!"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
'##### HATA ÖNLEME


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
        call jsac("/teklif/teklif_ayarlar.asp")
    end if









%><!--#include virtual="/reg/rs.asp" -->