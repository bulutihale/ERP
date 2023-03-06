<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
    teklifTuru        =   Request.QueryString("teklifTuru")
    teklifStokID      =   Request.QueryString("teklifStokID")
    teklifID          =   Request.QueryString("teklifID")
    teklifParaBirimi  =   Request.QueryString("teklifParaBirimi")
    teklifKalemID     =   Request.QueryString("teklifKalemID")
    iskonto1          =   0
    iskonto2          =   0
    iskonto3          =   0
    iskonto4          =   0
    stokAdet          =   1
'###### ANA TANIMLAMALAR


'##### HATA ÖNLEME
  if teklifKalemID = "" then
    if teklifStokID = "" then
        hatamesaj = "Hatalı Stok!"
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
    if teklifParaBirimi = "" then
        hatamesaj = "Lütfen önce teklifin verileceği para birimini seçin!"
        call logla(hatamesaj)
        Response.Write hatamesaj
        Response.End()
    end if
  end if
'##### HATA ÖNLEME





'###### TEKLİF BİLGİLERİNİ AL
        sorgu = "Select top 1 * from teklif.teklif where teklifID = " & teklifID
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount = 1 then
          teklifDili          =   rs("teklifDili")
          teklifParaBirimi    =   rs("teklifParaBirimi")
          teklifTuru          =   rs("teklifTuru")
        end if
        rs.close
'###### TEKLİF BİLGİLERİNİ AL


if teklifKalemID <> "" then
  '###### TEKLİF BİLGİLERİNİ AL
      sorgu = "Select top 1 * from teklif.teklif_urun where teklifKalemID = " & teklifKalemID
      rs.open sorgu,sbsv5,1,3
      if rs.recordcount = 1 then
        teklifStokID      =   rs("teklifStokID")
      end if
      rs.close
  '###### TEKLİF BİLGİLERİNİ AL
end if






'### ÜRÜN BİLGİLERİNİ AL
      sorgu = "Select kdv,stokAd,stokAdEn,stokAciklama,fiyat1,fiyat2,fiyat3,fiyat4,(Select birimTur from portal.birimler where birimID = stok.stok.anaBirimID) as birimTur,paraBirimID from stok.stok where silindi = 0 and stokID = " & teklifStokID
      rs.open sorgu,sbsv5,1,3
      if rs.recordcount > 0 then
          stokkdv =   rs("kdv")
          stokAd  =   rs("stokAd")
          stokAdEn  =   rs("stokAdEn")
          stokFiyat = rs("fiyat1")
          fiyat1  =   rs("fiyat1")
          fiyat2  =   rs("fiyat2")
          fiyat3  =   rs("fiyat3")
          fiyat4  =   rs("fiyat4")
          paraBirimID  =   rs("paraBirimID")
          birimTur  = rs("birimTur") & ""
          stokAciklama  = rs("stokAciklama") & ""
          stokToplamFiyat = stokFiyat
      else
          hatamesaj = "Hatalı Stok"
          call logla(hatamesaj)
          call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
          Response.End()
      end if
      rs.close
'### ÜRÜN BİLGİLERİNİ AL


if teklifKalemID = "" then
  call logla("Teklife ürün ekleniyor : " & stokAd)
else
  call logla("Teklifdeki ürün güncelleniyor : " & stokAd)
end if

  '### ECNEBİCE
      if teklifDili = "en" then
          stokAd = stokAdEn
      end if
  '### ECNEBİCE













'#### TEKLİF TÜRÜNE GÖRE HESAPLAMA
  if teklifTuru = 2 then
    stokFiyat = stokFiyat / (1+(stokkdv/100))
    fiyat1 = fiyat1 / (1+(stokkdv/100))
    fiyat2 = fiyat2 / (1+(stokkdv/100))

    stokFiyat = formatnumber(stokFiyat,4)
    fiyat1 = formatnumber(fiyat1,4)
    fiyat2 = formatnumber(fiyat2,4)
  end if
'#### TEKLİF TÜRÜNE GÖRE HESAPLAMA


'### BİRİMLERİ BUL
    if birimTur <> "" then
      sorgu = "Select birimID,uzunBirim from portal.birimler where silindi = 0 and birimTur = '" & birimTur & "' order by sira asc"
      rs.open sorgu,sbsv5,1,3
      if rs.recordcount > 0 then
        birimDegerler = ""
        for i = 1 to rs.recordcount
          birimID   =   rs("birimID")
          uzunBirim =   rs("uzunBirim")
          birimDegerler = birimDegerler & uzunBirim & "=" & birimID & "|"
          rs.movenext
        next
        birimDegerler = left(birimDegerler,len(birimDegerler)-1)
      end if
      rs.close
    end if
    '#### PARA BİRİMİNİ AYARLA
      if paraBirimID <> "" then
        sorgu = "Select TOP 1 uzunBirim from portal.birimler where silindi = 0 and birimID = " & paraBirimID
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount > 0 then
            stokParaBirim =   rs("uzunBirim")
        end if
        rs.close
      end if
    '#### PARA BİRİMİNİ AYARLA
'### BİRİMLERİ BUL


'###### PARA BİRİMİNİ TESBİT ET
  if teklifParaBirimi <> stokParaBirim then
    Response.Write "<div class=""text-center h3 mt-2 mb-3"">Teklif para birimi (" & teklifParaBirimi & ") ile stok para birimi (" & stokParaBirim & ") farklılar</div>"
    '### STOK PARA BİRİMİNİ DÖNÜŞTÜR
      if teklifParaBirimi = "TRY" then
        hesaplanacakParaBirimi = stokParaBirim & teklifParaBirimi
      else
        hesaplanacakParaBirimi = teklifParaBirimi & stokParaBirim
      end if
    '### STOK PARA BİRİMİNİ DÖNÜŞTÜR
  else
      hesaplanacakParaBirimi = ""
  end if
'###### PARA BİRİMİNİ TESBİT ET



'### DÖVİZ KONUSU 
  if hesaplanacakParaBirimi <> "" then
    if instr(hesaplanacakParaBirimi,"TRY") > 0 then
      '## içinde TL geçen çevrimler
        sorgu = "Select " & hesaplanacakParaBirimi & "," & hesaplanacakParaBirimi & "Custom from portal.doviz where firmaID = " & firmaID & " order by dovizID desc"
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount > 0 then
            ParaBirim1 =   rs(0)
            ParaBirim2 =   rs(1)
            if ParaBirim2 = 0 then
              paraBirimSonuc = ParaBirim1
            else
              paraBirimSonuc = ParaBirim2
            end if
            '## TL Dönüşümü
              if stokParaBirim = "TRY" then
                paraBirimSonuc = 1 / paraBirimSonuc
                paraBirimSonuc = formatnumber(paraBirimSonuc,7)
              end if
            '## TL Dönüşümü
            stokToplamFiyatTPB = paraBirimSonuc * stokFiyat
            dovizKuru = paraBirimSonuc
            paraBirimSonuc = replace(paraBirimSonuc,",",".")
        end if
        rs.close
      '## içinde TL geçen çevrimler
    elseif instr(hesaplanacakParaBirimi,"EUR") > 0 and instr(hesaplanacakParaBirimi,"USD") > 0 then
      '## eur/usd
        sorgu = "Select usdtry,usdtryCustom,eurtry,eurtryCustom from portal.doviz where firmaID = " & firmaID & " order by dovizID desc"
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount > 0 then
            usd1 =   rs(0)
            usd2 =   rs(1)
            if usd2 = 0 then
              usdsonuc = usd1
            else
              usdsonuc = usd2
            end if
            eur1 =   rs(2)
            eur2 =   rs(3)
            if eur2 = 0 then
              eursonuc = eur1
            else
              eursonuc = eur2
            end if
            if teklifParaBirimi = "EUR" then
              paraBirimSonuc = usdsonuc / eursonuc
            else
              paraBirimSonuc = eursonuc / usdsonuc
            end if
            stokToplamFiyatTPB = paraBirimSonuc * stokFiyat
            dovizKuru = paraBirimSonuc
            paraBirimSonuc = replace(paraBirimSonuc,",",".")
        end if
        rs.close
      '## eur/usd
    end if
  end if
  if dovizKuru = "" then
    dovizKuru = 1
  end if
'### DÖVİZ KONUSU






if teklifKalemID <> "" then
  '###### TEKLİF BİLGİLERİNİ AL
      sorgu = "Select top 1 * from teklif.teklif_urun where teklifKalemID = " & teklifKalemID
      rs.open sorgu,sbsv5,1,3
      if rs.recordcount = 1 then
        iskonto1          =   rs("iskonto1")
        iskonto2          =   rs("iskonto2")
        iskonto3          =   rs("iskonto3")
        iskonto4          =   rs("iskonto4")
        stokAdet          =   rs("stokAdet")
        stokBirim         =   rs("stokBirim")
        stokAciklama      =   rs("stokAciklama") & ""
        stokAd            =   rs("stokAd")
        stokFiyat         =   rs("stokFiyat")
        stokToplamFiyat   =   rs("stokToplamFiyatOrj")
      end if
      rs.close
  '###### TEKLİF BİLGİLERİNİ AL
end if











'### ANA FORM
  Response.Write "<form id=""teklifUrunModal"" class=""ajaxform"" method=""post"" action=""/teklif/teklif_urun_modal_kaydet.asp"">"
    Response.Write "<input type=""hidden"" value=""" & teklifID & """ name=""teklifID"" />"
    Response.Write "<input type=""hidden"" value=""" & teklifStokID & """ name=""teklifStokID"" />"
    Response.Write "<input type=""hidden"" value=""" & teklifParaBirimi & """ name=""teklifParaBirimi"" />"
    Response.Write "<input type=""hidden"" value=""" & stokParaBirim & """ name=""stokParaBirim"" />"
    Response.Write "<input type=""hidden"" value=""" & dovizKuru & """ name=""dovizKuru"" />"
    Response.Write "<input type=""hidden"" value=""" & teklifTuru & """ name=""teklifTuru"" />"
    Response.Write "<input type=""hidden"" value=""" & stokkdv & """ name=""stokkdv"" />"
    Response.Write "<table width=""100%"" border=""0"" cellspacing=""1"" cellpadding=""1"">"
    'Stok Ad
      Response.Write "<tr><td width=""100"">Ürün Adı</td><td colspan=""" & sb_TeklifFiyatSayi+1 & """>"
      call forminput("stokAd",stokAd,"","","stokAd mb-2","autocompleteOFF","stokAd","")
      Response.Write "</td></tr>"
    'Stok Ad
    'Stok Açıklama
      Response.Write "<tr><td width=""100"">Ürün Notu</td><td colspan=""" & sb_TeklifFiyatSayi+1 & """>"
      call formtextarea("stokAciklama",stokAciklama,"","","stokAciklama mb-2 height-100","autocompleteOFF","stokAciklama","")
      Response.Write "</td></tr>"
    'Stok Açıklama
    'Adet
      Response.Write "<tr>"
        Response.Write "<td>Adet</td>"
        Response.Write "<td>"
          call forminput("stokAdet",stokAdet,"numara(this,true,false);fiyathesapla();","","stokAdet mb-2 pr-2","autocompleteOFF","stokAdet","")
        Response.Write "</td>"
      Response.Write "</tr>"
    'Adet
    'Birim
      Response.Write "<tr>"
        Response.Write "<td>Birim</td>"
        Response.Write "<td>"
          call formselectv2("stokBirim",stokBirim,"fiyathesapla();","","mb-2","","stokBirim",birimDegerler,"")
        Response.Write "</td>"
      Response.Write "</tr>"
    'Birim
    'Fiyatlar
      Response.Write "<tr>"
          Response.Write "<td>Birim Fiyat</td>"
        '### fiyat
          Response.Write "<td class=""pr-2"">"
          Response.Write "<div class=""badge badge-danger"">" & sb_TeklifFiyatAd0
          if teklifTuru = 2 then
            Response.Write " KDV Hariç"
          end if
          Response.Write "</div>"
          stokFiyat = replace(stokFiyat,",",".")
          call forminput("stokFiyat",stokFiyat,"numara(this,true,false);fiyathesapla();","","stokFiyat mb-2","autocompleteOFF","stokFiyat","")
          Response.Write "</td>"
        '### fiyat
          if sb_TeklifFiyatSayi > 0 then
            Response.Write "<td class=""pr-2"">"
            Response.Write "<div class=""badge badge-warning"">" & sb_TeklifFiyatAd1 & "</div>"
            fiyat1 = replace(fiyat1,",",".")
            call forminput("fiyat1",fiyat1,"$('#stokFiyat').val(this.value);fiyathesapla();","","fiyat1 parmak","readonly","fiyat1","")
            Response.Write "</td>"
          end if
        '### fiyat
          if sb_TeklifFiyatSayi > 1 then
            Response.Write "<td class=""pr-2"">"
              Response.Write "<div class=""badge badge-warning"">" & sb_TeklifFiyatAd2 & "</div>"
              fiyat2 = replace(fiyat2,",",".")
              call forminput("fiyat2",fiyat2,"$('#stokFiyat').val(this.value);fiyathesapla();","","fiyat2 parmak","readonly","fiyat2","")
            Response.Write "</td>"
          end if
        '### fiyat
          if sb_TeklifFiyatSayi > 2 then
            Response.Write "<td class=""pr-2"">"
              Response.Write "<div class=""badge badge-warning"">" & sb_TeklifFiyatAd3 & "</div>"
              fiyat3 = replace(fiyat3,",",".")
              call forminput("fiyat3",fiyat3,"$('#stokFiyat').val(this.value);fiyathesapla();","","fiyat3 parmak","readonly","fiyat3","")
            Response.Write "</td>"
          end if
        '### fiyat
          if sb_TeklifFiyatSayi > 3 then
            Response.Write "<td>"
              Response.Write "<div class=""badge badge-warning"">" & sb_TeklifFiyatAd4 & "</div>"
              fiyat4 = replace(fiyat4,",",".")
              call forminput("fiyat4",fiyat4,"$('#stokFiyat').val(this.value);fiyathesapla();","","fiyat4 parmak","readonly","fiyat4","")
            Response.Write "</td>"
          end if
      Response.Write "</tr>"
    'Fiyatlar
    'iskonto
      Response.Write "<tr>"
            Response.Write "<td>İskonto</td>"
            'iskonto
              if sb_TeklifIskontoSayisi > 0 then
                  Response.Write "<td class=""pr-2"">"
                  Response.Write "<div class=""badge badge-secondary"">İskonto 1 % [<span class=""iskontospan1"">" & formatnumber(stokFiyat,2) & "</span>]</div>"
                  call forminput("iskonto1",iskonto1,"numara(this,false,'yok');fiyathesapla();","iskonto1","","","iskonto1","")
                  Response.Write "</td>"
              end if
              if sb_TeklifIskontoSayisi > 1 then
                  Response.Write "<td class=""pr-2"">"
                  Response.Write "<div class=""badge badge-secondary"">İskonto 2 % [<span class=""iskontospan2"">" & formatnumber(stokFiyat,2) & "</span>]</div>"
                  call forminput("iskonto2",iskonto2,"numara(this,false,'yok');fiyathesapla();","iskonto2","","","iskonto2","")
                  Response.Write "</td>"
              end if
              if sb_TeklifIskontoSayisi > 2 then
                  Response.Write "<td class=""pr-2"">"
                  Response.Write "<div class=""badge badge-secondary"">İskonto 3 % [<span class=""iskontospan3"">" & formatnumber(stokFiyat,2) & "</span>]</div>"
                  call forminput("iskonto3",iskonto3,"numara(this,false,'yok');fiyathesapla();","iskonto3","","","iskonto3","")
                  Response.Write "</td>"
              end if
              if sb_TeklifIskontoSayisi > 3 then
                  Response.Write "<td class=""pr-2"">"
                  Response.Write "<div class=""badge badge-secondary"">İskonto 4 % [<span class=""iskontospan4"">" & formatnumber(stokFiyat,2) & "</span>]</div>"
                  call forminput("iskonto4",iskonto4,"numara(this,false,'yok');fiyathesapla();","iskonto4","","","iskonto4","")
                  Response.Write "</td>"
              end if
            'iskonto
      Response.Write "</tr>"
    'iskonto
    'Toplam Fiyat stokParaBirim
      Response.Write "<tr>"
        Response.Write "<td>Toplam Fiyat</td>"
        Response.Write "<td>"
          Response.Write "<div class=""input-group mt-2"">"
            call forminput("stokToplamFiyat",stokToplamFiyat,"","","","","stokToplamFiyat","")
            Response.Write "<div class=""input-group-append"">"
              Response.Write "<span class=""input-group-text pt-2 pb-2"" style="""">" & stokParaBirim & "</span>"
            Response.Write "</div>"
          Response.Write "</div>"
        Response.Write "</td>"
      Response.Write "</tr>"
    'Toplam Fiyat stokParaBirim
    if hesaplanacakParaBirimi <> "" then
    'Toplam Fiyat teklifParaBirimi
      Response.Write "<tr>"
        Response.Write "<td>Toplam Fiyat</td>"
        Response.Write "<td>"
          Response.Write "<div class=""input-group mt-2"">"
            call forminput("stokToplamFiyatTPB",stokToplamFiyatTPB,"","","border-danger","","stokToplamFiyatTPB","")
            Response.Write "<div class=""input-group-append"">"
              Response.Write "<span class=""input-group-text pt-2 pb-2 border-danger"" style="""">" & teklifParaBirimi & "</span>"
            Response.Write "</div>"
          Response.Write "</div>"
        Response.Write "</td>"
      Response.Write "</tr>"
    'Toplam Fiyat teklifParaBirimi
    end if
    Response.Write "</table>"
    'kaydet butonu
        Response.Write "<div class=""col-lg-12 col-xs-12 mt-3"">"
        Response.Write "<div class=""badge"">&nbsp;</div>"
        Response.Write "<button type=""submit"" class=""btn btn-success form-control"">EKLE</button>"
        Response.Write "</div>"
    'kaydet butonu
  Response.Write "</form>"
'### ANA FORM


Response.Write "<scr" & "ipt>"
  Response.Write "function fiyathesapla() {"
    Response.Write "stokAdet = $('#stokAdet').val();"
    Response.Write "stokAdet = parseInt(stokAdet);"
    Response.Write "stokFiyat = $('#stokFiyat').val();"
    Response.Write "toplamfiyat =stokFiyat * stokAdet;"
    ' Response.Write "toplamfiyat = new Intl.NumberFormat('en-IN', { maximumSignificantDigits: 3 }).format(toplamfiyat);"
    if sb_TeklifIskontoSayisi > 0 then
      Response.Write "iskonto1 = $('#iskonto1').val();"
      Response.Write "iskonto1 = (parseInt(iskonto1) / 100);"
      Response.Write "iskonto1 = toplamfiyat * iskonto1;"
      Response.Write "iskontoHesap1 = toplamfiyat - iskonto1;"
      Response.Write "iskontoHesap1 = parseFloat(iskontoHesap1).toFixed(4);"
      Response.Write "$('.iskontospan1').text(iskontoHesap1);"
      Response.Write "toplamfiyat = iskontoHesap1;"
    end if
    if sb_TeklifIskontoSayisi > 1 then
      Response.Write "iskonto2 = $('#iskonto2').val();"
      Response.Write "iskonto2 = (parseInt(iskonto2) / 100);"
      Response.Write "iskonto2 = toplamfiyat * iskonto2;"
      Response.Write "iskontoHesap2 = toplamfiyat - iskonto2;"
      Response.Write "iskontoHesap2 = parseFloat(iskontoHesap2).toFixed(4);"
      Response.Write "$('.iskontospan2').text(iskontoHesap2);"
      Response.Write "toplamfiyat = iskontoHesap2;"
    end if
    if sb_TeklifIskontoSayisi > 2 then
      Response.Write "iskonto3 = $('#iskonto3').val();"
      Response.Write "iskonto3 = (parseInt(iskonto3) / 100);"
      Response.Write "iskonto3 = toplamfiyat * iskonto3;"
      Response.Write "iskontoHesap3 = toplamfiyat - iskonto3;"
      Response.Write "iskontoHesap3 = parseFloat(iskontoHesap3).toFixed(4);"
      Response.Write "$('.iskontospan3').text(iskontoHesap3);"
      Response.Write "toplamfiyat = iskontoHesap3;"
    end if
    if sb_TeklifIskontoSayisi > 3 then
      Response.Write "iskonto4 = $('#iskonto4').val();"
      Response.Write "iskonto4 = (parseInt(iskonto4) / 100);"
      Response.Write "iskonto4 = toplamfiyat * iskonto4;"
      Response.Write "iskontoHesap4 = toplamfiyat - iskonto4;"
      Response.Write "iskontoHesap4 = parseFloat(iskontoHesap4).toFixed(4);"
      Response.Write "$('.iskontospan4').text(iskontoHesap4);"
      Response.Write "toplamfiyat = iskontoHesap4;"
    end if
    Response.Write "$('#stokToplamFiyat').val(toplamfiyat);"
    if hesaplanacakParaBirimi <> "" then
        Response.Write "pbhesap = (toplamfiyat*" & paraBirimSonuc & ");"
      Response.Write "$('#stokToplamFiyatTPB').val(pbhesap);"
    end if
  Response.Write "}"
Response.Write "</scr" & "ipt>"

if teklifKalemID = "" then
  call jsrun("fiyathesapla();")
end if

%><!--#include virtual="/reg/rs.asp" -->