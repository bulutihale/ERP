<!--#include virtual="/reg/rs.asp" --><%

Response.End()



'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    Response.Flush()
    sablonID64 = Request.QueryString("sablonID")
    islem = Request.QueryString("islem")
'###### ANA TANIMLAMALAR


'##### HATA ÖNLEME
    if sablonID64 = "" then
        hatamesaj = "Şablon bilgisi alınamadı. Lütfen yeniden deneyin!"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
'##### HATA ÖNLEME

'##### ID ÇÖZ
    if hata = "" then
        sablonID = base64_decode_tr(sablonID64)
    end if
'##### ID ÇÖZ



      sorgu = "Select top 1 silindi from toplumail.sablon where sablonID = " & sablonID
      rs.open sorgu,sbsv5,1,3
      if rs.recordcount > 0 then
        if islem = "onay" then
            hatamesaj = "Şablon Onaylandı"
            call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-success","","","","","")
        elseif islem = "red" then
            hatamesaj = "Şablon Reddedildi"
            call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        elseif islem = "sil" then
            rs("silindi") = 1
            hatamesaj = "Şablon Silindi"
            call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        end if
        rs.update
        hatamesaj = hatamesaj & " : " & sablonID
        call logla(hatamesaj)
      else
        hatamesaj = "Şablon bilgisi alınamadı. Lütfen yeniden deneyin!"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
      end if
      rs.close

call jsac("/toplumail/sablon.asp")

%><!--#include virtual="/reg/rs.asp" -->