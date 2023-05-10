<!--#include virtual="/reg/rs.asp" --><%

on error resume next

'####### GET DATA
    remoteIP    =   Request.ServerVariables("REMOTE_ADDR")
    localIP     =   left(Request.Form("localIP"),20)
    kid         =   left(Request.Form("kid"),5)
    firmaID     =   left(Request.Form("firmaID"),5)
'####### GET DATA


'####### DATA KONTROL
    if kid = "" then
        kid = 0
    end if
    if localIP = "" then
        localIP = ""
    end if
    if remoteIP = "" then
        remoteIP = ""
    end if
    if firmaID = "" then
        firmaID = 0
    end if
'####### DATA KONTROL




'###### KAYDI AL
    sorgu = "Select top 1 * from portal.whereiam"
    rs.Open sorgu, sbsv5, 1, 3
    rs.addnew
        rs("localIP")       =   localIP
        rs("remoteIP")      =   remoteIP
        rs("kid")           =   kid
        rs("firmaID")       =   firmaID
    rs.update
    rs.close
'###### KAYDI AL


'##### BLOKLAMA
    sorgu = "select silindi from portal.firma"
    rs.Open sorgu, sbsv5, 1, 3
        silindi = rs("silindi")
    rs.close
    if silindi = 1 then
        Response.Write "1"
    elseif silindi = 0 then
        Response.Write "0"
    else
        Response.Write ""
    end if
'##### BLOKLAMA

on error goto 0


%><!--#include virtual="/reg/rs.asp" -->