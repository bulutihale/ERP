<%
gunleruzun		=	Array("Pazar","Pazartesi","Salı","Çarşamba","Perşembe","Cuma","Cumartesi","Pazar")
aylaruzun		=	Array("","Ocak","Şubat","Mart","Nisan","Mayıs","Haziran","Temmuz","Ağustos","Eylül","Ekim","Kasım","Aralık")
aylarkisa		=	Array("","Oc","Şb","Mr","Ns","My","Hz","Tm","Ağ","Ey","Ek","Ks","Ar")
oncelikArr		=	Array("Düşük","","Düşük+","","","Normal","","Yüksek","","Acil")
paraArr			=	Array("","TL","USD","EUR")
silindiArr		=	Array("",translate("Silindi","",""))
' muhasebedbArr   =   Array("best2022","best2021")

	'##### Depo Tipleri
		depoTipDegerler = "=|SANAL=0|FİZİKSEL=1|SÜREÇ=2"
	'##### Depo Tipleri
	
	'##### Depo Kategorileri
		depoKategoriDegerler = "=|Kalite Kontrol=kalite|Üretim=uretim|Mal Kabul=malKabul|Mamül=mamul|Satış=satis|Üretim Süreç=surecUretim|Kesimhane Süreç=surecKesim|Sterilizasyon Sarf=sterilizasyonSarf"
	'##### Depo Kategorileri
	
	'##### EVET - HAYIR
		HEdegerler = "=|" & translate("HAYIR","","") & "=0|" & translate("EVET","","") & "=1"
	'##### EVET - HAYIR

	'##### Diller
		dilDegerler = translate("Türkçe","","") & "=tr|" & translate("İngilizce","","") & "=en"
	'##### Diller
	
	'##### Stok Tipleri
		stokTurDegerler = "=|" & translate("Mamul","","") & "=1|" & translate("Yarı Mamul","","") & "=2|" & translate("Bileşen","","") & "=3|" & translate("Hammadde","","") & "=4"
	'##### Stok Tipleri
	
	'##### Reçete Ön Hazırlık Tipleri
		hazTurDegerler = "=|Saat=Saat|Gün=Gün"
	'##### Reçete Ön Hazırlık Tipleri

	'##### 0'dan 24'e sayilar
		sayiDegerler = "=|"
		for qi = 0 to 24
			sayiDegerler = sayiDegerler & qi & " = " & qi
			if qi < 24 then
				sayiDegerler = sayiDegerler & "|"
			end if
		next
	'##### 0'dan 24'e sayilar

	'##### TEKLİF MODULÜ
		teklifSonucArr	=	Array(translate("Hazırlanıyor","",""),translate("Amir Onayında","",""),translate("Amir Onaylı","",""),translate("Amir Red","",""),translate("Müşteriye Gönderildi","",""),translate("Müşteri Red","",""),translate("Satış Gerçekleşti","",""),translate("Ödeme Bekleniyor","",""),translate("Sevkiyatta","",""))
		teklifTurleriArr = Array("--" & translate("Teklif Türü","","") & "--",translate("Kdv Dahil Toplamlı Teklif","",""),translate("Kdv Hariç Toplamlı Teklif","",""),"",translate("Genel Teklif","",""),translate("Mail Order","",""),translate("Taksitli Mail Order","",""),translate("İhracat Teklif","",""),translate("Proforma Fatura","",""))
		teklifYaziYeriArr = "--" & translate("Neresi","","") & "--=|" & translate("Teklif Üstü","","") & "=Teklif Üstü|" & translate("Teklif Altı","","") & "=Teklif Altı|" & translate("Ürün Altı","","") & "=Ürün Altı"
	'##### TEKLİF MODULÜ


	'##### CARİ MODULÜ
		sb_cariTurArr	=	translate("Son Kullanıcı","","") & "=3|" & translate("Bayi","","") & "=2|" & translate("Tedarikçi","","") & "=8"
	'##### CARİ MODULÜ



%>