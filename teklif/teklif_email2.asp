<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    modulID =   "109"
    Response.Flush()
    teklifID = Request.Form("teklifID")
'###### ANA TANIMLAMALAR


'##### HATA ÖNLEME
    if teklifID = "" then
        hatamesaj = "Teklif bilgisi alınamadı. Lütfen yeniden deneyin!"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
'##### HATA ÖNLEME




'//FIXME - pdf oluştur

'//FIXME - mail gönder

'//FIXME - teklif durumunu güncelle

'//FIXME - mail gönderilen adresi cariye ait mail adreslerine ekle


        sorgu = "Select top 1 teklifSonuc,silindi,sonucAciklama,sonucTarih from teklif.teklif where teklifID = " & teklifID
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount > 0 then
            rs("teklifSonuc") = 4
            hatamesaj = "Teklifi mail olarak gönderildi"
            call logla(hatamesaj)
            call toastrCagir(hatamesaj, "OK", "right", "success", "otomatik", "")
            rs.update
        end if
        rs.close


call modalkapat()

call jsac("/teklif/teklif_liste.asp")

%><!--#include virtual="/reg/rs.asp" -->