<!--#include virtual="/reg/rs.asp" --><%


Response.Write geoIP("ilçe","31.223.84.240")
Response.Write geoIP("ilçe","212.156.34.226")



' function geoIP(byVal alan,byVal gelenIP)
'     if gelenIP = "" then
'         gelenIP = Request.ServerVariables("REMOTE_ADDR")
'         gelenIP = "31.223.84.240"
'     end if
'     IParr = Split(gelenIP,".")
'     IPSub = IParr(0) & "." & IParr(1) & "." & IParr(2) & "."
'     sorgu = "Select top 1 v3,v4,v5,v6 from portal.geoIP where IP1 like '" & IPSub & "%'"
'     rs.open sorgu, sbsv5,1,3
'         if rs.recordcount > 0 then
'             if alan = "şehir" then
'                 geoIP = rs("v3")
'             elseif alan = "ilçe" then
'                 geoIP = rs("v4")
'             elseif alan = "konum" then
'                 geoIP = rs("v5") & "," & rs("v6")
'             else
'                 geoIP = ""
'             end if
'         else
'             geoIP = ""
'         end if
'     rs.close
' end function



' '#### evren için
' sonuc = xmlverigonder("https://erp.sbstasarim.com/portal/ipnedir.asp","","POST","text","","","","","")
' Response.Write sonuc
' '#### evren için


%>