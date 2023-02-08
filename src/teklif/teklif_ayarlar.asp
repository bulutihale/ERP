<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
	aramaad	=	Request.Form("aramaad")
    Response.Flush()
'###### ANA TANIMLAMALAR

yetkiTM = yetkibul(modulAd)

call logla("Genel teklif ayarları güncelleme ekranı")

'####### ADRES LİSTESİ
	if yetkiTM > 0 then
        if hata = "" then
            Response.Write "<div class=""container-fluid scroll-ekle3"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-primary"">Koşullar</div>"
                    Response.Write "<div class=""card-body"">"
                    Response.Write "<div class=""row"">"
                        sorgu = "Select * from teklif.teklifKosul where firmaID = " & firmaID & " and silindi = 0 order by teklifKosulID desc"
                        rs.Open sorgu, sbsv5, 1, 3
                            if rs.recordcount > 0 then
                                Response.Write "<div class=""table-responsive"">"
                                Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
                                Response.Write "<th scope=""col"" width=""100"">Koşul</th>"
                                Response.Write "<th scope=""col"">İçerik</th>"
                                if yetkiTM >= 3 then
                                    Response.Write "<th scope=""col"" class=""d-sm-table-cell"" width=""50"">&nbsp;</th>"
                                end if
                                Response.Write "</tr></thead><tbody>" 
                                    for i = 1 to rs.recordcount
                                        adresGrupID			=	rs("teklifKosulID")
                                        kosul				=	rs("kosul")
                                        icerik		        =	rs("icerik")
                                        adresGrupID64       =   adresGrupID
                                        adresGrupID64       =   base64_encode_tr(adresGrupID64)
                                        Response.Write "<tr>"
                                            Response.Write "<td>"
                                                call forminput("kosul",kosul,"$('.formname').val('kosul');$('#formicerik').val(this.value);$('.gorevID').val(" & adresGrupID & ");$('#formdata').submit();","","kosul","","kosul","")
                                            Response.Write "</td>"
                                            Response.Write "<td>"
                                                call forminput("icerik",icerik,"$('.formname').val('icerik');$('#formicerik').val(this.value);$('.gorevID').val(" & adresGrupID & ");$('#formdata').submit();","","icerik","","icerik","")
                                            Response.Write "</td>"
                                        if yetkiTM >= 3 then
                                            Response.Write "<td class=""text-right"" nowrap>"
                                            if yetkiTM >= 6 then
                                                '# Şablon sil
                                                    adresGrupID64 =	adresGrupID
                                                    adresGrupID64 =	base64_encode_tr(adresGrupID64)
                                                    Response.Write "<a onClick="""
                                                    Response.Write "bootmodal('Koşulu Silmek Mi İstiyorsunuz?','custom','/teklif/teklif_ayarlar_islem.asp?islem=sil&gorevID=" & adresGrupID64 & "','','Sil','Silme','btn-danger','btn-success','','ajax','3000','','');"
                                                    Response.Write """ title=""" & translate("Koşulu Sil","","") & """ class=""ml-1"" >"
                                                    Response.Write "<i class=""icon delete"
                                                    Response.Write """></i>"
                                                    Response.Write "</a>"
                                                '# Şablon sil
                                            end if
                                            Response.Write "</td>"
                                        end if
                                        Response.Write "</tr>"
                                        Response.Flush()
                                    rs.movenext
                                    next
                                        Response.Write "<form action=""/teklif/teklif_ayarlar_islem.asp"" method=""post"" class=""ajaxform"">"
                                        Response.Write "<tr>"
                                            Response.Write "<td>"
                                                call forminput("kosul","","","","kosul","","kosul","")
                                            Response.Write "</td>"
                                            Response.Write "<td>"
                                                call forminput("icerik","","","","icerik","","icerik","")
                                            Response.Write "</td>"
                                            Response.Write "<td>"
                                                Response.Write "<button class=""form-control"" type=""submit"">Ekle</button>"
                                            Response.Write "</td>"
                                        Response.Write "</tr>"
                                        call forminput("gorevID","","","","gorevID","hidden","gorevID","")
                                        Response.Write "</form>"



                                Response.Write "</tbody>"
                                Response.Write "</table>"
                                Response.Write "</div>"
                            else
                                call yetkisizGiris("Şablon Bulunamadı","","")
                            end if
                        rs.close
                    Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"








            Response.Write "<form action=""/teklif/teklif_ayarlar_islem.asp"" method=""post"" id=""formdata"" class=""ajaxform"">"
                call forminput("formname","","","","formname","hidden","formname","")
                call forminput("formicerik","","","","formicerik","hidden","formicerik","")
                call forminput("gorevID","","","","gorevID","hidden","gorevID","")
            Response.Write "</form>"
        else
            call yetkisizGiris("Adres Gruplarını görmek için yeterli yetkiniz bulunmamaktadır","","")
        end if
	end if
'####### ADRES LİSTESİ

%><!--#include virtual="/reg/rs.asp" -->