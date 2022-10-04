<!--#include virtual="/reg/rs.asp" --><%



'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ssoID   =   ssoIDbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    modul   =   Request.QueryString("modul")
   	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modul   =   "Netsis Sipariş"
    modulAd =   modul
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Sipariş Oluşturuluyor")

if ssoID = "" then
	hatamesaj = "Plasiyer Kodu Bulunamadı"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
end if


'veri aktarım
'veri aktarım
	siphash		=	Request.QueryString("siphash")
	CARI_KOD	=	siphash
	CARI_KOD	=	base64_decode_tr(CARI_KOD)
	carikod		=	CARI_KOD
	sipno		=	netsisb2bsipnouret()
	toplambirimfiyat	=	0
'veri aktarım
'veri aktarım



'#### fiyatları yeniden hesapla
'#### fiyatları yeniden hesapla
	sorgu = "" & vbcrlf
	sorgu = sorgu & "select " & vbcrlf
	sorgu = sorgu & "netsis.siparisKalemTemp.sipno " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.adet " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.fiyat " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.birimfiyat_modifiye " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.tarih " & vbcrlf
	
	sorgu = sorgu & ",netsis.siparisKalemTemp.birim " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.OLCUBR " & vbcrlf

	sorgu = sorgu & ",netsis.siparisKalemTemp.pay " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.payda " & vbcrlf

	sorgu = sorgu & ",netsis.siparisKalemTemp.cariTur " & vbcrlf

	sorgu = sorgu & ",netsis.siparisKalemTemp.iskonto1 " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.iskonto2 " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.iskonto3 " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.iskonto4 " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.birimfiyat " & vbcrlf

	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.STOK_ADI " & vbcrlf
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.SATIS_FIAT1 " & vbcrlf
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.SATIS_FIAT2 " & vbcrlf
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.SATIS_FIAT3 " & vbcrlf
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.SATIS_FIAT4 " & vbcrlf
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.KDV_ORANI " & vbcrlf
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.OLCU_BR1 " & vbcrlf
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.OLCU_BR2 " & vbcrlf

	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.PAY_1 AS P1 " & vbcrlf
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.PAYDA_1 AS PD1 " & vbcrlf
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.PAY2 AS P2 " & vbcrlf
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.PAYDA2 AS PD2 " & vbcrlf

	sorgu = sorgu & "from netsis.siparisKalemTemp " & vbcrlf
	sorgu = sorgu & "INNER JOIN " & firmaSSOdb & ".dbo.TBLSTSABIT on netsis.siparisKalemTemp.STOK_KODU = " & firmaSSOdb & ".dbo.TBLSTSABIT.STOK_KODU " & vbcrlf
	sorgu = sorgu & "where netsis.siparisKalemTemp.CARI_KOD = '" & CARI_KOD & "' and (netsis.siparisKalemTemp.sipno = '' or netsis.siparisKalemTemp.sipno is null)" & vbcrlf

	rs.open sorgu,sbsv5,1,3
		toplamfiyat =	0
		toplamkdv	=	0
		for kalemsayisi = 1 to rs.recordcount
			adet	    =	rs("adet")
			birim	    =	rs("birim")
			SATIS_FIAT1	=	rs("SATIS_FIAT1")
			SATIS_FIAT2	=	rs("SATIS_FIAT2")
			SATIS_FIAT3	=	rs("SATIS_FIAT3")
			SATIS_FIAT4	=	rs("SATIS_FIAT4")
			OLCU_BR1	=	rs("OLCU_BR1")
			OLCU_BR2	=	rs("OLCU_BR2")
			KDV_ORANI	=	rs("KDV_ORANI")
			p1			=	rs("P1")
			p2			=	rs("P2")
			pd1			=	rs("PD1")
			pd2			=	rs("PD2")
			cariTur		=	rs("cariTur")
			iskonto1	=	rs("iskonto1")
			iskonto2	=	rs("iskonto2")
			iskonto3	=	rs("iskonto3")
			iskonto4	=	rs("iskonto4")
			birimfiyat	=	rs("birimfiyat")
			birimfiyat_modifiye	=	rs("birimfiyat_modifiye")
			tarih		=	rs("tarih")
            OLCUBR      =   rs("OLCUBR")
            pay         =   rs("pay")
            payda       =   rs("payda")
			KDV_ORANI	=	str2int(KDV_ORANI)

			if isnull(birimfiyat_modifiye) = True then
				birimfiyat_modifiye = 0
			end if
			birimfiyat_modifiye = str2fiyat(birimfiyat_modifiye)
'Response.Write OLCU_BR1
'Response.End()





'## eski tarihli sipariş
'## eski tarihli sipariş
if tarih < date() then
else
end if
'## eski tarihli sipariş
'## eski tarihli sipariş















			'## fiyat hesapla
			if cariTur = "TOPTAN" then
				if birim = OLCU_BR1 then
					Response.Write "1"
					fiyat		=	formatnumber(SATIS_FIAT1,4)
					fiyat		=	str2fiyat(fiyat)
					'## birim fiyat değiştirilmiş
					if birimfiyat_modifiye > 0 then
						if fiyat < birimfiyat_modifiye then
							'yeni fiyat elle girilen fiyat olsun
							fiyat = birimfiyat_modifiye
						end if
					end if
					'## birim fiyat değiştirilmiş
					adet		=	int(adet)
					rs("birimfiyat")	=	fiyat
					fiyat		=	fiyat * adet
					rs("fiyat")	=	fiyat
					' rs("OLCUBR")=	1
					' rs("pay")	=	p1
					' rs("payda")	=	pd1
					rs.update
				elseif birim = OLCU_BR2 then
					Response.Write "2"
					fiyat		=	formatnumber(SATIS_FIAT2,4)
					fiyat		=	str2fiyat(fiyat)
					'## birim fiyat değiştirilmiş
					if birimfiyat_modifiye > 0 then
						if fiyat < birimfiyat_modifiye then
							'yeni fiyat elle girilen fiyat olsun
							fiyat = birimfiyat_modifiye
						end if
					end if
					'## birim fiyat değiştirilmiş
					adet		=	int(adet)
					rs("birimfiyat")	=	fiyat
					fiyat		=	fiyat * adet
					rs("fiyat")	=	fiyat
					' rs("OLCUBR")=	2
					' rs("pay")	=	p1
					' rs("payda")	=	pd1
					rs.update
				end if
			else
				if birim = OLCU_BR1 then
					Response.Write "3"
					fiyat		=	formatnumber(SATIS_FIAT3,4)
					fiyat		=	str2fiyat(fiyat)
					'## birim fiyat değiştirilmiş
					if birimfiyat_modifiye > 0 then
						if fiyat < birimfiyat_modifiye then
							'yeni fiyat elle girilen fiyat olsun
							fiyat = birimfiyat_modifiye
						end if
					end if
					'## birim fiyat değiştirilmiş
					adet		=	int(adet)
					rs("birimfiyat")	=	fiyat
					fiyat		=	fiyat * adet
					rs("fiyat")	=	fiyat
					' rs("OLCUBR")=	1
					' rs("pay")	=	p1
					' rs("payda")	=	pd1
					rs.update
				elseif birim = OLCU_BR2 then
					Response.Write "4"
					fiyat		=	formatnumber(SATIS_FIAT4,4)
					fiyat		=	str2fiyat(fiyat)
					'## birim fiyat değiştirilmiş
					if birimfiyat_modifiye > 0 then
					Response.Write birimfiyat_modifiye
						if fiyat < birimfiyat_modifiye then
							'yeni fiyat elle girilen fiyat olsun
							fiyat = birimfiyat_modifiye
						end if
					end if
					'## birim fiyat değiştirilmiş
					adet		=	int(adet)
					rs("birimfiyat")	=	fiyat
					fiyat		=	fiyat * adet
					rs("fiyat")	=	fiyat
					' rs("OLCUBR")=	2
					' rs("pay")	=	p1
					' rs("payda")	=	pd1
					rs.update
				end if
			end if





			'## fiyat hesapla
			'## İSKONTO HESAPLA
				if iskonto1 > 0 then
					fiyat = fiyat - (fiyat * (iskonto1 / 100))
					if iskonto2 > 0 then
						fiyat = fiyat - (fiyat * (iskonto2 / 100))
						if iskonto3 > 0 then
							fiyat = fiyat - (fiyat * (iskonto3 / 100))
							if iskonto4 > 0 then
								fiyat = fiyat - (fiyat * (iskonto4 / 100))
							end if
						end if
					end if
				end if
			'## İSKONTO HESAPLA
			'## kdv hesapla
				kdv = kdvhesapla(fiyat,KDV_ORANI)
			'## kdv hesapla
			toplamfiyat =	toplamfiyat + rs("fiyat")
			toplamkdv	=	toplamkdv + kdv
			toplambirimfiyat	=	toplambirimfiyat + (rs("fiyat") - fiyat)


		rs.movenext
		next
		kalemsayisi = rs.recordcount
	rs.close
aciklama	=	""
'#### fiyatları yeniden hesapla
'#### fiyatları yeniden hesapla





'#### sipariş oluştur
'#### sipariş oluştur
	sorgu = "Select top(1) * from TBLSIPAMAS"
	fn2.open sorgu, ssov5, 1, 3
		fn2.addnew
		fn2("SUBE_KODU")		=	0
		fn2("FTIRSIP")			=	"6"
		fn2("FATIRS_NO")		=	sipno
		fn2("CARI_KODU")		=	carikod
		fn2("TARIH")	 		=	date()
		fn2("TIPI")				=	2
		fn2("BRUTTUTAR")		=	toplamfiyat
		fn2("KDV")				=	toplamkdv
		fn2("ACIKLAMA")			=	aciklama
		fn2("KDV_DAHILMI")		=	"H"
		fn2("ODEMEGUNU")		=	21					'xxxxxx
		fn2("FATKALEM_ADEDI")	=	kalemsayisi
		fn2("SIPARIS_TEST")		=	date()
		fn2("ODEMETARIHI")		=	date()
		fn2("KAPATILMIS")		=	"S"
		fn2("KAYITTARIHI")		=	date()
		fn2("ISLETME_KODU")		=	1
		fn2("KS_KODU")			=	"01"'?
		fn2("C_YEDEK6")			=	"X"
		fn2("KOSVADEGUNU")		=	0
		fn2("DOVIZTIP")			=	0
		fn2("PLA_KODU")			=	ssoID
		fn2("KAYITYAPANKUL")	=	"B2B"
		fn2("TOPDEPO")			=	0
		fn2("EBELGE")			=	0
		fn2("EBELGE")			=	0
		if toplambirimfiyat > 0 then
			fn2("SAT_ISKT") = toplambirimfiyat
			fn2("GENELTOPLAM")		=	(toplamfiyat - toplambirimfiyat + toplamkdv)
		else
			fn2("GENELTOPLAM")		=	(toplamfiyat + toplamkdv)
		end if
        'EK ALANLAR
		fn2("FIYATTARIHI")	    =	date()
		fn2("D_YEDEK10")	    =	date()
		fn2("GELSUBE_KODU")	    =	0
		fn2.update
	fn2.close
'#### sipariş oluştur
'#### sipariş oluştur

call logla("Sipariş Kaydı Eklendi : " & sipno)







'#### siparişe ürünleri ekle
'#### siparişe ürünleri ekle
	sorgu = ""
	sorgu = sorgu & "select "
	sorgu = sorgu & "netsis.siparisKalemTemp.sipno "
	sorgu = sorgu & ",netsis.siparisKalemTemp.adet "
	sorgu = sorgu & ",netsis.siparisKalemTemp.fiyat "
	sorgu = sorgu & ",netsis.siparisKalemTemp.birim "
	sorgu = sorgu & ",netsis.siparisKalemTemp.OLCUBR "
	sorgu = sorgu & ",netsis.siparisKalemTemp.pay " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.payda " & vbcrlf

	sorgu = sorgu & ",netsis.siparisKalemTemp.iskonto1 " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.iskonto2 " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.iskonto3 " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.iskonto4 " & vbcrlf
	sorgu = sorgu & ",netsis.siparisKalemTemp.birimfiyat " & vbcrlf

	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.STOK_ADI "
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.SATIS_FIAT1 "
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.SATIS_FIAT2 "
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.SATIS_FIAT3 "
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.SATIS_FIAT4 "
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.KDV_ORANI "
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.OLCU_BR1 "
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.OLCU_BR2 "
	sorgu = sorgu & "," & firmaSSOdb & ".dbo.TBLSTSABIT.STOK_KODU "
	
	sorgu = sorgu & "from netsis.siparisKalemTemp "
	sorgu = sorgu & "INNER JOIN " & firmaSSOdb & ".dbo.TBLSTSABIT on netsis.siparisKalemTemp.STOK_KODU = " & firmaSSOdb & ".dbo.TBLSTSABIT.STOK_KODU "
	sorgu = sorgu & "where netsis.siparisKalemTemp.CARI_KOD = '" & CARI_KOD & "' and (netsis.siparisKalemTemp.sipno = '' or netsis.siparisKalemTemp.sipno is null)"
	rs.open sorgu,sbsv5,1,3
		for kalemsayisi = 1 to rs.recordcount
			'#### HAZIRLIK
			'#### HAZIRLIK
			vadegun	=	0
			KDV_ORANI	=	rs("KDV_ORANI")
			KDV_ORANI	=	str2fiyat(KDV_ORANI)
			STOK_KODU	=	rs("STOK_KODU")
			adet		=	rs("adet")
			fiyat		=	rs("fiyat")
			OLCUBR		=	rs("OLCUBR")
			pay			=	rs("pay")
			payda		=	rs("payda")
			iskonto1	=	rs("iskonto1")
			iskonto2	=	rs("iskonto2")
			iskonto3	=	rs("iskonto3")
			iskonto4	=	rs("iskonto4")
			birimfiyat	=	rs("birimfiyat")

			'## İSKONTO HESAPLA
				if iskonto1 > 0 then
					fiyat = fiyat - (fiyat * (iskonto1 / 100))
					if iskonto2 > 0 then
						fiyat = fiyat - (fiyat * (iskonto2 / 100))
						if iskonto3 > 0 then
							fiyat = fiyat - (fiyat * (iskonto3 / 100))
							if iskonto4 > 0 then
								fiyat = fiyat - (fiyat * (iskonto4 / 100))
							end if
						end if
					end if
				end if
			'## İSKONTO HESAPLA






        '##### ÖLÇÜM ORANI HESAPLAMA
        '##### ÖLÇÜM ORANI HESAPLAMA
            olcumOrani = (adet * payda) / pay
        '##### ÖLÇÜM ORANI HESAPLAMA
        '##### ÖLÇÜM ORANI HESAPLAMA


			'## kdv hesapla
				kdv		=	kdvhesapla(birimfiyat,KDV_ORANI)
			'## kdv hesapla
			brutfiyat	=	birimfiyat + kdv
			brutfiyat	=	str2fiyat(brutfiyat)
			'#### HAZIRLIK
			'#### HAZIRLIK
			'#### OPERASYON
			'#### OPERASYON
			rs2.open "Select top(1) * from TBLSIPATRA", ssov5, 1, 3
				rs2.addnew
					rs2("STOK_KODU")		=	STOK_KODU
					rs2("FISNO")			=	sipno
					'## kolideki adet x adet
					' if OLCUBR = 1  then
					' 	rs2("STHAR_GCMIK")	=	adet' * pay
					' elseif OLCUBR = 2 and pay = 1 then 
					' 	rs2("STHAR_GCMIK")	=	adet' * payda
					' elseif OLCUBR = 2 and pay > 1 then
					' 	rs2("STHAR_GCMIK")	=	adet' * pay
					' end if
						rs2("STHAR_GCMIK")	=	olcumOrani
					'## kolideki adet x adet
					'## 1 / kolideki adet
					' if OLCUBR = 1 and pay = 1 then
					' 	rs2("CEVRIM")		=	0'1 / pay
					' elseif OLCUBR = 1 and pay > 1 then
					' 	rs2("CEVRIM")		=	0' / pay
					' elseif OLCUBR = 2 and pay = 1 then
					' 	rs2("CEVRIM")		=	payda / pay
					' else
					' 	rs2("CEVRIM")		=	pay / payda
					' end if
					'## 1 / kolideki adet
					rs2("CEVRIM")		    =	pay / payda
					rs2("STHAR_GCKOD")		=	"C"
					rs2("DEPO_KODU")		=	1
					rs2("STHAR_TARIH")		=	date()
					'## koli fiyat / kolideki adet
					if OLCUBR = 1 then
						rs2("STHAR_NF")		=	birimfiyat'fiyat
						rs2("STHAR_BF")		=	birimfiyat'brutfiyat
						rs2("LISTE_FIAT")	=	1							'bunu incele
					else
						rs2("STHAR_NF")		=	birimfiyat / payda'fiyat / payda
						rs2("STHAR_BF")		=	birimfiyat / payda'brutfiyat / payda
						rs2("LISTE_FIAT")	=	2
					end if
					'## 100 / kolideki adet
	'				rs2("STHAR_KOD1")		=	"Y"
					rs2("STHAR_KDV")		=	KDV_ORANI
					rs2("STHAR_ACIKLAMA")	=	carikod
					rs2("STHAR_FTIRSIP")	=	"6"
					rs2("STHAR_HTUR")		=	"H"
	'				rs2("STHAR_DOVTIP")		=	fn2("dovtipi")
					rs2("FIRMA_DOVTUT")		=	0
	'				rs2("D_YEDEK10")		=	date()-1
					rs2("STHAR_DOVFIAT")	=	0
					rs2("STHAR_ODEGUN")		=	21
					rs2("STHAR_BGTIP")		=	"I"
					rs2("STHAR_CARIKOD")	=	carikod
	'				rs2("PROJE_KODU")		=	projekodu
					rs2("PLASIYER_KODU")	=	ssoID
					rs2("REDNEDEN")			=	0
					rs2("SIRA")				=	kalemsayisi
					rs2("STRA_SIPKONT")		=	kalemsayisi
					rs2("IRSALIYE_TARIH")	=	date()
					rs2("OLCUBR")			=	OLCUBR
					rs2("BAGLANTI_NO")		=	0
					rs2("SUBE_KODU")		=	0
					rs2("STHAR_TESTAR")		=	date()
					rs2("VADE_TARIHI")		=	date()
	'				rs2("STHAR_ODEGUN")		=	vadegun


					if iskonto1 > 0 then
						rs2("STHAR_SATISK")		=	iskonto1 / 100000
					end if
					if iskonto2 > 0 then
						rs2("STHAR_SATISK2")	=	iskonto2
					end if
					if iskonto3 > 0 then
						rs2("STRA_SATISK3")		=	iskonto3
					end if
					if iskonto4 > 0 then
						rs2("STRA_SATISK4")		=	iskonto4
					end if

                    '### EK ALANLAR
					rs2("D_YEDEK10")		=	date()
					rs2("FIYATTARIHI")		=	date()


				rs2.update
			rs2.close
			rs("sipno") = sipno
			rs.update

call logla("Sipariş Kalemi Eklendi. Sipariş No : " & sipno & ". Stok Kodu : " & STOK_KODU)

		rs.movenext
		next
		rs.close
'#### siparişe ürünleri ekle
'#### siparişe ürünleri ekle

call jsrun("$('#siparislistesi').html('<h3 class=""text-center text-danger"">SİPARİŞ OLUŞTURULDU.<br />Sipariş No : " & sipno & "</h3>')")

call logla("Sipariş Oluşturuldu. Sipariş No : " & sipno)

%><!--#include virtual="/reg/rs.asp" -->