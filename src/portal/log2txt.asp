<!--#include virtual="/reg/rs.asp" --><%

Server.ScriptTimeout = 30000
Response.Flush()

    sorgu = "Select top 3000 * from personel.personel_log where Tarih < getdate()-30 order by id ASC"
    rs.open sorgu,sbsv5,1,3
    if rs.recordcount > 0 then
        Set objStream = server.CreateObject("ADODB.Stream")
        objStream.Open
        objStream.CharSet = "UTF-8"
            objStream.WriteText "id;Tarih;personelID;IP;gorevID;islem;firmaID;url;modulAd" & vbcrlf
            for ri = 1 to rs.recordcount
                id = rs("id") & ""
                tarih = rs("Tarih") & ""
                personelID = rs("personelID") & ""
                IP = rs("IP") & ""
                gorevID = rs("gorevID") & ""
                islem = rs("islem") & ""
                firmaID = rs("firmaID") & ""
                url = rs("url") & ""
                modulAd = rs("modulAd") & ""
                objStream.WriteText id & ";" & tarih & ";" & personelID & ";" & IP & ";" & gorevID & ";" & islem & ";" & firmaID & ";" & url & ";" & modulAd & vbcrlf
                rs.delete
            rs.movenext
            next
            dosyaadi = "personellog_" & unique()
        objStream.SaveToFile Server.Mappath("/temp/log/" & dosyaadi & ".csv"),2
        objStream.Close
        set objStream = Nothing
        Set objZip = Server.CreateObject("XStandard.Zip")
        objZip.Pack Server.Mappath("/temp/log/" & dosyaadi & ".csv"), sb_fizikselPath & dosyaadi & ".zip"
        Set objZip = Nothing
        call dosyasil("/temp/log/" & dosyaadi & ".csv")
    end if
    rs.close

call logla("Log dosyası oluşturuldu. Oluşturulan dosya : " & dosyaadi)


%><!--#include virtual="/reg/rs.asp" -->