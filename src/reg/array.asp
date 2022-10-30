<%
gunleruzun		=	Array("Pazar","Pazartesi","Salı","Çarşamba","Perşembe","Cuma","Cumartesi","Pazar")
aylaruzun		=	Array("","Ocak","Şubat","Mart","Nisan","Mayıs","Haziran","Temmuz","Ağustos","Eylül","Ekim","Kasım","Aralık")
aylarkisa		=	Array("","Oc","Şb","Mr","Ns","My","Hz","Tm","Ağ","Ey","Ek","Ks","Ar")
oncelikArr		=	Array("Düşük","","Düşük+","","","Normal","","Yüksek","","Acil")
paraArr			=	Array("","TL","USD","EUR")

hastaneArr      =   Array("","Özel Sağlık","Gözde Tepecik","Gözde Kuşadası")

muhasebedbArr   =   Array("best2022","best2021")

	'##### Depo Tipleri
				depoTipDegerler = "=|SANAL=0|FİZİKSEL=1"
	'##### Depo Tipleri
	
	'##### Depo Kategorileri
				depoKategoriDegerler = "=|Kalite Kontrol=kalite|Üretim=uretim|Mal Kabul=malKabul|Mamül=mamul|Satış=satis|Üretim Süreç=surecUretim"
	'##### Depo Kategorileri
	
	'##### EVET - HAYIR
				HEdegerler = "=|HAYIR=0|EVET=1"
	'##### EVET - HAYIR
	
	
	'##### Stok Tipleri
				stokTipDegerler = "=|Mamül=1|Yarı Mamül=2|Bileşen=3|Hammadde=4"
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

%>