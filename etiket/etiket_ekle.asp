<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.Form("gorevID")
    islem   =   Request.QueryString("islem")
    hata    =   ""
    modulAd =   "Etiket"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Etiket Bilgileri Giriş Ekranı")

yetkiEtiket = yetkibul("Etiket")


'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL
                stokAdi =   Request.Form("stokAdi")
                stokKodu =   Request.Form("stokKodu")
                mamulAdi =   Request.Form("mamulAdi")
                dil =   Request.Form("dil")
                mensei =   Request.Form("mensei")
                grubu =   Request.Form("grubu")
                olcu =   Request.Form("olcu")
                durum =   Request.Form("durum")
                pantoneKodu = Request.Form("pantoneKodu")
                revizyon = Request.Form("revizyon")
                revizyonClone   =   Request.Form("revizyonClone")
                aciklama   =   Request.Form("aciklama")
'###### FORM BİLGİLERİNİ AL
'###### FORM BİLGİLERİNİ AL



'#### VERİ KONTROL
'#### VERİ KONTROL
if stokKodu = "" then
	hatamesaj = translate("Lütfen stok kodunu yazın","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if
if stokAdi = "" then
	hatamesaj = translate("Lütfen stok adını yazın","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if
if mamulAdi = "" then
	hatamesaj = translate("Lütfen mamül adını yazın","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if
if mensei = "" then
	hatamesaj = translate("Lütfen mensei yazın","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if
if revizyon = "" then
	hatamesaj = translate("Lütfen revizyon adını yazın","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if
if durum = "" then
	hatamesaj = translate("Lütfen etiket durumunu seçin","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if
if olcu = "" then
	hatamesaj = translate("Lütfen etiket ölçüsünü yazın","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if
if durum = "DURDURULDU" then
    if aciklama = "" then
        hatamesaj = translate("Lütfen durdurulma sebebini açıklama alanına yazın","","")
        call logla(hatamesaj)
        call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
        Response.End()
    end if
end if
'#### VERİ KONTROL
'#### VERİ KONTROL





'#### DUPLİCATE EKLEMEYİ ENGELLEMEK
'#### DUPLİCATE EKLEMEYİ ENGELLEMEK
    if stokKodu <> "" and revizyon <> "" and gorevID = "" then
        sorgu = "Select top 1 * from agrobest.etiket"
        sorgu = sorgu & " where agrobest.etiket.stokKodu = '" & stokKodu & "' and revizyon = '" & revizyon & "'"
        rs.Open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            hatamesaj = translate("Girmiş olduğunuz stok kodlu etiket daha önce eklenmiş.<br />Yeni ekleme yapılmadı","","")
            call logla(hatamesaj)
            call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
            Response.End()
        end if
        rs.close
    end if
'#### DUPLİCATE EKLEMEYİ ENGELLEMEK
'#### DUPLİCATE EKLEMEYİ ENGELLEMEK













'####### INSERT - UPDATE
'####### INSERT - UPDATE
    sorgu = "Select top 1 * from agrobest.etiket"
    if gorevID <> "" then
	    sorgu = sorgu & " where agrobest.etiket.etiketID = " & gorevID
    end if
	rs.Open sorgu, sbsv5, 1, 3
		if gorevID = "" then
            rs.addnew
        end if
        if revizyonClone <> "" then
            if revizyon = rs("revizyon") then
                hatamesaj = translate("Revizyon numarasını değiştrmeyi unuttunuz","","")
                call logla(hatamesaj)
                call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
                Response.End()
            end if
        end if
        if revizyonClone <> "" then
            rs("sonRevizyon") = False
            rs.update
            rs.addnew
        end if
        rs("stokAdi")     =   stokAdi
        rs("stokKodu")     =   stokKodu
        rs("mamulAdi")          =   mamulAdi
        rs("dil")          =   dil
        rs("mensei")         =   mensei
        rs("grubu")           =   grubu
        rs("olcu")       =   olcu
        rs("durum")       =   durum
        rs("pantoneKodu")       =   pantoneKodu
        rs("revizyon")       =   revizyon
        rs("aciklama")       =   aciklama
        rs("tarih")            =    now()
    rs.update
    gorevIDyeni = rs("etiketID")
    rs.close
'####### INSERT - UPDATE
'####### INSERT - UPDATE






if gorevID = "" then
    hatamesaj = "Yeni Etiket Eklendi : " & stokKodu
    gorevID = gorevIDyeni
    call logla(hatamesaj)
    call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
else
    hatamesaj = "Etiket Bilgileri Güncellendi : " & stokKodu
    gorevID = gorevIDyeni
    call logla(hatamesaj)
    call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
end if




call jsac("/etiket/liste.asp")

' call modalkapat()

%><!--#include virtual="/reg/rs.asp" -->