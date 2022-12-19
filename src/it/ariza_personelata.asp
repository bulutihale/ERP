<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	Response.Flush()
	Session("lngTimer")	=	Timer
	site				=	Request.ServerVariables("HTTP_HOST")
	kid					=	kidbul()
	mobil				=	mobilkontrol()
	gorevID				=	Request.QueryString("gorevID")
	hata				=	""
	call logla("Görev Atama Ekranı")
	' yetkiIT = yetkibul("IT")
	modulAd =   "ITAriza"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



' if yetkiIT <= 3 then
' 	hata = "Bu alana girmek için yeterli yetkiniz bulunmamaktadır"
' end if


'### GÖREV AYRINTILARI
'### GÖREV AYRINTILARI
	if hata = "" then
		sorgu = ""
		sorgu = "Select personelID from IT.arizaPersonel where gorevID = " & gorevID & " order by ID asc"
		rs.Open sorgu, sbsv5, 1, 3
		if rs.recordcount > 0 then
			for i = 1 to rs.recordcount
				if i = 1 then
					personelID	=	rs("personelID")
				elseif i = 2 then
					personelID2	=	rs("personelID")
				elseif i = 3 then
					personelID3	=	rs("personelID")
				end if
			rs.movenext
			next
		end if
		rs.close
	end if
'### GÖREV AYRINTILARI
'### GÖREV AYRINTILARI


'### PERSONELLER
'### PERSONELLER
	if hata = "" then
		sorgu = "Select ad,Id from Personel.Personel where firmaID = " & firmaID & " order by Ad ASC"
		rs.open sorgu,sbsv5,1,3
			personelArr = "=|"
			do while not rs.eof
				personelArr = personelArr & rs("Ad")
				personelArr = personelArr & "="
				personelArr = personelArr & rs("Id")
				personelArr = personelArr & "|"
			rs.movenext
			loop
			personelArr = left(personelArr,len(personelArr)-1)
		rs.close
	end if
'### PERSONELLER
'### PERSONELLER


	sorgu = "Select top 1 * from IT.ariza where arizaID = " & gorevID
	rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount > 0 then
		gorevad = rs("ad")
	end if
	rs.close




'### PERSONEL ATAMA FORMU
'### PERSONEL ATAMA FORMU
	if hata = "" then
		Response.Write "<form action=""/it/ariza_personelata2.asp"" method=""post"" class=""ajaxform"">"
		Response.Write "<input type=""hidden"" name=""gorevID"" value=""" & gorevID & """ />"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center"">"
			Response.Write gorevad
			Response.Write "</div>"
			Response.Write "<div class=""container-fluid"">"
					'## PERSONEL 1
					'## PERSONEL 1
						Response.Write "<div class=""row mb-2"">"
							Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
							Response.Write "<div class=""badge badge-secondary"">Sorumlu Personel</div>"
								call formselectv2("personelID",personelID,"","","","","personelID",personelArr,"")
							Response.Write "</div>"
						Response.Write "</div>"
					'## PERSONEL 1
					'## PERSONEL 1

					'## PERSONEL 2
					'## PERSONEL 2
						Response.Write "<div class=""row mb-2"">"
							Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
							Response.Write "<div class=""badge badge-secondary"">Ek Personel</div>"
								call formselectv2("personelID2",personelID2,"","","","","personelID2",personelArr,"")
							Response.Write "</div>"
						Response.Write "</div>"
					'## PERSONEL 2
					'## PERSONEL 2

					'## PERSONEL 3
					'## PERSONEL 3
						Response.Write "<div class=""row mb-2"">"
							Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
							Response.Write "<div class=""badge badge-secondary"">Ek Personel</div>"
								call formselectv2("personelID3",personelID3,"","","","","personelID3",personelArr,"")
							Response.Write "</div>"
						Response.Write "</div>"
					'## PERSONEL 3
					'## PERSONEL 3

					'## BUTTON
					'## BUTTON
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 mt-2"">"
								Response.Write "<button class=""form-control btn btn-success"" type=""submit"">GÖREV ATA</button>"
							Response.Write "</div>"
						Response.Write "</div>"
					'## BUTTON
					'## BUTTON
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'### PERSONEL ATAMA FORMU
'### PERSONEL ATAMA FORMU




'####### HATA VARSA
'####### HATA VARSA
	if hata <> "" then
		Response.Write "<div class=""container-fluid "">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-primary"">Hata Oluştu</div>"
				Response.Write "<div class=""card-body"">"
				Response.Write hata
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
		call logla(hata)
	end if
'####### HATA VARSA
'####### HATA VARSA





%>