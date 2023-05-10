<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    hata    =   ""
    modulAd =   "Toplu Mail"
    Response.Flush()
    mailadresi64 = Request.QueryString("a")
'###### ANA TANIMLAMALAR

call pageHeader()
    Response.Write "<div class=""container-fluid"">"
    Response.Write "<div class=""row mt-5"">"
        Response.Write "<div class=""col mt-3"">&nbsp;"
        Response.Write "</div>"




if mailadresi64 = "" then
else
    mailAdresi = base64_decode_tr(mailadresi64)
end if


if mailAdresi <> "" then
    if instr(mailAdresi,"@") > 0 then
        sorgu = "Select * from toplumail.blacklist where firmaID = " & firmaID & vbcrlf
        sorgu = sorgu & " and (adres = '" & mailAdresi & "')" & vbcrlf
        rs.Open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
        Response.Write "<div class=""col-6 text-center mt-3 bg-info p-5"">"
            Response.Write "We can not find your mail address to our database. Probably you already deleted or didn't added"
        Response.Write "</div>"
        else
            rs.addnew
                rs("firmaID")   =   firmaID
                rs("adres")     =   mailAdresi
                rs("kaynak")    =   "Unsubscribe Link"
                Response.Write "<div class=""col-6 text-center mt-3"">"
                    Response.Write "Your mail address removed our mail list"
                Response.Write "</div>"
            rs.update
        end if
        rs.close
    end if
end if


        Response.Write "<div class=""col mt-3"">&nbsp;"
        Response.Write "</div>"
    Response.Write "</div>"
    Response.Write "</div>"
call pageFooter()


%><!--#include virtual="/reg/rs.asp" -->