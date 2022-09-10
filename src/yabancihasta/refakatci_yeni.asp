<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    islem   =   Request.QueryString("islem")
    hata    =   ""
    modulAd =   "YHRefakatci"
    hastaID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL
    refakatciID  =   Request.QueryString("refakatciID")
'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL

call logla("Refakatci Bilgileri Giriş Ekranı")

yetkiYabanciHasta = yetkibul("yabancihasta")

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiYabanciHasta > 2 then
        '## HASTA BİLGİLERİNİ AL
        '## HASTA BİLGİLERİNİ AL
            sorgu = "Select top 1 * from yabancihasta.hasta where hastaID = " & gorevID
            rs.open sorgu, sbsv5, 1, 3
                hastaAd =   rs("hastaAd")
            rs.close
        '## HASTA BİLGİLERİNİ AL
        '## HASTA BİLGİLERİNİ AL


        '## İŞLEM SİL
        '## İŞLEM SİL
        if islem = "sil" then
            sorgu = "Select top 1 * from yabancihasta.refakatci where refakatciID = " & refakatciID
            rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount = 1 then
                rs("silindi") =   True
                rs.update
            end if
            rs.close
        end if
        '## İŞLEM SİL
        '## İŞLEM SİL


        '## HASTA ÖDEME BİLGİLERİNİ AL
        '## HASTA ÖDEME BİLGİLERİNİ AL
        if refakatciID <> "" then
            sorgu = "Select top 1 * from yabancihasta.refakatci"
			sorgu = sorgu & " where yabancihasta.refakatci.silindi = 'False' and yabancihasta.refakatci.refakatciID = " & refakatciID
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
                refakatciID  =   rs("refakatciID")
                hastaID 	=   rs("hastaID")
                refakatciAd   =   rs("refakatciAd")
                refakatciPasaport   =   rs("refakatciPasaport")
            end if
            rs.close
        end if
        '## HASTA ÖDEME BİLGİLERİNİ AL
        '## HASTA ÖDEME BİLGİLERİNİ AL

		Response.Write "<div class=""col-sm-12 my-1 text-center"">"
		Response.Write "<span class=""badge badge-info badge-pill"">" & hastaAd & "</span>"
		Response.Write "</div>"


		Response.Write "<form action=""/yabancihasta/refakatci_ekle.asp"" method=""post"" class=""ajaxform"">"
        call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")
        call forminput("refakatciID",refakatciID,"","","refakatciID","hidden","refakatciID","")

		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-6 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Refakatci Adı Soyadı","","") & "</span>"
        call forminput("refakatciAd",refakatciAd,"","","refakatciAd","autocompleteOFF","refakatciAd","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-6 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Refakatci Pasaport Numarası","","") & "</span>"
        call forminput("refakatciPasaport",refakatciPasaport,"","","refakatciPasaport","autocompleteOFF","refakatciPasaport","")
		Response.Write "</div>"

		call clearfix()

		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("Kaydet","","") & "</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU







'#### AMELİYAT İŞLEM LİSTESİ
'#### AMELİYAT İŞLEM LİSTESİ
    if hata = "" and yetkiYabanciHasta > 2 then
        sorgu = "Select * from yabancihasta.refakatci where yabancihasta.refakatci.silindi = 'False' and hastaID = " & hastaID
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount > 0 then
		Response.Write "<div class=""container-fluid mt-3"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-success"">" & translate("Refakatci Listesi","","") & " : </div>"
                    Response.Write "<div class=""card-body"">"
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs mt-1"">"
                            '#### TABLO
                                Response.Write "<table class=""table table-striped table-bordered table-hover mt10""><thead><tr>"
                                Response.Write "<th>" & translate("Ad Soyad","","") & "</th>"
                                Response.Write "<th>" & translate("Pasaport Numarası","","") & "</th>"
                                Response.Write "</tr></thead><tbody>"
                                for ri = 1 to rs.recordcount
                                    Response.Write "<tr>"
                                    Response.Write "<td onClick=""modalajax('/yabancihasta/refakatci_yeni.asp?gorevID=" & hastaID & "&refakatciID=" & rs("refakatciID") & "');"">" & rs("refakatciAd") & "</td>"
                                    Response.Write "<td>" & rs("refakatciPasaport") & "</td>"
                                    Response.Write "<td><button title=""" & translate("Sil","","") & """ class=""btn btn-sm btn-danger d-none d-sm-table-cell"" onClick=""modalajax('/yabancihasta/refakatci_yeni.asp?islem=sil&gorevID=" & hastaID & "&refakatciID=" & rs("refakatciID") & "');""><i class=""fa fa-trash""></i></button>"
                                    Response.Write "</td>"
                                    Response.Write "</tr>"
                                rs.movenext
                                next
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
        rs.close
    end if
'#### AMELİYAT İŞLEM LİSTESİ
'#### AMELİYAT İŞLEM LİSTESİ








'### İŞLEM GEÇMİŞİ TABLOSU
'### İŞLEM GEÇMİŞİ TABLOSU
    if hata = "" and yetkiYabanciHasta = 9 and gorevID > 0 then
		Response.Write "<div class=""container-fluid mt-3"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-success"">Hareket Ayrıntıları : </div>"
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
                                sorgu = "Select top(1000) *,(Select personel.personel.ad from personel.personel where personel.personel.id = personel.personel_log.personelID) as kidAd from personel.personel_log where firmaID = " & firmaID & " and modulAd = '" & modulAd & "' and gorevID = " & gorevID
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