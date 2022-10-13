<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Personel"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


'#### ZAMANLANMIŞ GÖREVLER
'#### ZAMANLANMIŞ GÖREVLER
	Response.Write "<scr" & "ipt type=""text/javascript"">"
'	Response.Write "$().ready(function(){"
'        Response.Write "setTimeout(function(){"
'            Response.Write "$('#activeuserUrl').load('" & sb_activeuserUrl & "')"
'        Response.Write ";}, " & sb_activeuserTime & "000 );"
'   Response.Write "});"
	Response.Write "</scr" & "ipt>"
'#### ZAMANLANMIŞ GÖREVLER
'#### ZAMANLANMIŞ GÖREVLER


'#### BİLDİRİM YÖNETİMİ
'#### BİLDİRİM YÖNETİMİ
    sorgu = "Select count(*) from portal.notification where okundu = 0 and firmaID = " & firmaID & " and kid = " & kid
    rs.Open sorgu, sbsv5, 1, 3
        bildirimsayi = rs(0)
        'sayıyı güncelle
        if bildirimsayi = 0 then
            'd-none varsa bişey yapma, yoksa d-none ekle
        else
            '## d-none varsa sil
                komut = "if($('.bildirimcontainer').hasClass('d-none')){$('.bildirimcontainer').removeClass('d-none');}"
                call jsrun(komut)
            '## d-none varsa sil
        end if
    rs.close
'#### BİLDİRİM YÖNETİMİ
'#### BİLDİRİM YÖNETİMİ




%>