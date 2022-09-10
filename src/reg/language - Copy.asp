<%
klang = Request.Cookies("klang")


language_tr = "Ayarlar=Ayarlar||Çıkış=Çıkış||Her Hakkı Saklıdır=Her Hakkı Saklıdır||ARA=ARA||YENİ HASTA=YENİ HASTA||Ad Soyad=Ad Soyad||Not=Not||Tarih=Tarih||Acenta=Acenta||Refakatci Bilgileri=Refakatci Bilgileri||Ameliyat Bilgileri=Ameliyat Bilgileri||Ödeme Bilgileri=Ödeme Bilgileri||Uçuş Bilgileri=Uçuş Bilgileri||Konaklama Bilgileri=Konaklama Bilgileri||Dosyalar=Dosyalar||Hasta Bilgileri=Hasta Bilgileri||Kaydet=Kaydet||Lütfen hasta adını yazın=Lütfen hasta adını yazın||Lütfen hasta iletişim bilgilerini yazın=Lütfen hasta iletişim bilgilerini yazın||Ameliyat=Ameliyat||Doktor=Doktor||Hastane=Hastane||Ameliyat Listesi=Ameliyat Listesi||Lütfen ameliyatın yapılacağı hastaneyi seçin=Lütfen ameliyatın yapılacağı hastaneyi seçin||{%1} için <strong>{%2}</strong> cinsinden ödeme bilgilerini yazın={%1} için <strong>{%2}</strong> cinsinden ödeme bilgilerini yazın||Refakatci Listesi=Refakatci Listesi||Sil=Sil||Pasaport Numarası=Pasaport Numarası"
language_en = "Ayarlar=Settings||Çıkış=Logout||Her Hakkı Saklıdır=All Rights Reserved||ARA=Search||YENİ HASTA=New Patient||Ad Soyad=Name Surname||Not=Note||Tarih=Date||Acenta=Agency||Refakatci Bilgileri=Companion Info||Ameliyat Bilgileri=Operation Info||Ödeme Bilgileri=Payment Info||Uçuş Bilgileri=Uçuş Bilgileri||Konaklama Bilgileri=Konaklama Bilgileri||Dosyalar=Files||Hasta Bilgileri=Patient Info||Kaydet=Save||Lütfen hasta adını yazın=Please fill patient name||Lütfen hasta iletişim bilgilerini yazın=Please fill patient contact info||Ameliyat=Operation||Doktor=Doctor||Hastane=Hospital||Ameliyat Listesi=Operation List||Lütfen ameliyatın yapılacağı hastaneyi seçin=Please select the hospital where the surgery will be performed||{%1} için <strong>{%2}</strong> cinsinden ödeme bilgilerini yazın=Please type <strong>{%2}</strong> payment info for {%1}||Refakatci Listesi=Refakatci Listesi||Sil=Delte||Pasaport Numarası=Pasaport Numarası"









	if klang = "" then
		klang = "tr"
	end if
	if klang = "en" then
		hedefSozluk = language_en
	else
		hedefSozluk = language_en
	end if

    languageSozluk = Split(hedefSozluk,"||")
%>