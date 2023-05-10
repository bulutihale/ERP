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
    modulAd =   "YHAmeliyat"
    hastaID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL
    ameliyatID  =   Request.QueryString("ameliyatID")
'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL

call logla("Ameliyat Bilgileri Giriş Ekranı")

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
            sorgu = "Select top 1 * from yabancihasta.ameliyat where ameliyatID = " & ameliyatID
            rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount = 1 then
                rs("silindi") =   True
                rs.update
            end if
            rs.close
            call jsac("/yabancihasta/hasta_liste.asp")
        end if
        '## İŞLEM SİL
        '## İŞLEM SİL


							sorgu = "Select doktorID,doktorAd from yabancihasta.doktor where silindi = 'False' order by doktorAd"
							rs.open sorgu,sbsv5,1,3
							if rs.recordcount > 0 then
									degerler = "=0|"
									do while not rs.eof
										degerler = degerler & rs("doktorAd")
    									degerler = degerler & "="
										degerler = degerler & rs("doktorID")
										degerler = degerler & "|"
									rs.movenext
									loop
									doktorDegerler = left(degerler,len(degerler)-1)
							end if
							rs.close
                            doktorDegerlerArr = Split(doktorDegerler,"|")

        '## HASTA ÖDEME BİLGİLERİNİ AL
        '## HASTA ÖDEME BİLGİLERİNİ AL
        if ameliyatID <> "" then
            sorgu = "Select top 1 * from yabancihasta.ameliyat"
			sorgu = sorgu & " where yabancihasta.ameliyat.silindi = 'False' and yabancihasta.ameliyat.ameliyatID = " & ameliyatID
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
                ameliyatID  =   rs("ameliyatID")
                hastaID =   rs("hastaID")
                ameliyatlarID   =   rs("ameliyatlarID")
                ameliyatlarAd   =   rs("ameliyatlarAd")
                doktorID   =   rs("doktorID")
                doktorAd   =   rs("doktorAd")
                hastaneID   =   rs("hastaneID")
                tarih   =   rs("tarih")
                ameliyatNot     =   rs("ameliyatNot")
            end if
            rs.close
        end if
        '## HASTA ÖDEME BİLGİLERİNİ AL
        '## HASTA ÖDEME BİLGİLERİNİ AL

		Response.Write "<div class=""col-sm-12 my-1 text-center"">"
		Response.Write "<span class=""badge badge-info badge-pill"">" & hastaAd & "</span>"
		Response.Write "</div>"

		Response.Write "<form action=""/yabancihasta/ameliyat_ekle.asp"" method=""post"" class=""ajaxform"">"
        call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")
        call forminput("ameliyatID",ameliyatID,"","","ameliyatID","hidden","ameliyatID","")

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Tarih","","") & "</span>"
		call forminput("tarih",tarih,"","","tarih","autocompleteOFF","tarih","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Ameliyat","","") & "</span>"
        call forminput("ameliyatlarAd",ameliyatlarAd,"","","ameliyatlarAd","","ameliyatlarAd","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Doktor","","") & "</span>"
        call formselectv2("doktorAd",doktorAd,"","","","","doktorAd",doktorDegerler,"")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Hastane","","") & "</span>"
		degerler = "=|Özel Sağlık=1|Gözde Tepecik=2|Gözde Kuşadası=3"
		call formselectv2("hastaneID",hastaneID,"","","","","hastaneID",degerler,"")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Not","","") & "</span>"
		Response.Write "<textarea class=""form-control"" name=""ameliyatNot"">" & ameliyatNot & "</textarea>"
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
        sorgu = "Select * from yabancihasta.ameliyat where yabancihasta.ameliyat.silindi = 'False' and hastaID = " & hastaID
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount > 0 then
		Response.Write "<div class=""container-fluid mt-3"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-success"">" & translate("Ameliyat Listesi","","") & " : </div>"
                    Response.Write "<div class=""card-body"">"
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs mt-1"">"
                            '#### TABLO
                                Response.Write "<table class=""table table-striped table-bordered table-hover mt10""><thead><tr>"
                                Response.Write "<th>" & translate("Tarih","","") & "</th>"
                                Response.Write "<th>" & translate("Ameliyat","","") & "</th>"
                                Response.Write "<th>" & translate("Doktor","","") & "</th>"
                                Response.Write "<th>" & translate("Hastane","","") & "</th>"
                                Response.Write "</tr></thead><tbody>"
                                for ri = 1 to rs.recordcount
                                    Response.Write "<tr>"
                                    Response.Write "<td onClick=""modalajax('/yabancihasta/ameliyat_yeni.asp?gorevID=" & hastaID & "&ameliyatID=" & rs("ameliyatID") & "');"">" & rs("tarih") & "</td>"
                                    Response.Write "<td onClick=""modalajax('/yabancihasta/ameliyat_yeni.asp?gorevID=" & hastaID & "&ameliyatID=" & rs("ameliyatID") & "');"">" & rs("ameliyatlarAd") & "</td>"
                                    Response.Write "<td>" & arrPersonelBul(rs("doktorAd"),doktorDegerlerArr) & "</td>"
                                    Response.Write "<td>" & hastaneArr(rs("hastaneID")) & "</td>"
                                    Response.Write "<td><button title=""" & translate("Sil","","") & """ class=""btn btn-sm btn-danger d-none d-sm-table-cell"" onClick=""modalajax('/yabancihasta/ameliyat_yeni.asp?islem=sil&gorevID=" & hastaID & "&ameliyatID=" & rs("ameliyatID") & "');""><i class=""fa fa-trash""></i></button>"
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