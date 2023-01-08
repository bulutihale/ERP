<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
    teklifKalemID        =   Request.QueryString("teklifKalemID")
'###### ANA TANIMLAMALAR


'##### HATA ÖNLEME
    if teklifKalemID = "" then
        hatamesaj = "Hatalı Stok!"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
'##### HATA ÖNLEME


'### KAYDET
      sorgu = "Select top 1 * from teklif.teklif_urun where teklifKalemID = " & teklifKalemID
      rs.open sorgu,sbsv5,1,3
        if rs.recordcount > 0 then
            rs("silindi")   =   1
            teklifID        =   rs("teklifID")
            stokAd          =   rs("stokAd")
            rs.update
        end if
      rs.close
'### KAYDET


  call logla("Teklif içinden ürün silindi : " & stokAd)


call jsrun("$('#teklifUrunListe').load('/teklif/teklif_urun_liste.asp?teklifID=" & teklifID & "');")




%><!--#include virtual="/reg/rs.asp" -->