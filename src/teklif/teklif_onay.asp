<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
    teklifID64 = Request.QueryString("teklifID")
    islem = Request.QueryString("islem")
    customformverileri = Request.QueryString("customformverileri")
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




      sorgu = "Select top 1 teklifSonuc,silindi,sonucAciklama,sonucTarih from teklif.teklif where teklifID = " & teklifID
      rs.open sorgu,sbsv5,1,3
      if rs.recordcount > 0 then
        if islem = "0" then
            rs("teklifSonuc") = 0
            hatamesaj = "Teklif hazırlık aşamasında olarak işaretlendi"
            call logla(hatamesaj)
            call toastrCagir(hatamesaj, "OK", "right", "error", "otomatik", "")
        elseif islem = "1" then
            rs("teklifSonuc") = 1
            hatamesaj = "Teklif amir onayına gönderildi"
            call logla(hatamesaj)
            call toastrCagir(hatamesaj, "OK", "right", "success", "otomatik", "")
        elseif islem = "2" then
            rs("teklifSonuc") = 2
            rs("sonucAciklama") =   customformverileri
            hatamesaj = "Teklifi onayladınız"
            call logla(hatamesaj & ". Onay notu : " & customformverileri)
            call toastrCagir(hatamesaj, "OK", "right", "success", "otomatik", "")
        elseif islem = "3" then
            rs("teklifSonuc") = 3
            rs("sonucAciklama") =   customformverileri
            hatamesaj = "Teklifi reddettiniz"
            call logla(hatamesaj & ". Red sebebi : " & customformverileri)
            call toastrCagir(hatamesaj, "OK", "right", "error", "otomatik", "")
        elseif islem = "5" then
            rs("teklifSonuc") = 5
            rs("sonucAciklama") =   customformverileri
            hatamesaj = "Müşteri reddetti"
            call logla(hatamesaj & ". Red sebebi : " & customformverileri)
            call toastrCagir(hatamesaj, "OK", "right", "error", "otomatik", "")
        elseif islem = "6" then
            rs("teklifSonuc") = 6
            rs("sonucAciklama") =   customformverileri
            hatamesaj = "Satış gerçekleşti"
            call logla(hatamesaj & ". Satış notu : " & customformverileri)
            call toastrCagir(hatamesaj, "OK", "right", "success", "otomatik", "")
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