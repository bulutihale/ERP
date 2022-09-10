<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modulAd =   "Teklif"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Teklif Listesi Ekranı")

yetkiTeklif = yetkibul(modulAd)


if yetkiTeklif > 0 then
    call dataTableYap("deneme","Durum,Firma Adı,Teklif Sayı,Teklif Türü,Tarih,Personel,İşlemler","/teklif/json_teklif.asp","","","","","","","","","")
else
    call yetkisizGiris("","","")
end if










function dataTableYap(byVal dtad, byVal dtbasliklar, byVal dtjsonfile,byVal dtislemler, byVal dtsql, byVal ek1, byVal ek2, byVal ek3, byVal ek4, byVal ek5, byVal ek6, byVal ek7)
    'dtad = sayfada birden fazla datatable varsa diye ayrıştırıcı isim. Türkçe karakter ve numara olmaz
    'dtbasliklar = virgül ile ayrılmış başlıklar
    'dtjsonfile = json dosya yolu
    'dtislemler = işlemler alanı var - yok
    'dtsql = opsiyonel.  dosya içinde gösterilecek sorgu.
    Response.Write "<div class=""card"">"
    Response.Write "<div class=""card-body"">"
    Response.Write "<div class=""row"">"
    Response.Write "<div class=""col-12"">"
    Response.Write "<div class=""table-responsive"">"
        Response.Write "<table id=""" & dtad & """ class=""display"" cellspacing=""0"" width=""100%"">"
        Response.Write "<thead>"
        Response.Write "<tr>"
        dtbaslikarr = Split(dtbasliklar,",")
        for dth = 0 to ubound(dtbaslikarr)
            Response.Write "<th>" & dtbaslikarr(dth) & "</th>"
        next
        Response.Write "</thead>"
        Response.Write "</table>"
    Response.Write "</div>"
    Response.Write "</div>"
    Response.Write "</div>"
    Response.Write "</div>"
    Response.Write "</div>"

    Response.Write "<scr" & "ipt type=""text/javascript"">"
        Response.Write "$(document).ready(function() {"
            Response.Write "$('#" & dtad & "').dataTable( {"
                Response.Write "'lengthMenu': [[50, 100, 200, 500, 1000, -1], [50, 100, 200, 500, 1000, '" & translate("Hepsi","","") & "']]"
                Response.Write ",processing: true"
                Response.Write ",serverSide: true"
                Response.Write ",order: [[ 4, ""desc"" ]]"
                Response.Write ",ajax: '" & dtjsonfile & "'"
                Response.Write ",'language': {"
                Response.Write "'lengthMenu': '" & translate("Sayfa başına _MENU_ kayıt gösteriliyor","","") & "'"
                Response.Write ",'zeroRecords': '" & translate("Kayıt bulunamadı","","") & "'"
                Response.Write ",'info': '" & translate("_PAGE_ - _PAGES_ arası sayfalar gösteriliyor","","") & "'"
                Response.Write ",'infoEmpty': '" & translate("Kayıt bulunamadı","","") & "'"
                Response.Write ",'infoFiltered': '" & translate("(_MAX_ kayıt filtreleniyor)","","") & "'"
                Response.Write ",'emptyTable': '" & translate("Veri Bulunamadı","","") & "'"
                Response.Write ",'infoPostFix':''"
                Response.Write ",'thousands':  ','"
                Response.Write ",'loadingRecords': '" & translate("Yükleniyor","","") & "'"
                Response.Write ",'processing': '" & translate("İşleniyor","","") & "'"
                Response.Write ",'search': '" & translate("Ara :","","") & "'"
                Response.Write ",'paginate': {'first':'" & translate("İlk","","") & "','last':'" & translate("Son","","") & "','next':'" & translate("Sonraki","","") & "','previous':'" & translate("Önceki","","") & "'}"
                Response.Write "}"
            Response.Write "});"
        Response.Write "});"
    Response.Write "</scr" & "ipt>"



end function


















%>