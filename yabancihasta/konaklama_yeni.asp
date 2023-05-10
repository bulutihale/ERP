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
    modulAd =   "YHKonaklama"
    hastaID =   gorevID
    Response.Flush()
    oteldegerler = "=|Özel Sağlık Hastanesi=Özel Sağlık Hastanesi|Gözde Tepecik=Gözde Tepecik|Mövenpick=Mövenpick|ParkInn=ParkInn|Karaca=Karaca|Best Western=Best Western"
    odadegerler         =   "=|Single=Single|Double=Double"
    yatakdegerler       =   "=|Single Bed=Single Bed|Double Bed=Double Bed|Twin Bed=Twin Bed|French Bed=French Bed"
    kisisayisidegerler  =   "=|1=1|2=2|3=3"
    ' flightdegerler = "=|Turkey Izmir ADB=ADB|Turkey Istanbul IST=IST|Germany Berlin BER=BER|Germany Frankfurt FRA=FRA|Germany Hamburg HAM=HAM|Switzerland Genève GVA=GVA|UK Dublin DUB=DUB|UK Gatwick LGW=LGW|UK LON=LON|UK Manchester MAN=MAN|Austria Vienna VIE=VIE"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL
    konaklamaID  =   Request.QueryString("konaklamaID")
'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL

call logla("Konaklama Bilgileri Giriş Ekranı")

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
            sorgu = "Select top 1 * from yabancihasta.konaklama where konaklamaID = " & konaklamaID
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


        '## HASTA ÖDEME BİLGİLERİNİ AL
        '## HASTA ÖDEME BİLGİLERİNİ AL
        if konaklamaID <> "" then
            sorgu = "Select top 1 * from yabancihasta.konaklama"
			sorgu = sorgu & " where yabancihasta.konaklama.silindi = 'False' and yabancihasta.konaklama.konaklamaID = " & konaklamaID
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
                konaklamaID          =   rs("konaklamaID")
                otelID              =   rs("otelID")
                otelAd              =   rs("otelAd")
                otelCheckIn         =   rs("otelCheckIn")
                otelCheckOut           =   rs("otelCheckOut")
                otelKisiSayisi           =   rs("otelKisiSayisi")
                otelOdaTipi              =   rs("otelOdaTipi")
                otelYatakTipi              =   rs("otelYatakTipi")
            end if
            rs.close
        end if
        '## HASTA ÖDEME BİLGİLERİNİ AL
        '## HASTA ÖDEME BİLGİLERİNİ AL

		Response.Write "<div class=""col-sm-12 my-1 text-center"">"
		Response.Write "<span class=""badge badge-info badge-pill"">" & hastaAd & "</span>"
		Response.Write "</div>"

		Response.Write "<form action=""/yabancihasta/konaklama_ekle.asp"" method=""post"" class=""ajaxform"">"
        call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")
        call forminput("konaklamaID",konaklamaID,"","","konaklamaID","hidden","konaklamaID","")

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Konaklama Yeri","","") & "</span>"
        call formselectv2("otelAd",otelAd,"","","","","otelAd",oteldegerler,"")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Check In","","") & "</span>"
		call forminput("otelCheckIn",otelCheckIn,"","","tarih","autocompleteOFF","otelCheckIn","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Check Out","","") & "</span>"
		call forminput("otelCheckOut",otelCheckOut,"","","tarih","autocompleteOFF","otelCheckOut","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Kişi Sayısı","","") & "</span>"
        call formselectv2("otelKisiSayisi",otelKisiSayisi,"","","","","otelKisiSayisi",kisisayisidegerler,"")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Oda Türü","","") & "</span>"
        call formselectv2("otelOdaTipi",otelOdaTipi,"","","","","otelOdaTipi",odadegerler,"")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Yatak Türü","","") & "</span>"
		call formselectv2("otelYatakTipi",otelYatakTipi,"","","","","otelYatakTipi",yatakdegerler,"")
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
        sorgu = "Select * from yabancihasta.konaklama where yabancihasta.konaklama.silindi = 'False' and hastaID = " & hastaID
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount > 0 then
		Response.Write "<div class=""container-fluid mt-3"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-success"">" & translate("Konaklama Listesi","","") & " : </div>"
                    Response.Write "<div class=""card-body"">"
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs mt-1"">"
                            '#### TABLO
                                Response.Write "<table class=""table table-striped table-bordered table-hover mt10""><thead><tr>"
                                Response.Write "<th>" & translate("Konaklama Yeri","","") & "</th>"
                                Response.Write "<th>" & translate("Check In","","") & "</th>"
                                Response.Write "<th>" & translate("Check Out","","") & "</th>"
                                Response.Write "<th>" & translate("Kişi Sayısı","","") & "</th>"
                                Response.Write "<th>" & translate("Oda Türü","","") & "</th>"
                                Response.Write "<th>" & translate("Yatak Türü","","") & "</th>"
                                Response.Write "<th>&nbsp;</th>"
                                Response.Write "</tr></thead><tbody>"
                                for ri = 1 to rs.recordcount
                                    Response.Write "<tr>"
                                    Response.Write "<td onClick=""modalajax('/yabancihasta/konaklama_yeni.asp?gorevID=" & hastaID & "&konaklamaID=" & rs("konaklamaID") & "');"">" & rs("otelAd") & "</td>"
                                    Response.Write "<td>" & rs("otelCheckIn") & "</td>"
                                    Response.Write "<td>" & rs("otelCheckOut") & "</td>"
                                    Response.Write "<td>" & rs("otelKisiSayisi") & "</td>"
                                    Response.Write "<td>" & rs("otelOdaTipi") & "</td>"
                                    Response.Write "<td>" & rs("otelYatakTipi") & "</td>"
                                    Response.Write "<td><button title=""" & translate("Sil","","") & """ class=""btn btn-sm btn-danger d-none d-sm-table-cell"" onClick=""modalajax('/yabancihasta/konaklama_yeni.asp?islem=sil&gorevID=" & hastaID & "&konaklamaID=" & rs("konaklamaID") & "');""><i class=""fa fa-trash""></i></button>"
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