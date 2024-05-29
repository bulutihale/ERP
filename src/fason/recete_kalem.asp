<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

    call sessiontest()
    kid		=	kidbul()

	modulAd 		=   "Fason" 

	'##### YETKİ BUL
	'##### YETKİ BUL
	yetkiKontrol	 = yetkibul(modulAd)
	'##### YETKİ BUL
	'##### YETKİ BUL

	receteID				=	Request("receteID")
	siparisKalemID			=	Request("siparisKalemID")
	fasonAnaID				=	Request("fasonAnaID")
	isTur					=	"fason"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

Response.Flush()


			sorgu = "SELECT t1.miktar as fasonFirmaMiktar, t2.fasonDepoID"
			sorgu = sorgu & " FROM fason.fasonAna t1"
			sorgu = sorgu & " INNER JOIN cari.cari t2 ON t1.fasonCariID = t2.cariID"
			sorgu = sorgu & " WHERE t1.id = " & fasonAnaID
			rs.open sorgu, sbsv5, 1, 3
				fasonFirmaMiktar	=	rs("fasonFirmaMiktar")
				fasonDepoID			=	rs("fasonDepoID")
			rs.close

		'############ mamul için miktarları al bileşenler için reçete miktarları ile çarpım yap
            sorgu = "SELECT"
			sorgu = sorgu & " t1.sipMiktar, t1.miktarFason, t1.mikBirim"
			sorgu = sorgu & " FROM teklif.siparisKalem t1"
			sorgu = sorgu & " WHERE t1.id = " & siparisKalemID
			rs.open sorgu, sbsv5, 1, 3
				sipMiktarMamul		=	rs("sipMiktar")
				'miktarFasonMamul	=	rs("miktarFason")
				mikBirimMamul		=	rs("mikBirim")
			rs.close
		'############ /mamul için miktarları al bileşenler için reçete miktarları ile çarpım yap

            sorgu = "SELECT"
			sorgu = sorgu & " t1.receteID, t1.stokID, t2.stokKodu, t2.stokAd, t1.miktar as bilesenMiktar, t1.miktarBirim, t1.receteAdimID,"
			sorgu = sorgu & " ISNULL(stok.FN_stokSayDepo (" & firmaID & ", t1.stokID, 4),0) as malKabulDepoMiktar,"
			sorgu = sorgu & " ISNULL(stok.FN_stokSayDepo (" & firmaID & ", t1.stokID, " & fasonDepoID & "),0) as fasonDepoMiktar"
			sorgu = sorgu & " FROM recete.receteAdim t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " WHERE t1.receteID = " & receteID & " AND t1.silindi = 0" 
			rs.open sorgu, sbsv5, 1, 3


				
			if rs.recordcount > 0 then
			Response.Write "<div class=""container"">"
					Response.Write "<div class=""row mt-2 border-dark border-bottom bold text-center"">"
						Response.Write "<div class=""col-lg-1""><input type=""checkbox"" class=""chck20"" onclick=""$('.kalemClass').trigger('click');""></div>"
						Response.Write "<div class=""col-lg-3"">Bileşen</div>"
						Response.Write "<div class=""col-lg-1"">Depo</div>"
						Response.Write "<div class=""col-lg-1"">Fasondaki Miktar</div>"
						Response.Write "<div class=""col-lg-2"">Reçete Miktar</div>"
						Response.Write "<div class=""col-lg-2"">İhtiyaç Miktar</div>"
						Response.Write "<div class=""col-lg-1"">Gönderilecek</div>"
					Response.Write "</div>"
				for di = 1 to rs.recordcount
					stokID				=	rs("stokID")
					stokID64	 		=	stokID
					stokID64			=	base64_encode_tr(stokID64)
					receteID			=	rs("receteID")
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					bilesenMiktar		=	rs("bilesenMiktar")
					miktarBirim			=	rs("miktarBirim")
					'ihtiyacMiktar		=	miktarFasonMamul * bilesenMiktar
					ihtiyacMiktar		=	fasonFirmaMiktar * bilesenMiktar
					malKabulDepoMiktar	=	rs("malKabulDepoMiktar")
					receteAdimID		=	rs("receteAdimID")
					fasonDepoMiktar		=	rs("fasonDepoMiktar")

					'########## fasona sevk edilecek reçete bileşen miktarını ajanda tablosu al - yaz
						sorgu = ""
						sorgu = sorgu & "SELECT t1.id as ajandaID, miktar as fasonIhtiyacMiktar, fasonMiktarKilit"
						sorgu = sorgu & " FROM portal.ajanda t1"
						sorgu = sorgu & " WHERE t1.receteAdimID = " & receteAdimID & ""
						sorgu = sorgu & " AND silindi = 0"
						sorgu = sorgu & " AND t1.bagliAjandaID = (SELECT id FROM portal.ajanda WHERE fasonAnaID = " & fasonAnaID & " AND silindi = 0)"
						rs1.open sorgu, sbsv5, 1, 3
							ajandaID			=	rs1("ajandaID")
							fasonIhtiyacMiktar	=	rs1("fasonIhtiyacMiktar")
							fasonMiktarKilit	=	rs1("fasonMiktarKilit")
						rs1.close
					'########## /fasona sevk edilecek reçete bileşen miktarını ajanda tablosu al - yaz

					Response.Write "<div class=""row mt-2 border-warning border-bottom"">"
						Response.Write "<div class=""col-lg-1"">"
							Response.Write "<input id=""chck"&stokID&""" type=""checkbox"" class=""kalemClass chck20"""
							if fasonMiktarKilit = 1 then
								Response.Write "onchange=""swal('','Sevk edilecek miktarlar ajandaya kilitlenmiş, değiştirilemez!')"""
								butonYazi = "Ajanda Sevk Miktarları KİLİTLENMİŞ"
							else
								Response.Write " onchange=""toggleTextInput('chck"&stokID&"','fasonKalem"&stokID&"')"""
								butonYazi = "Ajanda Sevk Miktarlarını Kilitle"
							end if
							Response.Write ">"
						Response.Write "</div>"
						Response.Write "<div class=""col-lg-3""><span class=""font-italic"">" & stokKodu & "</span>  - " & stokAd &  "</div>"
							Response.Write "<div class=""col-1 text-center"">"
								Response.Write "<div title=""Depolara göre stok sayıları"" class=""pointer mr-2"""
									Response.Write " onClick=""modalajaxfit('/stok/stok_depo_miktar.asp?gorevID=" & stokID64 & "&siparisKalemID="&siparisKalemID&"');"">"
									Response.Write "<i class=""icon report-magnify""></i>"
									Response.Write "<div title=""mal kabul depoda bulunan ürün miktarı"">" & formatnumber(malKabulDepoMiktar,0) & "</div>"
								Response.Write "</div>"
							Response.Write "</div>"
						Response.Write "<div class=""col-1 text-center"">"
							'sorgu = "SELECT receteID FROM recete.recete WHERE stokID = " & stokID & " AND silindi = 0"
							'rs1.open sorgu, sbsv5, 1, 3
								'if rs1.recordcount = 0 then
									'Response.Write "-"
									'altReceteVar = "hayir"
								'elseif rs1.recordcount = 1 then
									'Response.Write rs1("receteID")
									'altReceteVar = "evet"
								'else
									'Response.Write "SEÇ"
									'altReceteVar = "evet"
								'end if
							'rs1.close
							Response.Write fasonDepoMiktar
						Response.Write "</div>"
						Response.Write "<div class=""col-lg-2 text-center"">" & bilesenMiktar & " " & miktarBirim & "</div>"
						Response.Write "<div class=""col-lg-2 text-center"">" & ihtiyacMiktar & " " & miktarBirim & "</div>"
						Response.Write "<div class=""col-lg-2 text-center"">"
							Response.Write "<input id=""fasonKalem" & stokID & """ type=""text"" class=""form-control text-center bold"" value=""" & fasonIhtiyacMiktar &""" disabled=""disabled"""
							Response.Write " onchange=""hucreKaydetGenel('id','" & ajandaID & "','miktar','portal.ajanda',$(this).val(),'sevk edilecek miktar değiştirilsin mi?','','','','sayisal')"""		
							if altReceteVar = "evet" then
								Response.Write " onclick=""swal('ÖNEMLİ','Ürüne ait alt reçete mevcut. Fason üreticiye gönderilecek miktarın değiştirilmesi durumunda alt reçete için otomatik oluşturulan üretim emri miktarı DEĞİŞTİRİLMEZ! <br><br> (" & ihtiyacMiktar & " " & miktarBirim & " olarak üretim emri çalışır)<br><br> Ancak gönderim miktarı giriş yapılacak değere göre değiştirilir.')"" "
							end if
							Response.Write ">"
						Response.Write "</div>"
					Response.Write "</div>"
				rs.movenext
				next
			Response.Write "<div class=""row mt-2 border-warning border-bottom"">"
				Response.Write "<div class=""col-12 text-right"">"
					Response.Write "<div class=""btn btn-sm btn-info"" "
						if fasonMiktarKilit = 0 then
							Response.Write " onclick=""sevkMiktarKilitle(" & receteID & ", " & siparisKalemID & ", " & fasonAnaID & ")"""
						end if
						Response.Write ">"
						Response.Write  butonYazi
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "</div>"
			end if
		Response.Write "</div>"
			rs.close

%><!--#include virtual="/reg/rs.asp" -->






