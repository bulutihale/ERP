<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
    modulAd 		=   "Döviz Hesaplayıcı"
    dovizPBArr      =   "--Para Birimi--=|TRY=TRY|USD=USD|EUR=EUR|GBP=GBP"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Döviz Hesaplayıcı")

'#### DÖVİZLER
        sorgu = "Select usdtry,eurtry,gbptry from portal.doviz order by dovizID desc"
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount > 0 then
            usdtry  =   rs("usdtry")
            eurtry  =   rs("eurtry")
            gbptry  =   rs("gbptry")
        end if
        rs.close
'#### DÖVİZLER

'### form
            Response.Write "<div class=""container-fluid"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-6"">"
                    call forminput("doviz1","1","dovizFiyatHesapla()","","doviz1","","doviz1","")
                Response.Write "</div>"
                Response.Write "<div class=""col-md-6"">"
                    call formselectv2("doviz1PB","USD","dovizFiyatHesapla()","","","","doviz1PB",dovizPBArr,"")
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "<div class=""row mt-3"">"
                Response.Write "<div class=""col-md-6"">"
                    call forminput("doviz2",replace(usdtry,",","."),"","","doviz2","readonly","doviz2","")
                Response.Write "</div>"
                Response.Write "<div class=""col-md-6"">"
                    call formselectv2("doviz2PB","TRY","dovizFiyatHesapla()","","","","doviz2PB",dovizPBArr,"")
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"
'### form


Response.Write "<scr" & "ipt>"
  Response.Write "function dovizFiyatHesapla() {"
    Response.Write "usdtry = " & replace(usdtry,",",".") & ";"
    Response.Write "eurtry = " & replace(eurtry,",",".") & ";"
    Response.Write "gbptry = " & replace(gbptry,",",".") & ";"
    Response.Write "usdtry = parseFloat(usdtry);"
    Response.Write "doviz1 = $('#doviz1').val();"
    Response.Write "doviz1PB = $('#doviz1PB').val();"
    Response.Write "doviz2PB = $('#doviz2PB').val();"

    Response.Write "if(doviz1PB=='TRY'){"
        Response.Write "if(doviz2PB=='TRY'){"
            Response.Write "sonuc = doviz1"
        Response.Write "}else if(doviz2PB=='USD'){"
            Response.Write "sonuc = doviz1/usdtry;"
        Response.Write "}else if(doviz2PB=='EUR'){"
            Response.Write "sonuc = doviz1/eurtry;"
        Response.Write "}else if(doviz2PB=='GBP'){"
            Response.Write "sonuc = doviz1/gbptry;"
        Response.Write "};"
    Response.Write "};"

    Response.Write "if(doviz1PB=='EUR'){"
        Response.Write "if(doviz2PB=='EUR'){"
            Response.Write "sonuc = doviz1"
        Response.Write "}else if(doviz2PB=='USD'){"
            Response.Write "sonuc = doviz1*(eurtry/usdtry);"
        Response.Write "}else if(doviz2PB=='TRY'){"
            Response.Write "sonuc = doviz1*eurtry;"
        Response.Write "}else if(doviz2PB=='GBP'){"
            Response.Write "sonuc = doviz1*(eurtry/gbptry);"
        Response.Write "};"
    Response.Write "};"

    Response.Write "if(doviz1PB=='USD'){"
        Response.Write "if(doviz2PB=='USD'){"
            Response.Write "sonuc = doviz1"
        Response.Write "}else if(doviz2PB=='EUR'){"
            Response.Write "sonuc = doviz1*(usdtry/eurtry);"
        Response.Write "}else if(doviz2PB=='TRY'){"
            Response.Write "sonuc = doviz1*usdtry;"
        Response.Write "}else if(doviz2PB=='GBP'){"
            Response.Write "sonuc = doviz1*(usdtry/gbptry);"
        Response.Write "};"
    Response.Write "};"

    Response.Write "if(doviz1PB=='GBP'){"
        Response.Write "if(doviz2PB=='GBP'){"
            Response.Write "sonuc = doviz1"
        Response.Write "}else if(doviz2PB=='EUR'){"
            Response.Write "sonuc = doviz1*(gbptry/eurtry);"
        Response.Write "}else if(doviz2PB=='TRY'){"
            Response.Write "sonuc = doviz1*gbptry;"
        Response.Write "}else if(doviz2PB=='USD'){"
            Response.Write "sonuc = doviz1*(gbptry/usdtry);"
        Response.Write "};"
    Response.Write "};"

    Response.Write "$('#doviz2').val(sonuc);"
  Response.Write "}"
Response.Write "</scr" & "ipt>"




%><!--#include virtual="/reg/rs.asp" -->