<!--#include virtual="/reg/rs.asp" --><%

Server.ScriptTimeout = 9000

if sb_sqlYedekCompress = "" then
    sb_sqlYedekCompress = true
end if


Response.Write "Start : " & now() & "<br />"
Response.Flush()

	sorgu = "BACKUP DATABASE " & sb_dbad & " TO DISK = '" & sb_fizikselPath & "yedek" & unique() & ".bak'"
    if sb_sqlYedekCompress = true then
        sorgu = sorgu & " WITH COMPRESSION"
    end if
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open sorgu, sbsv5, 1, 3

Response.Write "Finish : " & now()
Response.Flush()

%><!--#include virtual="/reg/rs.asp" -->