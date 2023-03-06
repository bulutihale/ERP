<!--#include virtual="/reg/rs.asp" --><%


    '## ALANLAR
        ' [cariAd]
        ' [cariKodu]
        ' [cariYetkiliAdSoyad]
        ' [teklifsayi]
        ' [tekliftarih]
        ' [teklifFirmaId]
        ' [teklifTuru]
        ' [teklifDili]
        ' [teklifParaBirimi]
        ' [ustyazi]
        ' [ozelNot]
        ' [ozelkosultur1]
        ' [ozelkosulicerik1]
        ' [altYazi]
        ' [teklifKosul]
        ' [teklifsayi]
        ' [teklifUrunler]
        ' [teklifKosullar]
        ' [logo]
        ' [bankaHesapBilgileri]
        ' [personelAdSoyad]
        ' [personelUnvan]
    '## ALANLAR


'###### ANA TANIMLAMALAR
    ' call sessiontest()
    ' kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
    teklifID = Request.QueryString("teklifID")
'###### ANA TANIMLAMALAR


'### SAYFA ID TESPİT ET
    if teklifID = "" then
        if hata = "" then
            if gorevID = "" then
                gorevID64 = Session("sayfa5")

                if gorevID64 = "" then
                else
                    gorevID		=	gorevID64
                    gorevID		=	base64_decode_tr(gorevID)
                end if
            else
                if isnumeric(gorevID) = False then
                    gorevID		=	base64_decode_tr(gorevID)
                end if
                gorevID		=	int(gorevID)
                gorevID64	=	gorevID
                gorevID64	=	base64_encode_tr(gorevID64)
            end if
        end if
        teklifID = gorevID
    end if
'### SAYFA ID TESPİT ET


'### TEKLİF DATASINI ÇEK
    if teklifID = "" then
        hata = "Teklif PDF oluşturulamıyor. ID boş geldi"
        call logla(hata)
    else
        call logla("Teklif PDF oluşturmaya başlanıyor ID : " & teklifID)
        sorgu = "Select top 1 * from teklif.teklif where teklifID = " & teklifID
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount = 1 then
        cariAd              =   rs("cariAd")
        cariID              =   rs("cariID")
        cariKodu            =   rs("cariKodu")
        cariYetkiliID       =   rs("cariYetkiliID")
        teklifsayi          =   rs("teklifsayi")
        tekliftarih         =   rs("tekliftarih")
        teklifFirmaId         =   rs("teklifFirmaId")
        teklifTuru            =   rs("teklifTuru")
        teklifDili            =   rs("teklifDili")
        teklifParaBirimi      =   rs("teklifParaBirimi")
        onUstYazi             =   rs("onUstYazi")
        ustyazi               =   rs("ustyazi")
        ozelNot               =   rs("ozelNot")
        ozelkosultur1         =   rs("ozelkosultur1")
        ozelkosulicerik1      =   rs("ozelkosulicerik1")
        onAltYazi             =   rs("onAltYazi")
        teklifKosul           =   rs("teklifKosul")
        urunKatalogKodu       =   rs("urunKatalogKodu")
        urunStokRefKodu       =   rs("urunStokRefKodu")
        personelID            =   rs("kid")
        altYazi               =   rs("altYazi") & ""
        altYazi               =   Replace(altYazi,chr(10),"<br />")
        altYazi               =   Replace(altYazi,chr(13),"<br />")



        else
            hata = "Kritik Hata Oluştu. Bahsi geçen ID ye ait teklif bulunamadı"
            call logla(hata)
        end if
        rs.close
    end if
'### TEKLİF DATASINI ÇEK


'### RAPOR FORMATINI ÇEK
    if hata = "" then
        sorgu = "Select raporIcerik, sayfaYonu from rapor.raporFormat where modul = 'Teklif' and modul2 = " & teklifTuru & " and firmaID = " & firmaID & " and silindi = 0 order by raporFormatID DESC"
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount = 1 then
            raporIcerik =   rs("raporIcerik")
            sayfaYonu   =   rs("sayfaYonu")
        else
            hata = "Kritik Hata Oluştu. Teklif PDF için uygun rapor formatı bulunamadı"
            call logla(hata)
        end if
        rs.close
    end if
'### RAPOR FORMATINI ÇEK


'###### OPERASYON ZAMANI
    call raporHead()
        if hata = "" then
            call raporBody(sb_kosulFontSize)
        else
            Response.Write hata
        end if
    call raporFoot()
'###### OPERASYON ZAMANI


function raporHead()
    font = "'Open Sans', sans-serif"
    Response.Write "<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Transitional//EN"" ""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"">"
    Response.Write "<html xmlns=""http://www.w3.org/1999/xhtml"">"
    Response.Write "<head>"
    Response.Write "<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" />"
    Response.Write "<meta http-equiv=""Content-Language"" content=""tr"">"
    Response.Write "<meta name=""Language"" CONTENT=""tr"" />"
    Response.Write "<link href=""http://fonts.googleapis.com/css?family=Open+Sans&subset=latin,latin-ext"" rel=""stylesheet"" type=""text/css"">"
    Response.Write "<style type=""text/css"">"
    Response.Write "*{font-family:" & font & ";}"
    Response.Write "body {font-family: " & font & ";margin-top: 0px;}"
    Response.Write "table {font-family: " & font & ";}"
    if sayfaYonu = "portrait" then 
        a="297mm"
        b="210mm"
    elseif sayfaYonu = "landscape" then
        a="210mm"
        b="297mm"
    end if
    Response.Write "#ortaalan {height:" & a & ";width:" & b & ";margin-left:auto;margin-right:auto;}"
    Response.Write "</style>"
    Response.Write "</head>"
    Response.Write "<body>"
end function



function raporFoot()
    Response.Write "</body>"
    Response.Write "</html>"
end function


function raporBody(sb_kosulFontSize)
    if raporIcerik = "" then
        hata = "Teklif raporu formatı bulunamadı"
        call logla(hata)
    else
        kosulIcerik = ""
        yeniIcerik = raporIcerik
        '## koşul içerikleri
            '## mevcut koşullar
                if isnull(teklifKosul) = False then
                    if teklifKosul <> "" then
                        sorgu = "Select * from teklif.teklifKosul where silindi = 0 and firmaID = " & firmaID & " and silindi = 0 and teklifKosulID in (" & teklifKosul & ") order by kosul ASC"
                        rs.open sorgu,sbsv5,1,3
                        if rs.recordcount > 0 then
                            kosulIcerik = kosulIcerik & "<table width=""100%"" cellspacing=""0"" cellpadding=""2"" border=""0"" style=""border-bottom: 1px solid #000;margin-top:4px;font-size:"&sb_kosulFontSize&""">"
                            kosulIcerik = kosulIcerik & "<tbody>"
                            for i = 1 to rs.recordcount
                                kosul           =   rs("kosul")
                                icerik          =   rs("icerik")
                                kosulIcerik = kosulIcerik & "<tr>"
                                kosulIcerik = kosulIcerik & "<td align=""left"" style=""border-left: 1px solid #000;border-top: 1px solid #000;border-right: 1px solid #000;""><strong>"
                                    kosulIcerik = kosulIcerik & kosul
                                kosulIcerik = kosulIcerik & "</strong></td>"
                                kosulIcerik = kosulIcerik & "<td align=""left"" style=""border-top: 1px solid #000;border-right: 1px solid #000;"">"
                                    kosulIcerik = kosulIcerik & icerik
                                kosulIcerik = kosulIcerik & "</td>"
                                kosulIcerik = kosulIcerik & "</tr>"
                            rs.movenext
                            next
                                if ozelkosultur1 <> "" then
                                    kosulIcerik = kosulIcerik & "<tr>"
                                    kosulIcerik = kosulIcerik & "<td align=""left"" style=""border-left: 1px solid #000;border-top: 1px solid #000;border-right: 1px solid #000;""><strong>"
                                        kosulIcerik = kosulIcerik & ozelkosultur1
                                    kosulIcerik = kosulIcerik & "</strong></td>"
                                    kosulIcerik = kosulIcerik & "<td align=""left"" style=""border-top: 1px solid #000;border-right: 1px solid #000;"">"
                                        kosulIcerik = kosulIcerik & ozelkosulicerik1
                                    kosulIcerik = kosulIcerik & "</td>"
                                    kosulIcerik = kosulIcerik & "</tr>"
                                end if
                            kosulIcerik = kosulIcerik & "</tbody>"
                            kosulIcerik = kosulIcerik & "</table>"
                        end if
                        rs.close
                    end if
                end if
            '## mevcut koşullar
        '## koşul içerikleri

        '### ÜRÜNLERİ ÇEK
            urunListesi = ""
            sorgu = "Select *" & VBCRLF
			sorgu = sorgu & ",(Select kisaBirim from portal.birimler where birimID = teklif.teklif_urun.stokBirim) as birimAd" & VBCRLF
			sorgu = sorgu & ",(Select kdv from stok.stok where stokID = teklif.teklif_urun.teklifStokID) as stokKdv" & VBCRLF
			sorgu = sorgu & ",(Select katalogKodu from stok.stok where stokID = teklif.teklif_urun.teklifStokID) as katalogKodu" & VBCRLF
			sorgu = sorgu & ",(Select cariUrunRef from stok.stokRef where stokID = teklif.teklif_urun.teklifStokID and cariID = " & cariID & ") as cariUrunRef" & VBCRLF
			sorgu = sorgu & ",(Select cariUrunAd from stok.stokRef where stokID = teklif.teklif_urun.teklifStokID and cariID = " & cariID & ") as cariUrunAd" & VBCRLF
			sorgu = sorgu & ",(Select count(stokAciklama) from teklif.teklif_urun where silindi = 0 and teklifID = " & teklifID & " and (stokAciklama is not null or len(stokAciklama) > 10 )) as urunStokDetails" & VBCRLF
			sorgu = sorgu & "from teklif.teklif_urun where silindi = 0 and teklifID = " & teklifID & " order by teklifKalemID ASC" & VBCRLF
            rs.open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
                '## hesaplamaları yap
                    teklifToplam            =   0
                    teklifIskontoToplam     =   0
                    teklifKdv               =   0
                    teklifGenelToplam       =   0
                    urunStokDetails         =   rs("urunStokDetails")
                    rowspansayi             =   0
                '## hesaplamaları yap


                urunListesi = urunListesi & "<div style=""clear:both;"">"
                urunListesi = urunListesi & "<table width=""100%"" cellspacing=""0"" cellpadding=""2"" border=""0"" style=""margin-top:4px;font-size:"&sb_kosulFontSize&""">"
                urunListesi = urunListesi & "<tbody><tr bgcolor=""#CCCCCC"">"
                urunListesi = urunListesi & "<th width="""" height=""22"" valign=""middle"" style=""border: 1px solid #000;border-right:0px;color:White;text-align:center;""><strong>Ürün Adı</strong></th>"
if urunKatalogKodu = 1 then
    urunListesi = urunListesi & "<th width="""" height=""22"" valign=""middle"" style=""border: 1px solid #000;border-right:0px;color:White;text-align:center;""><strong>Katalog Kodu</strong></th>"
    rowspansayi = rowspansayi + 1
end if
if urunStokRefKodu = 1 then
    urunListesi = urunListesi & "<th width="""" height=""22"" valign=""middle"" style=""border: 1px solid #000;border-right:0px;color:White;text-align:center;""><strong>Müşteri Kodu</strong></th>"
    rowspansayi = rowspansayi + 1
end if
if urunStokDetails > 0 then
    urunListesi = urunListesi & "<th width=""20%"" height=""22"" valign=""middle"" style=""border: 1px solid #000;border-right:0px;color:White;text-align:center;""><strong>Detay</strong></th>"
    rowspansayi = rowspansayi + 1
end if
                urunListesi = urunListesi & "<th width=""10%"" height=""22"" valign=""middle"" style=""border: 1px solid #000;border-right:0px;color:White;text-align:center;""><strong>Adet</strong></th>"
                urunListesi = urunListesi & "<th width=""10%"" height=""22"" valign=""middle"" style=""border: 1px solid #000;border-right:0px;color:White;text-align:center;""><strong>Birim Fiyatı</strong></th>"
                urunListesi = urunListesi & "<th width=""10%"" height=""22"" valign=""middle"" style=""border: 1px solid #000;color:White;text-align:center;""><strong>Toplam</strong></th>"
                urunListesi = urunListesi & "</tr>"

				for i = 1 to rs.recordcount
                    '## verileri al
                        teklifStokID        =   rs("teklifStokID")
                        teklifParaBirimi    =   rs("teklifParaBirimi")
                        stokParaBirim       =   rs("stokParaBirim")
                        stokAd              =   rs("stokAd")
                        stokAciklama        =   rs("stokAciklama") & ""
                        stokAciklama        =   Replace(stokAciklama,chr(10),"<br />")
                        stokAciklama        =   Replace(stokAciklama,chr(13),"<br />")
                        stokAdet            =   rs("stokAdet")
                        stokBirim           =   rs("stokBirim")
                        stokFiyat           =   rs("stokFiyat")
                        iskonto1            =   rs("iskonto1")
                        iskonto2            =   rs("iskonto2")
                        iskonto3            =   rs("iskonto3")
                        iskonto4            =   rs("iskonto4")
                        stokToplamFiyat     =   rs("stokToplamFiyat")
                        birimAd             =   rs("birimAd")
                        teklifKalemID       =   rs("teklifKalemID")
                        stokKdv             =   rs("stokKdv")
                        dovizKuru           =   rs("dovizKuru")
                        katalogKodu         =   rs("katalogKodu") & ""
                        cariUrunRef         =   rs("cariUrunRef") & ""

                    '## verileri al



                    '## hesaplamaları yap
                        teklifSatirToplami      =   stokFiyat * stokAdet * dovizKuru
                        teklifToplam            =   teklifToplam + teklifSatirToplami
                        teklifSatirIskonto      =   teklifSatirToplami - stokToplamFiyat
                        teklifIskontoToplam     =   teklifIskontoToplam + teklifSatirIskonto
                        teklifSatirKdv          =   (teklifSatirToplami - teklifSatirIskonto) - (teklifSatirToplami - teklifSatirIskonto) / (1 + (stokKdv / 100))
                        teklifSatirKdvDahil     =   (teklifSatirToplami - teklifSatirIskonto) / (1 + (stokKdv / 100))
                        teklifKdv               =   teklifKdv + teklifSatirKdv
                        teklifGenelToplam       =   teklifToplam - teklifKdv - teklifIskontoToplam
                    '## hesaplamaları yap

                    '## Ürün listesi
                        urunListesi = urunListesi & "<tr>"
                            urunListesi = urunListesi & "<td width="""" style=""border-left: 1px solid #000;border-bottom: 1px solid #000;"">"
                            ' urunListesi = urunListesi & "<img src=""http://teklif.sbstasarim.com/resim.asp?id=1140"" align=""left"" style=""max-width:50px;max-height:50px;"" width=""50"">"
                            urunListesi = urunListesi & "<strong>" & stokAd & "</strong></td>"
if urunKatalogKodu = 1 then
    urunListesi = urunListesi & "<td style=""border-left: 1px solid #000;border-bottom: 1px solid #000;"">" & katalogKodu & "</td>"
end if
if urunStokRefKodu = 1 then
    urunListesi = urunListesi & "<td style=""border-left: 1px solid #000;border-bottom: 1px solid #000;"">" & cariUrunRef & "</td>"
end if
if urunStokDetails > 0 then
    urunListesi = urunListesi & "<td style=""border-left: 1px solid #000;border-bottom: 1px solid #000;"">" & stokAciklama & "&nbsp;</td>"
end if
                            urunListesi = urunListesi & "<td width="""" align=""center"" valign=""middle"" style=""border: 1px solid #000;border-top:0px;border-bottom:1px solid #000;border-right:0px;"">" & stokAdet & " " & birimAd & "</td>"
                            urunListesi = urunListesi & "<td width="""" align=""right"" valign=""middle"" style=""border: 1px solid #000;border-top:0px;border-bottom:1px solid #000;border-right:0px;"">" & stokFiyat & " " & stokParaBirim & "</td>"
                            urunListesi = urunListesi & "<td width="""" align=""right"" valign=""middle"" style=""border: 1px solid #000;border-top:0px;border-bottom:1px solid #000;"">" & formatnumber(stokToplamFiyat,sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</td>"
                        urunListesi = urunListesi & "</tr>"
                    '## Ürün listesi

				rs.movenext
				next




                if teklifTuru = 1 then
                    urunListesi = urunListesi & "<tr>"
                    urunListesi = urunListesi & "<td width="""" rowspan=""6"" style="""">&nbsp;</td>"
                    urunListesi = urunListesi & "<td colspan=""2"" align=""left"" valign=""middle"" style=""border-left: 1px solid;height:20px;""><b>&nbsp;&nbsp;Toplam</b></td>"
                    urunListesi = urunListesi & "<td width="""" align=""right"" valign=""middle"" style=""border-left: 1px solid;border-right: 1px solid;"">" & formatnumber(teklifToplam,sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</td>"
                    urunListesi = urunListesi & "</tr>"
                end if
                if teklifTuru = 2 then
                    if teklifIskontoToplam <> 0 then
                        trowspansayi = rowspansayi + 1
                        urunListesi = urunListesi & "<tr>"
                        urunListesi = urunListesi & "<td width="""" colspan=""" & trowspansayi & """ rowspan=""2"" style="""">&nbsp;</td>"
                        urunListesi = urunListesi & "<td colspan=""2"" align=""left"" valign=""middle"" style=""border-left: 1px solid;height:20px;""><b>&nbsp;&nbsp;Toplam</b></td>"
                        urunListesi = urunListesi & "<td width="""" align=""right"" valign=""middle"" style=""border-left: 1px solid;border-right: 1px solid;"">" & formatnumber(teklifToplam,sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</td>"
                        urunListesi = urunListesi & "</tr>"
                    end if
                end if
                if teklifTuru = 1 or teklifTuru = 2 then
                    if teklifIskontoToplam <> 0 then
                        urunListesi = urunListesi & "<tr>"
                        urunListesi = urunListesi & "<td colspan=""2"" align=""left"" valign=""middle"" style=""border: 1px solid #000;height:20px;border-bottom:0px;border-right:0px;""><b>&nbsp;&nbsp;</b>Toplam İskonto</td>"
                        urunListesi = urunListesi & "<td align=""right"" valign=""middle"" style=""border: 1px solid #000;border-bottom:0px;"">" & formatnumber(teklifIskontoToplam,sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</td>"
                        urunListesi = urunListesi & "</tr>"
                    end if
                end if
                if teklifTuru = 1 then
                    urunListesi = urunListesi & "<tr>"
                    urunListesi = urunListesi & "<td colspan=""2"" align=""left"" valign=""middle"" style=""border: 1px solid #000;height:20px;border-bottom:0px;border-right:0px;""><b>&nbsp;&nbsp;</b>Ara Toplam</td>"
                    urunListesi = urunListesi & "<td align=""right"" valign=""middle"" style=""border: 1px solid #000;border-bottom:0px;"">" & formatnumber((teklifToplam - teklifIskontoToplam),sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</td>"
                    urunListesi = urunListesi & "</tr>"
                end if
                if teklifTuru = 1 then
                    urunListesi = urunListesi & "<tr>"
                    urunListesi = urunListesi & "<td colspan=""2"" align=""left"" valign=""middle"" style=""border: 1px solid #000;height:20px;border-bottom:0px;border-right:0px;""><b>&nbsp;&nbsp;</b>Toplam Kdv</td>"
                    urunListesi = urunListesi & "<td align=""right"" valign=""middle"" style=""border: 1px solid #000;border-bottom:0px;"">" & formatnumber(teklifKdv,sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</td>"
                    urunListesi = urunListesi & "</tr>"
                end if
                if teklifTuru = 1 then
                    urunListesi = urunListesi & "<tr>"
                    urunListesi = urunListesi & "<td colspan=""2"" align=""left"" valign=""middle"" style=""border: 1px solid #000;height:20px;border-right:0px;""><b>&nbsp;&nbsp;</b><strong>Toplam</strong></td>"
                    urunListesi = urunListesi & "<td align=""right"" valign=""middle"" style=""border: 1px solid #000;""><strong>" & formatnumber(teklifGenelToplam,sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</strong></td>"
                    urunListesi = urunListesi & "</tr>"
                end if
                if teklifTuru = 1 then
                    gtrowspansayi = rowspansayi + 1
                    urunListesi = urunListesi & "<tr>"
                    urunListesi = urunListesi & "<td width="""" rowspan=""6"" style="""">&nbsp;</td>"
                    urunListesi = urunListesi & "<td colspan=""" & gtrowspansayi & """ align=""left"" valign=""middle"" style=""border: 1px solid #000;height:20px;border-right:0px;""><b>&nbsp;&nbsp;</b><strong>Genel Toplam</strong></td>"
                    urunListesi = urunListesi & "<td align=""right"" valign=""middle"" style=""border: 1px solid #000;""><strong>" & formatnumber(teklifGenelToplam+teklifKdv,sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</strong></td>"
                    urunListesi = urunListesi & "</tr>"
                end if
                if teklifTuru = 2 then
                    gtrowspansayi = rowspansayi + 1
                    urunListesi = urunListesi & "<tr>"
                    if teklifIskontoToplam <> 0 then
                        urunListesi = urunListesi & "<td width="""" colspan=""" & gtrowspansayi & """ rowspan=""2"" style="""">&nbsp;</td>"
                    else
                        urunListesi = urunListesi & "<td colspan=""" & gtrowspansayi & """ style="""">&nbsp;</td>"
                    end if
                    urunListesi = urunListesi & "<td colspan=""2"" align=""left"" valign=""middle"" style=""border: 1px solid #000;height:20px;border-right:0px;""><b>&nbsp;&nbsp;</b><strong>Genel Toplam</strong></td>"
                    urunListesi = urunListesi & "<td align=""right"" valign=""middle"" style=""border: 1px solid #000;""><strong>" & formatnumber(teklifGenelToplam+teklifKdv,sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</strong></td>"
                    urunListesi = urunListesi & "</tr>"
                end if
                urunListesi = urunListesi & "</tbody></table>"
                urunListesi = urunListesi & "</div>"
			end if
			rs.close

            'if teklifTuru = 2 then
               ' urunListesi = urunListesi & "<div style=""clear:both;margin-top:4px;text-align:justify;"">*Yukarıdaki fiyatlara KDV ilave edilecektir.</div>"
            'end if
        '### ÜRÜNLERİ ÇEK





        '## BANKA HESAP BİLGİLERİ
' <table width="100%" border="0" cellspacing="1" cellpadding="1" style="border: 1px solid #000;margin-top:4px">
' 	<tbody><tr>
' 		<th bgcolor="#CCCCCC" style="color:White;">Banka</th>
' 		<th bgcolor="#CCCCCC" style="color:White;">Iban</th>
' 	</tr>
	
' 	<tr>
' 		<td align="center">TÜRKİYE İŞ BANKASI</td>
' 		<td align="center">TR89 0006 4000 0013 4940 2025 86
' </td>
' 	</tr>
	
' 	<tr>
' 		<td align="center" style="border-top:1px solid #E8E8E8;">GARANTİ BANKASI</td>
' 		<td align="center" style="border-top:1px solid #E8E8E8;">TR16 0006 2000 3550 0006 2985 17</td>
' 	</tr>
	
' 	<tr>
' 		<td align="center" style="border-top:1px solid #E8E8E8;">AKBANK</td>
' 		<td align="center" style="border-top:1px solid #E8E8E8;">TR45 0004 6006 3488 8000 0210 77
' </td>
' 	</tr>
' </tbody></table>
        '## BANKA HESAP BİLGİLERİ


        '## FİRMA BİLGİLERİ
            sorgu = "Select logo from portal.firma where id = " & teklifFirmaId
            rs.open sorgu,sbsv5,1,3
            if rs.recordcount > 0 then
                firmaLogo = rs("logo")
            end if
            rs.close
        '## FİRMA BİLGİLERİ


        '## PERSONEL AD SOYAD
            sorgu = "Select ad,gorev from personel.personel where id = " & personelID
            rs.open sorgu,sbsv5,1,3
            if rs.recordcount > 0 then
                personelAdSoyad = rs("ad")
                personelUnvan = rs("gorev")
            end if
            rs.close
        '## PERSONEL AD SOYAD


        '## CARİ YETKİLİ
            if isnull(cariYetkiliID) = false then
                sorgu = "Select ad,unvan from cari.cariYetkili where cariYetkiliID = " & cariYetkiliID
                rs.open sorgu,sbsv5,1,3
                if rs.recordcount > 0 then
                    cariYetkiliAdSoyad = rs("ad")
                    cariYetkiliUnvan = rs("unvan")
                end if
                rs.close
            end if
        '## CARİ YETKİLİ


        '## normal text içerikler
            yeniIcerik = Replace(yeniIcerik,"[cariAd]",cariAd)
            yeniIcerik = Replace(yeniIcerik,"[cariKodu]",cariKodu)
            yeniIcerik = Replace(yeniIcerik,"[cariYetkiliAdSoyad]",cariYetkiliAdSoyad)
            yeniIcerik = Replace(yeniIcerik,"[cariYetkiliUnvan]",cariYetkiliUnvan)
            yeniIcerik = Replace(yeniIcerik,"[teklifsayi]",teklifsayi)
            yeniIcerik = Replace(yeniIcerik,"[tekliftarih]",tekliftarih)
            yeniIcerik = Replace(yeniIcerik,"[teklifTuru]",teklifTuru)
            yeniIcerik = Replace(yeniIcerik,"[teklifDili]",teklifDili)
            yeniIcerik = Replace(yeniIcerik,"[teklifParaBirimi]",teklifParaBirimi)
            yeniIcerik = Replace(yeniIcerik,"[ustyazi]",ustyazi)
            yeniIcerik = Replace(yeniIcerik,"[ozelNot]",ozelNot)
            yeniIcerik = Replace(yeniIcerik,"[logo]",firmaLogo)
            ' yeniIcerik = Replace(yeniIcerik,"[ozelkosulicerik1]",ozelkosulicerik1)
            yeniIcerik = Replace(yeniIcerik,"[altYazi]",altYazi)
            yeniIcerik = Replace(yeniIcerik,"[teklifKosul]",kosulIcerik)
            yeniIcerik = Replace(yeniIcerik,"[teklifUrunler]",urunListesi)
            yeniIcerik = Replace(yeniIcerik,"[bankaHesapBilgileri]",bankaHesapBilgileri)
            yeniIcerik = Replace(yeniIcerik,"[personelAdSoyad]",personelAdSoyad)
            yeniIcerik = Replace(yeniIcerik,"[personelUnvan]",personelUnvan)
            
        '## normal text içerikler
    end if


    if hata = "" then
        Response.Write yeniIcerik
    else
        Response.Write hata
    end if
end function























%><!--#include virtual="/reg/rs.asp" -->