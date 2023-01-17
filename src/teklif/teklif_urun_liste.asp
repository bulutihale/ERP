<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
    teklifID            =   Request.QueryString("teklifID")
'###### ANA TANIMLAMALAR





'### VERİLERİ AL
    if teklifID <> "" then
		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">Stok Adı</th>"
		Response.Write "<th scope=""col"" class=""text-right"">Birim Fiyat</th>"
		Response.Write "<th scope=""col"" class=""text-right"">Adet</th>"
		Response.Write "<th scope=""col"" class=""text-right"">Satır Toplamı</th>"
		Response.Write "<th scope=""col"" class=""d-sm-table-cell"">&nbsp;</th>"
		Response.Write "</tr></thead><tbody>" 
            sorgu = "Select *,(Select kisaBirim from portal.birimler where birimID = teklif.teklif_urun.stokBirim) as birimAd,(Select kdv from stok.stok where stokID = teklif.teklif_urun.teklifStokID) as stokKdv from teklif.teklif_urun where silindi = 0 and teklifID = " & teklifID & " order by teklifKalemID ASC"
			rs.open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
                '## hesaplamaları yap
                    teklifToplam            =   0
                    teklifIskontoToplam     =   0
                    teklifKdv               =   0
                    teklifGenelToplam       =   0
                '## hesaplamaları yap
				for i = 1 to rs.recordcount
                    '## verileri al
                        teklifStokID        =   rs("teklifStokID")
                        teklifID            =   rs("teklifID")
                        teklifParaBirimi    =   rs("teklifParaBirimi")
                        stokParaBirim       =   rs("stokParaBirim")
                        stokAd              =   rs("stokAd")
                        stokAciklama        =   rs("stokAciklama")
                        stokAdet            =   rs("stokAdet")
                        stokBirim           =   rs("stokBirim")
                        stokFiyat           =   rs("stokFiyat")
                        iskonto1            =   rs("iskonto1")
                        iskonto2            =   rs("iskonto2")
                        iskonto3            =   rs("iskonto3")
                        iskonto4            =   rs("iskonto4")
                        stokToplamFiyat     =   rs("stokToplamFiyat")
                        birimAd             =   rs("birimAd")
                        teklifKalemID       =   rs("teklifKalemID")
                        stokKdv             =   rs("stokKdv")
                        dovizKuru           =   rs("dovizKuru")
                    '## verileri al
                    '## hesaplamaları yap
                        teklifSatirToplami      =   stokFiyat * stokAdet * dovizKuru
                        teklifToplam            =   teklifToplam + teklifSatirToplami
                        teklifSatirIskonto      =   teklifSatirToplami - stokToplamFiyat
                        teklifIskontoToplam     =   teklifIskontoToplam + teklifSatirIskonto
                        teklifSatirKdv          =   (teklifSatirToplami - teklifSatirIskonto) - (teklifSatirToplami - teklifSatirIskonto) / (1 + (stokKdv / 100))
                        teklifSatirKdvDahil     =   (teklifSatirToplami - teklifSatirIskonto) / (1 + (stokKdv / 100))
                        teklifKdv               =   teklifKdv + teklifSatirKdv
                        teklifGenelToplam       =   teklifToplam - teklifKdv - teklifIskontoToplam
                    '## hesaplamaları yap
					Response.Write "<tr>"
						Response.Write "<td>" & stokAd & "</td>"
						Response.Write "<td class=""text-right"">" & stokFiyat & " " & stokParaBirim & "</td>"
						Response.Write "<td class=""text-right"">" & stokAdet & " " & birimAd & "</td>"
						Response.Write "<td class=""text-right"">" & formatnumber(stokToplamFiyat,sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</td>"
						Response.Write "<td class=""text-right"" nowrap>"
						'# cari kullan
                            Response.Write "<a title=""" & translate("Seç","","") & """ class=""ml-1 badge badge-pill "
                            Response.Write " badge-warning"
                            Response.Write """"
                            Response.Write " onClick="""
                            Response.Write "$('#ajax').load('/teklif/teklif_urun_modal_sil.asp?teklifKalemID=" & teklifKalemID & "');"
                            Response.Write """>"
                            Response.Write "<i class=""mdi mdi-delete"
                            Response.Write """></i>"
                            Response.Write "</a>"
						'# cari kullan
						Response.Write "</td>"
					Response.Write "</tr>"
					Response.Flush()
				rs.movenext
				next
			end if
			rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"


            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-lg-8 mt-2"">"
		        Response.Write "</div>"
                Response.Write "<div class=""col-lg-4 mt-2"">"
                    Response.Write "<table class=""table table-striped table-bordered table-hover table-sm"">"
                    Response.Write "<tbody>"
                        Response.Write "<tr>"
                            Response.Write "<td class="""">Toplam</td>"
                            Response.Write "<td class=""text-right"">" & formatnumber(teklifToplam,sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</td>"
                        Response.Write "</tr>"
                        Response.Write "<tr>"
                            Response.Write "<td class="""">Toplam İskonto</td>"
                            Response.Write "<td class=""text-right"">" & formatnumber(teklifIskontoToplam,sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</td>"
                        Response.Write "</tr>"
                        Response.Write "<tr>"
                            Response.Write "<td class="""">Ara Toplam</td>"
                            Response.Write "<td class=""text-right"">" & formatnumber((teklifToplam - teklifIskontoToplam),sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</td>"
                        Response.Write "</tr>"
                        Response.Write "<tr>"
                            Response.Write "<td class="""">Toplam KDV</td>"
                            Response.Write "<td class=""text-right"">" & formatnumber(teklifKdv,sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</td>"
                        Response.Write "</tr>"
                        Response.Write "<tr>"
                            Response.Write "<td class="""">Toplam</td>"
                            Response.Write "<td class=""text-right"">" & formatnumber(teklifGenelToplam,sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</td>"
                        Response.Write "</tr>"
                        Response.Write "<tr>"
                            Response.Write "<td class="""">Genel Toplam</td>"
                            Response.Write "<td class=""text-right"">" & formatnumber((teklifGenelToplam+teklifKdv),sb_TeklifOndalikSayi) & " " & teklifParaBirimi & "</td>"
                        Response.Write "</tr>"
                    Response.Write "</tbody>"
                    Response.Write "</table>"
		        Response.Write "</div>"
		    Response.Write "</div>"

    end if
'### VERİLERİ AL













%><!--#include virtual="/reg/rs.asp" -->