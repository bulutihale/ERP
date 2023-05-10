<!--#include virtual="/reg/rs.asp" --><%


bu dosya silinsin






Response.Write "<!DOCTYPE html><html lang=""en""><head><meta charset=""utf-8""></head>"

    sorgu = "Select * from personel.personel where firmaID = 2 and email is null"
	rs.Open sorgu, sbsv5, 1, 3
    if rs.recordcount > 0 then
        for i = 1 to rs.recordcount
            Response.Write rs("ad") & "<br />"
            ad = rs("ad")
            ad = htmlad(ad)
            ad = replace(ad,"-",".")
            Response.Write instr(ad,".")
            kalanad = right(ad,len(ad)-instr(ad,"."))
            if instr(kalanad,".") = 0 then
                Response.Write "<br />"
                Response.Write "Email : " & ad & "@agrobestgrup.com" & "<br />"
                rs("email") = ad & "@agrobestgrup.com"
                rs.update
            else
                Response.Write "<br />Hatalı "
                Response.Write "Email : " & ad & "" & "<br />"
            end if
        rs.movenext
        next
    end if
    rs.close

%>