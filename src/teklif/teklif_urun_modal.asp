﻿<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
    teklifStokID      =   Request.QueryString("teklifStokID")
    teklifID          =   Request.QueryString("teklifID")
    teklifParaBirimi  =   Request.QueryString("teklifParaBirimi")
    iskonto1          =   0
    iskonto2          =   0
    iskonto3          =   0
    iskonto4          =   0
    stokAdet          =   1
'###### ANA TANIMLAMALAR



'##### HATA ÖNLEME
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
'##### HATA ÖNLEME


'### ÜRÜN BİLGİLERİNİ AL
      sorgu = "Select stokAd,stokAciklama,fiyat1,fiyat2,fiyat3,fiyat4,(Select birimTur from portal.birimler where birimID = stok.stok.anaBirimID) as birimTur,paraBirimID from stok.stok where silindi = 0 and stokID = " & teklifStokID
      rs.open sorgu,sbsv5,1,3
      if rs.recordcount > 0 then
          stokAd  =   rs("stokAd")
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

  call logla("Teklife ürün ekleniyor : " & stokAd)

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


if teklifParaBirimi <> stokParaBirim then
  Response.Write "<div class=""text-center h3 mt-2 mb-3"">Teklif para birimi (" & teklifParaBirimi & ") ile stok para birimi (" & stokParaBirim & ") farklılar</div>"

  '### STOK PARA BİRİMİNİ DÖNÜŞTÜR
    hesaplanacakParaBirimi = teklifParaBirimi & stokParaBirim
    Response.Write hesaplanacakParaBirimi
  '### STOK PARA BİRİMİNİ DÖNÜŞTÜR
end if

'### ANA FORM
  Response.Write "<form id=""teklifUrunModal"" class=""ajaxform"" method=""post"" action=""/teklif/teklif_urun_modal_kaydet.asp"">"
    Response.Write "<input type=""hidden"" value=""" & teklifID & """ name=""teklifID"" />"
    Response.Write "<input type=""hidden"" value=""" & teklifStokID & """ name=""teklifStokID"" />"
    Response.Write "<input type=""hidden"" value=""" & teklifParaBirimi & """ name=""teklifParaBirimi"" />"
    Response.Write "<table width=""100%"" border=""0"" cellspacing=""1"" cellpadding=""1"">"
    'Stok Ad
      Response.Write "<tr><td width=""100"">Ürün Adı</td><td colspan=""" & sb_TeklifFiyatSayi+1 & """>"
      call forminput("stokAd",stokAd,"","","stokAd mb-2","autocompleteOFF","stokAd","")
      Response.Write "</td></tr>"
    'Stok Ad
    'Stok Açıklama
      Response.Write "<tr><td width=""100"">Ürün Notu</td><td colspan=""" & sb_TeklifFiyatSayi+1 & """>"
      call forminput("stokAciklama",stokAciklama,"","","stokAciklama mb-2","autocompleteOFF","stokAciklama","")
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
          Response.Write "<div class=""badge badge-danger"">" & sb_TeklifFiyatAd0 & "</div>"
          call forminput("stokFiyat",stokFiyat,"numara(this,true,false);fiyathesapla();","","stokFiyat mb-2","autocompleteOFF","stokFiyat","")
          Response.Write "</td>"
        '### fiyat
          if sb_TeklifFiyatSayi > 0 then
            Response.Write "<td class=""pr-2"">"
            Response.Write "<div class=""badge badge-warning"">" & sb_TeklifFiyatAd1 & "</div>"
            call forminput("fiyat1",fiyat1,"$('#stokFiyat').val(this.value);fiyathesapla();","","fiyat1 parmak","readonly","fiyat1","")
            Response.Write "</td>"
          end if
        '### fiyat
          if sb_TeklifFiyatSayi > 1 then
            Response.Write "<td class=""pr-2"">"
              Response.Write "<div class=""badge badge-warning"">" & sb_TeklifFiyatAd2 & "</div>"
              call forminput("fiyat2",fiyat2,"$('#stokFiyat').val(this.value);fiyathesapla();","","fiyat2 parmak","readonly","fiyat2","")
            Response.Write "</td>"
          end if
        '### fiyat
          if sb_TeklifFiyatSayi > 2 then
            Response.Write "<td class=""pr-2"">"
              Response.Write "<div class=""badge badge-warning"">" & sb_TeklifFiyatAd3 & "</div>"
              call forminput("fiyat3",fiyat3,"$('#stokFiyat').val(this.value);fiyathesapla();","","fiyat3 parmak","readonly","fiyat3","")
            Response.Write "</td>"
          end if
        '### fiyat
          if sb_TeklifFiyatSayi > 3 then
            Response.Write "<td>"
              Response.Write "<div class=""badge badge-warning"">" & sb_TeklifFiyatAd4 & "</div>"
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
    'Toplam Fiyat
      Response.Write "<tr>"
        Response.Write "<td>Toplam Fiyat</td>"
        Response.Write "<td>"
          call forminput("stokToplamFiyat",stokToplamFiyat,"","","mt-2","","stokToplamFiyat","")
        Response.Write "</td>"
      Response.Write "</tr>"
    'Toplam Fiyat
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
      Response.Write "iskontoHesap1 = parseFloat(iskontoHesap1).toFixed(2);"
      Response.Write "$('.iskontospan1').text(iskontoHesap1);"
      Response.Write "toplamfiyat = iskontoHesap1;"
    end if
    if sb_TeklifIskontoSayisi > 1 then
      Response.Write "iskonto2 = $('#iskonto2').val();"
      Response.Write "iskonto2 = (parseInt(iskonto2) / 100);"
      Response.Write "iskonto2 = toplamfiyat * iskonto2;"
      Response.Write "iskontoHesap2 = toplamfiyat - iskonto2;"
      Response.Write "iskontoHesap2 = parseFloat(iskontoHesap2).toFixed(2);"
      Response.Write "$('.iskontospan2').text(iskontoHesap2);"
      Response.Write "toplamfiyat = iskontoHesap2;"
    end if
    if sb_TeklifIskontoSayisi > 2 then
      Response.Write "iskonto3 = $('#iskonto3').val();"
      Response.Write "iskonto3 = (parseInt(iskonto3) / 100);"
      Response.Write "iskonto3 = toplamfiyat * iskonto3;"
      Response.Write "iskontoHesap3 = toplamfiyat - iskonto3;"
      Response.Write "iskontoHesap3 = parseFloat(iskontoHesap3).toFixed(3);"
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
  Response.Write "}"
Response.Write "</scr" & "ipt>"

%><!--#include virtual="/reg/rs.asp" -->