<%

Response.CharSet = "utf-8"

' https://erp.sbstasarim.com/portal/geoIP.asp?ip=212.68.61.84

	set sbsv5=Server.CreateObject("ADODB.Connection")
	baglantibilgileri = "Provider=SQLOLEDB;Data Source=.;Initial Catalog=sbs_geoIP;User Id=geoIP;Password=SG(5WaA6&)5&zqpM;"
	sbsv5.Open baglantibilgileri
	Set fn1 = Server.CreateObject("ADODB.Recordset")


    gelenIP = Request.Form("ip")
    if gelenIP = "" then
        gelenIP = Request.QueryString("ip")
    end if


    if gelenIP = "" then
        gelenIP = Request.ServerVariables("REMOTE_ADDR")
    end if
    IParr = Split(gelenIP,".")
    IPSub = IParr(0) & "." & IParr(1) & "." & IParr(2) & "."
	set IParr = Nothing
    sorgu = "Select top 1 v3 from sbs_geoIP.portal.geoIP where IP1 like '" & IPSub & "%'"
    fn1.open sorgu, sbsv5,1,3
        if fn1.recordcount > 0 then
            ' if alan = "şehir" or alan = "sehir" then
                geoIP = fn1("v3")
            ' elseif alan = "ilçe" or alan = "ilce" then
            '     geoIP = fn1("v4")
            ' elseif alan = "konum" then
            '     geoIP = fn1("v5") & "," & fn1("v6")
            ' else
                ' geoIP = ""
            ' end if
        else
            geoIP = ""
        end if
    fn1.close

Response.Write geoIP
%>