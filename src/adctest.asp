<!--#include virtual="/reg/rs.asp" --><%

Response.Charset		=	"utf-8"

adclogin    =   False

Response.Flush()


DCuser = "emre.celik"
DCpass = "Y&jQ;6j7}P)wm(mt"
DCislem = "1"
DCDomain = "agrobestgroup"


if DCislem = "1" then
    if DCuser <> "" and DCpass <> "" and DCDomain <> "" then
        if instr(DCuser,"\") > 0 then
            DCuser = "agrobestgroup\" & DCuser'adrossen olabilir
            RQdata = Split(DCuser,"\")
        end if
        Set objConnection = CreateObject("ADODB.Connection")
        objConnection.Provider = "ADsDSOObject"
        With objConnection
            .Properties("User ID") = DCuser
            .Properties("Password") = DCpass
            .Properties("Encrypt password") = True
        End With
        objConnection.Open "Active Directory Provider"
        Set objCommand = CreateObject("ADODB.Command")
        Set objCommand.ActiveConnection = objConnection
        objCommand.Properties("Searchscope") = 2
        DCalanlar = Split("distinguishedname,givenName,sn,displayName,telephoneNumber,otherTelephone,mail,wWWHomePage,url,streetAddress,l,st,postalCode,userPrincipalName,sAMAccountName,userAccountControl,profilePath,scriptPath,homeDirectory,homeDrive,homeDirectory,title,department,company,manager,mobile,facsimileTelephoneNumber,info",",")
        DCSorgu = ""
        DCSayi = 27
            for i = 0 to DCSayi'ubound(DCalanlar)-1
                DCSorgu = DCSorgu & DCalanlar(i)
                DCSorgu = DCSorgu & ","
            next
        objCommand.CommandText ="select " & DCSorgu & "c FROM 'LDAP://agrobestgroup.local:389' where sAMAccountName = '" & DCuser & "' ORDER by sAMAccountname"
        on error resume next
            Set objRecordSet = objCommand.Execute
            ' userdn = objRecordSet.fields("distinguishedname")
            ' for i = 0 to DCSayi'ubound(DCalanlar)-1
            '     Response.Write DCalanlar(i)
            '     Response.Write ":"
            '     Response.Write objRecordSet.fields(DCalanlar(i))
            '     Response.Write "<br />"
            ' next
            DCfeedBack = ""
            DCfeedBack = DCfeedBack & objRecordSet.fields("displayName") & "|"
            DCfeedBack = DCfeedBack & objRecordSet.fields("telephoneNumber") & "|"
            DCfeedBack = DCfeedBack & objRecordSet.fields("mail") & "|"
            DCfeedBack = DCfeedBack & objRecordSet.fields("userAccountControl") & "|"
            DCfeedBack = DCfeedBack & objRecordSet.fields("title") & "|"
            DCfeedBack = DCfeedBack & objRecordSet.fields("department") & "|"
            DCfeedBack = DCfeedBack & objRecordSet.fields("mobile") & "|"
            DCfeedBack = DCfeedBack & objRecordSet.fields("facsimileTelephoneNumber") & "|"
            if err.Number = 0 then
                adclogin = True
            else
                adclogin = False
            end if
            DCfeedBack = adclogin & "|" & DCfeedBack
            Response.Write DCfeedBack
        on error goto 0
    end if
else
    if DCuser <> "" and DCpass <> "" and DCDomain <> "" then
        if instr(DCuser,"\") > 0 then
            DCuser = "agrobestgroup\" & DCuser'adrossen olabilir
            RQdata = Split(DCuser,"\")
        end if
        Set objConnection = CreateObject("ADODB.Connection")
        objConnection.Provider = "ADsDSOObject"
        With objConnection
            .Properties("User ID") = "basar.sonmez"
            .Properties("Password") = "55495549"
            .Properties("Encrypt password") = True
        End With
        objConnection.Open "Active Directory Provider"
        Set objCommand = CreateObject("ADODB.Command")
        Set objCommand.ActiveConnection = objConnection
        objCommand.Properties("Searchscope") = 2
        DCalanlar = Split("distinguishedname,givenName,sn,displayName,telephoneNumber,otherTelephone,mail,wWWHomePage,url,streetAddress,l,st,postalCode,userPrincipalName,sAMAccountName,userAccountControl,profilePath,scriptPath,homeDirectory,homeDrive,homeDirectory,title,department,company,manager,mobile,facsimileTelephoneNumber,info",",")
        DCSorgu = ""
        DCSayi = 27
            for i = 0 to DCSayi'ubound(DCalanlar)-1
                DCSorgu = DCSorgu & DCalanlar(i)
                DCSorgu = DCSorgu & ","
            next
        objCommand.CommandText ="select " & DCSorgu & "c FROM 'LDAP://agrobestgroup.local:389' where sAMAccountName = '" & RQ2(0) & "' ORDER by sAMAccountname"
        on error resume next
            Set objRecordSet = objCommand.Execute
            ' userdn = objRecordSet.fields("distinguishedname")
            ' for i = 0 to DCSayi'ubound(DCalanlar)-1
            '     Response.Write DCalanlar(i)
            '     Response.Write ":"
            '     Response.Write objRecordSet.fields(DCalanlar(i))
            '     Response.Write "<br />"
            ' next
            DCfeedBack = ""
            DCfeedBack = DCfeedBack & objRecordSet.fields("displayName") & "|"
            DCfeedBack = DCfeedBack & objRecordSet.fields("telephoneNumber") & "|"
            DCfeedBack = DCfeedBack & objRecordSet.fields("mail") & "|"
            DCfeedBack = DCfeedBack & objRecordSet.fields("userAccountControl") & "|"
            DCfeedBack = DCfeedBack & objRecordSet.fields("title") & "|"
            DCfeedBack = DCfeedBack & objRecordSet.fields("department") & "|"
            DCfeedBack = DCfeedBack & objRecordSet.fields("mobile") & "|"
            DCfeedBack = DCfeedBack & objRecordSet.fields("facsimileTelephoneNumber")
            if err.Number = 0 then
                adclogin = True
            else
                adclogin = False
            end if
            Response.Write DCfeedBack
        on error goto 0
    end if
end if
%>