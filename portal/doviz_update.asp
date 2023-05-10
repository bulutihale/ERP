<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
    modulAd 		=   "Döviz"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	yetkiTeklif	    = yetkibul("Teklif")
	yetkiSatis  	= yetkibul("Satış")

if yetkiTeklif >= 3 or yetkiSatis > 2 then
    islem   =   Request.Form("islem")
    usd     =   Request.Form("usd")
    eur     =   Request.Form("eur")
    gbp     =   Request.Form("gbp")

    if isnumeric(usd) = False or isnumeric(eur) = False or isnumeric(gbp) = False then
        hatamesaj = translate("Kur bölümüne lütfen rakam yazın","","" )
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","",translate("Tamam","","" ),"","btn-danger","","","","","")
        Response.End()
    end if
    sorgu = "Select top 1 * from portal.doviz"
    sorgu = sorgu & " where firmaID = " & firmaID
    sorgu = sorgu & " and tarih >= '" & tarihsql(date()) & "'"
    rs.Open sorgu, sbsv5, 1, 3
    if rs.recordcount = 0 then
        hatamesaj = translate("Kritik hata!! Güncelleme yapılamadı.","","" )
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","",translate("Tamam","","" ),"","btn-danger","","","","","")
        Response.End()
    else
        if islem = "custom" then
            usd = Replace(usd,".",",")
            eur = Replace(eur,".",",")
            gbp = Replace(gbp,".",",")
            hatamesaj = translate("Döviz kurları yazdığınız şekilde güncellendi","","" )
        else
            usd = kurcek("USD")
            eur = kurcek("EUR")
            gbp = kurcek("GBP")
            hatamesaj = translate("Döviz kurları merkez bankasından çekildi ve güncellendi","","" )
            call jsrundelay("$('.dashdovizDiv').load('/portal/doviz_dashboard.asp');",5)
        end if
        rs("usdtryCustom")  =   usd
        rs("eurtryCustom")  =   eur
        rs("gbptryCustom")  =   gbp
        rs.update
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","",translate("Tamam","","" ),"","btn-success","","","","","")
        hatamesaj = translate("Yeni döviz kurları","","" ) & " : usd = " & usd & " eur = " & eur & " gbp = " & gbp
        call logla(hatamesaj)
    end if
    rs.close
else
	hatamesaj = translate("Döviz kurlarını güncelleme yetkiniz bulunmamaktadır","","" )
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","",translate("Tamam","","" ),"","btn-danger","","","","","")
	Response.End()
end if
%>