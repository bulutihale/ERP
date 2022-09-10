<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	Response.Charset	=	"utf-8"
	Response.Flush()
	Session("lngTimer")	=	Timer
	site				=	Request.ServerVariables("HTTP_HOST")
	kid					=	kidbul()
	personelID			=	kid
	mobil				=	mobilkontrol()
	hata				=	""
	OrderGorevListe		=	"t1 desc"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



'###### SORGU
'###### SORGU
	sorgu = "Select "
	sorgu = sorgu & " IT.ariza.ad as gorevAd,IT.ariza.tarih,IT.ariza.durum,IT.ariza.t1,IT.ariza.t2,IT.ariza.oncelik,IT.ariza.arizaID as gorevID"
	sorgu = sorgu & " ,IT.arizaPersonel.personelAD,IT.ariza.tarihServis,IT.ariza.olusturanAD"
	sorgu = sorgu & " from IT.ariza "
	' sorgu = sorgu & " INNER JOIN Musteri.Musteri on IT.ariza.musteriID = Musteri.Musteri.Id "
	sorgu = sorgu & " LEFT JOIN IT.arizaPersonel on IT.ariza.arizaID = IT.arizaPersonel.gorevID "
	sorgu = sorgu & " where IT.ariza.firmaID = " & firmaID
	sorgu = sorgu & " and IT.ariza.durum = 'Yeni'"
	sorgu = sorgu & " and (IT.arizaPersonel.personelID = " & personelID & " or IT.ariza.olusturanID = " & personelID & ")"
	sorgu = sorgu & " order by "
	sorgu = sorgu & OrderGorevListe
'###### SORGU
'###### SORGU




'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount > 0 then
		Response.Write "<div class=""row mb-3"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-dark"">Aktif - Bekleyen Görevlerim</div>"
				Response.Write "<div class=""card-body"" style=""max-height:300px;overflow:auto;padding:0 !important"">"
					Response.Write "<div class=""table-responsive"">"
					Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
					Response.Write "<th scope=""col"">Öncelik</th>"
					' Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Müşteri</th>"
					Response.Write "<th scope=""col"">Görev</th>"
					Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">T0</th>"
					Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">T1</th>"
					Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">T2</th>"
					Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Durum</th>"
					Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Personel</th>"
					Response.Write "</tr></thead><tbody>"
					for i = 1 to rs.recordcount
						gorevID64 = rs("gorevID")
						gorevID64 = base64_encode_tr(gorevID64)
						Response.Write "<tr title=""Oluşturan : " & rs("olusturanAD") & """ class=""cursor-pointer"""
							if rs("durum") = "İptal" then
								Response.Write " style=""text-decoration:line-through;"""
							end if
							Response.Write ">"
							Response.Write "<td scope=""row"">"
								Response.Write "<span class=""badge "
								if rs("oncelik") = 0 then
									Response.Write "badge-secondary"
								elseif rs("oncelik") = 2 then
									Response.Write "badge-dark"
								elseif rs("oncelik") = 5 then
									Response.Write "badge-info"
								elseif rs("oncelik") = 7 then
									Response.Write "badge-warning"
								elseif rs("oncelik") = 9 then
									Response.Write "badge-danger"
								end if
								Response.Write """>"
								Response.Write oncelikArr(rs("oncelik"))
								Response.Write "</span>"
							Response.Write "</td>"
							' if len(rs("firmaAd")) > 30 then
							' 	Response.Write "<td class=""d-none d-sm-table-cell"">" & left(rs("firmaAd"),15) & ".." & right(rs("firmaAd"),20) & "</td>"
							' else
							' 	Response.Write "<td class=""d-none d-sm-table-cell"">" & left(rs("firmaAd"),30) & "</td>"
							' end if
							Response.Write "<td title=""" & rs("gorevAd") & """>" & left(rs("gorevAd"),50) & "</td>"
							Response.Write "<td title=""İstenilen Servis Başlama Saati"" class=""d-none d-sm-table-cell"">"
							t0tarih = tarihgorev(rs("tarihServis")) & ""
							t0tarih = Replace(t0tarih," - 00:00","")
							'# tarih işlem
							if isnull(rs("tarihServis")) = False then
								if rs("tarihServis") = date() then
									Response.Write "<span class=""badge badge-success blinking"">"
									Response.Write t0tarih
									Response.Write "</span>"
								elseif rs("tarihServis") < date() then
									Response.Write "<span class=""badge badge-danger blinking"">"
									Response.Write t0tarih
									Response.Write "</span>"
								else
									Response.Write t0tarih
								end if
							else
								Response.Write t0tarih
							end if
							'# tarih işlem
							Response.Write "</td>"
							Response.Write "<td title=""Gerçek Servis Başlama Saati"" class=""d-none d-sm-table-cell"">" & tarihgorev(rs("t1")) & "</td>"
							Response.Write "<td title=""Gerçek Servis Bitiş Saati"" class=""d-none d-sm-table-cell"">" & tarihgorev(rs("t2")) & "</td>"
							Response.Write "<td class=""d-none d-sm-table-cell"">"
								Response.Write "<span class=""badge "
								if rs("durum") = "Bitti" then
									Response.Write "badge-success"
								elseif rs("durum") = "Yeni" then
									Response.Write "badge-info"
								elseif rs("durum") = "Başladı" then
									Response.Write "badge-warning"
								elseif rs("durum") = "İptal" then
									Response.Write "badge-danger"
								end if
								Response.Write """>" & rs("durum") & "</td>"
							Response.Write "<td class=""d-none d-sm-table-cell"">" & rs("personelAD") & "</td>"
						Response.Write "</tr>"
					rs.movenext
					next
					Response.Write "</tbody>"
					Response.Write "</table>"
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
	end if
	rs.close
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU






































%>