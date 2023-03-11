<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    modulID =   "137"
    Response.Flush()
    sablonID64 = Request.QueryString("adresGrupID")
    islem = Request.QueryString("islem")
'###### ANA TANIMLAMALAR


'##### HATA ÖNLEME
    if sablonID64 = "" then
        hatamesaj = "Adres grubu bilgisi alınamadı. Lütfen yeniden deneyin!"
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



      sorgu = "Select top 1 silindi from toplumail.adresGrup where adresGrupID = " & sablonID
      rs.open sorgu,sbsv5,1,3
      if rs.recordcount > 0 then
        if islem = "sil" then
            rs("silindi") = 1
            hatamesaj = "Adres Grubu Silindi"
            call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        end if
        rs.update
        hatamesaj = hatamesaj & " : " & sablonID
        call logla(hatamesaj)
      else
        hatamesaj = "Adres grubu bilgisi alınamadı. Lütfen yeniden deneyin!"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
      end if
      rs.close

call jsac("/toplumail/adres.asp")

%><!--#include virtual="/reg/rs.asp" -->