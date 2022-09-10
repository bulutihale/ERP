<!--#include virtual="/temp/sabitler.asp" --><%
	set sbsv5=Server.CreateObject("ADODB.Connection")
	baglantibilgileri = "Provider=SQLOLEDB;Data Source=" & sb_dbsunucu & ";Initial Catalog=" & sb_dbad & ";User Id=" & sb_dbuser & ";Password=" & sb_dbpass & ";"
	sbsv5.Open baglantibilgileri
	Set rs = Server.CreateObject("ADODB.Recordset")


dil_tr = ""
dil_en = ""



' dil_tr = right(dil_tr,len(dil_tr)-2)
' dil_en = right(dil_en,len(dil_en)-2)

	Set objStream = server.CreateObject("ADODB.Stream")
	objStream.Open
	objStream.CharSet = "UTF-8"

objStream.WriteText "<"
objStream.WriteText "%" & vbcrlf
objStream.WriteText "klang = Request.Cookies(""klang"")" & vbcrlf

objStream.WriteText "language_tr = ""=""" & vbcrlf
objStream.WriteText "language_en = ""=""" & vbcrlf

sorgu = "Select * from portal.dil order by dil ASC,dilID ASC"
rs.open sorgu, sbsv5, 1, 3
for di = 1 to rs.recordcount
    dil = rs("dil")
    anahtar = rs("anahtar")
    kelime = rs("kelime")
    if dil = "tr" then
        dil_tr = "||" & anahtar & "=" & kelime
        objStream.WriteText "language_tr = language_tr & """ & dil_tr & """" & vbcrlf
    elseif dil = "en" then
        dil_en = "||" & anahtar & "=" & kelime
        objStream.WriteText "language_en = language_en & """ & dil_en & """" & vbcrlf
    end if
rs.movenext
next
rs.close


objStream.WriteText "if klang = """" then" & vbcrlf
objStream.WriteText "klang = ""tr""" & vbcrlf
objStream.WriteText "end if" & vbcrlf
objStream.WriteText"if klang = ""en"" then" & vbcrlf
objStream.WriteText "hedefSozluk = language_en" & vbcrlf
objStream.WriteText "else" & vbcrlf
objStream.WriteText"hedefSozluk = language_tr" & vbcrlf
objStream.WriteText "end if" & vbcrlf
objStream.WriteText "languageSozluk = Split(hedefSozluk,""||"")" & vbcrlf
objStream.WriteText "%"
objStream.WriteText ">"
	

	objStream.SaveToFile Server.Mappath("/temp/language.asp"),2
	objStream.Close
	set objStream = Nothing


Response.Write now()
%>