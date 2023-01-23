<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
    teklifStokID        =   Request.Form("teklifStokID")
    teklifID            =   Request.Form("teklifID")
    teklifParaBirimi    =   Request.Form("teklifParaBirimi")
    stokParaBirim       =   Request.Form("stokParaBirim")
    stokAd              =   Request.Form("stokAd")
    stokAciklama        =   Request.Form("stokAciklama")
    stokAdet            =   Request.Form("stokAdet")
    stokBirim           =   Request.Form("stokBirim")
    stokFiyat           =   Request.Form("stokFiyat")
    iskonto1            =   Request.Form("iskonto1")
    iskonto2            =   Request.Form("iskonto2")
    iskonto3            =   Request.Form("iskonto3")
    iskonto4            =   Request.Form("iskonto4")
    dovizKuru           =   Request.Form("dovizKuru")
    stokToplamFiyat     =   Request.Form("stokToplamFiyat")
    stokToplamFiyatTPB  =   Request.Form("stokToplamFiyatTPB")
'###### ANA TANIMLAMALAR


'##### HATA ÖNLEME
    if teklifStokID = "" then
        hatamesaj = "Hatalı Stok!"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    if stokAd = "" or stokAdet = "" or stokFiyat = "" then
        hatamesaj = "Eksik Bilgi! Lütfen formu tam doldurun."
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    if stokAdet = 0 then
        hatamesaj = "Lütfen teklif verilecek adet miktarını yazın"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    if stokFiyat = 0 then
        hatamesaj = "Lütfen teklif verilecek ürüne ait birim fiyatı yazın"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    if stokToplamFiyat = 0 then
        hatamesaj = "Lütfen teklif verilecek ürüne ait fiyatı yazın"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    stokToplamFiyat = Replace(stokToplamFiyat,".",",")
'##### HATA ÖNLEME


'### KAYDET
      sorgu = "Select top 1 * from teklif.teklif_urun"
      rs.open sorgu,sbsv5,1,3
        rs.addnew
          rs("kid")                 =   kid
          rs("firmaID")             =   firmaID
          rs("teklifID")            =   teklifID
          rs("teklifStokID")        =   teklifStokID
          rs("teklifParaBirimi")    =   teklifParaBirimi
          rs("stokAd")              =   stokAd
          rs("stokAciklama")        =   stokAciklama
          rs("stokAdet")            =   stokAdet
          rs("stokBirim")           =   stokBirim
          rs("stokFiyat")           =   stokFiyat
          rs("iskonto1")            =   iskonto1
          rs("iskonto2")            =   iskonto2
          rs("iskonto3")            =   iskonto3
          rs("iskonto4")            =   iskonto4
          rs("stokToplamFiyatOrj")  =   stokToplamFiyat
          rs("stokParaBirim")       =   stokParaBirim
          rs("dovizKuru")           =   dovizKuru
          if stokToplamFiyatTPB = "" then
            rs("stokToplamFiyat")     =   stokToplamFiyat
            rs("stokToplamFiyatTPB")  =   0
          else
            stokToplamFiyatTPB = Replace(stokToplamFiyatTPB,".",",")
            rs("stokToplamFiyat")     =   stokToplamFiyatTPB
            rs("stokToplamFiyatTPB")  =   stokToplamFiyatTPB
          end if
        rs.update
      rs.close
'### KAYDET


if stokToplamFiyatTPB <> "" then
    call logla("Teklife dövizli ürün eklendi : " & stokAd)
else
    call logla("Teklife ürün eklendi : " & stokAd)
end if


call jsrun("$('#teklifUrunListe').load('/teklif/teklif_urun_liste.asp?teklifID=" & teklifID & "');")

call jsrun("modalkapat();")




%><!--#include virtual="/reg/rs.asp" -->