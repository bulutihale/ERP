<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
    modulAd 		=   "Teklif"
	yetkiKontrol    =   yetkibul("Teklif")
	receteAdimID	=	Request.QueryString("receteAdimID")
	adimDirection	=	Request.QueryString("adimDirection")
'###### ANA TANIMLAMALAR

'####### SONUÇ TABLOSU
    call logla("Teklif ürün adımı sırası değiştirildi")

					sorgu = "" & vbcrlf
					sorgu = sorgu & "SELECT" & vbcrlf
					sorgu = sorgu & "teklif.teklif_urun.sira" & vbcrlf
					sorgu = sorgu & ",teklif.teklif_urun.teklifID" & vbcrlf
					sorgu = sorgu & "FROM teklif.teklif_urun" & vbcrlf
					sorgu = sorgu & "where teklif.teklif_urun.teklifKalemID = " & receteAdimID & vbcrlf
					rs.open sorgu, sbsv5, 1, 3
					if rs.recordcount > 0 then
						mevcutSira = rs("sira")
						receteID	=	rs("teklifID")
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
					sorgu = sorgu & "teklif.teklif_urun.sira" & vbcrlf
					sorgu = sorgu & "FROM teklif.teklif_urun" & vbcrlf
					sorgu = sorgu & "where teklif.teklif_urun.teklifID = " & receteID & vbcrlf
					sorgu = sorgu & "order by teklif.teklif_urun.sira ASC" & vbcrlf
					rs.open sorgu, sbsv5, 1, 3
					if rs.recordcount > 0 then
						yenii = 1
						for i = 1 to rs.recordcount
							rs("sira") = yenii
							rs.update
							yenii = yenii + 2
						rs.movenext
						next
					end if
					rs.close

call jsrun("$('#teklifUrunListe').load('/teklif/teklif_urun_liste.asp?teklifID=" & receteID & "');")

%>












