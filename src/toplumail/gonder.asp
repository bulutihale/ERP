<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Toplu Mail"
    Response.Flush()
'###### ANA TANIMLAMALAR


'#### verileri çek
    gelenveri = Session("sayfa5")
    if gelenveri <> "" then
        gelenveriArr = Split(gelenveri,"$")
        sablonID    =   gelenveriArr(0)
        adresGrupID =   gelenveriArr(1)
        if sablonID <> "" then
            sablonID = base64_decode_tr(sablonID)
        end if
        if adresGrupID <> "" then
            adresGrupID = base64_decode_tr(adresGrupID)
        end if
    end if
'#### verileri çek





'###### SEÇİMLER
	if hata = "" then
        '### ŞABLONLAR
            sorgu = "Select * from toplumail.sablon where firmaID = " & firmaID & " and silindi = 0"
            sorgu = sorgu & " order by sablonBaslik ASC"
            rs.open sorgu,sbsv5,1,3
            if rs.recordcount > 0 then
                degerler = "=|"
                for oi = 1 to rs.recordcount
                    degerler = degerler & rs("sablonBaslik")
                    degerler = degerler & "="
                    degerler = degerler & rs("sablonID")
                    degerler = degerler & "|"
                rs.movenext
                next
                degerlerSablon = left(degerler,len(degerler)-1)
            end if
            rs.close
        '### ŞABLONLAR
        '### ADRES GRUPLARI
            sorgu = "Select * from toplumail.adresGrup where firmaID = " & firmaID & " and silindi = 0"
            ' if sablonID <> "" then
            '     if isnumeric(sablonID) = True then
            '         sorgu = sorgu & " and sablonID = " & sablonID
            '     end if
            ' end if
            sorgu = sorgu & " order by adresGrupAd ASC"
            rs.open sorgu,sbsv5,1,3
            if rs.recordcount > 0 then
                degerler = "=|"
                for oi = 1 to rs.recordcount
                    degerler = degerler & rs("adresGrupAd")
                    degerler = degerler & "="
                    degerler = degerler & rs("adresGrupID")
                    degerler = degerler & "|"
                rs.movenext
                next
                degerlerAdresGrup = left(degerler,len(degerler)-1)
            end if
            rs.close
        '### ADRES GRUPLARI
        '### SMTP BİLGİLERİ
            sorgu = "Select * from toplumail.mailAccount where firmaID = " & firmaID & " and silindi = 0"
            sorgu = sorgu & " order by mailAccountAd ASC"
            rs.open sorgu,sbsv5,1,3
            if rs.recordcount > 0 then
                degerler = "=|"
                for oi = 1 to rs.recordcount
                    degerler = degerler & rs("mailAccountAd") & "-" & rs("gonderenAdres")
                    degerler = degerler & "="
                    degerler = degerler & rs("mailAccountID")
                    degerler = degerler & "|"
                rs.movenext
                next
                degerlerSmtpGrup = left(degerler,len(degerler)-1)
            end if
            rs.close
        '### SMTP BİLGİLERİ


		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-header text-white bg-info"">Gönderim Seçenekleri</div>"
                Response.Write "<div class=""card-body"">"
					Response.Write "<form action=""/toplumail/gonder2.asp"" method=""post"" class=""ajaxform"">"
						Response.Write "<div class=""form-row align-items-center"">"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
                                Response.Write "<div class=""badge badge-info"">Şablon</div>"
                                call formselectv2("sablonID",sablonID,"$('#mailOnizleme').attr('src','/toplumail/gonder_onizleme.asp?sablonID='+this.value)","","","","sablonID",degerlerSablon,"")
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
                                Response.Write "<div class=""badge badge-info"">Adres Grubu</div>"
                                call formselectv2("adresGrupID",adresGrupID,"","","","","adresGrupID",degerlerAdresGrup,"")
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
                                Response.Write "<div class=""badge badge-info"">Gönderen</div>"
                                call formselectv2("mailAccountID",mailAccountID,"","","","","mailAccountID",degerlerSmtpGrup,"")
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
                                Response.Write "<div class=""badge badge-info"">Koruma</div>"
                                degerlertekrar = "Tekrar Koruması Aktif=|Tekrar Koruması Pasif=evet"
                                call formselectv2("tekrarGonderim",tekrarGonderim,"","","","","tekrarGonderim",degerlertekrar,"")
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-2 col-sm-2 my-1"">"
                                Response.Write "<div class=""badge"">&nbsp;</div>"
                                Response.Write "<button type=""submit"" class=""btn btn-warning form-control"">" & translate("Gönder","","") & "</button>"
                            Response.Write "</div>"
						Response.Write "</div>"
					Response.Write "</form>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'###### SEÇİMLER



		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-header text-white bg-info"">Önizleme</div>"
                Response.Write "<div class=""card-body"">"
                    Response.Write "<iframe id=""mailOnizleme"" src=""/toplumail/gonder_onizleme.asp?sablonID=" & sablonID & """ style=""width:100%;height:400px;""></iframe>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"




%><!--#include virtual="/reg/rs.asp" -->