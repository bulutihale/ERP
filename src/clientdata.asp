<!--#include virtual="/reg/rs.asp" --><%

username    =   Request.QueryString("d")
username    =   Replace(username,"C:\Users\","")


if Request.ServerVariables("Remote_Addr") <> "192.168.0.145" then'rdp server
	sorgu = "Select top 1 * from personel.clientData"
	rs.Open sorgu, sbsv5, 1, 3
        rs.addnew
		rs("ip")      =   Request.ServerVariables("Remote_Addr")
		rs("username")      =   username
        rs.update
	rs.close
end if
%>