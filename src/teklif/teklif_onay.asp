<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
    teklifID64 = Request.QueryString("teklifID")
    islem = Request.QueryString("islem")
'###### ANA TANIMLAMALAR


'##### HATA ÖNLEME
    if teklifID64 = "" then
        hatamesaj = "Teklif bilgisi alınamadı. Lütfen yeniden deneyin!"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
'##### HATA ÖNLEME

'##### ID ÇÖZ
    if hata = "" then
        teklifID = base64_decode_tr(teklifID64)
    end if
'##### ID ÇÖZ



      sorgu = "Select top 1 teklifSonuc,silindi from teklif.teklif where teklifID = " & teklifID
      rs.open sorgu,sbsv5,1,3
      if rs.recordcount > 0 then
        if islem = "onay" then
            rs("teklifSonuc") = 1
            hatamesaj = "Teklif Onaylandı"
            call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-success","","","","","")
        elseif islem = "red" then
            rs("teklifSonuc") = 2
            hatamesaj = "Teklif Reddedildi"
            call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        elseif islem = "sil" then
            rs("teklifSonuc") = 3
            rs("silindi") = 1
            hatamesaj = "Teklif Silindi"
            call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        end if
        rs.update
        hatamesaj = hatamesaj & " : " & teklifID
        call logla(hatamesaj)
      else
        hatamesaj = "Teklif bilgisi alınamadı. Lütfen yeniden deneyin!"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
      end if
      rs.close

call jsac("/teklif/teklif_liste.asp")

%><!--#include virtual="/reg/rs.asp" -->