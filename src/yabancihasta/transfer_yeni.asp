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
    modulAd =   "YHTransfer"
    hastaID =   gorevID
    Response.Flush()
    flightdegerler = "=|Turkey Izmir ADB=ADB|Turkey Istanbul IST=IST|Germany Berlin BER=BER|Germany Frankfurt FRA=FRA|Germany Hamburg HAM=HAM|Switzerland Genève GVA=GVA|UK Dublin DUB=DUB|UK Gatwick LGW=LGW|UK LON=LON|UK Manchester MAN=MAN|Austria Vienna VIE=VIE|Düsseldorf DUS=DUS|Munich MUC=MUC|Frankfurt FRA=FRA|Stuttgart STR=STR|Köln CGN=CGN|Berlin BER=BER|Hannover HAJ=HAJ|Dortmund  DTM=DTM|Viyana  VIE=VIE|Bakü GYD=GYD|Minsk MSQ=MSQ|Bürüksel(Brussels) BRU=BRU|Liege LGG=LGG|Kopenhag CPH=CPH|Lyon LYS=LYS|Paris(Charles de Gaulle) CDG=CDG|Marsilya  MRS=MRS|Strazburg SXB=SXB|Helsinki HEL=HEL|Amsterdam AMS=AMS|Luton  LTN=LTN|Heatrow LHR=LHR|Stansted STN=STN|Manchester MAN=MAN|Birmingham BHX=BHX|Newcastle NCL=NCL|Dublin DUB=DUB|Glasgow GLA=GLA|Tel Aviv TLV=TLV|Stokholm ARN=ARN|Zurih  ZRH=ZRH|Basel BSL=BSL|Milano(Malpensa) MXP=MXP|Milano(Bergamo) BGY=BGY|Atina ATH=ATH|Kyiv KBP=KBP"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL
    transferID  =   Request.QueryString("transferID")
'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL

call logla("Transfer Bilgileri Giriş Ekranı")

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
            sorgu = "Select top 1 * from yabancihasta.transfer where transferID = " & transferID
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
        if transferID <> "" then
            sorgu = "Select top 1 * from yabancihasta.transfer"
			sorgu = sorgu & " where yabancihasta.transfer.silindi = 'False' and yabancihasta.transfer.transferID = " & transferID
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
                transferID          =   rs("transferID")
                ucusTarihi         =   rs("ucusTarihi")
                ucusSaati           =   rs("ucusSaati")
                ucakKalkisYeri           =   rs("ucakKalkisYeri")
                ucakNumarasi              =   rs("ucakNumarasi")
                ucakFirmasi              =   rs("ucakFirmasi")
                ucusVarisNoktasi              =   rs("ucusVarisNoktasi")
                inisSaati               =   rs("inisSaati")
            end if
            rs.close
        end if
        '## HASTA ÖDEME BİLGİLERİNİ AL
        '## HASTA ÖDEME BİLGİLERİNİ AL

		Response.Write "<div class=""col-sm-12 my-1 text-center"">"
		Response.Write "<span class=""badge badge-info badge-pill"">" & hastaAd & "</span>"
		Response.Write "</div>"
        

		Response.Write "<form action=""/yabancihasta/transfer_ekle.asp"" method=""post"" class=""ajaxform"">"
        call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")
        call forminput("transferID",transferID,"","","transferID","hidden","transferID","")

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Uçuş Tarihi","","") & "</span>"
		call forminput("ucusTarihi",ucusTarihi,"","","tarih","autocompleteOFF","ucusTarihi","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-6 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Uçuş Saati","","") & "</span>"
		call forminput("ucusSaati",ucusSaati,"","","","autocompleteOFF","ucusSaati","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-6 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Varış Saati","","") & "</span>"
		call forminput("inisSaati",inisSaati,"","","","autocompleteOFF","inisSaati","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Uçak Kalkış Yeri","","") & "</span>"
        call formselectv2("ucakKalkisYeri",ucakKalkisYeri,"","","","","ucakKalkisYeri",flightdegerler,"")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Uçak Numarası","","") & "</span>"
		call forminput("ucakNumarasi",ucakNumarasi,"","","ucakNumarasi","autocompleteOFF","ucakNumarasi","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Uçak Firması","","") & "</span>"
		call forminput("ucakFirmasi",ucakFirmasi,"","","ucakFirmasi","autocompleteOFF","ucakFirmasi","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Uçak İniş Havalimanı","","") & "</span>"
		call formselectv2("ucusVarisNoktasi",ucusVarisNoktasi,"","","","","ucusVarisNoktasi",flightdegerler,"")
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
        sorgu = "Select * from yabancihasta.transfer where yabancihasta.transfer.silindi = 'False' and hastaID = " & hastaID
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount > 0 then
		Response.Write "<div class=""container-fluid mt-3"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-success"">" & translate("Transfer Listesi","","") & " : </div>"
                    Response.Write "<div class=""card-body"">"
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs mt-1"">"
                            '#### TABLO
                                Response.Write "<table class=""table table-striped table-bordered table-hover mt10""><thead><tr>"
                                Response.Write "<th>" & translate("Uçuş Tarihi","","") & "</th>"
                                Response.Write "<th>" & translate("Kalkış Saati","","") & "</th>"
                                Response.Write "<th>" & translate("Varış Saati","","") & "</th>"
                                Response.Write "<th>" & translate("Uçak Firması","","") & "</th>"
                                Response.Write "<th>" & translate("Uçuş Numarası","","") & "</th>"
                                Response.Write "<th>" & translate("Uçak Kalkış Yeri","","") & "</th>"
                                Response.Write "<th>" & translate("Uçak İniş Yeri","","") & "</th>"
                                Response.Write "<th>" & translate("Transfer","","") & "</th>"
                                Response.Write "</tr></thead><tbody>"
                                for ri = 1 to rs.recordcount
                                    Response.Write "<tr>"
                                    Response.Write "<td onClick=""modalajax('/yabancihasta/transfer_yeni.asp?gorevID=" & hastaID & "&transferID=" & rs("transferID") & "');"">" & rs("ucusTarihi") & "</td>"
                                    Response.Write "<td>" & rs("ucusSaati") & "</td>"
                                    Response.Write "<td>" & rs("inisSaati") & "</td>"
                                    Response.Write "<td>" & rs("ucakFirmasi") & "</td>"
                                    Response.Write "<td>" & rs("ucakNumarasi") & "</td>"
                                    Response.Write "<td>" & rs("ucakKalkisYeri") & "</td>"
                                    Response.Write "<td>" & rs("ucusVarisNoktasi") & "</td>"
                                    Response.Write "<td>" & truefalse(rs("transfer"),"varyok") & "</td>"
                                    Response.Write "<td><button title=""" & translate("Sil","","") & """ class=""btn btn-sm btn-danger d-none d-sm-table-cell"" onClick=""modalajax('/yabancihasta/transfer_yeni.asp?islem=sil&gorevID=" & hastaID & "&transferID=" & rs("transferID") & "');""><i class=""fa fa-trash""></i></button>"
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



' arrival time
' dep timme


'### İŞLEM GEÇMİŞİ TABLOSU
'### İŞLEM GEÇMİŞİ TABLOSU
    ' if hata = "" and yetkiYabanciHasta = 9 and gorevID > 0 then
	' 	Response.Write "<div class=""container-fluid mt-3"">"
	' 	Response.Write "<div class=""row"">"
	' 		Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
	' 			Response.Write "<div class=""card"">"
    '                 Response.Write "<div class=""card-header text-white bg-success"">" & translate("Hareket Ayrıntıları","","") & " : </div>"
    '                 Response.Write "<div class=""card-body"">"
    '                     Response.Write "<div class=""row"">"
    '                         Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs mt-1"">"
    '                         '#### TABLO
    '                             Response.Write "<table class=""table table-striped table-bordered table-hover mt10""><thead><tr>"
    '                             Response.Write "<th>" & translate("Tarih","","") & "</th>"
    '                             Response.Write "<th>" & translate("Personel","","") & "</th>"
    '                             Response.Write "<th>" & translate("İşlem","","") & "</th>"
    '                             Response.Write "<th>" & translate("IP","","") & "</th>"
    '                             Response.Write "</tr></thead><tbody>"
    '                             sorgu = "Select top(10) *,(Select personel.personel.ad from personel.personel where personel.personel.id = personel.personel_log.personelID) as kidAd from personel.personel_log where firmaID = " & firmaID & " and modulAd = '" & modulAd & "' and gorevID = " & gorevID & ""
    '                             sorgu = sorgu & "order by id desc"
    '                             rs.open sorgu,sbsv5,1,3
    '                             if rs.recordcount > 0 then
    '                             for ri = 1 to rs.recordcount
    '                                 Response.Write "<tr>"
    '                                 Response.Write "<td>" & tarihtr(rs("tarih")) & "</td>"
    '                                 Response.Write "<td>" & rs("kidAd") & "</td>"
    '                                 Response.Write "<td>" & rs("islem") & "</td>"
    '                                 Response.Write "<td>" & rs("ip") & "</td>"
    '                                 Response.Write "</td>"
    '                                 Response.Write "</tr>"
    '                             rs.movenext
    '                             next
    '                             end if
    '                             rs.close
    '                             Response.Write "</table>"
    '                         '#### TABLO
    '                         Response.Write "</div>"
    '                     Response.Write "</div>"
    '                 Response.Write "</div>"
    '             Response.Write "</div>"
    '         Response.Write "</div>"
    '     Response.Write "</div>"
    '     Response.Write "</div>"
    ' end if
'### İŞLEM GEÇMİŞİ TABLOSU
'### İŞLEM GEÇMİŞİ TABLOSU





%><!--#include virtual="/reg/rs.asp" -->