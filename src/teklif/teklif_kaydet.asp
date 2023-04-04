<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
    teklifID            =   Request.Form("teklifID")
    cariAd              =   Request.Form("cariAd")
    cariID              =   Request.Form("cariID")
    cariKodu            =   Request.Form("cariKodu")
    teklifsayi          =   Request.Form("teklifsayi")
    tekliftarih         =   Request.Form("tekliftarih")
    teklifFirmaId       =   Request.Form("teklifFirmaId")
    teklifTuru          =   Request.Form("teklifTuru")
    teklifDili          =   Request.Form("teklifDili")
    teklifParaBirimi    =   Request.Form("teklifParaBirimi")
    onUstYazi           =   Request.Form("onUstYazi")
    ustyazi             =   Request.Form("ustyazi")
    ozelNot             =   Request.Form("ozelNot")
    ozelkosultur1       =   Request.Form("ozelkosultur1")
    ozelkosulicerik1    =   Request.Form("ozelkosulicerik1")
    onAltYazi           =   Request.Form("onAltYazi")
    kosul5              =   Request.Form("kosul5")
    altYazi             =   Request.Form("altYazi")
    teklifKosul         =   Request.Form("kosul")
    urunKatalogKodu       =   Request.Form("urunKatalogKodu")
    urunStokRefKodu       =   Request.Form("urunStokRefKodu")
'###### ANA TANIMLAMALAR


'##### HATA ÖNLEME
    if teklifID = "" then
        hatamesaj = translate("Hatalı Teklif! Devam Edilemez","","")
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    if teklifParaBirimi = "" then
        hatamesaj = translate("Lütfen para birimini seçin.","","")
        call logla(hatamesaj)
        call focusinput("teklifParaBirimi")
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    if teklifTuru = "" then
        hatamesaj = translate("Lütfen teklif türünü seçin","","")
        call logla(hatamesaj)
        call focusinput("teklifTuru")
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    if cariAd = "" then
        hatamesaj = translate("Lütfen teklif verdiğiniz firma adını yazın veya cari seçin","","")
        call logla(hatamesaj)
        call focusinput("cariAd")
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    if urunKatalogKodu = "" then
      urunKatalogKodu = 0
    end if
    if urunStokRefKodu = "" then
      urunStokRefKodu = 0
    end if
'##### HATA ÖNLEME



'##### teklifsayi
  if teklifsayi = "" then
      sorgu = "Select top 1 teklifsayi from teklif.teklif where firmaID = " & firmaID & " and silindi = 0 and teklifsayi like '" & sb_TeklifSayiFormatOn & "%' and teklifID <> " & teklifID & " order by teklifID desc"
      rs.open sorgu,sbsv5,1,3
      if rs.recordcount > 0 then
        sonteklifsayi = Replace(rs("teklifsayi"),sb_TeklifSayiFormatOn,"")
        yeniTeklifSayi = sonteklifsayi + 1
        yeniTeklifSayi = sb_TeklifSayiFormatOn & right("00000" & yeniTeklifSayi,sb_TeklifSayiFormatRakam)
      else
        yeniTeklifSayi = sb_TeklifSayiFormatOn & right("000001",sb_TeklifSayiFormatRakam)
      end if
      rs.close
      teklifsayi = yeniTeklifSayi
  end if
'##### teklifsayi


'### KAYDET
      sorgu = "Select top 1 * from teklif.teklif where teklifID = " & teklifID
      rs.open sorgu,sbsv5,1,3
          teklifsayi1               =   rs("teklifsayi") & ""
          if teklifsayi1 = "" then
            rs("teklifParaBirimi")    =   teklifParaBirimi
          else
            teklifParaBirimi1 = rs("teklifParaBirimi")
            if teklifParaBirimi1 = teklifParaBirimi then
            else
              hatamesaj = translate("Teklife ait para birimini sonradan değiştiremezsiniz.","","")
              call logla(hatamesaj)
              call focusinput("cariAd")
              call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
              Response.End()
            end if
          end if
          rs("kid")                 =   kid
          rs("firmaID")             =   firmaID
          rs("cariAd")              =   cariAd
          rs("cariKodu")            =   cariKodu
          rs("teklifsayi")          =   teklifsayi
          rs("tekliftarih")         =   tekliftarih
          rs("teklifFirmaId")       =   teklifFirmaId
          rs("teklifTuru")          =   teklifTuru
          rs("teklifDili")          =   teklifDili
          rs("onUstYazi")           =   onUstYazi
          rs("ustyazi")             =   ustyazi
          rs("ozelNot")             =   ozelNot
          rs("ozelkosultur1")       =   ozelkosultur1
          rs("ozelkosulicerik1")    =   ozelkosulicerik1
          rs("onAltYazi")           =   onAltYazi
          rs("altYazi")             =   altYazi
          rs("teklifKosul")         =   teklifKosul
          rs("teklifSonuc")         =   0                 '0 = Teklif verildi Beklemede
          if cariID <> "" then
            rs("cariID")            =   cariID
          end if
          rs("urunKatalogKodu")           =   urunKatalogKodu
          rs("urunStokRefKodu")           =   urunStokRefKodu
        rs.update
      rs.close
'### KAYDET

        hatamesaj = translate("Teklif Kaydedildi","","")
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-success","","","","","")


      jsrun("$('#teklifsayi').val('" & teklifsayi & "');")



  if teklifOlusuncaListeyeDon = "on" then
    call jsgit("/teklif/teklif_liste")
  end if


%><!--#include virtual="/reg/rs.asp" -->