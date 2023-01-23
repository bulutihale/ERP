<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modulAd =   "Teklif"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Teklif Listesi Ekranı")

yetkiTeklif = yetkibul(modulAd)



if yetkiTeklif > 0 then
    '###### ARAMA FORMU
    '###### ARAMA FORMU
        if hata = "" then
            Response.Write "<div class=""container-fluid"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-body"">"
                    Response.Write "<div class=""row"">"
                        Response.Write "<form action=""/teklif/teklif_liste.asp"" method=""post"" class=""ortaform"">"
                        Response.Write "<div class=""form-row align-items-center"">"
                        Response.Write "<div class=""col-6 my-1"">"
                        Response.Write "<input type=""text"" class=""form-control"" placeholder=""Cari Adı, Cari Kodu"" name=""aramaad"" value=""" & aramaad & """>"
                        Response.Write "</div>"
                        Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
                        ' if isnull(firmaSSO) = True then
                        ' if yetkiTeklif >= 3 or yetkiSatis > 1 then
                        '     Response.Write "<div class=""col-auto my-1""><button type=""button"" class=""btn btn-danger"" onClick=""modalajaxfit('/cari/cari_yeni.asp')"">" & translate("YENİ CARİ","","") & "</a></div>"
                        ' end if
                        ' end if
                        Response.Write "</div>"
                        Response.Write "</form>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"
        end if
    '###### ARAMA FORMU
    '###### ARAMA FORMU

    '####### SONUÇ TABLOSU
    '####### SONUÇ TABLOSU
        if hata = "" then
            Response.Write "<div class=""container-fluid scroll-ekle3"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-body"">"
                    Response.Write "<div class=""row"">"

            Response.Write "<div class=""table-responsive"">"
            Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
            Response.Write "<th scope=""col"">Tarih</th>"
            Response.Write "<th scope=""col"">Sayı</th>"
            Response.Write "<th scope=""col"">Dil</th>"
            Response.Write "<th scope=""col"">Cari Ad</th>"
            Response.Write "<th scope=""col"">Teklif Türü</th>"
            Response.Write "<th scope=""col"">Para Birimi</th>"
            Response.Write "<th scope=""col"">Sonuç</th>"
            if yetkiTeklif >= 3 then
                Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
            end if
            Response.Write "</tr></thead><tbody>" 
                sorgu = "SELECT" & vbcrlf
                sorgu = sorgu & " *" & vbcrlf
                sorgu = sorgu & " FROM teklif.teklif" & vbcrlf
                sorgu = sorgu & " WHERE firmaID = " & firmaID & vbcrlf
                sorgu = sorgu & " and silindi = 0" & vbcrlf
                if aramaad = "" then
                else
                    ' sorgu = sorgu & " and (t1.cariAd like N'%" & aramaad & "%' OR t1.vergiNo like N'%" & aramaad & "%' OR t1.cariKodu like N'%" & aramaad & "%')"
                end if
                sorgu = sorgu & " ORDER BY teklifID DESC"
                rs.open sorgu, sbsv5, 1, 3
                if rs.recordcount > 0 then

                    ' Teklif##Giriş Yapamaz=0,Kısıtlı Görebilir=1,Görebilir=2,Düzenleyebilir=3,Onay Verebilir=5,Teklifi Silebilir=6,Satış Yöneticisi=7,Yönetici=9

                    for i = 1 to rs.recordcount
                        teklifID			=	rs("teklifID")
                        tekliftarih			=	rs("tekliftarih")
                        teklifsayi			=	rs("teklifsayi")
                        teklifDili			=	rs("teklifDili")
                        cariAd			    =	rs("cariAd")
                        teklifTuru			=	rs("teklifTuru")
                        teklifParaBirimi	=	rs("teklifParaBirimi")
                        teklifSonuc			=	rs("teklifSonuc")
                        teklifID64          =   teklifID
                        teklifID64          =   base64_encode_tr(teklifID64)

                        Response.Write "<tr>"
                            Response.Write "<td>" & tekliftarih & "</td>"
                            Response.Write "<td>" & teklifsayi & "</td>"
                            Response.Write "<td>" & teklifDili & "</td>"
                            Response.Write "<td>" & cariAd & "</td>"
                            Response.Write "<td>" & teklifTuru &  "</td>"
                            Response.Write "<td>" & teklifParaBirimi &  "</td>"
                            Response.Write "<td>" & teklifSonucArr(teklifSonuc) &  "</td>"
                        if yetkiTeklif >= 3 then
                            Response.Write "<td class=""text-right"" nowrap>"
                            if yetkiTeklif >= 2 then
                                '# ÖN İZLEME
                                    teklif64 = teklifID
                                    teklif64 =	base64_encode_tr(teklif64)
                                    '//FIXME - bunu modal da yapabiliriz
                                    Response.Write "<a href=""/teklif/gosterhtml/" & teklif64 & """ title=""" & translate("Önizleme","","") & """ class=""ml-2"" >"
                                    Response.Write "<i title=""" & translate("Önizleme","","") & """ class=""icon page-white-find"
                                    Response.Write """></i>"
                                    Response.Write "</a>"
                                '# ÖN İZLEME
                            end if
                            if yetkiTeklif >= 2 then
                                '# PDF
                                    teklif64 = teklifID
                                    teklif64 =	base64_encode_tr(teklif64)
                                    Response.Write "<a href=""/teklif/teklif_pdfolustur/" & teklifID64 & """ title=""" & translate("PDF Oluştur","","") & """ class=""ml-2"" >"
                                    Response.Write "<i class=""icon page-white-acrobat"
                                    Response.Write """></i>"
                                    Response.Write "</a>"
                                '# PDF
                            end if
                            if yetkiTeklif >= 2 then
                                '# EMAIL
                                    teklif64 = teklifID
                                    teklif64 =	base64_encode_tr(teklif64)
                                    Response.Write "<a onClick=""modalajax('/teklif/teklif_email.asp?teklifID=" & teklifID64 & "')"" title=""" & translate("Email Gönder","","") & """ class=""ml-2"" >"
                                    Response.Write "<i class=""icon email-go"
                                    Response.Write """></i>"
                                    Response.Write "</a>"
                                '# EMAIL
                            end if
                            if yetkiTeklif >= 3 then
                                '# teklif düzenle
                                    teklif64 = teklifID
                                    teklif64 =	base64_encode_tr(teklif64)
                                    Response.Write "<a href=""/teklif/teklif_yeni_modal/" & teklif64 & """ title=""" & translate("Teklifi Düzenle","","") & """ class=""ml-2"" >"
                                    Response.Write "<i class=""icon page-white-edit"
                                    Response.Write """></i>"
                                    Response.Write "</a>"
                                '# teklif düzenle
                            end if
                            if yetkiTeklif >= 5 then
                                '# teklif onay
                                    teklif64 = teklifID
                                    teklif64 =	base64_encode_tr(teklif64)
                                    Response.Write "<a onClick="""
                                    Response.Write "bootmodal('Teklifi Onaylıyor Musunuz?','custom','/teklif/teklif_onay.asp?islem=onay&teklifID=" & teklif64 & "','/teklif/teklif_onay.asp?islem=red&teklifID=" & teklif64 & "','Teklifi Onayla','Teklifi Reddet','btn-danger','btn-success','','ajax','3000','','');"
                                    Response.Write """ title=""" & translate("Teklifi Onayla","","") & """ class=""ml-1"" >"
                                    Response.Write "<i class=""icon tick"
                                    Response.Write """></i>"
                                    Response.Write "</a>"
                                '# teklif onay
                            end if
                            if yetkiTeklif >= 6 then
                                '# teklif sil
                                    teklif64 = teklifID
                                    teklif64 =	base64_encode_tr(teklif64)
                                    Response.Write "<a onClick="""
                                    Response.Write "bootmodal('Teklifi Silmek Mi İstiyorsunuz?','custom','/teklif/teklif_onay.asp?islem=sil&teklifID=" & teklif64 & "','','Sil','Silme','btn-danger','btn-success','','ajax','3000','','');"
                                    Response.Write """ title=""" & translate("Teklifi Sil","","") & """ class=""ml-1"" >"
                                    Response.Write "<i class=""icon delete"
                                    Response.Write """></i>"
                                    Response.Write "</a>"
                                '# teklif sil
                            end if
                            Response.Write "</td>"
                        end if
                        Response.Write "</tr>"
                        Response.Flush()
                    rs.movenext
                    next
                end if
                rs.close
            Response.Write "</tbody>"
            Response.Write "</table>"
            Response.Write "</div>"

                    Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"
        ' else
        '     call yetkisizGiris("","","")
        end if
    '####### SONUÇ TABLOSU
    '####### SONUÇ TABLOSU
    ' call dataTableYap("deneme","Durum,Firma Adı,Teklif Sayı,Teklif Türü,Tarih,Personel,İşlemler","/teklif/json_teklif.asp","","","","","","","","","")
else
    call yetkisizGiris("Teklifleri görmek için yeterli yetkiniz bulunmamaktadır","","")
end if






%><!--#include virtual="/reg/rs.asp" -->