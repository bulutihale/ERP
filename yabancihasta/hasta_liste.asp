<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    hata    =   ""
    modulAd =   "YHBilgiler"
    hastaID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Hasta Listesi Ekranı")

yetkiYabanciHasta = yetkibul("yabancihasta")


							sorgu = "Select id,ad from personel.personel where firmaID = " & firmaID & " and (gorev = 'SELLER' or gorev = 'OPERATION')"
							rs.open sorgu,sbsv5,1,3
							if rs.recordcount > 0 then
									degerler = ""
									do while not rs.eof
										degerler = degerler & rs("ad")
    									degerler = degerler & "="
										degerler = degerler & rs("id")
										degerler = degerler & "|"
									rs.movenext
									loop
									personelDegerler = left(degerler,len(degerler)-1)
							end if
							rs.close
							personelDegerlerArr = Split(personelDegerler,"|")






'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and opener = "" and yetkiYabanciHasta > 0 then
		Response.Write "<form action=""/yabancihasta/hastaliste.asp"" method=""post"" class=""modalform"">"
		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-3 my-1"">"
		Response.Write "<input type=""text"" class=""form-control"" placeholder=""" & translate("Ad Soyad","","") & """ name=""aramaad"" value=""" & aramaad & """>"
		Response.Write "</div>"
		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"

        if yetkiYabanciHasta >= 5 then
            Response.Write "<div class=""col-sm-3 my-1""><button type=""button"" class=""btn btn-danger"" onClick=""modalajax('/yabancihasta/hasta_yeni.asp')"">" & translate("YENİ HASTA","","") & "</a></div>"
        end if

		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU



'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" and yetkiYabanciHasta > 0 then
		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">" & translate("Ad Soyad","","") & "</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">GSM</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Not","","") & "</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Tarih","","") & "</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">" & translate("Acenta","","") & "</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Sl</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Op</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">&nbsp;</th>"
		Response.Write "</tr></thead><tbody>"
            sorgu = "Select" & vbcrlf
			sorgu = sorgu & "yabancihasta.hasta.hastaID," & vbcrlf
			sorgu = sorgu & "yabancihasta.hasta.hastaAd," & vbcrlf
			sorgu = sorgu & "yabancihasta.hasta.hastaTelefon," & vbcrlf
			sorgu = sorgu & "yabancihasta.hasta.dosyaSayi," & vbcrlf
			sorgu = sorgu & "yabancihasta.hasta.hastaNot," & vbcrlf
			sorgu = sorgu & "yabancihasta.hasta.tarih," & vbcrlf
			sorgu = sorgu & "yabancihasta.hasta.hastaAcenta," & vbcrlf
			sorgu = sorgu & "yabancihasta.hasta.personelSatisciID," & vbcrlf
			sorgu = sorgu & "yabancihasta.hasta.personelOperasyoncuID," & vbcrlf
			sorgu = sorgu & "(Select count(yabancihasta.ameliyat.ameliyatID) from yabancihasta.ameliyat where yabancihasta.ameliyat.hastaID = yabancihasta.hasta.hastaID and yabancihasta.ameliyat.silindi = 'False') as ameliyatSayi," & vbcrlf
			sorgu = sorgu & "(Select count(yabancihasta.ameliyat.ameliyatID) from yabancihasta.ameliyat where yabancihasta.ameliyat.hastaID = yabancihasta.hasta.hastaID and yabancihasta.ameliyat.silindi = 'False' and yabancihasta.ameliyat.tarih is null) as ameliyatTarihSayi," & vbcrlf
			sorgu = sorgu & "(Select count(yabancihasta.transfer.transferID) from yabancihasta.transfer where yabancihasta.transfer.hastaID = yabancihasta.hasta.hastaID and yabancihasta.transfer.silindi = 'False') as transferSayi," & vbcrlf
			sorgu = sorgu & "(Select count(yabancihasta.odeme.odemeID) from yabancihasta.odeme where yabancihasta.odeme.hastaID = yabancihasta.hasta.hastaID) as odemeSayi," & vbcrlf
			sorgu = sorgu & "(Select count(yabancihasta.refakatci.refakatciID) from yabancihasta.refakatci where yabancihasta.refakatci.hastaID = yabancihasta.hasta.hastaID and yabancihasta.refakatci.silindi = 'False') as refakatciSayi," & vbcrlf
			sorgu = sorgu & "(Select count(yabancihasta.konaklama.konaklamaID) from yabancihasta.konaklama where yabancihasta.konaklama.hastaID = yabancihasta.hasta.hastaID and yabancihasta.konaklama.silindi = 'False') as konaklamaSayi" & vbcrlf
			sorgu = sorgu & "from yabancihasta.hasta" & vbcrlf
			sorgu = sorgu & " where yabancihasta.hasta.firmaID = " & firmaID & vbcrlf
			if aramaad = "" then
			else
				sorgu = sorgu & " and (yabancihasta.hasta.hastaAd like N'%" & aramaad & "%')" & vbcrlf
			end if
			sorgu = sorgu & " order by yabancihasta.hasta.tarih DESC" & vbcrlf
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					hastaID	=	rs("hastaID")
					Response.Write "<tr>"
					Response.Write "<td>"
                    Response.Write rs("hastaAd")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write replace(rs("hastaTelefon")," ","")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("hastaNot")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("tarih")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("hastaAcenta")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write arrPersonelBul(rs("personelSatisciID"),personelDegerlerArr)
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write arrPersonelBul(rs("personelOperasyoncuID"),personelDegerlerArr)
					Response.Write "</td>"
					Response.Write "<td class=""text-right"">"
					if yetkiYabanciHasta >= 5 then
						'# Ameliyat
						Response.Write "&nbsp;<div title=""" & translate("Ameliyat Bilgileri","","") & """ class=""badge badge-pill "
						if rs("ameliyatSayi") = 0 then
							Response.Write " badge-danger"
						elseif rs("ameliyatTarihSayi") > 0 then
							Response.Write " badge-warning"
						else
							Response.Write " badge-success"
						end if
						Response.Write """ onClick=""modalajax('/yabancihasta/ameliyat_yeni.asp?gorevID=" & hastaID & "');"">"
							Response.Write rs("ameliyatSayi")
							Response.Write "&nbsp;"
						Response.Write "<i class=""mdi mdi-hotel"
						Response.Write """></i></div>"
						'# Ameliyat
					end if
					if yetkiYabanciHasta >= 3 then
						'# ödeme
						Response.Write "&nbsp;<div title=""" & translate("Ödeme Bilgileri","","") & """ class=""badge badge-pill "
						if rs("odemeSayi") = 0 then
							Response.Write " badge-danger"
						else
							Response.Write " badge-success"
						end if
						Response.Write """ onClick=""modalajax('/yabancihasta/odeme_yeni.asp?gorevID=" & hastaID & "');"">"
						Response.Write "<i class=""mdi mdi-account-card-details"
						Response.Write """></i></div>"
						'# ödeme
						'# transfer
						Response.Write "&nbsp;<div title=""" & translate("Uçuş Bilgileri","","") & """ class=""badge badge-pill "
						if rs("transferSayi") = 0 then
							Response.Write " badge-danger"
						else
							Response.Write " badge-success"
						end if
						Response.Write """ onClick=""modalajax('/yabancihasta/transfer_yeni.asp?gorevID=" & hastaID & "');"">"
							Response.Write rs("transferSayi")
							Response.Write "&nbsp;"
						Response.Write "<i class=""mdi mdi-airplane"
						Response.Write """></i></div>"
						'# transfer

						'# konaklama
						Response.Write "&nbsp;<div title=""" & translate("Konaklama Bilgileri","","") & """ class=""badge badge-pill "
						if rs("konaklamaSayi") = 0 then
							Response.Write " badge-warning"
						else
							Response.Write " badge-success"
						end if
						Response.Write """ onClick=""modalajax('/yabancihasta/konaklama_yeni.asp?gorevID=" & hastaID & "');"">"
							Response.Write rs("konaklamaSayi")
							Response.Write "&nbsp;"
						Response.Write "<i class=""mdi mdi-home-map-marker"
						Response.Write """></i></div>"
						'# konaklama
					end if
					if yetkiYabanciHasta >= 3 then
						'# REFAKATCİ
						Response.Write "&nbsp;<div title=""" & translate("Refakatci Bilgileri","","") & """ class=""badge badge-pill "
							Response.Write " badge-success"
						Response.Write """ onClick=""modalajax('/yabancihasta/refakatci_yeni.asp?gorevID=" & hastaID & "');"">"
							Response.Write rs("refakatciSayi")
							Response.Write "&nbsp;"
						Response.Write "<i class=""mdi mdi-account-multiple"
						Response.Write """></i></div>"
						'# REFAKATCİ
					end if
					if yetkiYabanciHasta >= 5 then
						'# dosya bilgileri
							if isnull(rs("dosyaSayi")) = True then
								rs("dosyaSayi") = 0
								rs.update
							end if
						Response.Write "&nbsp;<div title=""" & translate("Dosyalar","","") & """ class=""badge badge-pill "
						if rs("dosyaSayi") = 0 then
							Response.Write " badge-outline-info"
						else
							Response.Write " badge-success"
						end if

							' Response.Write " badge-outline-info"
						' Response.Write """ onClick=""modalajax('/yabancihasta/dosya_yeni.asp?gorevID=" & hastaID & "');"">"
							Response.Write """ onClick=""modalajax('/dosya/dosya_ayrinti.asp?modul=aGFzdGE&gorevID=" & hastaID & "');"">"
							Response.Write rs("dosyaSayi")
						Response.Write "<i class=""mdi mdi-file-cloud"
						Response.Write """></i></div>"
						'# dosya bilgileri
						'# dosya bilgileri
						Response.Write "&nbsp;<div title=""" & translate("Dosyalar","","") & """ class=""badge badge-pill "
							Response.Write " badge-warning"

							' Response.Write " badge-outline-info"
						' Response.Write """ onClick=""modalajax('/yabancihasta/dosya_yeni.asp?gorevID=" & hastaID & "');"">"
							Response.Write """ onClick=""modalajax('/dosya/yukle1.asp?modul=aGFzdGE&gorevID=" & hastaID & "');"">"
						Response.Write "<i class=""mdi mdi-file-cloud"
						Response.Write """></i></div>"
						'# dosya bilgileri
						'# hasta bilgileri
						Response.Write "&nbsp;<div title=""" & translate("Hasta Bilgileri","","") & """ class=""badge badge-pill "
							Response.Write " badge-success"
						Response.Write """ onClick=""modalajax('/yabancihasta/hasta_yeni.asp?gorevID=" & hastaID & "');"">"
						Response.Write "<i class=""mdi mdi-account-convert"
						Response.Write """></i></div>"
						'# hasta bilgileri
					end if
					Response.Write "</td>"
					Response.Write "</tr>"
				rs.movenext
				next
			end if
			rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"
	else
		call yetkisizGiris("","","")
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU






%>