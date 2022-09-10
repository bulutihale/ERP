<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    Session("lngTimer")	=	Timer
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
	aramaad	=	Request.Form("aramaad")
	modulAd =   "ITAriza"
	mobil				=	mobilkontrol()
	aramagorev			=	Request.Form("aramagorev")
	aramadurum			=	Request.Form("aramadurum")
	aramaunvan			=	Request.Form("aramaunvan")
	aramapersonelID		=	Request.Form("aramapersonelID")
	listeiptal			=	Request.Form("listeiptal")
	listebitmis			=	Request.Form("listebitmis")
	paginglimit			=	40
	pagingorder			=	"tarih DESC"
	pagingsayfa			=	Request.Form("pagingsayfa")
	hata				=	""

	yetkiIT = yetkibul("IT")

	if pagingsayfa = "" or pagingsayfa < 1 then
		pagingsayfa		=	1
	end if
	if aramaunvan <> "" then
		aramaunvan = int(aramaunvan)
	end if
	if listeiptal = "" then
		listeiptal = Session("listeiptal")
	end if
	if listebitmis = "" then
		listebitmis = Session("listebitmis")
	end if
	if yetkiIT > 0 then
		if listeiptal = "" then
			listeiptal = "off"
		end if
		if listebitmis = "" then
			listebitmis = "off"
		end if
	else
		if listeiptal = "" then
			listeiptal = "on"
		end if
		if listebitmis = "" then
			listebitmis = "on"
		end if
	end if
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Arıza Ekranı")


' if hata = "" then
' 	if yetkiIT = False then
' 		' call yetkisizGiris("","","")
' 	end if
' end if




'###### TOPLAM KAYIT SAYISI
'###### TOPLAM KAYIT SAYISI
	if hata = "" then
		if aramagorev = "" and aramadurum = "" and aramaunvan = "" and aramapersonelID = "" then
			sorgu = "Select count(arizaID) from IT.ariza where durum not in ('Bitti','İptal') and firmaID = " & firmaID
		else
			sorgu = "Select count(IT.ariza.arizaID) from IT.ariza"
			sorgu = sorgu & " LEFT JOIN IT.arizaPersonel on IT.ariza.arizaID = IT.arizaPersonel.gorevID "
			sorgu = sorgu & " where IT.ariza.firmaID = " & firmaID & " and IT.ariza.ad like '" & aramagorev & "'"
			if aramadurum <> "" then
				aramadurummodifiye = aramadurum
				aramadurummodifiye = right(aramadurummodifiye,len(aramadurummodifiye)-1)
				aramadurummodifiye = "_" & aramadurummodifiye
				sorgu = sorgu & " and IT.ariza.durum like '" & aramadurummodifiye & "'"
			end if
			if aramaunvan <> "" then
				sorgu = sorgu & " and IT.ariza.musteriID = " & aramaunvan & " "
			end if
			if aramapersonelID <> "" then
				sorgu = sorgu & " and IT.arizaPersonel.personelID = " & aramapersonelID & " "
			end if
			if listeiptal = "off" then
				sorgu = sorgu & " and IT.ariza.durum not like '%ptal'"
			end if
			if listebitmis = "off" then
				sorgu = sorgu & " and IT.ariza.durum not like 'Bitti'"
			end if
		end if
		rs.Open sorgu, sbsv5, 1, 3
			pagingtoplam = rs(0)
		rs.close
	end if
'###### TOPLAM KAYIT SAYISI
'###### TOPLAM KAYIT SAYISI



'###### ARAMA FORMU
'###### ARAMA FORMU
	' if mobilkontrol() = False then
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
		Response.Write "<form action=""/IT/ariza_liste"" method=""post"">"
		Response.Write "<div class=""form-row align-items-center "
		' if FiltreDurum = False then
		' 	Response.Write "filtrealan"
		' end if
		Response.Write """>"
		Response.Write "<div class=""col-sm-3 my-1"">"
		Response.Write "<label class=""sr-only"" for=""inlineFormInputName"">Arıza</label>"
		Response.Write "<input type=""text"" class=""form-control"" placeholder=""Arama"" name=""aramagorev"" value=""" & aramagorev & """>"
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-2 my-1"">"
		Response.Write "<label class=""sr-only"" for=""inlineFormInputName"">Durum</label>"
		degerler = "Görev Durumu=|Yeni=Yeni|Başladı=Başladı|Bitti=Bitti|İptal=İptal"
		call formselectv2("aramadurum",aramadurum,"","","","","aramadurum",degerler,"")
		Response.Write "</div>"
		'firma
		' Response.Write "<div class=""col-sm-3 my-1"">"
		' Response.Write "<label class=""sr-only"" for=""inlineFormInputName"">Durum</label>"
		' sorgu = "Select kisaAd,Id from Musteri.Musteri where firmaID = " & firmaID & " order by kisaAd ASC"
		' rs.open sorgu,sbsv5,1,3
		' 	degerler = "Müşteri=|"
		' 	do while not rs.eof
		' 		degerler = degerler & rs("kisaAd")
		' 		degerler = degerler & "="
		' 		degerler = degerler & rs("Id")
		' 		degerler = degerler & "|"
		' 	rs.movenext
		' 	loop
		' 	degerler = left(degerler,len(degerler)-1)
		' rs.close
		' call formselectv2("aramaunvan",aramaunvan,"","","","","aramaunvan",degerler,"")
		' Response.Write "</div>"
		'firma
		'personel
		' if GorevListeleHerkes = True then
			Response.Write "<div class=""col-sm-3 my-1"">"
			Response.Write "<label class=""sr-only"" for=""inlineFormInputName"">Durum</label>"
			sorgu = "Select ad,Id from Personel.Personel where expiration is null and firmaID = " & firmaID & " and (gorev like N'Bilgi İşlem%' or gorev like N'BİLGİ İŞLEM%') order by ad ASC"
			rs.open sorgu,sbsv5,1,3
				degerler = "Personel=|"
				do while not rs.eof
					degerler = degerler & rs("Ad")
					degerler = degerler & "="
					degerler = degerler & rs("Id")
					degerler = degerler & "|"
				rs.movenext
				loop
				degerler = left(degerler,len(degerler)-1)
			rs.close
			call formselectv2("aramapersonelID",aramapersonelID,"","","","","aramapersonelID",degerler,"")
			Response.Write "</div>"
		' end if
		'personel
		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">ARA</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
	' end if
'###### ARAMA FORMU
'###### ARAMA FORMU

'####### PAGING
'####### PAGING
	if mobilkontrol() = False then
	if hata = "" then
		Response.Write "<form action=""/IT/ariza_liste"" method=""post"" id=""pagingform"">"
		Response.Write "<input type=""hidden"" name=""pagingsayfa"" class=""pagingsayfa"" id=""pagingsayfa"" value=""" & pagingsayfa & """ />"
		Response.Write "<input type=""hidden"" name=""aramagorev"" value=""" & aramagorev & """ />"
		Response.Write "<input type=""hidden"" name=""aramadurum"" value=""" & aramadurum & """ />"
		Response.Write "<input type=""hidden"" name=""aramapersonelID"" value=""" & aramapersonelID & """ />"
		Response.Write "</form>"
		Response.Write "<scr" & "ipt type=""text/javascript"">"
		Response.Write "function pagingIslemYap(islem){"
		Response.Write "$('.pagingsayfa').val(islem);"
		Response.Write "$('#pagingform').submit();"
		Response.Write "}"
		Response.Write "</scr" & "ipt>"

		Response.Write "<div class=""row "
			' if FiltreDurum = False then
			' 	Response.Write "filtrealan"
			' end if
			Response.Write """>"
			Response.Write "<div class=""col-lg-3 my-1"">"
			Response.Write "<ul class=""pagination"">"
			Response.Write "<li "
			if pagingsayfa > 1 then
				Response.Write "class=""page-item"" onClick=""pagingIslemYap('" & (pagingsayfa-1) & "');"""
			else
				Response.Write "class=""page-item disabled"""
			end if
			Response.Write "><span class=""page-link"">Önceki</span></li>"
			if pagingsayfa > 1 then
				Response.Write "<li class=""page-item""><a class=""page-link"" onClick=""pagingIslemYap('" & (pagingsayfa-1) & "');"">" & (pagingsayfa-1) & "</a></li>"
			end if
			Response.Write "<li class=""page-item active""><span class=""page-link"" onClick=""pagingIslemYap('" & (pagingsayfa) & "');"">" & (pagingsayfa) & "<span class=""sr-only"">(current)</span></span></li>"
			if (int(pagingtoplam / paginglimit)+1) >= int(pagingsayfa+1) then
				Response.Write "<li class=""page-item""><a class=""page-link"" onClick=""pagingIslemYap('" & (pagingsayfa+1) & "');"">" & (pagingsayfa+1) & "</a></li>"
			end if
			if (int(pagingtoplam / paginglimit)) >= int(pagingsayfa+2) then
				Response.Write "<li class=""page-item""><a class=""page-link"" onClick=""pagingIslemYap('" & (pagingsayfa+2) & "');"">" & (pagingsayfa+2) & "</a></li>"
			end if
			if (int(pagingtoplam / paginglimit)+1) >= int(pagingsayfa+1) then
				Response.Write "<li class=""page-item"" onClick=""pagingIslemYap('" & (pagingsayfa+1) & "');""><span class=""page-link"">Sonraki</span></li>"
			end if
			Response.Write "</ul>"
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-6 my-1"">"
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-3 my-1 text-right"">"
			Response.Write "<form action=""/it/ariza_liste"" method=""post"" id=""listebuttonform"">"
				if listeiptal = "on" then
					Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""$('#listeiptal').val('off');$('#listebuttonform').submit();"">İptalleri Gizle</button>&nbsp;"
					Session("listeiptal") = "on"
				else
					Response.Write "<button type=""button"" class=""btn btn-warning"" onClick=""$('#listeiptal').val('on');$('#listebuttonform').submit();"">İptalleri Göster</button>&nbsp;"
					Session("listeiptal") = "off"
				end if
				if listebitmis = "on" then
					Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""$('#listebitmis').val('off');$('#listebuttonform').submit();"">Bitmişleri Gizle</button>&nbsp;"
					Session("listebitmis") = "on"
				else
					Response.Write "<button type=""button"" class=""btn btn-warning"" onClick=""$('#listebitmis').val('on');$('#listebuttonform').submit();"">Bitmişleri Göster</button>&nbsp;"
					Session("listebitmis") = "off"
				end if
				Response.Write "<input type=""hidden"" id=""listeiptal"" name=""listeiptal"" value=""" & listeiptal & """ />"
				Response.Write "<input type=""hidden"" id=""listebitmis"" name=""listebitmis"" value=""" & listebitmis & """ />"
			Response.Write "</div>"
			Response.Write "</form>"
		Response.Write "</div>"
	end if
	end if
'####### PAGING
'####### PAGING

'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Öncelik</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Oluşturan</th>"
		Response.Write "<th scope=""col"">Görev</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">T0</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">T1</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">T2</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Durum</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Personel</th>"
		if yetkiIT > 0 then
			Response.Write "<th scope=""col"">İşlem"
			Response.Write "</th>"
		end if
		if mobil = False then
'			Response.Write "<th scope=""col"">Adres</th>"
		end if
		Response.Write "</tr></thead><tbody>"
			ilkkayit = (pagingsayfa * paginglimit) - paginglimit
			if ilkkayit < 0 then
				ilkkayit = 0
			end if
			sorgu = "Select " & vbcrlf
			' sorgu = sorgu & " Musteri.Musteri.unvan,Musteri.Musteri.kisaAd as firmaAd,"
            sorgu = sorgu & " IT.ariza.firmaID,IT.ariza.ad as gorevAd,IT.ariza.tarih,IT.ariza.durum,IT.ariza.t1,IT.ariza.t2,IT.ariza.oncelik,IT.ariza.arizaID as gorevID" & vbcrlf
			sorgu = sorgu & " ,IT.ariza.personelADTemp" & vbcrlf
			sorgu = sorgu & " ,IT.ariza.personelIDTemp" & vbcrlf
			sorgu = sorgu & " ,IT.ariza.tarihServis" & vbcrlf
			sorgu = sorgu & " ,IT.ariza.olusturanAD" & vbcrlf
			sorgu = sorgu & " ,IT.ariza.olusturanID" & vbcrlf
			sorgu = sorgu & " from IT.ariza " & vbcrlf
			' sorgu = sorgu & " LEFT JOIN Musteri.Musteri on IT.ariza.musteriID = Musteri.Musteri.Id " & vbcrlf
			if aramapersonelID <> "" then
				sorgu = sorgu & " LEFT JOIN IT.arizaPersonel on IT.ariza.arizaID = IT.arizaPersonel.gorevID " & vbcrlf
			end if
			sorgu = sorgu & " where IT.ariza.firmaID = " & firmaID & vbcrlf
			if aramagorev = "" then
			else
				sorgu = sorgu & " and IT.ariza.ad like '%" & aramagorev & "%'" & vbcrlf
			end if
			' if aramaunvan <> "" then
			' 	sorgu = sorgu & " and IT.ariza.musteriID = " & aramaunvan & " " & vbcrlf
			' end if
			if aramapersonelID <> kid and aramapersonelID <> "" then
				sorgu = sorgu & " and IT.arizaPersonel.personelID = " & aramapersonelID & " " & vbcrlf
			elseif aramapersonelID <> "" then
				sorgu = sorgu & " and (" & vbcrlf
				sorgu = sorgu & " IT.arizaPersonel.personelID = " & aramapersonelID & " " & vbcrlf
				sorgu = sorgu & " or IT.ariza.olusturanID = " & kid & " " & vbcrlf
				sorgu = sorgu & ")" & vbcrlf
			end if
			'durum sorguları
			if aramadurum <> "" then
				aramadurummodifiye = aramadurum
				aramadurummodifiye = right(aramadurummodifiye,len(aramadurummodifiye)-1)
				aramadurummodifiye = "_" & aramadurummodifiye
				sorgu = sorgu & " and IT.ariza.durum like '" & aramadurummodifiye & "'" & vbcrlf
			end if
			if listeiptal = "off" then
				sorgu = sorgu & " and IT.ariza.durum not like '%ptal'" & vbcrlf
			end if
			if listebitmis = "off" then
				sorgu = sorgu & " and IT.ariza.durum not like 'Bitti'" & vbcrlf
			end if
			'durum sorguları

			if yetkiIT = False then
				sorgu = sorgu & " and IT.ariza.olusturanID = " & kid & " " & vbcrlf
			end if

			sorgu = sorgu & " order by tarih DESC"
			'  & OrderGorevListe
			'  & " OFFSET " & ilkkayit & " ROWS FETCH NEXT " & paginglimit & " ROWS ONLY" & vbcrlf

			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					gorevID64 = rs("gorevID")
					gorevID64 = base64_encode_tr(gorevID64)
					Response.Write "<tr title=""Oluşturan : " & rs("olusturanAD") & """ class=""cursor-pointer"""
					if rs("durum") = "İptal" then
						Response.Write " style=""text-decoration:line-through;"""
					end if
					Response.Write ">"
					Response.Write "<td scope=""row"" class=""d-none d-sm-table-cell"">"
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

					Response.Write "<td class=""d-none d-sm-table-cell"" nowrap>" & rs("olusturanAD") & "</td>"
					Response.Write "<td title=""" & rs("gorevAd") & """>" & rs("gorevAd") & "</td>"
					Response.Write "<td class=""d-none d-sm-table-cell"">"
					t0tarih = rs("tarihServis")
                    if isnull(t0tarih) = True then
                        t0tarih = rs("tarih")
                    end if
					'# tarih işlem
						if cdate(t0tarih) = date() then
							Response.Write "<span class=""badge badge-success"
							if rs("durum") = "Bitti" then
							else
								Response.Write " blinking"
							end if
							Response.Write """>"
                            t0tarih = Replace(t0tarih," - 00:00","")
							Response.Write tarihgorev(t0tarih)
							Response.Write "</span>"
						elseif cdate(t0tarih) < date() and rs("durum") <> "Bitti" then
							Response.Write "<span class=""badge badge-danger"
							if rs("durum") = "Bitti" then
							else
								Response.Write " blinking"
							end if
							Response.Write """>"
                            t0tarih = Replace(t0tarih," - 00:00","")
							Response.Write tarihgorev(t0tarih)
							Response.Write "</span>"
						else
                            t0tarih = Replace(t0tarih," - 00:00","")
							Response.Write tarihgorev(t0tarih)
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

					Response.Write "<td class=""d-none d-sm-table-cell"" nowrap>" & replace(rs("personelADTemp") & "","/","<br />") & "</td>"

					personelIDTemp = "/" & rs("personelIDTemp") & "/"


					if mobil = False then
'						Response.Write "<td>" & rs("adres") & "</td>"
					end if
					if yetkiIT > 0 then
					Response.Write "<td class=""text-right"" nowrap>"
						if rs("durum") = "Bitti" or rs("durum") = "İptal" then
							Response.Write "<button type=""button"" title=""Görev Ayrıntıları"" class=""btn btn-sm"" onClick=""modalajax('/it/ariza_ayrinti.asp?gorevID=" & rs("gorevID") & "');""><i class=""fa fa-search""></i></button>"
						else
							Response.Write "<button type=""button"" title=""Görev Ayrıntıları"" class=""btn btn-sm"" onClick=""document.location = '/it/ariza/" & gorevID64 & "';""><i class=""fa fa-search""></i></button>"
						end if
							if rs("durum") = "Yeni" then
								if yetkiIT > 3 then
									Response.Write "&nbsp;<button type=""button"" title=""Personele Görev Ata"" class=""btn btn-sm d-none d-sm-table-cell"" onClick=""modalajax('/it/ariza_personelata.asp?gorevID=" & rs("gorevID") & "');""><i class=""fa fa-user-plus""></i></button>"
								end if
							end if
						
						if instr(personelIDTemp,kid) > 0 then
							if isnull(rs("t1")) = True then
								Response.Write "&nbsp;<button title=""Göreve Başla"" class=""btn btn-sm d-none d-sm-table-cell"" onClick=""document.location = '/it/ariza_hizli_basla/" & gorevID64 & "';""><i class=""fa fa-play""></i></button>"
							end if
						end if

						if kid = rs("olusturanID") or ( instr(personelIDTemp,kid) > 0 and isnull(rs("t1")) = False ) then
							if rs("durum") <> "Bitti" then
								Response.Write "&nbsp;<button title=""Görev Tamamla"" class=""btn btn-sm d-none d-sm-table-cell"" onClick=""document.location = '/it/ariza_hizli_tamamla/" & gorevID64 & "';""><i class=""fa fa-check""></i></button>"
							end if
						end if

						if kid = rs("olusturanID") or GorevSil = True then
							if rs("durum") <> "Bitti" then
								Response.Write "&nbsp;<button title=""Görevi Sil"" class=""btn btn-sm btn-danger d-none d-sm-table-cell"" onClick=""document.location = '/it/ariza_hizli_sil/" & gorevID64 & "';""><i class=""fa fa-trash""></i></button>"
							end if
						end if
					Response.Write "</td>"
					end if
					Response.Write "</tr>"
				rs.movenext
				next
			end if
			rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU








'####### HATA VARSA
'####### HATA VARSA
	if hata <> "" then
		call logla(hata)
		Response.Write "<div class=""container-fluid mt-5"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-1 col-xs-1""></div>"
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-10 col-xs-10"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-primary"">Hata Oluştu</div>"
				Response.Write "<div class=""card-body"">"
				Response.Write hata
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-1 col-xs-1""></div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'####### HATA VARSA
'####### HATA VARSA










%>