<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    hata    =   ""
    modulAd =   "YHÖdeme"
    hastaID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Ödeme Bilgileri Giriş Ekranı")

yetkiYabanciHasta = yetkibul("yabancihasta")

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiYabanciHasta > 2 then
        '## HASTA BİLGİLERİNİ AL
        '## HASTA BİLGİLERİNİ AL
            sorgu = "Select top 1 * from yabancihasta.hasta where hastaID = " & gorevID
            rs.open sorgu, sbsv5, 1, 3
                hastaParaBirim =   rs("hastaParaBirim")
                hastaAd =   rs("hastaAd")
            rs.close
        '## HASTA BİLGİLERİNİ AL
        '## HASTA BİLGİLERİNİ AL

        '## HASTA ÖDEME BİLGİLERİNİ AL
        '## HASTA ÖDEME BİLGİLERİNİ AL
            sorgu = "Select top 1 * from yabancihasta.odeme"
			sorgu = sorgu & " where yabancihasta.odeme.hastaID = " & gorevID
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
                paketFiyat  =   rs("paketFiyat")
                kaparoFiyat =   rs("kaparoFiyat")
                dekontNo1   =   rs("dekontNo1")
                dekontNo2   =   rs("dekontNo2")
                banka1   =   rs("banka1")
                banka2   =   rs("banka2")
            end if
            rs.close
        '## HASTA ÖDEME BİLGİLERİNİ AL
        '## HASTA ÖDEME BİLGİLERİNİ AL


		Response.Write "<div class=""col-sm-12 my-1 text-center"">"
		Response.Write "<span class=""badge badge-info badge-pill"">" & translate("{%1} için <strong>{%2}</strong> cinsinden ödeme bilgilerini yazın",hastaAd,hastaParaBirim) & "</span>"
		Response.Write "</div>"

		Response.Write "<form action=""/yabancihasta/odeme_ekle.asp"" method=""post"" class=""ajaxform"">"
        Response.Write "<input type=""hidden"" class=""form-control"" name=""gorevID"" id=""gorevID"" value=""" & gorevID & """ />"
        
		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Paket Fiyatı","","") & "</span>"
        call forminput("paketFiyat",paketFiyat,"","","","autocompleteOFF","paketFiyat","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Kaparo","","") & "</span>"
        call forminput("kaparoFiyat",kaparoFiyat,"","","","autocompleteOFF","kaparoFiyat","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Banka Dekontu","","") & "</span>"
        call forminput("dekontNo1",dekontNo1,"","","","autocompleteOFF","dekontNo1","")
		Response.Write "</div>"

		' Response.Write "<div class=""col-sm-6 my-1"">"
        ' Response.Write "<span class=""badge badge-secondary"">" & translate("Banka Adı","","") & " 1</span>"
		' Response.Write "<input type=""text"" class=""form-control"" placeholder=""" & translate("Banka Adı","","") & " 1"" name=""banka1"" value=""" & banka1 & """>"
		' Response.Write "</div>"

		' Response.Write "<div class=""col-sm-6 my-1"">"
        ' Response.Write "<span class=""badge badge-secondary"">" & translate("Banka Dekontu","","") & " 2</span>"
		' Response.Write "<input type=""text"" class=""form-control"" placeholder=""" & translate("Banka Dekontu","","") & " 2"" name=""dekontNo2"" value=""" & dekontNo2 & """>"
		' Response.Write "</div>"

		' Response.Write "<div class=""col-sm-6 my-1"">"
        ' Response.Write "<span class=""badge badge-secondary"">" & translate("Banka Adı","","") & " 2</span>"
		' Response.Write "<input type=""text"" class=""form-control"" placeholder=""" & translate("Banka Adı","","") & " 2"" name=""banka2"" value=""" & banka2 & """>"
		' Response.Write "</div>"

        call clearfix()

		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("Kaydet","","") & "</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU







'### İŞLEM GEÇMİŞİ TABLOSU
'### İŞLEM GEÇMİŞİ TABLOSU
    if hata = "" and yetkiYabanciHasta = 9 and gorevID > 0 then
		Response.Write "<div class=""container-fluid mt-3"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-success"">" & translate("Hareket Ayrıntıları","","") & " : </div>"
                    Response.Write "<div class=""card-body"">"
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs mt-1"">"
                            '#### TABLO
                                Response.Write "<table class=""table table-striped table-bordered table-hover mt10""><thead><tr>"
                                Response.Write "<th>" & translate("Tarih","","") & "</th>"
                                Response.Write "<th>" & translate("Personel","","") & "</th>"
                                Response.Write "<th>" & translate("İşlem","","") & "</th>"
                                Response.Write "<th>" & translate("IP","","") & "</th>"
                                Response.Write "</tr></thead><tbody>"
                                sorgu = "Select top(10) *,(Select personel.personel.ad from personel.personel where personel.personel.id = personel.personel_log.personelID) as kidAd from personel.personel_log where firmaID = " & firmaID & " and modulAd = '" & modulAd & "' and gorevID = " & gorevID & ""
                                sorgu = sorgu & "order by id desc"
                                rs.open sorgu,sbsv5,1,3
                                if rs.recordcount > 0 then
                                for ri = 1 to rs.recordcount
                                    Response.Write "<tr>"
                                    Response.Write "<td>" & rs("tarih") & "</td>"
                                    Response.Write "<td>" & rs("kidAd") & "</td>"
                                    Response.Write "<td>" & rs("islem") & "</td>"
                                    Response.Write "<td>" & rs("ip") & "</td>"
                                    Response.Write "</td>"
                                    Response.Write "</tr>"
                                rs.movenext
                                next
                                end if
                                rs.close
                                Response.Write "</table>"
                            '#### TABLO
                            Response.Write "</div>"
                        Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
        Response.Write "</div>"
        Response.Write "</div>"
    end if
'### İŞLEM GEÇMİŞİ TABLOSU
'### İŞLEM GEÇMİŞİ TABLOSU





%><!--#include virtual="/reg/rs.asp" -->