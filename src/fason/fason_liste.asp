<!--#include virtual="/reg/rs.asp" --><%


'###### FİLTRELER
'###### FİLTRELER
		
	cariID			=	Request.Form("cariID")
	stokID			=	Request.Form("stokID")
	t1				=	Request.Form("t1")
	t2				=	Request.Form("t2")
	t3				=	Request.Form("t3")
	t4				=	Request.Form("t4")
	siparisNo		=	Request.Form("siparisNo")
    modulAd 		=   "Fason"


	
	'####### varsayılan tarih sınırları
		if t1 = "" then t1 = date() - 30 end if
		if t2 = "" then t2 = date() end if
	'####### /varsayılan tarih sınırları
	

'###### FİLTRELER
'###### FİLTRELER

	yetkiKontrol	 = yetkibul(modulAd)

'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU

	if yetkiKontrol = 0 then
		call yetkisizGiris("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
	else

call logla("Fason İşler Listelendi")



Response.Write "<div class=""card rounded-top"">"
Response.Write "<div class=""card-header h5"">Fason Listesi</div>"

Response.Write "<div class=""card-body"">"
		Response.Write "<div class=""col-1 pointer"" onclick=""modalajax('/satis/filtre.asp')""><i class=""mdi mdi-filter table-success rounded""></i></div>"
		Response.Write "<div class=""table-responsive mt-3"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr class=""text-center"">"
		Response.Write "<th class="""" >Sipariş Tarih</th>"
		Response.Write "<th class="""" >Müşteri</th>"
		Response.Write "<th class="""" >Kod</th>"
		Response.Write "<th class="""" >Ürün Adı</th>"
		Response.Write "<th class="""" >Depo</th>"
		Response.Write "<th class="""" >Sipariş Miktar</th>"
		Response.Write "<th class="""" >Fason Miktar</th>"
		Response.Write "<th class="""" >Üretim Miktar</th>"
		Response.Write "<th class="""" >Üretim Plan Tarih</th>"
		Response.Write "<th class="""" ></th>"
		Response.Write "</tr></thead><tbody>"
		
		
            sorgu = "SELECT"
			sorgu = sorgu & " t1.id as siparisKalemID, t3.siparisNo, t1.stokID, t2.stokKodu, t2.stokAd, t4.cariAd, t3.cariID, t3.siparisAD, t1.sipMiktar , t1.miktarFason,"
			sorgu = sorgu & " t1.miktar as uretimMiktar, t1.mikBirim, t3.siparisTarih"
			sorgu = sorgu & " FROM teklif.siparisKalem t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " INNER JOIN teklif.siparis t3 ON t1.siparisID = t3.sipID"
			sorgu = sorgu & " INNER JOIN cari.cari t4 ON t3.cariID = t4.cariID"
			sorgu = sorgu & " WHERE t1.miktarFason > 0"
			rs.open sorgu, sbsv5, 1, 3


			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					siparisKalemID		=	rs("siparisKalemID")
					siparisNo			=	rs("siparisNo")
					stokID				=	rs("stokID")
					stokID64	 		=	stokID
					stokID64			=	base64_encode_tr(stokID64)
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					cariAd				=	rs("cariAd")
					cariID				=	rs("cariID")
					siparisAD			=	rs("siparisAD")
					miktarFason			=	rs("miktarFason")
					sipMiktar			=	rs("sipMiktar")
					mikBirim			=	rs("mikBirim")
					siparisTarih		=	rs("siparisTarih")
					uretimMiktar		=	rs("uretimMiktar")

			sorgu = "SELECT DATEFROMPARTS(t1.hangiYil, t1.hangiAy, t1.hangiGun) as planTarih"
			sorgu = sorgu & " FROM portal.ajanda t1"
			sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.siparisKalemID = " & siparisKalemID
			rs1.open sorgu, sbsv5, 1, 3
				if rs1.recordcount > 0 then
					planTarih	=	rs1("planTarih")
				else
					planTarih	=	0
				end if
			rs1.close
					

					teslimDurum	=	""
					satirClass	=	""
					butonDurum	=	""
					if cdbl(miktar) = cdbl(bakiye) then
						teslimDurum	=	"tam"
						satirClass 	= 	" table-success "
						butonDurum	=	"gizli"
					elseif cdbl(miktar) > cdbl(bakiye) then
						teslimDurum	=	"eksik"
					end if
					
					Response.Write "<tr class=""" & satirClass & """>"
						Response.Write "<td class=""text-center"">"
							Response.Write siparisTarih
						Response.Write "</td>"
						Response.Write "<td>"
							Response.Write  "<div>" & cariAd & "</div>"
							Response.Write "<div class=""font-italic fontkucuk2 text-danger ml-3"">" & siparisAD & "</div>"
						Response.Write "</td>"
						Response.Write "<td>" & stokKodu & "</td>"
						Response.Write "<td>" & stokAd & "</td>"
						Response.Write "<td class=""text-center"">"
							Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-6"">"
								Response.Write "<div title=""Depolara göre stok sayıları"" class=""pointer mr-2"""
									Response.Write " onClick=""modalajaxfit('/stok/stok_depo_miktar.asp?gorevID=" & stokID64 & "&siparisKalemID="&siparisKalemID&"');"">"
									Response.Write "<i class=""icon report-magnify""></i>"
								Response.Write "</div>"
							Response.Write "</div>"
							Response.Write "<div class=""col-6"">"
								if yetkibul("Admin") = 9 then
								Response.Write "<div title=""Reçete maliyeti hesaplama"" class=""pointer mr-2"""
									Response.Write " onClick=""modalajaxfit('/satis/recete_maliyet.asp?siparisKalemID="&siparisKalemID&"&cariID=" & cariID & "&stokID=" & stokID & "');"">"
									Response.Write "<i class=""icon money""></i>"
								Response.Write "</div>"
								end if
							Response.Write "</div>"
							Response.Write "</div>"
						Response.Write "</td>"
						Response.Write "<td class=""text-right"">"
							Response.Write "<div>" & sipMiktar & " " & mikBirim & "</div>"'gelen siparişin toplam miktarı
						Response.Write "</td>"
						Response.Write "<td id=""divFasonMiktar"&siparisKalemID&""" class=""text-right"">"
							if miktarFason > 0 then fClass = " bg-danger rounded p-2 bold " else fClass="" end if
							Response.Write "<div class=""" & fClass & """>" & miktarFason & " " & mikBirim & "</div>"'fasona girecek olan miktar
						Response.Write "</td>"
						Response.Write "<td id=""divMiktar"&siparisKalemID&""" class=""text-right"">"
							Response.Write "<div>" & uretimMiktar & " " & mikBirim & "</div>"'üretime girecek olan miktar
						Response.Write "</td>"
						Response.Write "<td class=""text-center"">"
							Response.Write formatdatetime(planTarih)
						Response.Write "</td>"
						Response.Write "<td class=""align-middle text-center"">"
							Response.Write "<div class=""container"">"
							Response.Write "<div class=""row "">"
								Response.Write "<div class=""col-2"" title=""fason işlemleri"">"
									Response.Write "<div class=""pointer rounded"" onclick=""$('#ortaalan').load('/fason/fason_ana.asp', {stokID:"&stokID&",siparisKalemID:"&siparisKalemID&"})""><i class=""icon page-edit""></i></div>"
								Response.Write "</div>"
							Response.Write "</div>"
							Response.Write "</div>"
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
	Response.Write "</div>"'card-body
	Response.Write "</div>"'card
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU


end if




%>











