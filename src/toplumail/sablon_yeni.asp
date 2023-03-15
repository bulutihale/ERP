<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    Response.Flush()
    gorevID = Request.QueryString("sablonID")
    islem = Request.QueryString("islem")
    tur = Request.QueryString("tur")
'###### ANA TANIMLAMALAR


call logla("Yeni Toplu Mail Şablonu Ekleme Ekranı")
yetkiTM = yetkibul(modulAd)


'### SAYFA ID TESPİT ET
	if hata = "" then
		if gorevID <> "" then
			gorevID64   =   gorevID
			gorevID		=	base64_decode_tr(gorevID)
        end if
	end if
'### SAYFA ID TESPİT ET


if yetkiTM >= 3 then
    if gorevID <> "" then
        sorgu = "Select top 1 * from toplumail.sablon where firmaID = " & firmaID & " and sablonID = " & gorevID
        rs.open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            sablonBaslik    =   rs("sablonBaslik")
            sablonIcerik    =   rs("sablonIcerik")
            if isnull(rs("smsBaslikID")) = true then
                tur = "mail"
            elseif rs("smsBaslikID") = 0 then
                tur = "mail"
            end if
        else
            hata = 1
        end if
        rs.close
    end if
end if




        '### ŞABLONLAR
            sorgu = "Select * from toplumail.smsBaslik where firmaID = " & firmaID & " and silindi = 0"
            sorgu = sorgu & " order by baslik ASC"
            rs.open sorgu,sbsv5,1,3
            if rs.recordcount > 0 then
                degerler = "=|"
                for oi = 1 to rs.recordcount
                    if sablonBaslik = rs("baslik") then
                        smsBaslikID = rs("smsBaslikID")
                    end if
                    degerler = degerler & rs("baslik")
                    degerler = degerler & "="
                    degerler = degerler & rs("smsBaslikID")
                    degerler = degerler & "|"
                rs.movenext
                next
                degerlerSablon = left(degerler,len(degerler)-1)
            end if
            rs.close
        '### ŞABLONLAR








if yetkiTM >= 3 then
    if hata = "" then
		Response.Write "<form action=""/toplumail/sablon_kaydet.asp"" method=""post"" class=""ajaxform"" enctype=""multipart/form-data"">"
        call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")
        call forminput("tur",tur,"","","tur","hidden","tur","")
		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Başlık","","") & "</span>"
        if tur = "mail" then
		    call forminput("sablonBaslik",sablonBaslik,"","","","autocompleteOFF","sablonBaslik","")
        elseif tur = "sms" then
            call formselectv2("smsBaslikID",smsBaslikID,"","","","","smsBaslikID",degerlerSablon,"")
        end if
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
        if tur = "mail" then
            Response.Write "<span class=""badge badge-secondary"">" & translate("İçerik","","") & "</span>"
            call clearfix()
            Response.Write "<textarea class=""summernote sablonIcerik"" name=""sablonIcerik"">" & sablonIcerik & "</textarea>"
        elseif tur = "sms" then
            Response.Write "<span class=""badge badge-secondary"">" & translate("İçerik","","") & " [<span id=""smslength"">" & len(sablonIcerik) & "</span>]</span>"
            call clearfix()
            Response.Write "<textarea class=""sablonIcerik form-control"" name=""sablonIcerik"" onKeyUp=""$('#smslength').text(this.value.length)"">" & sablonIcerik & "</textarea>"
        end if
		Response.Write "</div>"

        if tur = "mail" then
            Response.Write "<div class=""col-sm-12 my-1"">"
                Response.Write "<span class=""badge badge-secondary"">" & translate("Ek Dosya","","") & "</span>"
                Response.Write "<div><input type=""file"" name=""resim1"" /></div>"
            Response.Write "</div>"
        end if

        if tur = "mail" then
		    Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"" onClick=""$('.summernote').summernote('code');$('.summernote').summernote('destroy');"">" & translate("Kaydet","","") & "</button></div>"
        elseif tur = "sms" then
		    Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("Kaydet","","") & "</button></div>"
        end if
		Response.Write "</div>"
		Response.Write "</form>"
	end if
end if

%><!--#include virtual="/reg/rs.asp" -->