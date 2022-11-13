<!--#include virtual="/reg/rs.asp" --><%

'//FIXME - webmail için bilgileri tanımlama


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    hata    =   ""
    modulAd =   "personel"
    hastaID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Personel Bilgileri Giriş Ekranı")

yetkiPersonel = yetkibul("personel")


'###### 64 DÖNÜŞÜM
'###### 64 DÖNÜŞÜM
    if gorevID = "" then
    else
        gorevID = base64_decode_tr(gorevID)
    end if
'###### 64 DÖNÜŞÜM
'###### 64 DÖNÜŞÜM


'###### ARAMA FORMU
'###### ARAMA FORMU
	' if hata = "" and yetkiPersonel > 2 then
        '## HASTA BİLGİLERİNİ AL
        '## HASTA BİLGİLERİNİ AL
			if gorevID <> "" then
                sorgu = "Select top 1 * from personel.personel where id = " & gorevID
                rs.open sorgu, sbsv5, 1, 3
                if rs.recordcount > 0 then
                    id			    =	rs("id")
                    ad			    =	rs("ad")
                    gorev	        =	rs("gorev")
                    password	    =	rs("password")
                    expiration	    =	rs("expiration")
                    ceptelefon      =	rs("ceptelefon")
                    email		    =	rs("email")
                    LoginHatirla	=	rs("LoginHatirla")
                    language	    =   rs("language")
                    SSOID           =   rs("SSOID")
                    call logla("Personel Bilgileri : " & ad)
                end if
                rs.close
			end if
        '## HASTA BİLGİLERİNİ AL
        '## HASTA BİLGİLERİNİ AL



'############# GÖREVLER
							sorgu = "Select distinct(gorev) from personel.personel where firmaID = " & firmaID & " order by gorev ASC"
							rs.open sorgu,sbsv5,1,3
							' if rs.recordcount > 0 then
									degerler = ""
									do while not rs.eof
										degerler = degerler & rs("gorev")
    									degerler = degerler & "="
										degerler = degerler & rs("gorev")
										degerler = degerler & "|"
									rs.movenext
									loop
									gorevDegerler = left(degerler,len(degerler)-1)
							' end if
							rs.close
'############# GÖREVLER





		Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<form action=""/personel/personel_ekle.asp"" method=""post"" class=""ajaxform"">"
		call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")
		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Personel Adı Soyadı","","") & "</span>"
        if yetkiPersonel >= 5 then
		    call forminput("ad",ad,"otomatikbuyut('ad')","","ad","autocompleteOFF","ad","")
        else
            call forminput("ad",ad,"otomatikbuyut('ad')","","ad","readonly","ad","")
        end if
		Response.Write "</div>"
    
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("GSM","","") & "</span>"
		call forminput("ceptelefon",ceptelefon,"","","ceptelefon","autocompleteOFF","ceptelefon","")
		Response.Write "</div>"
        if isnull(SSOID) = true then
            Response.Write "<div class=""col-sm-12 my-1"">"
            Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Şifre","","") & "</span>"
            call forminput("password","","","","password","autocompleteOFF","password","")
            Response.Write "</div>"
        end if
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Eposta Adresi","","") & "</span>"
        if yetkiPersonel >= 5 then
		    call forminput("email",email,"","","email","autocompleteOFF","email","")
        else
            call forminput("email",email,"","","email","readonly","email","")
        end if
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Görev","","") & "</span>"
        if yetkiPersonel >= 5 then
            call formselectv2("gorev",gorev,"","","","","gorev",gorevDegerler,"")
            'drop
        else
            call forminput("gorev",gorev,"","","gorev","readonly","gorev","")
        end if
		Response.Write "</div>"

        if yetkiPersonel >= 5 then
            Response.Write "<div class=""col-sm-12 my-1"">"
            Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Son Kullanma Tarihi","","") & "</span>"
            call forminput("expiration",expiration,"","","tarih","autocompleteOFF","expiration","")
            Response.Write "</div>"
        end if

call clearfix()

		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("Kaydet","","") & "</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
'###### ARAMA FORMU
'###### ARAMA FORMU









'### İŞLEM GEÇMİŞİ TABLOSU
'### İŞLEM GEÇMİŞİ TABLOSU
    if hata = "" and yetkiPersonel = 9 and gorevID > 0 then
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