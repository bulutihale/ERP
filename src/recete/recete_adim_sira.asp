<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()

    modulAd 		=   "Reçete"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	yetkiKontrol	 = yetkibul(modulAd)

	receteAdimID	=	Request.QueryString("receteAdimID")
	adimDirection	=	Request.QueryString("adimDirection")


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU


call logla("Reçete adımı sırası değiştirildi")


					sorgu = "" & vbcrlf
					sorgu = sorgu & "SELECT" & vbcrlf
					sorgu = sorgu & "recete.receteAdim.sira" & vbcrlf
					sorgu = sorgu & ",recete.receteAdim.receteID" & vbcrlf
					sorgu = sorgu & "FROM recete.receteAdim" & vbcrlf
					sorgu = sorgu & "where recete.receteAdim.receteAdimID = " & receteAdimID & vbcrlf
					rs.open sorgu, sbsv5, 1, 3
					if rs.recordcount > 0 then
						mevcutSira = rs("sira")
						receteID	=	rs("receteID")
						if adimDirection = "up" then
							yeniSira = mevcutSira - 3
						else
							yeniSira = mevcutSira + 3
						end if
						rs("sira") = yeniSira
						rs.update
					else
						Response.End()
					end if
					rs.close




					sorgu = "" & vbcrlf
					sorgu = sorgu & "SELECT" & vbcrlf
					sorgu = sorgu & "recete.receteAdim.sira" & vbcrlf
					sorgu = sorgu & "FROM recete.receteAdim" & vbcrlf
					sorgu = sorgu & "where recete.receteAdim.receteID = " & receteID & vbcrlf
					sorgu = sorgu & "order by recete.receteAdim.sira ASC" & vbcrlf
					rs.open sorgu, sbsv5, 1, 3
					if rs.recordcount > 0 then
						yenii = 1
						for i = 1 to rs.recordcount
							rs("sira") = yenii
							rs.update
							yenii = yenii + 2
							Response.Write yenii
						rs.movenext
						next
					end if
					rs.close


call jsac("/recete/recete_adim_liste.asp?gorevID=" & receteID)

%>












