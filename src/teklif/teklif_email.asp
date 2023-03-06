<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
'###### ANA TANIMLAMALAR


'### SAYFA ID TESPİT ET
	if hata = "" then
        teklifID = Request.QueryString("teklifID")
	end if
'### SAYFA ID TESPİT ET


'### hata önleme
    if teklifID = "" then
        hata = "Teklif bilgisine ulaşılamadı!"
    end if
'### hata önleme

'### TEKLİF ID BUL
    if hata = "" then
        teklifID = base64_decode_tr(teklifID)
    end if
'### TEKLİF ID BUL


'### TEKLİF BİLGİLERİNE ULAŞ
    if hata = "" then
        sorgu = "Select top 1 * from teklif.teklif where teklifID = " & teklifID
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount = 1 then
          gonderenMail  =   rs("gonderenMail") & ""
          gonderenAd    =   rs("gonderenAd")
          musteriMail   =   rs("musteriMail")
          teklifDili    =   rs("teklifDili")
        end if
        rs.close
    end if
'### TEKLİF BİLGİLERİNE ULAŞ


'### PERSONEL BİLGİLERİNE ULAŞ
    if hata = "" then
        sorgu = "Select top 1 * from personel.personel where id = " & kid & " and firmaID = " & firmaID
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount = 1 then
            if gonderenMail = "" then
                gonderenAd      =   rs("ad")
                gonderenMail    =   rs("email")
            end if
            webmailSmtpIP       =   rs("webmailSmtpIP") & ""
        else
            hata = "Kritik Hata Oluştu. Hatalı teklif"
        end if
        rs.close
    end if
'### PERSONEL BİLGİLERİNE ULAŞ


'### RAPOR FORMATINI ÇEK
    if hata = "" then
        sorgu = "Select raporIcerik from rapor.raporFormat where modul = 'Teklif Mail' and firmaID = " & firmaID & " and dil = '" & teklifDili & "' and silindi = 0 order by raporFormatID DESC"
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount = 1 then
            mailIcerik = rs("raporIcerik")
        ' else
            ' hata = "Kritik Hata Oluştu. Teklif mail için uygun rapor formatı bulunamadı"
            ' call logla(hata)
        end if
        rs.close
    end if
'### RAPOR FORMATINI ÇEK


'###### CARİ ARAMA FORMU
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-warning"">" & translate("Mail Gönderimi","","") & "</div>"
				Response.Write "<div class=""card-body"">"
                    Response.Write "<form action=""/teklif/teklif_email2.asp"" method=""post"" class=""ajaxform"">"
                        call formhidden("teklifID",teklifID,"","","","","teklifID","")
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-4"">"
                                Response.Write "<div class=""badge badge-warning"">Gönderici Adres : </div>"
                                call forminput("gonderenMail",gonderenMail,"","","","","gonderenMail","")
				            Response.Write "</div>"
                            Response.Write "<div class=""col-lg-4"">"
                                Response.Write "<div class=""badge badge-warning"">Gönderen Ad : </div>"
                                call forminput("gonderenAd",gonderenAd,"","","","","gonderenAd","")
				            Response.Write "</div>"
                            Response.Write "<div class=""col-lg-4"">"
                                Response.Write "<div class=""badge badge-warning"">Müşterinin Mail Adresi : </div>"
                                call forminput("musteriMail",musteriMail,"","","","","musteriMail","")
                                '//FIXME - drop yapılabilir
				            Response.Write "</div>"
                        Response.Write "</div>"
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12"">"
                                Response.Write "<div class=""badge badge-warning mt-3"">Mail içeriği : </div>"
                                call formtextarea("mailIcerik",mailIcerik,"","Mail İçeriği","mailIcerik summernote","","","")
				            Response.Write "</div>"
                        Response.Write "</div>"
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12"">"
                                if webmailSmtpIP = "" then
                                    Response.Write "<div class=""badge badge-danger text-center mt-3"">* Mail ayarlarınız doğru yapılandırılmadığından mail gönderemezsiniz.</div>"
                                    Response.Write "<button disabled=""disabled"" type=""submit"" class=""btn btn-danger form-control mt-3"">" & translate("Mail Gönder","","") & "</button>"
                                else
                                    Response.Write "<button type=""submit"" class=""btn btn-success form-control mt-3"" onClick=""$('.summernote').summernote('code');$('.summernote').summernote('destroy');"">" & translate("Mail Gönder","","") & "</button>"
                                end if
                            Response.Write "</div>"
                        Response.Write "</div>"
                    Response.Write "</form>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'###### CARİ ARAMA FORMU






%><!--#include virtual="/reg/rs.asp" -->