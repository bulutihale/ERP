﻿<%
klang = Request.Cookies("klang")
language_tr = "="
language_en = "="
language_en = language_en & "||Çıkış=Logout"
language_en = language_en & "||Her Hakkı Saklıdır=All Rights Reserved"
language_en = language_en & "||Ad Soyad=Name Surname"
language_en = language_en & "||ARA=Search"
language_en = language_en & "||YENİ HASTA=New Patient"
language_en = language_en & "||Not=Note"
language_en = language_en & "||Tarih=Date"
language_en = language_en & "||Acenta=Agency"
language_en = language_en & "||Refakatci Bilgileri=Companion Info"
language_en = language_en & "||Ameliyat Bilgileri=Surgery Info"
language_en = language_en & "||Ödeme Bilgileri=Payment Info"
language_en = language_en & "||Uçuş Bilgileri=Flight Info"
language_en = language_en & "||Konaklama Bilgileri=Accommodation Information"
language_en = language_en & "||Dosyalar=Files"
language_en = language_en & "||Hasta Bilgileri=Patient Info"
language_en = language_en & "||Ameliyat=Surgery"
language_en = language_en & "||Doktor=Doctor"
language_en = language_en & "||Hastane=Hospital"
language_en = language_en & "||Kaydet=Save"
language_en = language_en & "||{%1} için <strong>{%2}</strong> cinsinden ödeme bilgilerini yazın=Please type <strong>{%2}</strong> payment info for {%1}"
language_en = language_en & "||Hasta Adı Soyadı=Patient Name Surname"
language_en = language_en & "||GSM=GSM"
language_en = language_en & "||Eposta Adresi=Email Address"
language_en = language_en & "||Çağrı Kaynağı=Call Source"
language_en = language_en & "||Geldiği Ülke=Country"
language_en = language_en & "||Para Birimi=Currency"
language_en = language_en & "||Ayarlar=Settings"
language_en = language_en & "||Pasaport Numarası=Passport Number"
language_en = language_en & "||Refakatci Listesi=Companion List"
language_en = language_en & "||Sil=Delete"
language_en = language_en & "||Lütfen ameliyatın yapılacağı hastaneyi seçin=Please select the hospital where the surgery will be performed"
language_en = language_en & "||Lütfen ameliyatın yapılacağı tarihi seçin=Please select the date when the surgery will be performed"
language_en = language_en & "||Ameliyat Listesi=Surgery List"
language_en = language_en & "||Paket Fiyatı=Package Price"
language_en = language_en & "||Kaparo=Deposit"
language_en = language_en & "||Banka Dekontu=GG Number"
language_en = language_en & "||Banka Adı=Bank Name"
language_en = language_en & "||Personel=Employee"
language_en = language_en & "||İşlem=Process"
language_en = language_en & "||IP=IP"
language_en = language_en & "||Hareket Ayrıntıları=Process Details"
language_en = language_en & "||Uçuş Tarihi=Flight Date"
language_en = language_en & "||Uçuş Saati=Flight Time"
language_en = language_en & "||Uçak Kalkış Yeri=Departure Airport"
language_en = language_en & "||Uçak Numarası=Flight Number"
language_en = language_en & "||Uçak Firması=Airways"
language_en = language_en & "||Uçak İniş Havalimanı=Landing Airport"
language_en = language_en & "||Lütfen uçuş tarihini ve saatini yazın=Please write the flight date and time"
language_en = language_en & "||Transfer Listesi=Transfer List"
language_en = language_en & "||Transfer=Transfer"
language_en = language_en & "||Var=Yes"
language_en = language_en & "||Yok=No"
language_en = language_en & "||Konaklama Yeri=Accommodation place"
language_en = language_en & "||Check In=Check In"
language_en = language_en & "||Check Out=Check Out"
language_en = language_en & "||Kişi Sayısı=Number of Persons"
language_en = language_en & "||Oda Türü=Room Type"
language_en = language_en & "||Yatak Türü=Bed Type"
language_en = language_en & "||Konaklama Listesi=Accommodation List"
language_en = language_en & "||Hatalı konaklama tarihi seçtiniz. Giriş tarihi, çıkış tarihinden sonra olamaz=You have selected the wrong accommodation date. Check-in date cannot be later than check-out date"
language_en = language_en & "||Lütfen konaklama yerini seçin=Please select the patients accommodation"
language_en = language_en & "||Lütfen konaklama tarihini seçin=Please choose check in date"
language_en = language_en & "||Lütfen konaklama ayrıntılarını seçin=Please select the patients accommodation details"
language_en = language_en & "||Lütfen hasta iletişim bilgilerini yazın=Please write patient contact information"
language_en = language_en & "||Sorumlu Operasyon Personeli=Responsible Operations Personnel"
language_en = language_en & "||Lütfen acenta seçin=Please select agent"
language_en = language_en & "||Lütfen para birimi seçin=Please select currency"
language_en = language_en & "||Lütfen hastanın geleceği ülkeyi seçin=Please select the country from which the patient will come"
language_en = language_en & "||Lütfen çağrı kaynağını seçin=Please select the call source"
language_en = language_en & "||Refakatci Adı Soyadı=Companion Name Surname"
language_en = language_en & "||Refakatci Pasaport Numarası=Companion Passport Number"
language_en = language_en & "||Transfer Bilgileri Güncellendi=Transfer Information Updated"
language_en = language_en & "||Please type GG number=Please type GG number"
language_en = language_en & "||Please type surgery price informations=Please type surgery price informations"
language_en = language_en & "||Ödeme Bilgileri Güncellendi=Payment Information Updated"
language_en = language_en & "||YENİ PERSONEL=YENİ PERSONEL"
language_en = language_en & "||Görev=Görev"
language_en = language_en & "||Son Giriş=Son Giriş"
language_en = language_en & "||Personel Düzenle=Personel Düzenle"
language_en = language_en & "||Personel Adı Soyadı=Personel Adı Soyadı"
language_en = language_en & "||Şifre=Password"
language_en = language_en & "||Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır=Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır"
language_en = language_en & "||Hatalı email adresi yazdınız=Hatalı email adresi yazdınız"
language_en = language_en & "||Son Kullanma Tarihi=Son Kullanma Tarihi"
language_en = language_en & "||Lütfen yeni şifrenizi yazın=Please type new password"
language_en = language_en & "||Güncelle=Update"
language_en = language_en & "||Lütfen email adresini yazın=Please type your email address"
language_en = language_en & "||Lütfen şifrenizi yazın=Please type password"
language_en = language_en & "||Personel Yetkileri=Personel Yetkileri"
language_en = language_en & "||Yetki : =Yetki : "
language_en = language_en & "||Yönetici=Manager"
language_en = language_en & "||Yetki Güncellendi=Yetki Güncellendi"
language_en = language_en & "||Giriş Yapamaz=Giriş Yapamaz"
language_en = language_en & "||Kalkış Saati=Kalkış Saati"
language_en = language_en & "||Varış Saati=Arrival Time"
language_en = language_en & "||Uçuş Numarası=Uçuş Numarası"
language_en = language_en & "||Uçak İniş Yeri=Arival Airport"
language_en = language_en & "||Sorumlu Personel=Sorumlu Personel"
language_en = language_en & "||Öncelik=Öncelik"
language_en = language_en & "||Arıza Başlığı=Arıza Başlığı"
language_en = language_en & "||Arıza Ayrıntıları=Arıza Ayrıntıları"
language_en = language_en & "||ARIZA BİLDİR=ARIZA BİLDİR"
language_en = language_en & "||Ünvan=Title"
language_en = language_en & "||Dahili=Dahili"
language_en = language_en & "||YENİ ETİKET=NEW LABEL"
language_en = language_en & "||Stok Kodu - Stok Adı=Stok Kodu - Stok Adı"
language_en = language_en & "||Stok Kodu=Stok Kodu"
language_en = language_en & "||Stok Adı=Stok Adı"
language_en = language_en & "||Mamül Adı=Mamül Adı"
language_en = language_en & "||Etiket Dili=Etiket Dili"
language_en = language_en & "||Menşei=Menşei"
language_en = language_en & "||Ölçü=Ölçü"
language_en = language_en & "||Durum=Durum"
language_en = language_en & "||Grubu=Grubu"
language_en = language_en & "||Etiket Ayrıntıları=Etiket Ayrıntıları"
language_en = language_en & "||Dil=Dil"
language_en = language_en & "||Etiket Ölçüsü=Etiket Ölçüsü"
language_en = language_en & "||Etiket Durumu=Etiket Durumu"
language_en = language_en & "||Revizyon=Revizyon"
language_en = language_en & "||Pantone Kodu=Pantone Kodu"
language_en = language_en & "||Son Güncelleme=Son Güncelleme"
language_en = language_en & "||Açıklama=Açıklama"
language_en = language_en & "||Yeni Revizyon Olarak Kaydet=Yeni Revizyon Olarak Kaydet"
language_en = language_en & "||Revizyon numarasını değiştrmeyi unuttunuz=Revizyon numarasını değiştrmeyi unuttunuz"
language_en = language_en & "||Lütfen stok kodunu yazın=Lütfen stok kodunu yazın"
language_en = language_en & "||Lütfen stok adını yazın=Lütfen stok adını yazın"
language_en = language_en & "||Lütfen mamül adını yazın=Lütfen mamül adını yazın"
language_en = language_en & "||Lütfen revizyon adını yazın=Lütfen revizyon adını yazın"
language_en = language_en & "||Lütfen etiket ölçüsünü yazın=Lütfen etiket ölçüsünü yazın"
language_en = language_en & "||Lütfen durdurulma sebebini açıklama alanına yazın=Lütfen durdurulma sebebini açıklama alanına yazın"
language_en = language_en & "||Lütfen mensei yazın=Lütfen mensei yazın"
language_en = language_en & "||Girmiş olduğunuz stok kodlu etiket daha önce eklenmiş.<br />Yeni ekleme yapılmadı=Girmiş olduğunuz stok kodlu etiket daha önce eklenmiş.<br />Yeni ekleme yapılmadı"
language_en = language_en & "||Dosya Ayrıntıları=Dosya Ayrıntıları"
language_en = language_en & "||Dosya Yükleme=Dosya Yükleme"
language_en = language_en & "||Resim Dosyası=Resim Dosyası"
language_en = language_en & "||Yüklenen Dosya Açıklaması=Yüklenen Dosya Açıklaması"
language_en = language_en & "||Yükle=Yükle"
language_en = language_en & "||Dosya başarıyla yüklendi=Dosya başarıyla yüklendi"
language_en = language_en & "||Bir hata oluştu=Bir hata oluştu"
language_en = language_en & "||Dosyayı İndir=Dosyayı İndir"
language_en = language_en & "||Sipariş No=Sipariş No"
language_en = language_en & "||Cari Kodu=Cari Kodu"
language_en = language_en & "||Grup Kodu=Grup Kodu"
language_en = language_en & "||Cinsi=Cinsi"
language_en = language_en & "||Sipariş Tarihi=Sipariş Tarihi"
language_en = language_en & "||Teslim Tarihi=Teslim Tarihi"
language_en = language_en & "||Kalite Sonuç=Kalite Sonuç"
language_en = language_en & "||TD Puanı=TD Puanı"
language_tr = language_tr & "||Çıkış=Çıkış"
language_tr = language_tr & "||Her Hakkı Saklıdır=Her Hakkı Saklıdır"
language_tr = language_tr & "||Uçuş Tarihi=Uçuş Tarihi"
language_tr = language_tr & "||Uçuş Saati=Uçuş Saati"
language_tr = language_tr & "||Uçak Kalkış Yeri=Uçak Kalkış Yeri"
language_tr = language_tr & "||Uçak Numarası=Uçak Numarası"
language_tr = language_tr & "||Uçak Firması=Uçak Firması"
language_tr = language_tr & "||Uçak İniş Havalimanı=Uçak İniş Havalimanı"
language_tr = language_tr & "||Ayarlar=Ayarlar"
language_tr = language_tr & "||Cihaz=Cihaz"
language_tr = language_tr & "||Marka=Marka"
language_tr = language_tr & "||Model=Model"
language_tr = language_tr & "||Son Akış=Son Akış"
language_tr = language_tr & "||Kontrol=Kontrol"
language_tr = language_tr & "||Durum=Durum"
language_tr = language_tr & "||Tarih=Tarih"
language_tr = language_tr & "||Ad Soyad=Ad Soyad"
language_tr = language_tr & "||ARA=ARA"
language_tr = language_tr & "||YENİ PERSONEL=YENİ PERSONEL"
language_tr = language_tr & "||Görev=Görev"
language_tr = language_tr & "||Son Giriş=Son Giriş"
language_tr = language_tr & "||Personel Düzenle=Personel Düzenle"
language_tr = language_tr & "||Personel Adı Soyadı=Personel Adı Soyadı"
language_tr = language_tr & "||GSM=GSM"
language_tr = language_tr & "||Şifre=Şifre"
language_tr = language_tr & "||Eposta Adresi=Eposta Adresi"
language_tr = language_tr & "||Kaydet=Kaydet"
language_tr = language_tr & "||Personel=Personel"
language_tr = language_tr & "||İşlem=İşlem"
language_tr = language_tr & "||IP=IP"
language_tr = language_tr & "||Bilgiler Güncellendi=Bilgiler Güncellendi"
language_tr = language_tr & "||Son Kullanma Tarihi=Son Kullanma Tarihi"
language_tr = language_tr & "||Lütfen yeni şifrenizi yazın=Lütfen yeni şifrenizi yazın"
language_tr = language_tr & "||Güncelle=Güncelle"
language_tr = language_tr & "||Personel Yetkileri=Personel Yetkileri"
language_tr = language_tr & "||Giriş Yapamaz=Giriş Yapamaz"
language_tr = language_tr & "||Yönetici=Yönetici"
language_tr = language_tr & "||Yetki : =Yetki : "
language_tr = language_tr & "||YENİ HASTA=YENİ HASTA"
language_tr = language_tr & "||Not=Not"
language_tr = language_tr & "||Acenta=Acenta"
language_tr = language_tr & "||Ameliyat Bilgileri=Ameliyat Bilgileri"
language_tr = language_tr & "||Ödeme Bilgileri=Ödeme Bilgileri"
language_tr = language_tr & "||Uçuş Bilgileri=Uçuş Bilgileri"
language_tr = language_tr & "||Konaklama Bilgileri=Konaklama Bilgileri"
language_tr = language_tr & "||Refakatci Bilgileri=Refakatci Bilgileri"
language_tr = language_tr & "||Dosyalar=Dosyalar"
language_tr = language_tr & "||Hasta Bilgileri=Hasta Bilgileri"
language_tr = language_tr & "||Ameliyat=Ameliyat"
language_tr = language_tr & "||Doktor=Doktor"
language_tr = language_tr & "||Hastane=Hastane"
language_tr = language_tr & "||Ameliyat Listesi=Ameliyat Listesi"
language_tr = language_tr & "||Sil=Sil"
language_tr = language_tr & "||{%1} için <strong>{%2}</strong> cinsinden ödeme bilgilerini yazın={%1} için <strong>{%2}</strong> cinsinden ödeme bilgilerini yazın"
language_tr = language_tr & "||Paket Fiyatı=Paket Fiyatı"
language_tr = language_tr & "||Kaparo=Kaparo"
language_tr = language_tr & "||Banka Dekontu=Banka Dekontu"
language_tr = language_tr & "||Hareket Ayrıntıları=Hareket Ayrıntıları"
language_tr = language_tr & "||Transfer Listesi=Transfer Listesi"
language_tr = language_tr & "||Transfer=Transfer"
language_tr = language_tr & "||Var=Var"
language_tr = language_tr & "||Transfer Bilgileri Güncellendi=Transfer Bilgileri Güncellendi"
language_tr = language_tr & "||Konaklama Yeri=Konaklama Yeri"
language_tr = language_tr & "||Check In=Check In"
language_tr = language_tr & "||Check Out=Check Out"
language_tr = language_tr & "||Kişi Sayısı=Kişi Sayısı"
language_tr = language_tr & "||Oda Türü=Oda Türü"
language_tr = language_tr & "||Yatak Türü=Yatak Türü"
language_tr = language_tr & "||Refakatci Adı Soyadı=Refakatci Adı Soyadı"
language_tr = language_tr & "||Refakatci Pasaport Numarası=Refakatci Pasaport Numarası"
language_tr = language_tr & "||Yetki Güncellendi=Yetki Güncellendi"
language_tr = language_tr & "||Konaklama Listesi=Konaklama Listesi"
language_tr = language_tr & "||Refakatci Listesi=Refakatci Listesi"
language_tr = language_tr & "||Pasaport Numarası=Pasaport Numarası"
language_tr = language_tr & "||Öncelik=Öncelik"
language_tr = language_tr & "||Sorumlu Personel=Sorumlu Personel"
language_tr = language_tr & "||Arıza Başlığı=Arıza Başlığı"
language_tr = language_tr & "||Arıza Ayrıntıları=Arıza Ayrıntıları"
language_tr = language_tr & "||ARIZA BİLDİR=ARIZA BİLDİR"
language_tr = language_tr & "||Stok Kodu - Stok Adı=Stok Kodu - Stok Adı"
language_tr = language_tr & "||YENİ ETİKET=YENİ ETİKET"
language_tr = language_tr & "||Stok Kodu=Stok Kodu"
language_tr = language_tr & "||Revizyon=Revizyon"
language_tr = language_tr & "||Stok Adı=Stok Adı"
language_tr = language_tr & "||Mamül Adı=Mamül Adı"
language_tr = language_tr & "||Etiket Dili=Etiket Dili"
language_tr = language_tr & "||Menşei=Menşei"
language_tr = language_tr & "||Grubu=Grubu"
language_tr = language_tr & "||Ölçü=Ölçü"
language_tr = language_tr & "||Son Güncelleme=Son Güncelleme"
language_tr = language_tr & "||Etiket Ayrıntıları=Etiket Ayrıntıları"
language_tr = language_tr & "||Dil=Dil"
language_tr = language_tr & "||Etiket Ölçüsü=Etiket Ölçüsü"
language_tr = language_tr & "||Pantone Kodu=Pantone Kodu"
language_tr = language_tr & "||Etiket Durumu=Etiket Durumu"
language_tr = language_tr & "||Açıklama=Açıklama"
language_tr = language_tr & "||Yeni Revizyon Olarak Kaydet=Yeni Revizyon Olarak Kaydet"
language_tr = language_tr & "||Revizyon numarasını değiştrmeyi unuttunuz=Revizyon numarasını değiştrmeyi unuttunuz"
language_tr = language_tr & "||Lütfen durdurulma sebebini açıklama alanına yazın=Lütfen durdurulma sebebini açıklama alanına yazın"
language_tr = language_tr & "||Lütfen stok kodunu yazın=Lütfen stok kodunu yazın"
language_tr = language_tr & "||Lütfen stok adını yazın=Lütfen stok adını yazın"
language_tr = language_tr & "||Lütfen mamül adını yazın=Lütfen mamül adını yazın"
language_tr = language_tr & "||Lütfen mensei yazın=Lütfen mensei yazın"
language_tr = language_tr & "||Lütfen revizyon adını yazın=Lütfen revizyon adını yazın"
language_tr = language_tr & "||Lütfen etiket durumunu seçin=Lütfen etiket durumunu seçin"
language_tr = language_tr & "||Lütfen etiket ölçüsünü yazın=Lütfen etiket ölçüsünü yazın"
language_tr = language_tr & "||Dahili=Dahili"
language_tr = language_tr & "||Ünvan=Ünvan"
language_tr = language_tr & "||Dosya Ayrıntıları=Dosya Ayrıntıları"
language_tr = language_tr & "||Resim Dosyası=Resim Dosyası"
language_tr = language_tr & "||PDF Dosyası=PDF Dosyası"
language_tr = language_tr & "||Yüklenen Dosya Açıklaması=Yüklenen Dosya Açıklaması"
language_tr = language_tr & "||Yükle=Yükle"
language_tr = language_tr & "||Dosya başarıyla yüklendi=Dosya başarıyla yüklendi"
language_tr = language_tr & "||Dosya Yükleme=Dosya Yükleme"
language_tr = language_tr & "||Dosyayı İndir=Dosyayı İndir"
language_tr = language_tr & "||Hasta Adı Soyadı=Hasta Adı Soyadı"
language_tr = language_tr & "||Çağrı Kaynağı=Çağrı Kaynağı"
language_tr = language_tr & "||Geldiği Ülke=Geldiği Ülke"
language_tr = language_tr & "||Para Birimi=Para Birimi"
language_tr = language_tr & "||Sorumlu Operasyon Personeli=Sorumlu Operasyon Personeli"
language_tr = language_tr & "||Varış Saati=Varış Saati"
language_tr = language_tr & "||Cari Kodu=Cari Kodu"
language_tr = language_tr & "||Sipariş No=Sipariş No"
language_tr = language_tr & "||Grup Kodu=Grup Kodu"
language_tr = language_tr & "||Sipariş Tarihi=Sipariş Tarihi"
language_tr = language_tr & "||Kalite Sonuç=Kalite Sonuç"
language_tr = language_tr & "||TD Puanı=TD Puanı"
language_tr = language_tr & "||Cinsi=Cinsi"
language_tr = language_tr & "||Teslim Tarihi=Teslim Tarihi"
language_tr = language_tr & "||Kayıt Oluşturan Personel=Kayıt Oluşturan Personel"
language_tr = language_tr & "||Sipariş Miktarı=Sipariş Miktarı"
language_tr = language_tr & "||Teslim Miktarı=Teslim Miktarı"
language_tr = language_tr & "||Teslimat Sayısı=Teslimat Sayısı"
language_tr = language_tr & "||Teslim Gün=Teslim Gün"
language_tr = language_tr & "||Sipariş No - Cari Kod=Sipariş No - Cari Kod"
language_tr = language_tr & "||Fiş No=Fiş No"
language_tr = language_tr & "||Cari Bul=Cari Bul"
language_tr = language_tr & "||Cari Adı=Cari Adı"
language_tr = language_tr & "||Cari Kodu - Cari Adı=Cari Kodu - Cari Adı"
language_tr = language_tr & "||Hatalı email adresi yazdınız=Hatalı email adresi yazdınız"
language_tr = language_tr & "||Ürün=Ürün"
language_tr = language_tr & "||Kod=Kod"
language_tr = language_tr & "||Ürün Adı=Ürün Adı"
language_tr = language_tr & "||Tür=Tür"
language_tr = language_tr & "||Stok Düzenle=Stok Düzenle"
language_tr = language_tr & "||Cari Düzenle=Cari Düzenle"
language_tr = language_tr & "||Lütfen email adresini yazın=Lütfen email adresini yazın"
language_tr = language_tr & "||Reçete Düzenle=Reçete Düzenle"
language_tr = language_tr & "||Reçete Adımları Düzenle=Reçete Adımları Düzenle"
language_tr = language_tr & "||Reçete Adım Düzenle=Reçete Adım Düzenle"
language_tr = language_tr & "||Reçete Kopyala=Reçete Kopyala"
language_tr = language_tr & "||Yukarı Taşı=Yukarı Taşı"
language_tr = language_tr & "||Aşağı Taşı=Aşağı Taşı"
language_tr = language_tr & "||Kayıt bulunamadı=Kayıt bulunamadı"
language_tr = language_tr & "||Hepsi=Hepsi"
language_tr = language_tr & "||Sayfa başına _MENU_ kayıt gösteriliyor=Sayfa başına _MENU_ kayıt gösteriliyor"
language_tr = language_tr & "||_PAGE_ - _PAGES_ arası sayfalar gösteriliyor=_PAGE_ - _PAGES_ arası sayfalar gösteriliyor"
language_tr = language_tr & "||(_MAX_ kayıt filtreleniyor)=(_MAX_ kayıt filtreleniyor)"
language_tr = language_tr & "||Veri Bulunamadı=Veri Bulunamadı"
language_tr = language_tr & "||Yükleniyor=Yükleniyor"
language_tr = language_tr & "||İşleniyor=İşleniyor"
language_tr = language_tr & "||İlk=İlk"
language_tr = language_tr & "||Son=Son"
language_tr = language_tr & "||Sonraki=Sonraki"
language_tr = language_tr & "||Önceki=Önceki"
language_tr = language_tr & "||Ara :=Ara :"
language_tr = language_tr & "||YENİ STOK=YENİ STOK"
language_tr = language_tr & "||Rapor Adı=Rapor Adı"
language_tr = language_tr & "||Rapor Türü=Rapor Türü"
language_tr = language_tr & "||SQL Sorgusu=SQL Sorgusu"
language_tr = language_tr & "||Düzenle=Düzenle"
language_tr = language_tr & "||YENİ CARİ=YENİ CARİ"
language_tr = language_tr & "||Cari Kod=Cari Kod"
language_tr = language_tr & "||Cari Ad=Cari Ad"
language_tr = language_tr & "||Vergi Dairesi=Vergi Dairesi"
language_tr = language_tr & "||Vergi Numarası=Vergi Numarası"
language_tr = language_tr & "||Şehir=Şehir"
language_tr = language_tr & "||Cari Türü=Cari Türü"
language_tr = language_tr & "||Telefon=Telefon"
language_tr = language_tr & "||Posta Kodu=Posta Kodu"
language_tr = language_tr & "||Email Adresi=Email Adresi"
language_tr = language_tr & "||Posta Adresi=Posta Adresi"
language_tr = language_tr & "||Şehir Ekle=Şehir Ekle"
language_tr = language_tr & "||Şehir Adını Yazın=Şehir Adını Yazın"
language_tr = language_tr & "||Teklif Ver=Teklif Ver"
language_tr = language_tr & "||Cari Ad veya Kod=Cari Ad veya Kod"
language_tr = language_tr & "||CARİ ARA=CARİ ARA"
language_tr = language_tr & "||Seç=Seç"
language_tr = language_tr & "||Bildirim Yöntemi=Bildirim Yöntemi"
language_tr = language_tr & "||Etiket=Etiket"
language_tr = language_tr & "||Teklif Düzenle=Teklif Düzenle"
language_tr = language_tr & "||PDF=PDF"
language_tr = language_tr & "||Teklifi Düzenle=Teklifi Düzenle"
language_tr = language_tr & "||Önizleme=Önizleme"
language_tr = language_tr & "||PDF Oluştur=PDF Oluştur"
language_tr = language_tr & "||Teklifi Onayla=Teklifi Onayla"
language_tr = language_tr & "||Teklifi Sil=Teklifi Sil"
language_tr = language_tr & "||Email Gönder=Email Gönder"
language_tr = language_tr & "||Mail Gönderimi=Mail Gönderimi"
language_tr = language_tr & "||Mail Gönder=Mail Gönder"
language_tr = language_tr & "||Şablonu Düzenle=Şablonu Düzenle"
language_tr = language_tr & "||Şablonu Sil=Şablonu Sil"
language_tr = language_tr & "||Ek Dosya=Ek Dosya"
language_tr = language_tr & "||Adres Grubunu Düzenle=Adres Grubunu Düzenle"
language_tr = language_tr & "||Adres Grubunu Sil=Adres Grubunu Sil"
language_tr = language_tr & "||Grup içindeki adresleri incele=Grup içindeki adresleri incele"
language_tr = language_tr & "||Koşulu Sil=Koşulu Sil"
language_tr = language_tr & "||Gönder=Gönder"
language_tr = language_tr & "||Onay=Onay"
language_tr = language_tr & "||Teklifler=Teklifler"
language_tr = language_tr & "||Bekliyor=Bekliyor"
language_tr = language_tr & "||Red=Red"
language_tr = language_tr & "||Tümü=Tümü"
language_tr = language_tr & "||TRY=TRY"
language_tr = language_tr & "||EUR=EUR"
language_tr = language_tr & "||USD=USD"
language_tr = language_tr & "||Departman=Departman"
language_tr = language_tr & "||Hava Durumu=Hava Durumu"
language_tr = language_tr & "||Dashboard dizilimini değiştir=Dashboard dizilimini değiştir"
language_tr = language_tr & "||Modulü Sil=Modulü Sil"
language_tr = language_tr & "||Adresi Listeden Kaldır=Adresi Listeden Kaldır"
language_tr = language_tr & "||Teklifi Amir Onaylına Gönder=Teklifi Amir Onaylına Gönder"
language_tr = language_tr & "||Teklif sonucunu seçiniz=Teklif sonucunu seçiniz"
language_tr = language_tr & "||Grup Atamaları=Grup Atamaları"
language_tr = language_tr & "||Grup Adı=Grup Adı"
language_tr = language_tr & "||{%1} için grup abonelikleri={%1} için grup abonelikleri"
if klang = "" then
klang = "tr"
end if
if klang = "en" then
hedefSozluk = language_en
else
hedefSozluk = language_tr
end if
languageSozluk = Split(hedefSozluk,"||")
%>