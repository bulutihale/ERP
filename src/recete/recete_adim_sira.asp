<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
    modulAd =   "Reçete"
    modulID =   "97"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	yetkiKontrol	 = yetkibul(modulAd)
	receteAdimID	=	Request.QueryString("receteAdimID")
	adimDirection	=	Request.QueryString("adimDirection")
	siraDeger		=	Request.QueryString("siraDeger")
	siraDeger		=	cint(siraDeger)
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
						if mevcutSira < siraDeger then
							siraDeger = siraDeger + 1
						else
							siraDeger = siraDeger
						end if
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
					 adimSayi = rs.recordcount
					 	for i = 1 to rs.recordcount
						kontrolSira = rs("sira")
					 		if siraDeger > kontrolSira then
								artisDeger = 0
							else
								artisDeger = 1
							end if

								yeniDeger = kontrolSira + artisDeger

							rs("sira") = yeniDeger
					 		rs.update
					 	rs.movenext
					 	next
					 end if
					 rs.close

				'### adım sayısından fazla sıra numarası girildiyse fazlasını yazma
				'### adım sayısından fazla sıra numarası girildiyse fazlasını yazma
					if siraDeger > adimSayi then 
						siraDeger = adimSayi + 1
					end if
				'### adım sayısından fazla sıra numarası girildiyse fazlasını yazma
				'### adım sayısından fazla sıra numarası girildiyse fazlasını yazma

				'### yeni sıra numarasını yaz.
					sorgu = "UPDATE recete.receteAdim set sira = " & siraDeger & " WHERE receteAdimID = " & receteAdimID
					rs.open sorgu, sbsv5, 3, 3
				'### yeni sıra numarasını yaz.



					 sorgu = "" & vbcrlf
					 sorgu = sorgu & "SELECT" & vbcrlf
					 sorgu = sorgu & "recete.receteAdim.sira" & vbcrlf
					 sorgu = sorgu & "FROM recete.receteAdim" & vbcrlf
					 sorgu = sorgu & "where recete.receteAdim.receteID = " & receteID & vbcrlf
					 sorgu = sorgu & "order by recete.receteAdim.sira ASC" & vbcrlf
					 rs.open sorgu, sbsv5, 1, 3
					 if rs.recordcount > 0 then
						'yenii = 0
					 	for i = 1 to rs.recordcount
					 		'yenii = yenii + 1
							rs("sira") = i
					 		rs.update
					 		
					 	rs.movenext
					 	next
					 end if
					 rs.close


					 

call jsac("/recete/recete_adim_liste.asp?gorevID=" & receteID)

%>












