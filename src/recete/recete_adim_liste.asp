<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
	cariID			=	Request.Form("cariID")
	gorevID			=	Request.QueryString("gorevID")
    modulAd 		=   "Reçete"
	
	

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	yetkiKontrol	 = yetkibul(modulAd)

'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU



'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET
	if hata = "" then
		if gorevID = "" then
			gorevID64 = Session("sayfa5")

			if gorevID64 = "" then
			else
				gorevID		=	gorevID64
				gorevID		=	base64_decode_tr(gorevID)

				if isnumeric(gorevID) = False then
					gorevID		=	""
				end if
			end if
		else
			if isnumeric(gorevID) = False then
				gorevID		=	base64_decode_tr(gorevID)
			end if
			gorevID		=	int(gorevID)
			gorevID64	=	gorevID
			gorevID64	=	base64_encode_tr(gorevID64)
		end if
	end if
'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET




if gorevID = "" then
	Response.Write "Reçete Bulunamadı"
else
	'################### REÇETE BİLGİLERİ
	'################### REÇETE BİLGİLERİ
				sorgu = "SELECT"
				sorgu = sorgu & " t1.receteAd, t2.cariKodu, t2.cariAd, t3.stokKodu, t3.stokAd"
				sorgu = sorgu & " FROM recete.recete t1"
				sorgu = sorgu & " LEFT JOIN cari.cari t2 ON t1.cariID = t2.cariID"
				sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
				sorgu = sorgu & " WHERE t1.receteID = " & gorevID
				rs.open sorgu, sbsv5, 1, 3
				if rs.recordcount > 0 then
					receteAd	=	rs("receteAd")
					cariKodu	=	rs("cariKodu")
					cariAd		=	rs("cariAd")
					stokKodu	=	rs("stokKodu")
					stokAd		=	rs("stokAd")
				end if
				rs.close
	'################### REÇETE BİLGİLERİ
	'################### REÇETE BİLGİLERİ

	call logla("Reçete Adımları Listelendi : " & receteAd)



	Response.Write "<div class=""container-fluid mt-3"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
					Response.Write "<div class=""card-header text-white bg-info"">Reçete Bilgileri</div>"
					Response.Write "<div class=""card-body"">"
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-lg-2 col-sm-6 bold"">Reçete Adı : </div>"
							Response.Write "<div class=""col-lg-10 col-sm-6"">" & receteAd & " </div>"
						Response.Write "</div>"
						if cariAd <> "" then
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-lg-2 col-sm-6 bold"">Cari Kodu / Adı : </div>"
							Response.Write "<div class=""col-lg-10 col-sm-6"">" & cariKodu & " / " & cariAd & " </div>"
						Response.Write "</div>"
						end if
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-lg-2 col-sm-6 bold"">Stok Kodu / Adı : </div>"
							Response.Write "<div class=""col-lg-10 col-sm-6"">" & stokKodu & " / " & stokAd & "</div>"
						Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
	Response.Write "</div>"

	if yetkiKontrol > 0 then


		'################### REÇETE ADIM BİLGİLERİ
		'################### REÇETE ADIM BİLGİLERİ
			Response.Write "<div class=""container-fluid mt-3"">"
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
					Response.Write "<div class=""card"">"
						Response.Write "<div class=""card-header text-white bg-info"">"
							Response.Write "<div class=""row"">"
								Response.Write "<div class=""col-lg-3 col-sm-6 text-left"">Reçete Adımları</div>"
								if yetkiKontrol >= 5 then
									Response.Write "<div class=""col-lg-9 col-sm-6 my-1 text-right"">"
										Response.Write "<button type=""button"" class=""btn btn-success"" onClick=""modalajax('/recete/recete_adim_yeni.asp?receteID=" & gorevID & "')"">YENİ ADIM EKLE</button>&nbsp;"
									Response.Write "</div>"
								end if
							Response.Write "</div>"
						Response.Write "</div>"
						
						Response.Write "<div class=""card-body""><div class=""row"">"
					sorgu = ""
					sorgu = sorgu & "SELECT"
					sorgu = sorgu & " t1.receteAdimID, t1.etiketeEkle, t1.islemAciklama,"
					sorgu = sorgu & " t2.ad,"
					sorgu = sorgu & " t1.stokID,"
					sorgu = sorgu & " t3.stokKodu,"
					sorgu = sorgu & " t3.stokAd,"
					sorgu = sorgu & " t1.isGucuSayi,"
					sorgu = sorgu & " t1.miktar,"
					sorgu = sorgu & " t1.miktarBirim,"
					sorgu = sorgu & " t1.sira,"
					sorgu = sorgu & " t1.altReceteID,"
					sorgu = sorgu & " t4.receteAd,"
					sorgu = sorgu & " t1.stokKontroluYap,"
					sorgu = sorgu & " (SELECT TOP(1) receteAdimID FROM recete.receteAdim WHERE receteID = t1.altReceteID AND silindi = 0) as altReceteAdimID"
					sorgu = sorgu & " FROM recete.receteAdim t1"
					sorgu = sorgu & " INNER JOIN recete.receteIslemTipi t2 ON t2.receteIslemTipiID = t1.receteIslemTipiID"
					sorgu = sorgu & " LEFT JOIN stok.stok t3 ON t3.stokID = t1.stokID"
					sorgu = sorgu & " LEFT JOIN recete.recete t4 ON t4.receteID = t1.altReceteID"
					sorgu = sorgu & " WHERE t1.receteID = " & gorevID
					sorgu = sorgu & " AND t1.silindi = 0"
					sorgu = sorgu & " ORDER BY t1.sira ASC"
					rs.open sorgu, sbsv5, 1, 3
					if rs.recordcount = 0 then
						Response.Write "Reçete Adımları Bulunamadı"
					else
						Response.Write "<div class=""table-responsive mt-3"">"
						Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr class=""text-center"">"
							Response.Write "<th class=""col-1"" scope=""col""></th>"
							Response.Write "<th class=""col-2"" scope=""col"">İşlem Tipi</th>"
							Response.Write "<th class=""col-4"" scope=""col"">İşlem Açıklama</th>"
							Response.Write "<th class=""col-1"" scope=""col"">Etiket</th>"
							Response.Write "<th class=""col-1"" scope=""col"">Miktar</th>"
							Response.Write "<th class=""col-1"" scope=""col"">İşgücü Sayı</th>"
							Response.Write "<th class=""col-2"" scope=""col"">Alt Reçete</th>"
							if yetkiKontrol >= 5 then
								Response.Write "<th class=""col-1"" scope=""col"">İşlem</th>"
							end if
						Response.Write "</tr></thead><tbody>"
							for i = 1 to rs.recordcount
							altReceteID		=	rs("altReceteID")
							altReceteAd		=	rs("receteAd")
							receteAdimID	=	rs("receteAdimID")
							altReceteAdimID	=	rs("altReceteAdimID")
							etiketeEkle		=	rs("etiketeEkle")
							islemAciklama	=	rs("islemAciklama")
								Response.Write "<tr>"
									Response.Write "<td>"
									if yetkiKontrol >= 5 then
										'## UP
										Response.Write "<div title=""" & translate("Yukarı Taşı","","") & """ class=""badge badge-pill"
										if rs("sira") < 2 then
											Response.Write " badge-secondary not-allowed"
											Response.Write """>"
										else
											Response.Write " pointer badge-info"
											Response.Write """"
											Response.Write " onClick=""$('#ajax').load('/recete/recete_adim_sira.asp?receteAdimID=" & rs("receteAdimID") & "&adimDirection=up')"">"
										end if
										Response.Write "<i class=""mdi mdi-arrow-up-bold"
										Response.Write """></i>"
										Response.Write "</div>"
										'## UP
										
										'## DOWN
										Response.Write "<div title=""" & translate("Aşağı Taşı","","") & """ class=""badge badge-pill"
										if rs.recordcount <= i then
											Response.Write " badge-secondary not-allowed"
											Response.Write """>"
										else
											Response.Write " pointer badge-info"
											Response.Write """"
											Response.Write " onClick=""$('#ajax').load('/recete/recete_adim_sira.asp?receteAdimID=" & rs("receteAdimID") & "&adimDirection=down')"">"
										end if
										Response.Write "<i class=""mdi mdi-arrow-down-bold"
										Response.Write """></i>"
										Response.Write "</div>"
										'## DOWN
									end if
									Response.Write "</td>"
									Response.Write "<td>" & rs("ad") & "</td>"
									Response.Write "<td>"
										Response.Write "<div>" & rs("stokKodu") & " - " & rs("stokAd") & "</div>"
										Response.Write "<div class=""fonkucuk2 font-italic text-info pl-3"">" & islemAciklama & "</div>"
									Response.Write "</td>"
									Response.Write "<td class=""text-center text-success"">"
										if etiketeEkle = 1 then
											Response.Write "<i class=""mdi mdi-checkbox-marked""></i>"
										else
										end if
									Response.Write "</td>"
									Response.Write "<td class=""text-right"">"
										Response.Write "<div>" & rs("miktar") & " " & rs("miktarBirim") & "</div>"
									Response.Write "</td>"
									Response.Write "<td class=""text-right"">" & rs("isGucuSayi") & "</td>"
									Response.Write "<td>"
										Response.Write "<div class=""pointer"" onclick=""modalajax('/recete/recete_adim_yeni.asp?islem=gor&receteAdimID=" & altReceteAdimID & "&receteID=" & altReceteID & "')"">"
										Response.Write altReceteAd
										if not isnull(altReceteAd) then
											Response.Write "<i class=""mdi mdi-clipboard-text""></i>"
										end if
										Response.Write "</div>"
									Response.Write "</td>"
									if yetkiKontrol >= 5 then
										Response.Write "<td class=""text-right"">"
											




											Response.Write "<div title=""" & translate("Reçete Adım Düzenle","","") & """ class=""badge badge-pill pointer"
											Response.Write " badge-success"
											Response.Write """"
											Response.Write " onClick=""modalajax('/recete/recete_adim_yeni.asp?islem=edit&receteAdimID=" & receteAdimID & "&receteID=" & gorevID & "')"">"
											Response.Write "<i class=""mdi mdi-account-convert"
											Response.Write """></i>"
											Response.Write "</div>"
										Response.Write "</td>"
									end if
								Response.Write "</tr>"
							rs.movenext
							next
						Response.Write "</tbody>"
						Response.Write "</table>"
						Response.Write "</div>"
					end if
					rs.close
			Response.Write "</div></div></div></div></div></div>"
		'################### REÇETE ADIM BİLGİLERİ
		'################### REÇETE ADIM BİLGİLERİ
	else
		Response.Write "Reçete Adımlarını Görme Yetkiniz Yok"
	end if
end if
%>













