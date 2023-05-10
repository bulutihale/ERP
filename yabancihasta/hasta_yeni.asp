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
    modulAd =   "YHBilgiler"
    hastaID =   gorevID
    Response.Flush()
	operasyoncuDegerler		=	"=|LIZA=4|TUĞBA=3"
	paraBirimDegerler = "=|EUR=EUR|USD=USD|GBP=GBP"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Hasta Bilgileri Giriş Ekranı")

yetkiYabanciHasta = yetkibul("yabancihasta")

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiYabanciHasta > 2 then
        '## HASTA BİLGİLERİNİ AL
        '## HASTA BİLGİLERİNİ AL
			if gorevID <> "" then
            sorgu = "Select top 1 * from yabancihasta.hasta where hastaID = " & gorevID
            rs.open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				hastaAd			=	rs("hastaAd")
				hastaTelefon	=	rs("hastaTelefon")
				hastaEmail		=	rs("hastaEmail")
				hastaPasaport	=	rs("hastaPasaport")
				hastaCagriKaynak=	rs("hastaCagriKaynak")
				hastaAcenta		=	rs("hastaAcenta")
				hastaUlke		=	rs("hastaUlke")
                hastaParaBirim	=   rs("hastaParaBirim")
				hastaNot		=	rs("hastaNot")
				personelOperasyoncuID	=	rs("personelOperasyoncuID")
			end if
            rs.close
			end if
        '## HASTA BİLGİLERİNİ AL
        '## HASTA BİLGİLERİNİ AL



		Response.Write "<form action=""/yabancihasta/hasta_ekle.asp"" method=""post"" class=""ajaxform"">"
		call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")
		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-6 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Hasta Adı Soyadı","","") & "</span>"
		call forminput("hastaAd",hastaAd,"otomatikbuyut('hastaAd')","","hastaAd","autocompleteOFF","hastaAd","")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-6 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("GSM","","") & "</span>"
		call forminput("hastaTelefon",hastaTelefon,"","","hastaTelefon","autocompleteOFF","hastaTelefon","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-6 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Eposta Adresi","","") & "</span>"
		call forminput("hastaEmail",hastaEmail,"","","hastaEmail","autocompleteOFF","hastaEmail","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-6 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Pasaport Numarası","","") & "</span>"
		call forminput("hastaPasaport",hastaPasaport,"","","hastaPasaport","autocompleteOFF","hastaPasaport","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-6 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Çağrı Kaynağı","","") & "</span>"
			degerler = "=|Facebook Instagram Lead=Facebook Instagram Lead|Instagram DM=Instagram DM|Facebook DM=Facebook DM|Reference=Reference|Web Site=Web Site|Whatclinic=Whatclinic|WhatsApp=WhatsApp"
			call formselectv2("hastaCagriKaynak",hastaCagriKaynak,"","","","","hastaCagriKaynak",degerler,"")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-6 my-1"">"
			Response.Write "<div class=""badge badge-secondary"">" & translate("Acenta","","") & "</div>"
			degerler = "=|GIH=GIH|BNC=BNC|HERMES=HERMES|GETSLIM=GETSLIM"
			call formselectv2("hastaAcenta",hastaAcenta,"","","","","hastaAcenta",degerler,"")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-6 my-1"">"
							sorgu = "Select ulkeAd from portal.ulke order by ulkeAd ASC"
							rs.open sorgu,sbsv5,1,3
							if rs.recordcount > 0 then
							Response.Write "<div class=""badge badge-secondary"">" & translate("Geldiği Ülke","","") & "</div>"
									degerler = "=|"
									do while not rs.eof
										degerler = degerler & rs("ulkeAd")
    									degerler = degerler & "="
										degerler = degerler & rs("ulkeAd")
										degerler = degerler & "|"
									rs.movenext
									loop
									degerler = left(degerler,len(degerler)-1)
								call formselectv2("hastaUlke",hastaUlke,"","","","","hastaUlke",degerler,"")
							end if
							rs.close
		Response.Write "</div>"


		Response.Write "<div class=""col-sm-6 my-1"">"
			Response.Write "<div class=""badge badge-secondary"">" & translate("Para Birimi","","") & "</div>"
			call formselectv2("hastaParaBirim",hastaParaBirim,"","","","","hastaParaBirim",paraBirimDegerler,"")
		Response.Write "</div>"

call clearfix()

	if yetkiYabanciHasta >= 7 then

							sorgu = "Select id,ad from personel.personel where firmaID = " & firmaID & " and (gorev = 'OPERATION')"
							rs.open sorgu,sbsv5,1,3
							if rs.recordcount > 0 then
									degerler = ""
									do while not rs.eof
										degerler = degerler & rs("ad")
    									degerler = degerler & "="
										degerler = degerler & rs("id")
										degerler = degerler & "|"
									rs.movenext
									loop
									personelDegerler = left(degerler,len(degerler)-1)
							end if
							rs.close

		Response.Write "<div class=""col-sm-12 my-1"">"
			Response.Write "<div class=""badge badge-secondary"">" & translate("Sorumlu Operasyon Personeli","","") & "</div>"
			call formselectv2("personelOperasyoncuID",personelOperasyoncuID,"","","","","personelOperasyoncuID",personelDegerler,"")
		Response.Write "</div>"
		call clearfix()
	end if

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Not","","") & "</span>"
		Response.Write "<textarea class=""form-control"" name=""hastaNot"">" & hastaNot & "</textarea>"
		Response.Write "</div>"

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