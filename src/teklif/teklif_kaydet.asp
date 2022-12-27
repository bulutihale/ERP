<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
    teklifID            =   Request.Form("teklifID")
    cariAd        =   Request.Form("cariAd")
    cariKodu    =   Request.Form("cariKodu")
    teklifsayi              =   Request.Form("teklifsayi")
    tekliftarih        =   Request.Form("tekliftarih")
    teklifFirmaId            =   Request.Form("teklifFirmaId")
    teklifTuru           =   Request.Form("teklifTuru")
    teklifDili           =   Request.Form("teklifDili")
    teklifParaBirimi            =   Request.Form("teklifParaBirimi")
    onUstYazi            =   Request.Form("onUstYazi")
    ustyazi            =   Request.Form("ustyazi")
    ozelNot            =   Request.Form("ozelNot")
    ozelkosultur1     =   Request.Form("ozelkosultur1")
    ozelkosulicerik1     =   Request.Form("ozelkosulicerik1")
    onAltYazi     =   Request.Form("onAltYazi")
    kosul5     =   Request.Form("kosul5")
    altYazi     =   Request.Form("altYazi")
'###### ANA TANIMLAMALAR


'##### HATA ÖNLEME
    if teklifID = "" then
        hatamesaj = "Hatalı Teklif! Devam Edilemez"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    if teklifParaBirimi = "" then
        hatamesaj = "Lütfen para birimini seçin."
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    ' if stokAdet = 0 then
    '     hatamesaj = "Lütfen teklif verilecek adet miktarını yazın"
    '     call logla(hatamesaj)
    '     call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
    '     Response.End()
    ' end if
    ' if stokFiyat = 0 then
    '     hatamesaj = "Lütfen teklif verilecek ürüne ait birim fiyatı yazın"
    '     call logla(hatamesaj)
    '     call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
    '     Response.End()
    ' end if
    ' if stokToplamFiyat = 0 then
    '     hatamesaj = "Lütfen teklif verilecek ürüne ait fiyatı yazın"
    '     call logla(hatamesaj)
    '     call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
    '     Response.End()
    ' end if
    ' stokToplamFiyat = Replace(stokToplamFiyat,".",",")
'##### HATA ÖNLEME


'### KAYDET
      sorgu = "Select top 1 * from teklif.teklif"
      rs.open sorgu,sbsv5,1,3
        rs.addnew
          rs("kid")                 =   kid
          rs("firmaID")             =   firmaID
          rs("teklifID")            =   teklifID
          rs("cariAd")              =   cariAd
          rs("cariKodu")            =   cariKodu
          rs("teklifsayi")              =   teklifsayi
          rs("tekliftarih")         =   tekliftarih
          rs("teklifFirmaId")            =   teklifFirmaId
          rs("teklifTuru")           =   teklifTuru
          rs("teklifDili")           =   teklifDili
          rs("teklifParaBirimi")           =   teklifParaBirimi
          rs("onUstYazi")           =   onUstYazi
          rs("ustyazi")             =   ustyazi
          rs("ozelNot")             =   ozelNot
          rs("ozelkosultur1")           =   ozelkosultur1
          rs("ozelkosulicerik1")           =   ozelkosulicerik1
          rs("onAltYazi")           =   onAltYazi
          rs("altYazi")             =   altYazi
        rs.update
      rs.close
'### KAYDET


'   call logla("Teklife ürün eklendi : " & stokAd)


' call jsrun("$('#teklifUrunListe').load('/teklif/teklif_urun_liste.asp?teklifID=" & teklifID & "');")

' call jsrun("modalkapat();")




%><!--#include virtual="/reg/rs.asp" -->