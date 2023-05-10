<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid         =	kidbul()
    modulAd =   "Dashboard"
    modulID =   "158"
    islem       =   Request.QueryString("islem")
    modul       =   Request.QueryString("modul")
    modulArr    =   Array("","doviz","webmail","gorevPersonel","gorevDurum","gorevListesi","islemLog","havaDurumu","teklifDurum")
    modulAdArr  =   Array("","Döviz Bilgileri","Son Mailler","Görev İstatistikleri : Personel Bazlı","Görev İstatistikleri : Durum Bazlı","Görev Listesi : Bekleyenler","Panel İşlem Logları","Hava Durumu","Teklif İstatistikleri")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

if islem = "sil" then
    sorgu = "delete portal.dashboard where personelID = " & kid & " and modul = '" & modul & "'"
    rs.Open sorgu, sbsv5, 3, 3
    call logla("Dashboard düzenleniyor : Modul silindi : " & modul)
	call jsac("/dashboard/dashboard.asp?islem=edit")
end if



if islem = "ekle" then
    sorgu = "select * from portal.dashboard where personelID = " & kid & " and modul = '" & modul & "'"
    rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount = 0 then
	    call logla("Dashboard düzenleniyor : Modul eklendi : " & modul)
		rs.addnew
	end if
	rs("kid")			=	kid
	rs("firmaID")		=	firmaID
	rs("personelID")	=	kid
	rs("modul")			=	modul
	for mi = 0 to ubound(modulArr)
		if modul = modulArr(mi) then
			rs("modulAd")	=	modulAdArr(mi)
			exit for
		end if
	next
	rs("sira")			=	99
	rs.update
	rs.close
	call jsac("/dashboard/dashboard.asp?islem=edit")
end if



'### MEVCUT
	sorgu = "Select" & vbcrlf
	sorgu = sorgu & "* from portal.dashboard" & vbcrlf
	sorgu = sorgu & "where (personelID = " & kid & " or personelID = 0)" & vbcrlf
	rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount > 0 then
		degerlerGuncel = ""
		for i = 1 to rs.recordcount
			degerlerGuncel = degerlerGuncel & rs("modul")
			degerlerGuncel = degerlerGuncel & ","
		rs.movenext
		next
		degerlerGuncel = left(degerlerGuncel,len(degerlerGuncel)-1)
		degerlerGuncel = Split(degerlerGuncel,",")
	else
		degerlerGuncel = array("-")
	end if
	rs.close
'### MEVCUT













'#### DROP
    Response.Write "<div class=""container-fluid"">"
    Response.Write "<div class=""row mb-3"">"
        Response.Write "<div class=""col-lg-9 col-md-9 col-sm-9 col-xs-12"">"
            degerler = ""
            for ti = 0 to ubound(modulArr)
				guncelatla = False
				for tti = 0 to ubound(degerlerGuncel)
					if modulArr(ti) = degerlerGuncel(tti) then
						guncelatla = True
						exit for
					end if
				next
				if guncelatla = False then
					degerler = degerler & modulAdArr(ti)
					degerler = degerler & "="
					degerler = degerler & modulArr(ti)
					degerler = degerler & "|"
				end if
            next
            degerler = left(degerler,len(degerler)-1)
            call formselectv2("moduldrop",moduldrop,"$('#modalform').load('/dashboard/dashboard_duzenle.asp?islem=ekle&modul=' + this.value);","","","","moduldrop",degerler,"")
        Response.Write "</div>"
        Response.Write "<div class=""col-lg-3 col-md-3 col-sm-3 col-xs-12"">"
            Response.Write "<button type=""button"" class=""btn btn-warning form-control"" onClick="""">Ekle</button>"
        Response.Write "</div>"
    Response.Write "</div>"
    Response.Write "</div>"
'#### DROP



'#### ekrana dökme
	sorgu = "Select" & vbcrlf
	sorgu = sorgu & "* from portal.dashboard" & vbcrlf
	sorgu = sorgu & "where (personelID = " & kid & " or personelID = 0)" & vbcrlf
	sorgu = sorgu & "order by sira ASC" & vbcrlf
	rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount > 0 then
		'### HTML KISMI
			Response.Write "<div class=""container-fluid"">"
			Response.Write "<div class=""row"">"
			for i = 1 to rs.recordcount
				modul       =   rs("modul")
				modulAd     =   rs("modulAd")
				Response.Write "<div class=""" & modulBilgiBul(modul,"boyut") & " mb-2"">"
					Response.Write "<div class=""dashDiv bg-info p-2 text-small"">"
                        Response.Write "<i onClick=""$('#modalform').load('/dashboard/dashboard_duzenle.asp?islem=sil&modul=" & modul & "');"" class=""icon bin parmak"" style=""position:absolute;right:20px;"" title=""" & translate("Modulü Sil","","") & """></i>"
                    Response.Write modulAd
                    Response.Write "</div>"
				Response.Write "</div>"
			rs.movenext
			next
			Response.Write "</div>"
			Response.Write "</div>"
		'### HTML KISMI
	end if
	rs.close
'#### ekrana dökme



function modulBilgiBul(byVal modul,byVal bilgi)
	if modul = "doviz" then
		if bilgi = "dosya" then
			modulBilgiBul = "/portal/doviz_dashboard.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-4 col-md-4 col-sm-4 col-xs-12"
		end if
	elseif modul = "webmail" then
		if bilgi = "dosya" then
			modulBilgiBul = "/webmail/dashboard.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-4 col-md-4 col-sm-4 col-xs-12"
		end if
	elseif modul = "gorevPersonel" then
		if bilgi = "dosya" then
			modulBilgiBul = "/dashboard/it_gorevpersonel.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-4 col-md-4 col-sm-4 col-xs-12"
		end if
	elseif modul = "gorevDurum" then
		if bilgi = "dosya" then
			modulBilgiBul = "/dashboard/it_arizadurum.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-4 col-md-4 col-sm-4 col-xs-12"
		end if
	elseif modul = "gorevListesi" then
		if bilgi = "dosya" then
			modulBilgiBul = "/dashboard/it_ariza.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-8 col-md-8 col-sm-8 col-xs-12"
		end if
	elseif modul = "islemLog" then
		if bilgi = "dosya" then
			modulBilgiBul = "/dashboard/islemLog.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-4 col-md-4 col-sm-4 col-xs-12"
		end if
	elseif modul = "havaDurumu" then
		if bilgi = "dosya" then
			modulBilgiBul = "/dashboard/havadurumu.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-4 col-md-4 col-sm-4 col-xs-12"
		end if
	elseif modul = "teklifDurum" then
		if bilgi = "dosya" then
			modulBilgiBul = "/dashboard/teklif_durum.asp"
		elseif bilgi = "boyut" then
			modulBilgiBul = "col-lg-4 col-md-4 col-sm-4 col-xs-12"
		end if
	end if
end function







%><!--#include virtual="/reg/rs.asp" -->