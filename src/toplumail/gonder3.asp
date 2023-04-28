<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    aramaad	=	Request.QueryString("aramaad")
    gonderimID	=	Request.QueryString("gonderimID")
    Response.Flush()
'###### ANA TANIMLAMALAR



'#### tekrar korumasını atlat
    sorgu = "update toplumail.gonderim set durum = 'Beklemede' where gonderimID = " & gonderimID
    rs.Open sorgu, sbsv5, 3, 3
'#### tekrar korumasını atlat

if aramaad = "" then
    call mailGonderToplu(gonderimID)
end if


call jsac("/toplumail/gonderim_liste.asp?aramaad=" & aramaad)


%><!--#include virtual="/reg/rs.asp" -->