<!--#include virtual="/reg/rs.asp" --><%

'#### ön hazırlık
	Set objStream = server.CreateObject("ADODB.Stream")
	objStream.Open
	objStream.CharSet = "UTF-8"
'#### ön hazırlık



'dosya içeriği
    objStream.WriteText "<"
    objStream.WriteText "%" & vbcrlf

    objStream.WriteText "kid = kidbul()" & vbcrlf

    sorgu = "Select * from personel.personelAyar order by kid ASC"
    rs.open sorgu, sbsv5, 1, 3
    guncelKid = 0
    for di = 1 to rs.recordcount
        if guncelKid <> rs("kid") then
            if guncelKid > 0 then
                objStream.WriteText "end if" & vbcrlf
            end if
            objStream.WriteText "if kid = " & rs("kid") & " then" & vbcrlf
        end if
        objStream.WriteText vbtab & rs("ayarAd") & "=" & """" & rs("ayarDeger") & """" & vbcrlf
        guncelKid = rs("kid")
    rs.movenext
    next
    rs.close
    objStream.WriteText "end if" & vbcrlf

    objStream.WriteText "%"
    objStream.WriteText ">"
'dosya içeriği


	
'#### olayı kapat ve dosyaya kaydet
	objStream.SaveToFile Server.Mappath("/temp/sabitler_personelayar.asp"),2
	objStream.Close
	set objStream = Nothing
'#### olayı kapat ve dosyaya kaydet

%>